Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1320B595979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiHPLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiHPLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:08:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73685A8311
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:18:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x25so10052147ljm.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3TSQJ+ajQb7oi0SISNRrwjgay+bQ0YpimkdDJopO6Zw=;
        b=xjjTCVqjAVU4Lr5HgNJZklHzY+wpNtU8v8mBhm7o2HhzogdL4vRU0XJ5fmJngd0tx6
         XUIqZRhJNKcv5N0ShN0JyVq4DwxmiBYBzQ2D9SWNJ6eBdsYwRiPwhCdcLy6xHgtnPuAb
         yIAzq3JRL3olX9nF6shP/M+zDzdv7jKNFT6B2vJ+cD05EXOJIyfY987amxAjAjb8ujvP
         9iG3K2/BBp1lbWYwfvxaHS5t56ZO7+sRxXWEtYU8qGOfkuWsyD4ROUkWO/iMf13WRH9+
         Jft38ypd0UnUyRKrnUnNihg9qT9Pu2PK4ZH9rkbsL1i0BvqSiTg1Zil7aMKBokMKyTVI
         ZsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3TSQJ+ajQb7oi0SISNRrwjgay+bQ0YpimkdDJopO6Zw=;
        b=5nhsVdz3UJwIlpTYJwqCRLPJBO4vzmuf59+XLJJVfgU/a2/x1Xe+je+aSvLvumzGe2
         1VogwSQi8MpKXfaVfUCm50W4ksaIqUCPtx+jUo2ZWLNlqOVA/cyop1maxI2i/vSnrhjd
         Os+v5r1uP1wM+REIsVPOtMwhXwwwMi4aQajefNjMi4qKmYQgCjrSDAvLJjLOMMi+Pdbw
         klZMexmsZX9YB+6DChQJU7ISOFuBaeuCxfRemzcNcOk2FzdOY3T1EO72UDZxZqM/s9qD
         Vvq5kwtoe8Mx7BHFeQEC+BlXTA3h/erMbYzzN8KivmLtBJc2hnI+po0+NrSAwM7eQehJ
         aITw==
X-Gm-Message-State: ACgBeo0+bl1EokcnG6Eah2v4NX7pcA/4PzNowuzqTJ++5z35LUwYVog5
        +ajnGHUYA0+ZHfty396ZTBn5tw==
X-Google-Smtp-Source: AA6agR4zLM19yV8AIxJngm1cQTBt04mcHmIAWaf59FHTXRvmruyL3ih96C0EcgpAUCdxQ8T6G7uvdA==
X-Received: by 2002:a2e:8096:0:b0:25e:4024:5fb6 with SMTP id i22-20020a2e8096000000b0025e40245fb6mr5956281ljg.332.1660645105391;
        Tue, 16 Aug 2022 03:18:25 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651c118d00b0025fe2049beesm1677215ljo.60.2022.08.16.03.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:18:24 -0700 (PDT)
Message-ID: <3e897c2c-c2a0-b815-e6b4-374bd80b98e0@linaro.org>
Date:   Tue, 16 Aug 2022 13:18:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
 <c85ec3a3-fa6e-aa71-a847-22062b9683e9@linaro.org>
 <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0d2bf232-8aa6-2dc1-121d-f0439bfd7b54@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2022 01:19, Samuel Holland wrote:
> On 8/12/22 5:45 AM, Krzysztof Kozlowski wrote:
>> On 12/08/2022 10:55, Samuel Holland wrote:
>>> The sun6i DPHY can generate several interrupts, mostly for reporting
>>> error conditions, but also for detecting BTA and UPLS sequences.
>>> Document this capability in order to accurately describe the hardware.
>>>
>>> The DPHY has no interrupt number provided in the vendor documentation
>>> because its interrupt line is shared with the DSI controller.
>>>
>>> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a schema")
>>
>> I don't understand what is being fixed in that commit. That commit did
>> not have interrupts in D-PHY, so what was broken by it?
>>
>> The Fixes tag annotates the commit which introduced a bug.
> 
> The binding had a bug because it did not accurately describe the hardware. If
> you don't think this warrants a Fixes tag, I can remove it. Or are you
> suggesting that the Fixes tag should instead reference the commit adding the
> original .txt binding?

Yes, the latter. If original binding were not complete (although just
"incompleteness" is not really a bug, unless it is something
serious/obvious etc), then TXT commit should be the fixed one.

The backports of course will not go that deep, but Fixes tag is used
also for statistics which kernel release actually brought the bug.
Therefore adjusting Fixes just for sake of backporting is not good -
messes up with statistics.


Best regards,
Krzysztof
