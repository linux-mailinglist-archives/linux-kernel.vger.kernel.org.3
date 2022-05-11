Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2E5229DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiEKCcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiEKCcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:32:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B730FD5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF207B81F93
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FACC385D8;
        Wed, 11 May 2022 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652236336;
        bh=/Hp6dU5hclTkoExV1aXWnjWD+RcFFs7kpZHwfwv6wEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8RU/4GYhn7UPYgYuI1ACj0GMtmWe15Z9yy8qhGLuCOojJ817oL44x7KTrsCqd15i
         HBSah0TyT99EjnD+fwvU5YclqKzLpJ7u4tiz6S2/R8DMA1Wckeo4YKmpbsJ/Ox/Vlv
         Shy2mseOIgOs9IHx+HO0yWs9B+eo7WkAod8q9qs0=
Date:   Tue, 10 May 2022 19:32:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Message-Id: <20220510193215.14ed7e3fb70857738e10c0a2@linux-foundation.org>
In-Reply-To: <c44769b3-a132-63a5-fd40-4d483497dff2@bytedance.com>
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
        <20220510115922.350a496ca8b91686c1758282@linux-foundation.org>
        <c44769b3-a132-63a5-fd40-4d483497dff2@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 10:19:48 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> ,,,
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -35,6 +35,17 @@ struct folio_batch;
> >>   /* Do not use these with a slab allocator */
> >>   #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
> >>   
> >> +#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
> >> +	static bool __section(".data.once") __warned;			\
> >> +	int __ret_warn_once = !!(cond);					\
> >> +									\
> >> +	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
> >> +		__warned = true;					\
> >> +		WARN_ON(1);						\
> >> +	}								\
> >> +	unlikely(__ret_warn_once);					\
> >> +})
> > 
> > I don't think WARN_ON_ONCE_GFP is a good name for this.  But
> > WARN_ON_ONCE_IF_NOT_GFP_NOWARN is too long :(
> > 
> > WARN_ON_ONCE_NOWARN might be better.  No strong opinion here, really.
> 
> I've thought about WARN_ON_ONCE_NOWARN, but I feel a little weird 
> putting 'WARN' and 'NOWARN' together, how about WARN_ON_ONCE_IF_ALLOWED?

I dunno.  WARN_ON_ONCE_GFP isn't too bad I suppose.  Add a comment over
the definition explaining it?

> > 
> >> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >>   	 * We also sanity check to catch abuse of atomic reserves being used by
> >>   	 * callers that are not in atomic context.
> >>   	 */
> >> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> >> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> >> +	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> >> +				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
> >>   		gfp_mask &= ~__GFP_ATOMIC;
> >>   
> >>   retry_cpuset:
> > 
> > I dropped this hunk - Neil's "mm: discard __GFP_ATOMIC"
> > (https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name)
> > deleted this code.
> > 
> 
> This series is based on v5.18-rc5, I will rebase it to the latest next
> branch and check if there are any missing WARN_ON_ONCEs that are not
> being handled.

Against git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm branch
mm-unstable, please.  That ends up in linux-next, with a delay.
