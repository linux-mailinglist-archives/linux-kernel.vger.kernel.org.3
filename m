Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF953B84A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiFBLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiFBLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:54:00 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239591DA40;
        Thu,  2 Jun 2022 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QxS95NZvfvenpMssN8GdGggpAUbQye4uoJjCm8L++y0=; b=dA7RvGXsT0Ahu/E4UyD7BzQNNn
        Z9GHJfzVFA3E0KIVV/k4h68SP1MLZxlnI18ySyPCfyGO+h++PeShZ0kRnDZZz2m3fpixb5Vr7CetG
        nh/AfXTG+9nu7k1ml9j1IzJhUqvJsJghUNYHO8j2f3jQYsYDN+I94nWwr6YhKIH9Nvld3d4gWfSTH
        16Ryt+yhdHOe/qE0ZdcAa2/ODessv/8IUjrwDzThJec2QYIpEHtfBxJiTzXIR+WGMTWv7CrKJin7U
        npJokGkns8SvkcwRQ/qVvuqj2ELa4gQDG/Zutzva4DvygBs0Xr7D+T91IqbL0CyoA935jxs0wN8QR
        zvbG/a/w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nwjOk-00033v-Fo; Thu, 02 Jun 2022 13:53:54 +0200
Received: from [2001:a61:2a7f:a201:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nwjOk-000Udv-3t; Thu, 02 Jun 2022 13:53:54 +0200
Message-ID: <ad3af033-97f1-3aad-d082-c6ed56185b59@metafoo.de>
Date:   Thu, 2 Jun 2022 13:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] iio: adc: meson_saradc: Use temporary variable for
 struct device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
 <20220602114241.12601-3-andriy.shevchenko@linux.intel.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220602114241.12601-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26560/Thu Jun  2 10:06:31 2022)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 13:42, Andy Shevchenko wrote:
return -ENOMEM;
>   
> @@ -690,7 +687,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>   	priv->clk_gate.bit_idx = __ffs(MESON_SAR_ADC_REG3_CLK_EN);
>   	priv->clk_gate.hw.init = &init;
>   
> -	priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
> +	priv->adc_clk = devm_clk_register(idev, &priv->clk_gate.hw);

You are not changing anything here. But we shouldn't be devm'ing on the 
IIO device. It will get freed eventually, but only when the last 
reference to the iio device has been dropped, which might be long after 
the platform device has been removed. devm'ing should happen on the 
platform_device's device. Might be worth fixing.

>   	if (WARN_ON(IS_ERR(priv->adc_clk)))
>   		return PTR_ERR(priv->adc_clk);
>   
> @@ -706,8 +703,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>   	size_t read_len;
>   	

