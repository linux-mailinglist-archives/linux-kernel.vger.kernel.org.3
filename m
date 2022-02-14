Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865B04B557A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356057AbiBNP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:58:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBNP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:58:16 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4A49F94;
        Mon, 14 Feb 2022 07:58:08 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id l43-20020a9d1cab000000b005aa50ff5869so11919380ota.0;
        Mon, 14 Feb 2022 07:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HC4XTESAlBEiQmap9WUF/9U7hqqRdnfo3OTofUKvpI8=;
        b=iGkrGQuNgu7knroGARyb+LBQbIP1I2yxkiEwxEwzOoYdEgQXijWwh8llyIRGyycMD5
         3QdsoANhyv9wkq7jTyX2Jr5fL1LKxDHK1sfumd0+0tmFvq2dorR5+ovJdvZIjQRrD0fJ
         s66+o1i/xHpO+hii3BS3mtXRkOAG9jH6EHpXMVOXQyGbxoWAJy+CIZtB27UD5rDe5gtJ
         5SJGzmdxb3Z2Zw3W6UGjnJQUDs+PZcQKpzJM6pQHQ8cFrkHfSSs/+PqNyfzojCH7dica
         8zJ/0sLMSVKWvld8UuAPGJI25MM4MAmGsBHsBduS/qwNAIY0zMwu28CBtitn4nrxhpHj
         boYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HC4XTESAlBEiQmap9WUF/9U7hqqRdnfo3OTofUKvpI8=;
        b=EXiLjiSRaWe25xAdLevYbDL4iukcyLRo/3TnCipxzDbL1eg4r3b1JbvT1+IwD5vz1N
         w53SX1YW06APNugbnP8qKuFXr/T0yqH7iH6NRtSrujOnCisz02cr57eckwzdy1O/SclR
         YCu6lzCR/d1j0HaOAz6zl4wuAj62eUQyNiB5Ds/Rae9sBLf8prqhxjWRe5C0s8gUEpHI
         ikaG7il7R0CTOh7OqCxRZeBM+FkEjjytJs2TZB97mu8GKMUTLcfuXmoDLFeLQV6CIadV
         4hs7RETe3cV4B5kIri8QtV0gXqcWzwLDNTSBn9/v9nIblOfLOwem7o6tUQv8ocaFC2KO
         3QhQ==
X-Gm-Message-State: AOAM5337SWgP3rNQQpi1/iTXU+Gdw9ft2tlTruqCxOzdSlHw3SnB9HOP
        ufz6aARmiMqRMICVSlhKxng=
X-Google-Smtp-Source: ABdhPJz+MImJcfd9e9o7MjP3S5I3yF71NgIrpMJoJ94NPl6xQnYoMsGg85r2xEekQZmsyOTfjx7s+g==
X-Received: by 2002:a05:6830:2684:: with SMTP id l4mr164145otu.164.1644854288254;
        Mon, 14 Feb 2022 07:58:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k13sm13068382ots.48.2022.02.14.07.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:58:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Feb 2022 07:58:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
Message-ID: <20220214155806.GA299273@roeck-us.net>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
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

On Fri, Feb 11, 2022 at 01:32:56PM +1300, Chris Packham wrote:
> The first interrupt is for the regular watchdog timeout. Normally the
> RSTOUT line will trigger a reset before this interrupt fires but on
> systems with a non-standard reset it may still trigger.
> 
> The second interrupt is for a timer1 which is used as a pre-timeout for
> the watchdog.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
>  arch/arm/boot/dts/armada-xp.dtsi          | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index 38a052a0312d..0e561dfc0ca9 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -286,6 +286,7 @@ &watchdog {
>  	compatible = "marvell,armada-xp-wdt";
>  	clocks = <&coreclk 2>, <&refclk>;
>  	clock-names = "nbclk", "fixed";
> +	interrupts = <93>, <38>;
>  };
>  
>  &cpurst {
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 6c19984d668e..4297482da62f 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -260,6 +260,7 @@ &watchdog {
>  	compatible = "marvell,armada-xp-wdt";
>  	clocks = <&coreclk 2>, <&refclk>;
>  	clock-names = "nbclk", "fixed";
> +	interrupts = <93>, <38>;
>  };
>  
>  &cpurst {
