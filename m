Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9157650DADE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiDYILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiDYILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:11:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EFD261C;
        Mon, 25 Apr 2022 01:08:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u7so9917497plg.13;
        Mon, 25 Apr 2022 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdimrDz9Y0e+F8PGqX+0haACD3w5sX1bUWCWY+f1ZHE=;
        b=G3XrIpFE22g+gpWlm/CT9WxnpjQZ0eAIJouyYkNz2F3R9MTzeHuwnhvQoeJUQUpMC8
         0QPGFvEMKJp7f2BNh7ZePMlPNYAxxSB7YW8JgcIyX6D2i/a/dhOw+ZqSo1gxNcdwjyHt
         jPh9p7tl7zFzBO26nQTB7OjGEbY1AoDMak/c7vPG/i8mn6yWq23OFXVRC9ddkG8jXs/9
         fjEkc1qhFy0oEZrXFjGyZ2K/avlvMjMAMUvsCTgB5NzvL8ZnTuAoEeOiETBfk/WOL0O2
         gi3oAmc8OffWShrwO3vo6/s0veNIq4hhMGjcxHpemUe5VOiAyC34MTxIAWlX2LvCoJux
         2nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdimrDz9Y0e+F8PGqX+0haACD3w5sX1bUWCWY+f1ZHE=;
        b=i6tB5xW0SjVnnXzd0jNLwOaRXCfZEhiLRhoX2LqUUA1s948V1XM2QoIpvygOY/GmGL
         N7iSyV6Vrx7Fey18P4/6Az58YmR5iW2Mud2mI774z7oVYlDcV6oIoCYB3MLLwrqLhYGh
         sYA5r4sNfWbQEOvTmFF4r7YQjx1UIezGYKYWucjRFEQmq0zxvZEUkRn/ccDUcvCdJUPd
         GreNS43imdjzC/4lENML4bQQ6QOLitc6j9SVYCMXjnNVcKBnUbzZIwpaz7vBAVUTsfKi
         YaU6o8lg5RLzR6SeI9zets8egBpe0//bBn1DKWPWdxtBaf73/7waQy8tekf72Kw007wK
         YU9g==
X-Gm-Message-State: AOAM5307rxPoAFLc3HDpkOghNDC50voPanEeAL0TxBpvlR177q1MkSLa
        C4KentKJHXoXHs4ujwi0A2W/PHuCMOAIXg==
X-Google-Smtp-Source: ABdhPJwy9oFm9lWOkIzY1VJc+2C540aTJWcmCdRxLgz16hnH2ioq5dwPhuPmLU2rGS7cogK7mVxZfg==
X-Received: by 2002:a17:902:6bc9:b0:158:f2e1:8c69 with SMTP id m9-20020a1709026bc900b00158f2e18c69mr16523871plt.69.1650874116862;
        Mon, 25 Apr 2022 01:08:36 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:569:b7a9:d402:1333:c60b:f1a1])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b0050a4e73bf89sm10763127pfo.66.2022.04.25.01.08.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:08:36 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:08:31 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regulator: richtek,rt4801: parse GPIOs per
 regulator
Message-ID: <20220425080819.GA20397@cyhuang-hp-elitebook-840-g3.rt>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
 <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
 <20220425075812.GA29439@cyhuang-hp-elitebook-840-g3.rt>
 <fe4b42c9-f747-145a-5fce-9be6fc3e19af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4b42c9-f747-145a-5fce-9be6fc3e19af@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:01:24AM +0200, Krzysztof Kozlowski wrote:
> On 25/04/2022 09:58, ChiYuan Huang wrote:
> >>  
> >> -	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
> >> -	if (IS_ERR(priv->enable_gpios)) {
> >> -		dev_err(&i2c->dev, "Failed to get gpios\n");
> >> -		return PTR_ERR(priv->enable_gpios);
> >> +	for (i = 0; i < DSV_OUT_MAX; i++) {
> >> +		priv->enable_gpios[i] = devm_gpiod_get_index_optional(&i2c->dev,
> >> +								      "enable",
> >> +								      i,
> >> +								      GPIOD_OUT_HIGH);
> >> +		if (IS_ERR(priv->enable_gpios[i])) {
> >> +			dev_err(&i2c->dev, "Failed to get gpios\n");
> >> +			return PTR_ERR(priv->enable_gpios[i]);
> >> +		}
> >>  	}
> > You can directly removed all about 'enable-gpios' in probe phase.
> > Just keep of_parse_cb to get per regulator 'enable' gpio. 
> 
> We cannot, it would break the ABI and make the change backwards
> incompatible.
> 

Almost forget the backward compatibility.

I'm testing it right now. After that I'll add 'Tested-by' tag.

Thanks.
> 
> Best regards,
> Krzysztof
