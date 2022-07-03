Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF95643BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiGCDrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:47:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003F95A3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rucRFvpOsDc52A2QntChyESyfLe7Ora1LslugDlcseU=; b=ZRipj/oToh79hyhqe/Obn0YXtg
        Ori3VMGREiPDCg7n5Xs4NVzE/mKqUpLYI6S2/S8qs/HLwGA/cx8O1YS9Hgn1S0etp+3SHNF9SwB7i
        gX2C/2qv0xm1oMduNsmiC2/RzZ30eaP4z+o4//nzcdBo0aVOfaIzMY8t44ZwRdXcveb9unhea62Fc
        S0YNbtFUtC4ApLuEjRG/S0UDRgPZVpdkExPKrVdnwk/hALr/hvpJLxyLVsjtJbuCGy6SvnV+eqt+y
        cfTs8+oR4ykuREqyrf9xgFb0Qfz5k0+zrqXt70UZiAQuZ19uGgHCc/kNA9Dhuy+7Le1P6ulOuPjPe
        bCcNmssg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7qZf-00GDeQ-Ql; Sun, 03 Jul 2022 03:47:07 +0000
Date:   Sun, 3 Jul 2022 04:47:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <YsERO3OpZSJuC4hW@casper.infradead.org>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:11:15PM +0800, Baolin Wang wrote:
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	pud_t *pud;
> +	struct page *page;
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> -	if (pud)
> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);

Argh.  I just got rid of PMD_ORDER from PA-RISC.  Now Loongstupid has
reintroduced it, and worse introduced PUD_ORDER.  See commit
7bf82eb3873f.
