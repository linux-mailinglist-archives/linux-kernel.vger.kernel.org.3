Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDC52CB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiESFl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiESFlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:41:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED400A5000
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:41:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c22so4133405pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fjgJyUxglOdNX7ORgfsXOs9MOe0Djm4FQwuHrj7GTTE=;
        b=Kkk2V/Ze8u/GszkRJQ6HDT0Y3PRUy6UbRTQTWtISRk+4RdjlmgLml3lNvJImahYCLE
         QHj/pPvHSBfqcXsh5lvwFpzr8JJ1kP3maZhxdOPOXeHgvuzHkXVgVedPrxym1kfKm5GM
         Yh4FrJKck6E4S7WDodZnXZo/7akxxMK1DimK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjgJyUxglOdNX7ORgfsXOs9MOe0Djm4FQwuHrj7GTTE=;
        b=aoZWuWq9kGwx05ttfkYwH4DPk4coGKAesEs6u1qT7IzUcjNuQrh3j4Big5BtHYfQFU
         WVmSdsq1TXEiI9xRhwlc0YMv0N5VAE3OlhwZvkRtWu71NyTQFaG/UIvgCJ0QNgo04td3
         LG653AWr7EGl931JhyhlT/aw7zAWa21X1i39lFU9lH4kjoJXA7XyZAv+LNeL+6oTIBUh
         RSVGg5SCdTK3DQnoC41o4cNZxnxOVlGUPBdhKjhItZadLDFEFgantgWrDU6Jo/fbaU9s
         9lfYS5hQqPAqvaeu/eKr94T77x5nKgMfPrs/JxtW9bKXXdvi+QYuEKgVk7dxZ9utTf4Y
         jEhA==
X-Gm-Message-State: AOAM530EYvj5BvDtMCIQliEFW66afMJiojS7NtrJuBa0tq8+TUZ/Qhna
        uD9NmwO5GorOdYSlWJzCrI8WGISLdDVGqA==
X-Google-Smtp-Source: ABdhPJxHqltwgTe80L7xytpq/ugnENmQ0t31RUNN4OoXKTpQ2c3WtoGWGY8KwrId2pyzrJLZxAtcXg==
X-Received: by 2002:a05:6a00:1c76:b0:510:8b76:93b5 with SMTP id s54-20020a056a001c7600b005108b7693b5mr3230605pfw.44.1652938903427;
        Wed, 18 May 2022 22:41:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm2677829plb.268.2022.05.18.22.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 22:41:43 -0700 (PDT)
Date:   Wed, 18 May 2022 22:41:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Wrap literal addresses in absolute_pointer()
Message-ID: <202205182240.A8DDA7D4C@keescook>
References: <20220227195918.705219-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227195918.705219-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 11:59:18AM -0800, Kees Cook wrote:
> GCC 11 (incorrectly[1]) assumes that literal values cast to (void *)
> should be treated like a NULL pointer with an offset, and raises
> diagnostics when doing bounds checking under -Warray-bounds. GCC 12
> got "smarter" about finding these:
> 
> In function 'rdfs8',
>     inlined from 'vga_recalc_vertical' at /srv/code/arch/x86/boot/video-mode.c:124:29,
>     inlined from 'set_mode' at /srv/code/arch/x86/boot/video-mode.c:163:3:
> /srv/code/arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array bounds of 'u8[0]' {aka 'unsigned char[]'} [-Warray-bounds]
>   114 |         asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
>       |         ^~~
> 
> This has been solved in other places[2] already by using the recently
> added absolute_pointer() macro. Do the same here.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> [2] https://lore.kernel.org/all/20210912160149.2227137-1-linux@roeck-us.net/
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: x86@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thread ping -- this is still needed for GCC 12. Can an x86 maintainer
either take this or Ack it and I'll carry it?

Thanks!

-Kees

> ---
>  arch/x86/boot/boot.h | 36 ++++++++++++++++++++++++------------
>  arch/x86/boot/main.c |  2 +-
>  2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> index 34c9dbb6a47d..686a9d75a0e4 100644
> --- a/arch/x86/boot/boot.h
> +++ b/arch/x86/boot/boot.h
> @@ -110,66 +110,78 @@ typedef unsigned int addr_t;
>  
>  static inline u8 rdfs8(addr_t addr)
>  {
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
>  	u8 v;
> -	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
> +	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*ptr));
>  	return v;
>  }
>  static inline u16 rdfs16(addr_t addr)
>  {
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
>  	u16 v;
> -	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
> +	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
>  	return v;
>  }
>  static inline u32 rdfs32(addr_t addr)
>  {
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
>  	u32 v;
> -	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
> +	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
>  	return v;
>  }
>  
>  static inline void wrfs8(u8 v, addr_t addr)
>  {
> -	asm volatile("movb %1,%%fs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
> +	asm volatile("movb %1,%%fs:%0" : "+m" (*ptr) : "qi" (v));
>  }
>  static inline void wrfs16(u16 v, addr_t addr)
>  {
> -	asm volatile("movw %1,%%fs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
> +	asm volatile("movw %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
>  }
>  static inline void wrfs32(u32 v, addr_t addr)
>  {
> -	asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
> +	asm volatile("movl %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
>  }
>  
>  static inline u8 rdgs8(addr_t addr)
>  {
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
>  	u8 v;
> -	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
> +	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*ptr));
>  	return v;
>  }
>  static inline u16 rdgs16(addr_t addr)
>  {
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
>  	u16 v;
> -	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
> +	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
>  	return v;
>  }
>  static inline u32 rdgs32(addr_t addr)
>  {
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
>  	u32 v;
> -	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
> +	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
>  	return v;
>  }
>  
>  static inline void wrgs8(u8 v, addr_t addr)
>  {
> -	asm volatile("movb %1,%%gs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
> +	u8 *ptr = (u8 *)absolute_pointer(addr);
> +	asm volatile("movb %1,%%gs:%0" : "+m" (*ptr) : "qi" (v));
>  }
>  static inline void wrgs16(u16 v, addr_t addr)
>  {
> -	asm volatile("movw %1,%%gs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
> +	u16 *ptr = (u16 *)absolute_pointer(addr);
> +	asm volatile("movw %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
>  }
>  static inline void wrgs32(u32 v, addr_t addr)
>  {
> -	asm volatile("movl %1,%%gs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
> +	u32 *ptr = (u32 *)absolute_pointer(addr);
> +	asm volatile("movl %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
>  }
>  
>  /* Note: these only return true/false, not a signed return value! */
> diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
> index e3add857c2c9..c421af5a3cdc 100644
> --- a/arch/x86/boot/main.c
> +++ b/arch/x86/boot/main.c
> @@ -33,7 +33,7 @@ static void copy_boot_params(void)
>  		u16 cl_offset;
>  	};
>  	const struct old_cmdline * const oldcmd =
> -		(const struct old_cmdline *)OLD_CL_ADDRESS;
> +		absolute_pointer(OLD_CL_ADDRESS);
>  
>  	BUILD_BUG_ON(sizeof(boot_params) != 4096);
>  	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
> -- 
> 2.32.0
> 

-- 
Kees Cook
