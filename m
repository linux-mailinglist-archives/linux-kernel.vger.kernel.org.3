Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD99D53E2EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiFFHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFFHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:50:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BDB41D4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPxHfG/UDxYj0oyJrzzEbK9o4LGHULeUwDrGsln6nJ0=; b=l86XAKhUWNGhIFaLw0lQV9B3IH
        WxUjDPk3Xsa0F1oUwNdgazNtu+z98w/Ybo1JCpWphHo2DDAw+XETdERrsD5RZNoVsWRikF1xjGDUY
        3V3sz883b4fH21ZoY7JFU1/sPyiRPhzTDBirUZibgFLt3ddPM9/HcrIVPhLx4ugtRtD1m5jKdtPhx
        Il2PDQ42+0210Ffv7KYmRc9ocCx0oy61LeMab42M8/90f8sithyIQJtAlhByLYSwGFUbGnchIa6Ue
        2a55iC8fe+XWjpdZbouAz+p4+ibIEhYl0XTqvLjR/eIxFdtLFBikK0pjK6v7tKrtbIPL0M0uZf5ZN
        Rs8K2TGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny7V8-00HZxE-Dc; Mon, 06 Jun 2022 07:50:14 +0000
Date:   Mon, 6 Jun 2022 00:50:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 2/6] mm: ioremap: Use more sensibly name in
 ioremap_prot()
Message-ID: <Yp2xtsMaULU4dZJt@infradead.org>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-3-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 03:48:11PM +0800, Kefeng Wang wrote:
> Use more meaningful and sensibly naming phys_addr
> instead addr in ioremap_prot().
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/asm-generic/io.h |  2 +-
>  mm/ioremap.c             | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ce93aaf69f8..e6ffa2519f08 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,7 +964,7 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);

This adds an overly long line now.

> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)

Same here.
