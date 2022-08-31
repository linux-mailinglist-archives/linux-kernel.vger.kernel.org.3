Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AF5A8611
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiHaSvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:51:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE8C0E5D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=RNaldf3In8WKTXSgD2d1uVP7Sa1eKmzNdCfkgY7eMd4=; b=Q/Qct81j+lZIFYdXyl8L+jLdPx
        fTTsY3DXIBre2dBi+EgaFbHlVVf05QH/g6m5tQIIqc78HWT+Xoum8POCCbeum90qo2xn2CWVZaiiR
        vqzm8PZPU7aKH4Q0puM6I9jLJ00O+IOmQ5YThZ3ohjzZOIwjGrxIp2kGoqB5YhIXqJlEC12YoOMJT
        bd+uADtFYSUF6wvbWek5jwVXg/hG6rL5MUzt8L1J8B/C3Oi+6aDH1JgKV/8ODUnN0OYiBqfw43mg1
        YtJcu9JJ1Q5chTfzD+BT1b2qoOBOid28bKqL4gSHo5mMG7LNn1970rFdGzdwyA+IoFU9Pv+JIBcr7
        SGwmjLbA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTSoM-007gYD-Qi; Wed, 31 Aug 2022 18:51:38 +0000
Message-ID: <269a80eb-e0c9-182f-9c28-fb12ad54c020@infradead.org>
Date:   Wed, 31 Aug 2022 11:51:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] sound: soc/codecs: tlv320adc3xxx: needs GPIOLIB
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20220409052120.3780-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220409052120.3780-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 4/8/22 22:21, Randy Dunlap wrote:
> Fix build errors when CONFIG_GPIOLIB is not enabled:
> 
> ../sound/soc/codecs/tlv320adc3xxx.c: In function 'adc3xxx_i2c_probe':
> ../sound/soc/codecs/tlv320adc3xxx.c:1352:28: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>  1352 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> ../sound/soc/codecs/tlv320adc3xxx.c:1352:57: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>  1352 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>   CC      lib/dynamic_debug.o
> ../sound/soc/codecs/tlv320adc3xxx.c:1400:9: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>  1400 |         gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
> 
> Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Ricard Wanderlof <ricardw@axis.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> ---
>  sound/soc/codecs/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1567,6 +1567,7 @@ config SND_SOC_TFA989X
>  config SND_SOC_TLV320ADC3XXX
>  	tristate "Texas Instruments TLV320ADC3001/3101 audio ADC"
>  	depends on I2C
> +	depends on GPIOLIB
>  	help
>  	 Enable support for Texas Instruments TLV320ADC3001 and TLV320ADC3101
>  	 ADCs.

-- 
~Randy
