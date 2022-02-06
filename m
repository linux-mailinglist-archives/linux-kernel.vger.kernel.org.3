Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E064AB265
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiBFVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiBFVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:33:53 -0500
X-Greylist: delayed 12031 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 13:33:52 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9B3C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B2FBB80EBC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 21:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9CBC340E9;
        Sun,  6 Feb 2022 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644183230;
        bh=h2SajfhFf8TtHLMiyVXH0IM+grwV0nx1jK8VevBkp+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgC+G0VLvmJHtYN9yV9jHhyBdM2VnP7MAqeIWcilx+Gh+pSysK/c1VAwtpgnLkVZC
         3csqQGfetTG/+vLf2+PWyPDuguuhF9yB6zQcZh7PpCvwR1HA4J5u+gjtXa1u+zBJ0T
         f5XOHhO40wDysggrbLCTEkyU9CE+WsbIvOT6gntWJbqTnQSqSIhnwRFlGFw5fz/uGL
         d9FbIS34Jsa1nszqjLrF4s70MSEdCBzUE/b9k8hZQLAiypK5FmYIW2puwUt1HrfLyg
         nclj03z7rEz+2iPckBLa4axUsOPfSUgFXZVp9Nh17IQWvdKfzX6X9ogAosL7JZzA2b
         lrEbKPI+FPYnA==
Date:   Sun, 6 Feb 2022 23:33:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/75] hexagon: Add pmd_pfn()
Message-ID: <YgA+tGqw70ZBTu/1@kernel.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-42-willy@infradead.org>
 <YgAPtxN7WW222SFI@kernel.org>
 <YgAztSuYrKXZBgJx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgAztSuYrKXZBgJx@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:46:45PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 06, 2022 at 08:13:11PM +0200, Mike Rapoport wrote:
> > On Fri, Feb 04, 2022 at 07:58:18PM +0000, Matthew Wilcox (Oracle) wrote:
> > > I need to use this function in common code, so define it for hexagon.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  arch/hexagon/include/asm/pgtable.h | 3 ++-
> > 
> > Why hexagon out of all architectures?
> > What about m68k, nios2, nds32 etc?

> Presumably they don't support CONFIG_TRANSPARENT_HUGEPAGE.
> This code isn't compiled when THP are disabled; at least I haven't
> had a buildbot complaint for any other architectures.

m68k defconfig fails:

  CC      mm/page_vma_mapped.o
mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
mm/page_vma_mapped.c:219:20: error: implicit declaration of function 'pmd_pfn'; did you mean 'pmd_off'? [-Werror=implicit-function-declaration]
  219 |     if (!check_pmd(pmd_pfn(pmde), pvmw))
      |                    ^~~~~~~
      |                    pmd_off
> 
> > > +#define pmd_pfn(pmd)	(pmd_val(pmd) >> PAGE_SHIFT)
> > 
> > I'd put it in include/linux/pgtable.h inside #ifndef pmd_pfn
> 
> That's completely upside down.  pmd_pfn() should be defined by each
> architecture (because generic code can't know anything about the format
> of PMDs); if anything pmd_page() should be defined in linux/pgtable.h
> in terms of pmd_pfn.
> 
> I'm not signing up to do that work as part of this series.  That seems
> like a distraction.

-- 
Sincerely yours,
Mike.
