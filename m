Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A24BCB65
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiBTAoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 19:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiBTAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:44:38 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2E56217
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:44:18 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d7so22744647qvk.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OLv9zpb4hkkm//e/REiX7j2WaQAi/SIf23HMsMGfwOc=;
        b=DSht2VgXCT3sdm8B33mAvPHKmVYArHC63d/Ou2vgaom/pQoq9qLlwtVN2McWJ8FrBd
         5AVaoqerOtmQQ7brCB0RHK3QmS1iMe3/N6D13z3BZjtYnebHNEISUikDuFfiLltk/mv9
         qxDTiKW8hdAE/y1YlFTY6z6AT5nfdqaeP4zEl/z82cgdqBcJ4a3V8kmjs/KeP0QIT2tw
         VsmayvLvuVbmtt4da4EItnCkG6eEXKeBQnbc+mzxMHfDmmsJtFit9XvniAE55JbWi6U8
         X8zTvOjC5ND1GI+xDe0zPFAq0UnLtGkqdQXsncK5fbUJkWdWODzFOMyfioQnKLJc8SXh
         TyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=OLv9zpb4hkkm//e/REiX7j2WaQAi/SIf23HMsMGfwOc=;
        b=BOXHHDRajuNQoLfbgeQw5kaCe5E0X/h/utp4ZyGURi7fVTx6y+Ij5Tis3mMcDWNpTO
         +wudx1la6waqDr9fayjcyOUTueaYaDIo58KauV+rLxldCp/KXpk4Rut0l17E0Ov7BUI0
         yW38z/mHdVJwX0IdsW7Fdt5PmTJ8xMsZH8RyUMs9T7vDlJhR/sVWldgPR8n68FAk3FIx
         NM2ePlbEHvcEkyYu3PK6e8aLlcZmDXF7dbtcrG4a0Q84h59C5G90Ks3ev2A5GtjKgJJS
         VH04/w3Qecfneyot8Mdc/v/l5Mw7OJvuFi6UYjrm0L0E8UT0QjB6Uje3XPmoJSd32XKC
         VVWA==
X-Gm-Message-State: AOAM530CbLopzU375BQDm8ynwpdDzuvz+knkZO+KnDuONJdcGTpUH/Mv
        jm31rPgn90ljxO9TuOOmNq8=
X-Google-Smtp-Source: ABdhPJxJ1ud/CYhPuDu+yj0IN6tIwNznRf9KmN7VuVXUAHThPFJvPfdGvTmjXsAermWACf4LAEXrOg==
X-Received: by 2002:ac8:7c4b:0:b0:2d1:bff6:e9ef with SMTP id o11-20020ac87c4b000000b002d1bff6e9efmr12635861qtv.22.1645317857986;
        Sat, 19 Feb 2022 16:44:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14sm28038977qtc.31.2022.02.19.16.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 16:44:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com,
        vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Message-ID: <20220220004415.GA1519274@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:
> The root of the problem is that we are selecting symbols that have
> dependencies. This can cause random configurations that can fail.
> The cleanest solution is to avoid using select.
> 
> This driver uses interfaces from the OMAP_GPMC driver so we have to
> depend on it instead.
> 
> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/mtd/nand/raw/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 36e697456ec4..9b078e78f3fa 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on HAS_IOMEM
> -	select MEMORY
> -	select OMAP_GPMC
> +	depends on OMAP_GPMC
>  	help
>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>  	  and Keystone platforms.
> -- 
> 2.17.1
> 
