Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47C524055
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbiEKWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiEKWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:33:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3F6D960
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9914AB82407
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2CC340EE;
        Wed, 11 May 2022 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652308430;
        bh=l5qFeU21BOfqAOWsHedlR70rZJGoWr8PVojCgih54Vg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0qQdpXwKqZt4VQ8QtuYDJYdmrU4nqF54uXos8Hp+ArLkuDDpuFhwCqGAOiDQUDe8
         Q0B135DWSLeXVdxy35CIgMrXzSZGP8BFjS814Efs3ScCVEHB9A3cTlpQML0S8d3oJy
         3C8Ja1KWE8pfVJW6qzHe42sJlIEcScKZfDDpdswo=
Date:   Wed, 11 May 2022 15:33:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4] mm: don't be stuck to rmap lock on reclaim path
Message-Id: <20220511153349.045ab3865f25920dce11ca16@linux-foundation.org>
In-Reply-To: <20220510215423.164547-1-minchan@kernel.org>
References: <20220510215423.164547-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 14:54:23 -0700 Minchan Kim <minchan@kernel.org> wrote:

> The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
> contended under memory pressure if processes keep working on
> their vmas(e.g., fork, mmap, munmap). It makes reclaim path
> stuck. In our real workload traces, we see kswapd is waiting the
> lock for 300ms+(worst case, a sec) and it makes other processes
> entering direct reclaim, which were also stuck on the lock.
> 
> This patch makes lru aging path try_lock mode like shink_page_list
> so the reclaim context will keep working with next lru pages
> without being stuck. if it found the rmap lock contended, it rotates
> the page back to head of lru in both active/inactive lrus to make
> them consistent behavior, which is basic starting point rather than
> adding more heristic.
> 
> Since this patch introduces a new "contended" field as out-param
> along with try_lock in-param in rmap_walk_control, it's not
> immutable any longer if the try_lock is set so remove const
> keywords on rmap related functions. Since rmap walking is already
> expensive operation, I doubt the const would help sizable benefit(
> And we didn't have it until 5.17).
> 
> In a heavy app workload in Android, trace shows following statistics.
> It almost removes rmap lock contention from reclaim path.

What might be the worst-case failure modes using this approach?

Could we burn much CPU time pointlessly churning though the LRU?  Could
it mess up aging decisions enough to be performance-affecting in any
workload?

Something else?
