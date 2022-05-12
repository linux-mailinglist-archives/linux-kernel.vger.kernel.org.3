Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36825243C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbiELD53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbiELD5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6822B26
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB8360F47
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCBFC385B8;
        Thu, 12 May 2022 03:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652327842;
        bh=53MI5L2TTsXVrR0+maeQDB6x59/snOKRo6bSDL9T59o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=elZql7crJ753Qa6Q6fe8U2r0/+q0xdzvdkEGMgmS8yzt0Mf1Xn3FDsdZ7k3CuHXoo
         B09ww8MkDgFtXmnjAHxwUtw9LFqtL670fcLx+eI+PFKmg8Y/8fDUBTj8LAKL9lReAU
         vq7PO4mH3R3DtXwzjYVRjI4y3GLSXC6UGBXPttn3ttl4XhF49jaz8sq+uH1u2KK0Wa
         aSNN3rcVSE5cDvgXE5M7on4nTk8X7OlCFDKpmGu6PX6MTReOpC90ZhjfveqWvi+OT6
         wy+zCBUTFvErK+dFxMez9HVDEYJ/6+CLjH7u/NbuQQyxGG7EJFmZpTnVynVfll0A6a
         Z/jvEkTiKMu8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5FF835C05FC; Wed, 11 May 2022 20:57:22 -0700 (PDT)
Date:   Wed, 11 May 2022 20:57:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220512035722.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:18:56PM -0700, John Hubbard wrote:
> On 5/11/22 18:08, John Hubbard wrote:
> > On 5/11/22 18:03, Minchan Kim wrote:
> > > > 
> > > > Or there might be some code path that really hates a READ_ONCE() in
> > > > that place.
> > > 
> > > My worry about chaning __get_pfnblock_flags_mask is it's called
> > > multiple hot places in mm codes so I didn't want to add overhead
> > > to them.
> > 
> > ...unless it really does generate the same code as is already there,
> > right? Let me check that real quick.
> > 
> 
> It does change the generated code slightly. I don't know if this will
> affect performance here or not. But just for completeness, here you go:
> 
> free_one_page() originally has this (just showing the changed parts):
> 
>     mov    0x8(%rdx,%rax,8),%rbx
>     and    $0x3f,%ecx
>     shr    %cl,%rbx
>     and    $0x7,
> 
> 
> And after applying this diff:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..df1f8e9a294f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct
> page *page,
>         word_bitidx = bitidx / BITS_PER_LONG;
>         bitidx &= (BITS_PER_LONG-1);
> 
> -       word = bitmap[word_bitidx];
> +       word = READ_ONCE(bitmap[word_bitidx]);
>         return (word >> bitidx) & mask;
>  }
> 
> 
> ...it now does an extra memory dereference:
> 
>     lea    0x8(%rdx,%rax,8),%rax
>     and    $0x3f,%ecx
>     mov    (%rax),%rbx
>     shr    %cl,%rbx
>     and    $0x7,%ebx

That could indeed be a bad thing on a fastpath.

							Thanx, Paul
