Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484165A0E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiHYK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiHYK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:56:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A906A98D1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:56:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so23288327wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dQ5qxruqxh3KGlaUc7JkBGn3OziOOUhgI201fMCzvDs=;
        b=lji9Dlw9/DT4OUH/CFvf/ZgGEOntsizxLFo6C1pjQIwXS5g3/Gd8db2EiO0qcQGDSZ
         FCCUrh+fCVLHxkV7QCxpZRmMU4ZZJejQpZWvVSFbQ5NIKX8VaOv8hpGMjrO0+uuLmmNz
         ToZU7pUVeAV6cnSOcd8RAOeQsG3drNGlkXGht6T2/o0koMAD/OtvAvfS2EvYSAnNsgew
         9M02148CkoJ1QZJcYGTOKAd7j534B3VmQgqaonceW79f1whJU752HEZATPwFJ2baYBOE
         Uil3PTom28+zPUlFfDDxYAfm3qjapKKZHYKvKttketV+G2yMKolYcRWyoZMSceyXOj8v
         ItZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dQ5qxruqxh3KGlaUc7JkBGn3OziOOUhgI201fMCzvDs=;
        b=nfu55Dp5MhSrMDcMdKd7IcvIQpHEzDoDo2lSGFfU8RcjELkY6+56AYj84iy0pZkjlS
         UoCwwAlgcKmUH5UbP8Gkm9s3jTltM1wNBJx3BsO05pJ4VhabF+dgDFuu/H4b+UNz8eep
         2tDid3fQ0wA39jy9V+F9nNWDax6e5tVQl/Oh1a3lJI4fWURonjPs+Q296c+bUur25t+6
         6CVaG0YnTqyJSwLmWv6URe6O7JSK9PvtKHDBkTWx8ua11dAzor8kb3nIm7OxgcSoY1xG
         1BaB+2zCNUgtesOrujPIPIibkF56V1RuGni/3d97yFJOC13iO4rFMw6ZsBAJ9P7UF2f4
         RosA==
X-Gm-Message-State: ACgBeo2PXGj8Hh1JySYWvi4DuiWfCYOi0l4RBPwoJriBXtKBE6pJNEdV
        csjGZZS2T/WVsPFcN1MdtdE+kw==
X-Google-Smtp-Source: AA6agR7VRGSOjNnHjALlK2/vuTSmeZeoEQ/oNbpPf07thckXdKCJDvdqECp5OgqhKAAGq/RFu6s7Ag==
X-Received: by 2002:a05:6000:2a3:b0:225:7ce8:a318 with SMTP id l3-20020a05600002a300b002257ce8a318mr1294505wry.350.1661424962454;
        Thu, 25 Aug 2022 03:56:02 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c210b00b003a531c7aa66sm4816868wml.1.2022.08.25.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:56:01 -0700 (PDT)
Date:   Thu, 25 Aug 2022 12:56:00 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename
 __get/put_user_nocheck to __get/put_mem_nocheck
Message-ID: <20220825105600.ezueddmwehob42rf@kamzik>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-2-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815032025.2685516-2-tongtiangen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:20:24AM +0000, Tong Tiangen wrote:
> Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
> __get/put_kernel_nofault(), which is not always uaccess, so the name with
> *user* is not appropriate.
> 
> Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
> __get/put_user_nocheck()
> 
> Only refactor code without any functional changes.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/riscv/include/asm/uaccess.h | 48 ++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 855450bed9f5..1370da055b44 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -50,7 +50,7 @@
>   * call.
>   */
>  
> -#define __get_user_asm(insn, x, ptr, err)			\
> +#define __get_mem_asm(insn, x, ptr, err)			\
>  do {								\
>  	__typeof__(x) __x;					\
>  	__asm__ __volatile__ (					\
> @@ -64,12 +64,12 @@ do {								\
>  } while (0)
>  
>  #ifdef CONFIG_64BIT
> -#define __get_user_8(x, ptr, err) \
> -	__get_user_asm("ld", x, ptr, err)
> +#define __get_mem_8(x, ptr, err) \
> +	__get_mem_asm("ld", x, ptr, err)
>  #else /* !CONFIG_64BIT */
> -#define __get_user_8(x, ptr, err)				\
> +#define __get_mem_8(x, ptr, err)				\
>  do {								\
> -	u32 __user *__ptr = (u32 __user *)(ptr);		\
> +	u32 *__ptr = (u32 *)(ptr);				\

Doesn't casting away __user reduce sparse's utility?

>  	u32 __lo, __hi;						\
>  	__asm__ __volatile__ (					\
>  		"1:\n"						\
> @@ -88,20 +88,20 @@ do {								\
>  } while (0)
>  #endif /* CONFIG_64BIT */
>  
> -#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
> +#define __get_mem_nocheck(x, __gu_ptr, __gu_err)		\

The patch replaces all get/put_user instances with get/put_mem,
but what about 'gu' and 'pu' instances (which are presumably short
for get/put_user)?

Thanks,
drew
