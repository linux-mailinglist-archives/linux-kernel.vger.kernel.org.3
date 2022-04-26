Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F494510A15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbiDZUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354545AbiDZUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:17:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031F1A15D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:43 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so20575189fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=avrL8kBGOAtHrlufWidGzW1SmL7urHwKdn/4+Y9ZapU=;
        b=ekwF9H5Lj4Esed2D7g0ZUxlVHCSLuJ639rdDmoSOqIXBY3XdEIHYO22C8h1/MujRSd
         JM+nnb9rUVZTY941rNSAtVeqzY1AVWUnpT0BpKB0m1L88RNWJr8llN9wDMolf7GjsaGc
         ZuQxQq5xU67IJb3sZ0x4kQm1JzrkYCC0CC9KbMZAIdVEo3MNXS5iB9U0P0+V4h71J4qZ
         OUVLMaztRxOBpZTQtW2l/TjH0qJ9+WvHmGi5/AIVzlAjcvio383qf5MJcUwbU8tBjXOM
         +/ggS4GDBBmiqwk6w8KJWSiJBKPono+ukIA8elVgStzLeHt70xT8Zel4SxrJ6KuI42u7
         x5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=avrL8kBGOAtHrlufWidGzW1SmL7urHwKdn/4+Y9ZapU=;
        b=xCSKCmtSqOp6DTPYgu9Ulp+0MWq+RqnP859QVJlgDf9G8RhzNifyHQ8dtGkCOnRSVS
         unXxicRryRnW8G3M9q+3iTD4+ByClLmhHhhbzXpICwsnE4olUFr/JMHDxsKFVDnPcfqG
         vhib3AfRZseC3ruf7GfMRNnzs8gi94ddTUZXN7GN/BCUkIi0swZt7wEVp5sOe4hChH0y
         xpsHR0poFCQqIBZDm59Pjo5XF1Qbs3H5vVg0bYxo3Bg/lscDch7WWCDNHrxY+QbDF+yv
         okdNvOxiVfN0umKu6j09X6SR9nzWwWWq0enHx02u1o9tPJd4kfL08Td1g/VlftnboMs5
         /ikw==
X-Gm-Message-State: AOAM5318pprQkgSetOaeGuyJqWO908nsT/bAUdx2c+NLVWyXT6nV88qO
        Kulo8r9siZGuCGBDM9Og8nE=
X-Google-Smtp-Source: ABdhPJyLGBKirk1hBPpVS+1Z9qsk4+S0BscWuLt5Raf+YLahHgrw6ExNxnQyBMPC1NF+gSFUJSzLJw==
X-Received: by 2002:a05:6870:4728:b0:e9:4272:fe3 with SMTP id b40-20020a056870472800b000e942720fe3mr4875695oaq.61.1651004083313;
        Tue, 26 Apr 2022 13:14:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j72-20020a9d17ce000000b005e6b89f9f54sm5321108otj.32.2022.04.26.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:14:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:14:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] soc: rockchip: Fix compile-testing SoC drivers
Message-ID: <20220426201441.GJ4093517@roeck-us.net>
References: <20220426014545.628100-1-briannorris@chromium.org>
 <20220425184503.v3.3.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425184503.v3.3.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:45:44PM -0700, Brian Norris wrote:
> Similar to commit 7f94b69ece51 ("ARM: ixp4xx: fix compile-testing soc
> drivers").
> 
> drivers/soc/rockchip/Kconfig makes plenty of provision for configuring
> drivers either for ARCH_ROCKCHIP or for COMPILE_TEST. But
> drivers/soc/Makefile pulls the rug out from under us, by refusing to
> build anything if we specified COMPILE_TEST but not ARCH_ROCKCHIP.
> 
> Currently, I'm not aware of anything that breaks without this patch, but
> it certainly makes for confusing builds (CONFIG_ROCKCHIP_PM_DOMAINS=y,
> but we didn't actually compile the driver?) and leaves room for future
> error (I have pending patches that break confusingly with COMPILE_TEST=y
> even though their Kconfig dependencies seem correct [1]).
> 
> Defer to drivers/soc/rockchip/{Makefile,Kconfig} to do the right thing.
> 
> [1] e.g.,
> https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
> [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v3:
>  * Drop ARM||ARM64 dependency, now that bare dsb()s have been removed
> 
> Changes in v2:
>  * Depend on ARM||ARM64
> 
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fd7717d597fc..4c91705a8bb3 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -23,7 +23,7 @@ obj-y				+= pxa/
>  obj-y				+= amlogic/
>  obj-y				+= qcom/
>  obj-y				+= renesas/
> -obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
> +obj-y				+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
>  obj-y				+= sunxi/
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
