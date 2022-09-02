Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727F5AABC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiIBJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiIBJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:49:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75ECCEB03
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:49:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so4242398wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iTtfs4ZEmz2CO0tqyShdZy5SmT8da7zI2nW4mYiBg+c=;
        b=X4IvpiG63ejRn1EIKWvGaz7DCDnZqy0WSyVucEnSYcPk2w1QrY+gyJyFJFC08kfsaD
         oDoVxupIZJhGur5lGQH2eM1a0R813H0MUmqu3G9RsT2CzXFdJDJwAMbcDyxkr4fxZkPu
         NFQedKIOwRmY6j3lcsiCpBRJCjjGf+xvutAw4uh/Wy+FbkZMULs2KXGStwmShxGNSKgm
         twUoq1+Q/uSxiLicDLNA8We0KLynTdEhxgXWSKQbHVWSUEe/Edv5eFvGC+PIXAC3C1Df
         JEJ/lHlzwCdJTpgKkWuKGZxQIKRPk+cuFLzLYN8NoGa8asJkIAe2mBiAASKH+TAUeL6C
         EcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iTtfs4ZEmz2CO0tqyShdZy5SmT8da7zI2nW4mYiBg+c=;
        b=4eHGNowtR0NjPfPHzBCMU25stwY0zPA16FND1GiA/b4xUtcidYdUvXFh6xLbyH1cTP
         vY+dXO+TEWE3mPHTt5JFq0zdKh05upNpmK9bjdd7rrIa5OicXd5+BHoe8FAsHEj86a73
         zUr0o9JLxBWYvXgp7ZQQRROjYzogefs9FIsnWud+2Mrf5OooacpRCjcd7KA7WMgUIUam
         R1OjZ6LGpQX1FsXdbtuEEs0WwSyuhE/4vt/YCbEX6LWOiheHbDNid+v+xd0Iy3nTQpQJ
         F8zb/jobTzKkFqWlyfPdYpZRcpLXSM0GXeO9V7qWnXDhQkMAmCAi91VHcWlGRx+x1F2R
         EdIg==
X-Gm-Message-State: ACgBeo1577x9FhtIxaCqJyfYz7BLQnE7zkQryAwIk4gN0L6cOpHa2MVW
        vTXu2x9mmtW7L3QI3874SULnHA==
X-Google-Smtp-Source: AA6agR7g6UjnTtC54SC24/+GwV++cMHs/qNuPRNWMTUDeFLY9RsZbZndkhHBZal1E6VW66nimnslZQ==
X-Received: by 2002:a1c:202:0:b0:3a8:4197:eec0 with SMTP id 2-20020a1c0202000000b003a84197eec0mr2204962wmc.83.1662112180473;
        Fri, 02 Sep 2022 02:49:40 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a50924f1c0sm1700998wmb.18.2022.09.02.02.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:49:40 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:49:39 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Message-ID: <20220902094939.wvzovl6ytujtjbtm@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901222744.2210215-1-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Please use a cover-letter for a patch series. They allow the series to be
threaded better and people can reply to the cover-letter with series-wide
comments. For example, I'd like to reply to a cover-letter now with

For the series

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

but now it looks like I need to go back and reply to each patch
separately.

Thanks,
drew

On Fri, Sep 02, 2022 at 12:27:41AM +0200, Heiko Stuebner wrote:
> This can also do without the ifdef and use IS_ENABLED instead and
> for better readability, getting rid of that switch also seems
> waranted.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/cpufeature.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 553d755483ed..764ea220161f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -253,16 +253,13 @@ void __init riscv_fill_hwcap(void)
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
>  {
> -#ifdef CONFIG_RISCV_ISA_SVPBMT
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> +	if (!IS_ENABLED(CONFIG_RISCV_ISA_SVPBMT))
>  		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, SVPBMT);
> -	}
> -#endif
>  
> -	return false;
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	return riscv_isa_extension_available(NULL, SVPBMT);
>  }
>  
>  static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
