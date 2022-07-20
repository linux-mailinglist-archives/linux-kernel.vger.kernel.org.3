Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008D457B644
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiGTMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:23:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D62C12A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:23:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so1230777wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JLxF/0Kiw2UkgVRNOHRym3MLoLLSmnWlmSV1izRp4x0=;
        b=LpC7monAfz692y2h4Q2KLn/5jyoYADgALsIzCxPloN+WT7zwLJWOnyHHwc8uOmCu78
         mPuk41vMa/I+ZLSVv/N2CVs+i48jq+Kf6MGGZtYU+bGxBPU/dxAMrAGMaJiw2efc7+qN
         VeQ0tO/BcE4W0/jVCUXQaDrjcFJ92XKNaDqggtn6FrZCY57T80TiD943XtDGNwVcPc56
         ONk/6pk2GihhpkyOVczATL+AvX3Kea16cESIQwy42DPC0jOpVsH0mkcxbkYSmL1DYnzI
         +g0mR7vU60ElxQhqzmWTgVw8OIUCQk3FIBZnETq4oJUd9wcu+sq5sVL7hvKa2YzzpFV8
         BD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JLxF/0Kiw2UkgVRNOHRym3MLoLLSmnWlmSV1izRp4x0=;
        b=w9olz48ZeHKhJPZvMSQn5jWzba8VF5aHyBgTDABatByw9nFMnpy+WzqZkQpebcjlTb
         2AmzUiD5eQdTR72Fenhk/ilzEgCyAl/JOQlazvk/JuoQfPKQBxJwR8aq0fgcPLhF9E3p
         XdEwm8Dl4QA8n9CDxMnZJfUrnjdwo1XqP9pKNuVVDw1eLeaH3l5vsHpP5vngvmCV/riZ
         M8n4DgvlUI+Ia6ktN6V3AY6INQ0eaLOIA73EE/1Kkc+/4sg7II6iZWbBcCsmjyC9+w5b
         Lr0iYLgaRLg75bgzXXFKQ92pIorJd54xcKHX+hy+uiYrOjh6agIWrOqCRD6iEYKxNGBl
         Qecw==
X-Gm-Message-State: AJIora+pWaVOL/NL6qmgUkteGyObIkPR3NV08EIcAKl4A7G0U47TcJ8h
        UULzFI6qLHbGLhYbvsn4CZ4kxA==
X-Google-Smtp-Source: AGRyM1tFA28srnKBwK4QTFEPCVfHQm4IXMaMq0ccjYMM7Im2eU+1ihq5aMslmYBnlNE9UR8jA/5Ghg==
X-Received: by 2002:a05:600c:3ba3:b0:3a3:5dd:f10f with SMTP id n35-20020a05600c3ba300b003a305ddf10fmr3571064wms.185.1658319806815;
        Wed, 20 Jul 2022 05:23:26 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b00397402ae674sm2636506wmg.11.2022.07.20.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:23:26 -0700 (PDT)
Date:   Wed, 20 Jul 2022 13:23:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls
Message-ID: <YtfzvK0T8pJacsDm@google.com>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jul 2022, haibinzhang(张海斌) wrote:

> How to reproduce:
>     launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 1 > /proc/sys/abi/swp
>        done
> 
> Oops info:
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>     Internal error: Oops: 96000006 [#1] SMP
>     Call trace:
>     update_insn_emulation_mode+0xc0/0x148
>     emulation_proc_handler+0x64/0xb8
>     proc_sys_call_handler+0x9c/0xf8
>     proc_sys_write+0x18/0x20
>     __vfs_write+0x20/0x48
>     vfs_write+0xe4/0x1d0
>     ksys_write+0x70/0xf8
>     __arm64_sys_write+0x20/0x28
>     el0_svc_common.constprop.0+0x7c/0x1c0
>     el0_svc_handler+0x2c/0xa0
>     el0_svc+0x8/0x200
> 
> emulation_proc_handler changes table->data for proc_dointvec_minmax
> and so it isn't allowed to reenter before restoring table->data,
> which isn't right now.
> To fix this issue, keep the table->data as &insn->current_mode and
> use container_of() to retrieve the insn pointer. Another mutex is
> used to protect against the current_mode update but not for retrieving
> insn_emulation as table->data is no longer changing.

Looks as though this lost its Fixes tag during the rework.

  Fixes: 587064b610c7 ("arm64: Add framework for legacy instruction emulation")

Will, are you able to add this retroactively?

> Signed-off-by: hewenliang <hewenliang4@huawei.com>
> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 6875a16b09d2..fb0e7c7b2e20 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -59,6 +59,7 @@ struct insn_emulation {
>  static LIST_HEAD(insn_emulation);
>  static int nr_insn_emulated __initdata;
>  static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
> +static DEFINE_MUTEX(insn_emulation_mutex);
>  
>  static void register_emulation_hooks(struct insn_emulation_ops *ops)
>  {
> @@ -207,10 +208,10 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  				  loff_t *ppos)
>  {
>  	int ret = 0;
> -	struct insn_emulation *insn = (struct insn_emulation *) table->data;
> +	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
>  	enum insn_emulation_mode prev_mode = insn->current_mode;
>  
> -	table->data = &insn->current_mode;
> +	mutex_lock(&insn_emulation_mutex);
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  
>  	if (ret || !write || prev_mode == insn->current_mode)
> @@ -223,7 +224,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  		update_insn_emulation_mode(insn, INSN_UNDEF);
>  	}
>  ret:
> -	table->data = insn;
> +	mutex_unlock(&insn_emulation_mutex);
>  	return ret;
>  }
>  
> @@ -247,7 +248,7 @@ static void __init register_insn_emulation_sysctl(void)
>  		sysctl->maxlen = sizeof(int);
>  
>  		sysctl->procname = insn->ops->name;
> -		sysctl->data = insn;
> +		sysctl->data = &insn->current_mode;
>  		sysctl->extra1 = &insn->min;
>  		sysctl->extra2 = &insn->max;
>  		sysctl->proc_handler = emulation_proc_handler;
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
