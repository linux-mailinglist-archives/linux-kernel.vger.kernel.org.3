Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29559B282
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiHUHD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiHUHDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341B140E4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0a6VDXeUDWqpyW5dOeUR66fpQ0IrNu3SkYDJZLhUFfo=; b=XRGOGR1tWbxOf4fDsEL+NOAGv1
        YjukYmQI6hJ3+/xQ/UEv5zWKUjB9onx+ZXXuobJMOVCAhg1TKxSuxD7X0GLQPqIUVDp2t5bNsZLG0
        kA7EdGMiJ3pWzT13YzsWSieLDBa2jyFuSMo5qVs9ZEm+nz7Mac8vJfa3dMg/+xduqLN4OLAMl68ne
        bsc4Xxio8PO6AE4SWwqg2IYMO0TTgS1RzZeQOrebGail+VtL+xYP482C30r9Jte01uIOix7tY/48i
        VKleSSJTRjUQZr1ugne+x2bWv2UI2MdqXLShtcUAyvKcv009mQ1Q97rFA5vshUwH8T5T1coO1gVBl
        DOkTIMYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPezf-00760D-Cc; Sun, 21 Aug 2022 07:03:35 +0000
Date:   Sun, 21 Aug 2022 00:03:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHYx0eXouIWnN8Z@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-8-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (unlikely(!mem_init_done)) {
>  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> +			return IOMEM_ERR_PTR(ret);
>  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
>  		fixmaps_used += (size >> PAGE_SHIFT);
>  
> +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
>  			fixmaps_used -= (size >> PAGE_SHIFT);
> +			return IOMEM_ERR_PTR(ret);
> +		}
> +
> +		return (void __iomem *)(offset + (char *)v);
>  	}

This code needs to go away, and all very early boot uses of ioremap
need to switch to use early_ioremap insted.
