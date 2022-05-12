Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5D52424F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiELCFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiELCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79239606E3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEB4060C47
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09974C340EE;
        Thu, 12 May 2022 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652321124;
        bh=yxFRds1Pcg/OQ1UUPuRr6YvsChTNPVzsOfJva8s6jvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pEXmVdnJizJwS6RzO8590cF/lPKNz00suPvYyvizRI5sKB8CJIErNrzEDaUbvg9dE
         VIRveG9ox9HlD4bjI3S8sW48i4ZJWS+BdgvJhWfYw0fuh5CIDWqmMXUzDdxssjpP28
         2qjaUq02IscCgOxHdyQDb+rTbg+JSc9jPgTrJF3g=
Date:   Wed, 11 May 2022 19:05:23 -0700
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
Message-Id: <20220511190523.7d159b2e9caccbf13469e74e@linux-foundation.org>
In-Reply-To: <Ynw/RRsEj33gq+Hf@google.com>
References: <20220510215423.164547-1-minchan@kernel.org>
        <20220511153349.045ab3865f25920dce11ca16@linux-foundation.org>
        <Ynw/RRsEj33gq+Hf@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 15:57:09 -0700 Minchan Kim <minchan@kernel.org> wrote:

> > 
> > Could we burn much CPU time pointlessly churning though the LRU?  Could
> > it mess up aging decisions enough to be performance-affecting in any
> > workload?
> 
> Yes, correct. However, we are already churning LRUs by several
> ways. For example, isolate and putback from LRU list for page
> migration from several sources(typical example is compaction)
> and trylock_page and sc->gfp_mask not allowing page to be
> reclaimed in shrink_page_list.

Well.  "we're already doing a risky thing so it's OK to do more of that
thing"?

> > 
> > Something else?
> 
> One thing I am worry about was the granularity of the churning.
> Example above was page granuarity churning so might be execuse
> but this one is address space's churning, especically for file LRU
> (i_mmap_rwsem) which might cause too many rotating and live-lock
> in the end(keey rotating in small LRU with heavy memory pressure).
> 
> If it could be a problem, maybe we use sc->priority to stop
> the skipping on a certain level of memory pressure.
> 
> Any thought? Do we really need it?

Are we able to think of a test which might demonstrate any worst case? 
Whip that up and see what the numbers say?

It's a bit of a drag, but if we don't do it, our users surely will ;)
