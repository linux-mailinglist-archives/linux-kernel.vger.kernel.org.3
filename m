Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A721516DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384362AbiEBJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381912AbiEBJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:53:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53F0F2700
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:50:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6B123A;
        Mon,  2 May 2022 02:50:05 -0700 (PDT)
Received: from [10.163.32.39] (unknown [10.163.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B433F774;
        Mon,  2 May 2022 02:49:58 -0700 (PDT)
Message-ID: <cc0e5f88-d562-74c6-d002-b9cf3196e09e@arm.com>
Date:   Mon, 2 May 2022 15:20:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/5] mm: ioremap: Setup phys_addr of struct vm_struct
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de,
        Christoph Hellwig <hch@lst.de>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-3-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220429103225.75121-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 16:02, Kefeng Wang wrote:
> Show physical address of each ioremap in /proc/vmallocinfo.
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/ioremap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 1f9597fbcc07..7cb9996b0c12 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -32,6 +32,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>  	if (!area)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
> +	area->phys_addr = phys_addr;
>  
>  	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, __pgprot(prot))) {
>  		free_vm_area(area);
