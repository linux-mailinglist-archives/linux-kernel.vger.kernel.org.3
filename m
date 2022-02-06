Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223C4AB287
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbiBFWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiBFWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:05:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942EC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUG/BeH1eoOJbWKGISx6FgIeT1FgLx8h+BHS51Koo9w=; b=TXmG0YQ/hITDxJ4ZRMAGSIFoH5
        tUa31/EGrTBx3DYdFFJ6W3RcDlMtXeAKGJ/C+lQstIeqgDOTCQpO4GOcAyRLt2/MrUQPDutK8KUSq
        OGuQyRO4YDA0tCBZn2AtcrKVPoXopc8zlpAT31tUNghY2ZL+7yMfPbSjQxEpET4jRxPusOjxNjQ5p
        t4GdpBpmVWIKr7SZHeVSkJGFwAV5Dxw6h6n7WXCOnvHWLiU2hA+/oIAROdYfuTzuoKzrtpsl1+2Zv
        XIaWc3jnzKXQQZhjptdCGTOn6/HsSmqY5PA41REv0BPHEpLw/9RXfaTCiUP2+nmPIs9u12byCIulE
        q6Se2ppw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGpf5-00Fm8w-9s; Sun, 06 Feb 2022 22:05:35 +0000
Date:   Sun, 6 Feb 2022 22:05:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/75] hexagon: Add pmd_pfn()
Message-ID: <YgBGLyl4SKWikon0@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-42-willy@infradead.org>
 <YgAPtxN7WW222SFI@kernel.org>
 <YgAztSuYrKXZBgJx@casper.infradead.org>
 <YgA+tGqw70ZBTu/1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgA+tGqw70ZBTu/1@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 11:33:40PM +0200, Mike Rapoport wrote:
> On Sun, Feb 06, 2022 at 08:46:45PM +0000, Matthew Wilcox wrote:
> > On Sun, Feb 06, 2022 at 08:13:11PM +0200, Mike Rapoport wrote:
> > > On Fri, Feb 04, 2022 at 07:58:18PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > I need to use this function in common code, so define it for hexagon.
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  arch/hexagon/include/asm/pgtable.h | 3 ++-
> > > 
> > > Why hexagon out of all architectures?
> > > What about m68k, nios2, nds32 etc?
> 
> > Presumably they don't support CONFIG_TRANSPARENT_HUGEPAGE.
> > This code isn't compiled when THP are disabled; at least I haven't
> > had a buildbot complaint for any other architectures.
> 
> m68k defconfig fails:
> 
>   CC      mm/page_vma_mapped.o
> mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
> mm/page_vma_mapped.c:219:20: error: implicit declaration of function 'pmd_pfn'; did you mean 'pmd_off'? [-Werror=implicit-function-declaration]
>   219 |     if (!check_pmd(pmd_pfn(pmde), pvmw))
>       |                    ^~~~~~~
>       |                    pmd_off

Ok, so this whole thing is protected by "if (pmd_trans_huge(pmd))"
which is defined to be 0 if !THP.  But obviously, gcc is trying to parse
it.  So I think we need something like:

#ifndef CONFIG_TRANSPARENT_HUGEPAGE
static inline unsigned long pmd_pfn(pmd_t pmd)
{
        BUG();
        return 0UL;
}
#endif

but that can have its own problem if architectures define pmd_pfn()
when they don't have CONFIG_TRANSPARENT_HUGEPAGE.  Which of course, they
can do.
