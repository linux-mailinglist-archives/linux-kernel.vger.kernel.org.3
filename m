Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8F5AEEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiIFPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiIFPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:31:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DBC12FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:42:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so23757429ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=obQJf2HknhO5LzamvcoZsXBNmP3jnXXMiHwGcU1ms9o=;
        b=A5Qc+A50njRhw1b0a1ZGGwu5fDE1YrtFg3Ico2zug/0A42aYG+KK8KbolxcVUBi9Bb
         ZhCzClL+eQS5DYrAC5FPM5lebzThdjB/tYzCGO/RBUYfQ4K7RTCjmpYHCaNhPSswnqil
         ntuyKzTa/ejN3Q6GN11yHAIxy1dYX5rsFFiMptv2jQRX/tDbP/Dqp5/eaFT9PBcXBNDC
         3jJaj5mlij2DLvjBXYIx5UZoZmNGGKOzPUstbAjgggv30h4YMJRlnmPQIRvSzPNXApVL
         XoClgGvta8m/TpOCQjXI9QnyaxOezSeZ088kDGPvRTzquGOd44bQe34u/+NhTAKIws5U
         PCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=obQJf2HknhO5LzamvcoZsXBNmP3jnXXMiHwGcU1ms9o=;
        b=5mfn9eZmaoH2jhTySJWLFeJ0biMFHsdOS66pP67oWrF21egkaW2WuCv4AFqzv5QeZl
         1pRi8q1aa2j3rmwQ6wG/3MfzkT55OesiehkXG6ep7qZEPwwSEVShe0IV8szV3j9BdMAg
         IUPT9U16I9ADcPdEQI3ZbWpcdBPKJEHMxK258X7BKJO2Qf9UH8rBQi+EB0rx/zhmcgIF
         vhZRzOqiaZK4wrtFDA+TvA7M8njVVuE1O7D3udIVLwlwqYorjvCTzxl1ger8Hh4fDZDF
         8kIXjK0nLIAZe8V+RseQhEj3nbI1+Wl9Xh0wgLTzxxJmIFs6Ala+GuNZ1w7SxCXSVdCF
         h0CQ==
X-Gm-Message-State: ACgBeo2yolpcHOl4Pf4E/ypjfw9aapT+PNiLswUpeInOGPoKzRMb5986
        qdZ7G6YPqiyY0trvLZ1StShBdQ==
X-Google-Smtp-Source: AA6agR4M8LGhVDadjv3GI5r/7o8QPMQuVlDlgU4uWaZusJxp2iRDYJDDjLlZ+KbYRkK12sJNOWh6vQ==
X-Received: by 2002:a17:907:9721:b0:741:5c68:a0a4 with SMTP id jg33-20020a170907972100b007415c68a0a4mr31455536ejc.81.1662475287925;
        Tue, 06 Sep 2022 07:41:27 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b007308812ce89sm6600708ejb.168.2022.09.06.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:41:27 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:41:26 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jinyu Tang <tjytimi@163.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        anup@brainfault.org, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org, heiko@sntech.de,
        tongtiangen@huawei.com, sunnanyong@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org
Subject: Re: [PATCH v1] riscv : support update_mmu_tlb() for riscv
Message-ID: <20220906144126.3enx6y2mhevrc4ur@kamzik>
References: <20220906121921.8355-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906121921.8355-1-tjytimi@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:19:21PM +0800, Jinyu Tang wrote:
> Add macro definition to support updata_mmu_tlb() for riscv,
> this function is from commit:7df676974359 ("mm/memory.c:Update 
> local TLB if PTE entry exists").
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..84a791d54f95 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -418,6 +418,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  	local_flush_tlb_page(address);
>  }
>  
> +#define	__HAVE_ARCH_UPDATE_MMU_TLB
           ^ just a single space here, please, as all the other
	     'define __HAVE's in this file

> +#define update_mmu_tlb	update_mmu_cache
> +
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  		unsigned long address, pmd_t *pmdp)
>  {
> -- 
> 2.30.2

This seems like the right thing to do, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

I'm curious if this patch is the result of debugging something? Or what
led you to post it?

Thanks,
drew
