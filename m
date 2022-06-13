Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA71F54A042
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbiFMUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiFMUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11AE9C;
        Mon, 13 Jun 2022 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CF9UJrdeWimgjo6b+3sLXnRZ+YKpG34Hd87mZaFsWOQ=; b=c7khjL9wMhgkexLmyAP5JznkUn
        VxdBdmEKdzpLyXSV9VSwQobUMXr98PHFoytDWiQ3HIhBlu694lInFw+iOU7AnJf/nW+gz5S9kJ11G
        SCoCRG5b1TjhHYBX4qaK92eN62Kt76eunJAA/aEgAf11AkTBq1iM/rhvPErEdPacMTQVFH70dhvb4
        vlrHgpxrZYLBjXB9VHFcUeLsq640SfT4uzfotwf+a9hfdMe0MvLN0qnEEzsqT9SLr/PpswCycaTIA
        r/Ujr7d4yuDkHzfFA9xKaomERUPE1mbxc9qUI9TWS/YLPX3BX+X3TDWnUnQ4BbxeUICwJXWQ9RVC2
        fe3jX5OQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0qS4-007f8t-8C; Mon, 13 Jun 2022 20:14:23 +0000
Message-ID: <4aef2e48-9717-1aca-b716-5f9486bf320e@infradead.org>
Date:   Mon, 13 Jun 2022 13:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 08/15] mfd: mt6370: Add Mediatek MT6370 support
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
 <20220613111146.25221-9-peterwu.pub@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220613111146.25221-9-peterwu.pub@gmail.com>
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



On 6/13/22 04:11, ChiaEn Wu wrote:
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..d9a7524a3e0e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -937,6 +937,19 @@ config MFD_MT6360
>  	  PMIC part includes 2-channel BUCKs and 2-channel LDOs
>  	  LDO part includes 4-channel LDOs
>  
> +config MFD_MT6370
> +	tristate "Mediatek MT6370 SubPMIC"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C
> +	help
> +	  Say Y here to enable MT6370 SubPMIC functional support.
> +	  It integrate single cell battery charger with adc monitoring, RGB

	     integrates                                 ADC  (?)

> +	  LEDs, dual channel flashlight, WLED backlight driver, display bias
> +	  voltage supply, one general purpose LDO, and cc logic

	                                               CC   (?)
What is CC?

> +	  controller with USBPD commmunication capable.

	                                       capability.

-- 
~Randy
