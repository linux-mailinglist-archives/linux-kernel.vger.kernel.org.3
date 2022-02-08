Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B74AD80A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356697AbiBHL6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344218AbiBHL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:58:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD282C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:58:46 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F0C33FE41
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644321525;
        bh=P+HobyeC3bQCcGpxberLLoh6gpapBvcaDJDz9Lhr76E=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Q8w/6cqsWvnt+l4u2KUPq+gEMrkjhHYBw88uKQx+ifnB4MowqhU6+hKtSjQ1z/da8
         3+XITIIHdVxvcQhnqF6LjAzJiTtZPxfB597H/rXs/dPKU1+7zpPsPUcinuSpruhIGD
         9gM5DGdpwkR1h2JJ0WsZ90OSaBdlWd9QSPAT8ALuAwqX2DXySaiEHWyKLoQlfEpCJw
         FBkAp3hDaZyhLVWag6jhG6Wwi1w/vN4nYoFgbojS7YXobnRJHeCrENojlmC1j4lJYW
         wrJmcdt5blq8t+SCd1zhXqrvDhLKWwwRplRvLuhxbpVHpZdXLe0BWIB5z4++7FKssR
         1kxn36lDpwMIA==
Received: by mail-ej1-f71.google.com with SMTP id o7-20020a170906860700b006cbe6deec1bso1961446ejx.22
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P+HobyeC3bQCcGpxberLLoh6gpapBvcaDJDz9Lhr76E=;
        b=ME+rAP0yaHoCIzLu1AXHMYYbjN/EqKfbzY00Dof7rPOIFkvbQwzETuWg41ekJyfZj6
         OTP1SNCpJppqdWx6I2UOZ5pvWPGRFYPXu7ZrhHj3nI6zcEu4hVr9ovPT8vyQjZ8Adzg9
         m1LLGEU0/q2oSnIVd9pqJ4oj90XDlesyH/ETAbKdww32CEubBsgitXW3z17vxamG91Zv
         EV3HG30DFtTGmWshtZK1Mv1zwBHHGzwIWhRedl8WXRHeKnF+HtyOUiIIlvWoUIUiScId
         z84s40ts++DUoDf7E03DqdCQ3uDn8hUuNtYOAdsngK8/IQAERq5IGgdO77rYPwPPHfBQ
         XSRw==
X-Gm-Message-State: AOAM531pqTX4q8HtcEpyUbsLO10dM0C+ZWaTeIgCQay44X7xnHnpMXuX
        6TrZJlIheV/8IPpcsQqktT9HoSlAAb3U7rgH+kFEagsSbeumc8Q4IP3jU9kMpAKh2Hjr5t9YsZ2
        Y51lBar0ksiYCb6w/X8OVYv0ABvmy2VhHT7P4umcJGw==
X-Received: by 2002:a17:906:72dc:: with SMTP id m28mr319001ejl.163.1644321525145;
        Tue, 08 Feb 2022 03:58:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9a1MhDXtiay9NU1pHyJzzyQxLYCRSLs2dpBgS8l6BBII4mq5a8o/AZSnO3Zpzup21jbBJFw==
X-Received: by 2002:a17:906:72dc:: with SMTP id m28mr318989ejl.163.1644321525003;
        Tue, 08 Feb 2022 03:58:45 -0800 (PST)
Received: from [192.168.0.93] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y5sm1455630ejf.142.2022.02.08.03.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:58:44 -0800 (PST)
Message-ID: <f5563605-7b61-c23e-68ec-6e315efb268d@canonical.com>
Date:   Tue, 8 Feb 2022 12:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        herbert@gondor.apana.org.au
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
 <20220208104918.226156-2-tudor.ambarus@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208104918.226156-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 11:49, Tudor Ambarus wrote:
> Convert Atmel AES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../crypto/atmel,at91sam9g46-aes.yaml         | 65 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>  2 files changed, 65 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> 

I understand that you keep the license GPL-2.0 (not recommended mix)
because of example coming from previous bindings or from DTS (both GPL-2.0)?

Best regards,
Krzysztof
