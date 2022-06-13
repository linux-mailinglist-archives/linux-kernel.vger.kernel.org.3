Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05B54A09D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352184AbiFMU66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352164AbiFMUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50DB857;
        Mon, 13 Jun 2022 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KNSY/4MRKQGA0e53i6BGkqSv8r1BdiuacVK4fX068bM=; b=D9Zwkz6L1ZS3ZNBp0ThENt14z6
        X3LjNufcYo/Gv90ywbVGZn2PrAYmEZmmuqzdMVq2fVHDcEGEjjn6tRWFgEgjLdCMBbr0S7WAb/Dc/
        S+GYoU8ErQmFfc2zc76yluxAv5p853ep/tOllb5wHh7Ce8lAR2LfqhW8UmiIv6lEigrUNNDezQKjw
        sS+Ml3IDFcrkHWp3cSZ5zuf48URPzVsCnyckp4nK4RSIpapQ58HRcfEZi53+fNOhb2N6xtLerajxA
        CtuMaRVXvWZnNwe55sa1L4S+16GpEI3Q3Mn+WryCDBpAHw/a2UsweeKpAB+NRFk/ev0xQ6ggb0qOl
        ZBIflXgQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0qXn-007fGw-IA; Mon, 13 Jun 2022 20:20:16 +0000
Message-ID: <23dd79db-87e3-14b5-e844-d596730bf057@infradead.org>
Date:   Mon, 13 Jun 2022 13:20:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 13/15] leds: mt6370: Add Mediatek MT6370 current sink
 type LED Indicator support
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-14-peterwu.pub@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220613111146.25221-14-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/13/22 04:11, ChiaEn Wu wrote:
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..61e6ec416cb0 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -244,6 +244,17 @@ config LEDS_MT6323
>  	  This option enables support for on-chip LED drivers found on
>  	  Mediatek MT6323 PMIC.
>  
> +config LEDS_MT6370_RGB
> +	tristate "LED Support for Mediatek MT6370 PMIC"
> +	depends on LEDS_CLASS
> +	depends on MFD_MT6370
> +	select LINEAR_RANGE
> +	help
> +	  Say Y here to enable support for MT6370_RGB LED device.
> +	  In MT6370, there're four channel current-sink LED driver that support

Please spell out "there are" instead of using an unusual contraction.
Also:
	                                                    drivers that support

> +	  hardware pattern for reg, pwm, breath mode. Isink4 channel

	                            PWM,
What is "reg"?

> +	  can also be used as a CHG_VIN power good indicator.

-- 
~Randy
