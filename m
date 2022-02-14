Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF14B4EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiBNLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351713AbiBNLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:33:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98166F87
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:19:10 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5E36402E0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644837546;
        bh=b1wIey0Vq3c48r+pFvoWpMCvk+Swn1uTiC6iPNor7mM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=io3TvZ92BbK+sfXy1F7VtakSu1eMRepu1cu5CTCKGxsbCCCXYYAQiNQVlMfbElyFh
         bbNkIVFAmiGWOUlj8+PaxPJi70BUte4qilh3fJCmMaI4ATwkfErCNWOsdeJKcnE5+H
         VpEo4Z6oSax23jsOBGc4pCgwMex7afokuM4IATHBroMKDN3qr3PB9bgXaDEFsBli9h
         z2TWnVg2a1nmK5GQ27KWS4sYD1zDQGgi6i9LWFZDuOO9wWdQwQFBReMQd/UKUT2JtC
         3JOptiRexg8zPyp+Cxp2nbe/k9wWZvjiFlfmBNL1JuMtI8VSXHNtPTN90BNCnrNAVP
         01AoGrUVIk5EQ==
Received: by mail-ej1-f70.google.com with SMTP id ho37-20020a1709070ea500b006cd51be5cd8so5697956ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b1wIey0Vq3c48r+pFvoWpMCvk+Swn1uTiC6iPNor7mM=;
        b=TPRFJZCU2pqgx7a3+2+MDy4Rj25T8lciCUZtAXKVHB2kdXbXE/ZiCbZauBb2/aEsLD
         Xc3io2uaNaCFTFVNstF5+2zwDmdsnICKEwyuYitmjugLT+IjFQKiBMm2SkzG69HYyq/E
         TWle8DMGA3+dtlujNWBXYMQIp2PLv/lS9dfayezgsrDpdQZMt1clMM2joUD6SqgusaOh
         R5xaGZn/XSYVKToDOClhCF94FbBsvZDHv7BjWk9qXRwSpmWZW3mmJ9Z+yv59N+lA7hK7
         cqdRQMlLTaGSKDKVeVEt3r4f4TiG86ijv6vDX+CkRI5KwxbR3Y/8uEUqV4q9L67Nnnwc
         Gd9Q==
X-Gm-Message-State: AOAM533KPDevy78oduy8RVDDasjI6/CII93u1Tn5c0nnUxpc9B3jzCyY
        X/HgY45FV0lz/bul9S2dDJjDQKt9dVZIhCf1d/sV8dcX0s8DkOjFt4SAvCl+m6S1Lacrf42v36x
        Maf7h1PNHbqMNtKVyigN4z3q6APzlfyIa3u1igaG1Tw==
X-Received: by 2002:a17:906:5d0a:: with SMTP id g10mr11821341ejt.595.1644837546198;
        Mon, 14 Feb 2022 03:19:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS2G+jb0/qYs1mMuGfvrV4QBhHmJLqINK5K6mW5YCtirPJOTwEh3846UzG3lrR49melIGbFQ==
X-Received: by 2002:a17:906:5d0a:: with SMTP id g10mr11821329ejt.595.1644837546045;
        Mon, 14 Feb 2022 03:19:06 -0800 (PST)
Received: from [192.168.0.104] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i28sm1217868ejo.49.2022.02.14.03.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:19:05 -0800 (PST)
Message-ID: <e1f2f9c4-a597-2c8f-df0c-4ae30a5ad594@canonical.com>
Date:   Mon, 14 Feb 2022 12:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/2] pwm: Add clock based PWM output driver
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220212162342.72646-1-nikita@trvn.ru>
 <20220212162342.72646-3-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220212162342.72646-3-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2022 17:23, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> 

(...)

> +
> +static int pwm_clk_probe(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *chip;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(chip->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
> +				     "Failed to get clock\n");
> +
> +	chip->chip.dev = &pdev->dev;
> +	chip->chip.ops = &pwm_clk_ops;
> +	chip->chip.npwm = 1;
> +
> +	ret = clk_prepare(chip->clk);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
> +
> +	ret = pwmchip_add(&chip->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");

You need to cleanup - unprepare the clock.

> +
> +	platform_set_drvdata(pdev, chip);
> +	return 0;
> +}
> +


Best regards,
Krzysztof
