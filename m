Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17255204C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiEIS6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiEIS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:58:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633AD268EB1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20DBFB81900
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A61CC385B6;
        Mon,  9 May 2022 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652122490;
        bh=nP4AaDAQvx8ByC615kFCUYPzsO+pDHdHQ+SVWEedQEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uLkXC1Me95pG+Iu0knA05AobpRJGOiDwU/ZRC0txVD7BJ5rG/3n9aYr1DfuRQL+Tx
         VJT9NYKhAQVK94aMTEZyxkJUayJaIIBw4BVZN0BQC3MJea4f/Tz9bgiMR9T8Pxz8ZB
         DXFn0GNnrMxuT5WUmlGoElbSjDNlPY967X7Dm9Gk=
Date:   Mon, 9 May 2022 11:54:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2] mm: don't be stuck to rmap lock on reclaim path
Message-Id: <20220509115449.f48559dd40a5e5ec95b8ead8@linux-foundation.org>
In-Reply-To: <20220509154710.4132957-1-minchan@kernel.org>
References: <20220509154710.4132957-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 May 2022 08:47:10 -0700 Minchan Kim <minchan@kernel.org> wrote:

> The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
> contented under memory pressure if processes keep working on
> their vmas(e.g., fork, mmap, munmap). It makes reclaim path
> stuck. In our real workload traces, we see kswapd is waiting the
> lock for 300ms+(a sec as worst case) and it makes other processes
> entering direct reclaim, which were also stuck on the lock.
> 
> This patch makes LRU aging path try_lock mode like shink_page_list
> so the reclaim context will keep working with next LRU pages
> without being stuck.
> 
> Since this patch introduces a new "contended" field as out-param
> along with try_lock in-param in rmap_walk_control, it's not
> immutable any longer if the try_lock is set so remove const
> keywords on rmap related functions. Since rmap walking is already
> expensive operation, I doubt the const would help sizable benefit(
> And we didn't have it until 5.17).

Some quantitative testing results would be helpful.  Demonstrate
the benefits of the patch?
