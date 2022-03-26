Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161D4E8101
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiCZNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCZNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:18:08 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071320037F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:16:31 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 928711B4426
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:16:30 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id Y6HOn26ygRnrrY6HOnHxhw; Sat, 26 Mar 2022 08:16:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DEVWh3k1tzSFjzVItEHtWw3rtg9fugVFhCv5VfMBq24=; b=5YHM5ynr5A/lRUUAjl7R/X93X1
        fAFyTO/Mx5Qp28hu4p4nwvQWVk0CzCTUaXnQsiGXoOrLEi5ee3FG20aLwcGqFg1g+EW2XNBxrokaK
        Z4ZOk9nxSJnsQ1X0cfPThkPuWO//+f85VVEoJXkV2ZASENwPH6pNAqKDFlXiUUKNUhn57F2NrFKxZ
        EhiTV7DDdbSzTGVQRqqR+x3YkmYEPUj1uRGPMfvfpDbrfZqVh204ndnMtSdEh4cKvVlURxNc7DYhg
        XVDgYPAMGSJcmUTuQd4N9vJ7E/UneqyHBUzn+yfG//qQSP2u9oVcaV8QSnPX1DlhtFxzgiL19Wlaz
        dLVqxqIA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57670 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nY6HO-002EmQ-2q; Sat, 26 Mar 2022 13:16:30 +0000
Date:   Sat, 26 Mar 2022 06:16:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH 1/2] habanalabs: make sure device mem alloc is page
 aligned
Message-ID: <20220326131629.GA198653@roeck-us.net>
References: <20220221084914.493784-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221084914.493784-1-ogabbay@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nY6HO-002EmQ-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57670
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:49:13AM +0200, Oded Gabbay wrote:
> From: Ohad Sharabi <osharabi@habana.ai>
> 
> Working with MMU that supports multiple page sizes requires that mapping
> of a page of a certain size will be aligned to the same size (e.g. the
> physical address of 32MB page shall be aligned to 32MB).
> 
> To achieve this the gen_poll allocation is now using the "align" variant
> to comply with the alignment requirements.
> 
> Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/misc/habanalabs/common/memory.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index 385bf3448c73..0b76f40e9930 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -90,8 +90,8 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>  	struct hl_vm_phys_pg_pack *phys_pg_pack;
>  	u64 paddr = 0, total_size, num_pgs, i;
>  	u32 num_curr_pgs, page_size;
> -	int handle, rc;
>  	bool contiguous;
> +	int handle, rc;
>  
>  	num_curr_pgs = 0;
>  
> @@ -110,7 +110,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>  	contiguous = args->flags & HL_MEM_CONTIGUOUS;
>  
>  	if (contiguous) {
> -		paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
> +		if (is_power_of_2(page_size))
> +			paddr = (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool, total_size, NULL,
> +							page_size);

I see that this is fixed in -next, but ...

> +		else
> +			paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);

... this has an unnecessary typecast in -next (gen_pool_alloc() returns
unsigned long, not a pointer), and ...

>  		if (!paddr) {
>  			dev_err(hdev->dev,
>  				"failed to allocate %llu contiguous pages with total size of %llu\n",
> @@ -144,9 +148,14 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>  			phys_pg_pack->pages[i] = paddr + i * page_size;
>  	} else {
>  		for (i = 0 ; i < num_pgs ; i++) {
> -			phys_pg_pack->pages[i] = (u64) gen_pool_alloc(
> -							vm->dram_pg_pool,
> -							page_size);
> +			if (is_power_of_2(page_size))
> +				phys_pg_pack->pages[i] =
> +						(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> +										page_size, NULL,
> +										page_size);

... this still causes a compile error when building 32-bit test images.

Building mips:allmodconfig ... failed
--------------
Error log:
drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer to integer of different size

Guenter

> +			else
> +				phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> +										page_size);
>  			if (!phys_pg_pack->pages[i]) {
>  				dev_err(hdev->dev,
>  					"Failed to allocate device memory (out of memory)\n");
> -- 
> 2.25.1
> 
