Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27A4B4472
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiBNIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:41:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiBNIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:41:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3334D9EA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:41:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id p10so7390367pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3PDuWpWatMEsaSvbNwsNqzkAPf6BcghIhJSFC8jSD30=;
        b=gzY3pqJhek5FzBlOdPIHTO6Zi2K/2OsE1k4GoPy0cxDgZ5eiMZT0IOILUlSj/aEB4B
         RjD+XDpKRlfGfkd/XwIm9iSe4Y+3nP7SOyYnzFkzxTVfZMbOltHxTQIQwcsjUxgvliuV
         RbJXxs85zzqTaHQWz1//TsTD6s0IGS66ul3McsyVMsXz87heLAK41x4z7Fg3uQQnq8gs
         jVm4hmClESlQUful+1F5d92AmYMkmuI1xGetK5qucl6SvgNaSvpmZ39gw9Fb73LQQZT/
         RccWidsx/F+CL0uIRPkA+2xst5I/kC1auwLVRK+xr2e8w3MCZvct39/rBc4n3iiEZo/U
         mw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3PDuWpWatMEsaSvbNwsNqzkAPf6BcghIhJSFC8jSD30=;
        b=T9zVyaNBugLs6fOOtsU2wAWT5b7OFGPwlqsYLmeDAOPF1IDs+xz6Rah9OVgY8rGHPV
         TGYONGfd5xwFku8cC45amsRZUka3RAmVBZ3aav2QdhBZkYXrbnqzANxhNriQx+22pK38
         hAy8rvrX6TSOs2KX7RmZAh6P+WAz9D1bBk1ao0kFRwG8oZ8EAaFzF9anDJnyheiuSiag
         i/S7TfpMmh8pc7b+a0E+Xwue/qpEbyBJpjHQ7ZY1UsJVUR9d831UdljUVFrNiEpOPgyE
         t98EtRS/8OLPY+51BVpikLASDIPVzpRdnsXi0iQ9+936fIYmr49XhzwfGMJKD9hYd17t
         l3iQ==
X-Gm-Message-State: AOAM530GR3zzrOmkBqAltnAegLtQ3/1rWXi5zm3nwD+RJbEkt5bHmsWh
        z0dt5/FnlOzAppGWokuGKzH9ZA==
X-Google-Smtp-Source: ABdhPJzmEmYGRRFkNZU0hWCXQ2YmoXneh7/sz9+wMy0j+UOb40vkZ+zxFyd9qfzrI5KxLYmYagM5Pg==
X-Received: by 2002:aa7:900d:: with SMTP id m13mr13355552pfo.14.1644828093877;
        Mon, 14 Feb 2022 00:41:33 -0800 (PST)
Received: from sunil-ThinkPad-T490 ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id 13sm22335469pfx.122.2022.02.14.00.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:41:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:11:24 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Anup Patel <apatel@ventanamicro.com>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv/efi_stub: Fix get_boot_hartid_from_fdt() return
 value
Message-ID: <20220214084124.GA11866@sunil-ThinkPad-T490>
References: <20220128045004.4843-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128045004.4843-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,
   Could you please take this patch? Heinrich and Atish have added RB
   tag. Let me know if I need to do anything.
Thanks
Sunil

On Fri, Jan 28, 2022 at 10:20:04AM +0530, Sunil V L wrote:
> The get_boot_hartid_from_fdt() function currently returns U32_MAX
> for failure case which is not correct because U32_MAX is a valid
> hartid value. This patch fixes the issue by returning error code.
> 
> Fixes: d7071743db31 ("RISC-V: Add EFI stub support.")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/firmware/efi/libstub/riscv-stub.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 380e4e251399..9c460843442f 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -25,7 +25,7 @@ typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
>  
>  static u32 hartid;
>  
> -static u32 get_boot_hartid_from_fdt(void)
> +static int get_boot_hartid_from_fdt(void)
>  {
>  	const void *fdt;
>  	int chosen_node, len;
> @@ -33,23 +33,26 @@ static u32 get_boot_hartid_from_fdt(void)
>  
>  	fdt = get_efi_config_table(DEVICE_TREE_GUID);
>  	if (!fdt)
> -		return U32_MAX;
> +		return -EINVAL;
>  
>  	chosen_node = fdt_path_offset(fdt, "/chosen");
>  	if (chosen_node < 0)
> -		return U32_MAX;
> +		return -EINVAL;
>  
>  	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
>  	if (!prop || len != sizeof(u32))
> -		return U32_MAX;
> +		return -EINVAL;
>  
> -	return fdt32_to_cpu(*prop);
> +	hartid = fdt32_to_cpu(*prop);
> +	return 0;
>  }
>  
>  efi_status_t check_platform_features(void)
>  {
> -	hartid = get_boot_hartid_from_fdt();
> -	if (hartid == U32_MAX) {
> +	int ret;
> +
> +	ret = get_boot_hartid_from_fdt();
> +	if (ret) {
>  		efi_err("/chosen/boot-hartid missing or invalid!\n");
>  		return EFI_UNSUPPORTED;
>  	}
> -- 
> 2.25.1
> 
