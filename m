Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808B44C6592
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiB1JVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiB1JV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:21:28 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CEB57B23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:20:49 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D51C3FCAE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646040047;
        bh=zIzvjzWPwb88RX7Be5mzyc2hwLD5m8zhDYIVz1aVBLU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PbkFymyxuNdtcXa2N1GQ5TIaf3Bh5kLixcBWvBPdEmJREg5DoOQlwx86hl0A1W2/4
         YgEV08QHGzvwNmgELlRb06f3HtNDlUMMctfCeqTGCDzolUIIxXKFieesLntRNKvUtZ
         yXicplcdEY18W9SHfnMY8niyC+npuhtMPMzzBDiLUHGXMK1zFBq1EVGyb7/PIzlNYg
         hHqQuge3C8GToZmxCrMEfRU7IW+lE8x+/nc85Hm85tIesuFM8r8VZC296MAAtra8e/
         zRuGx/sqDzzOQN5NREhhmGhNHsYrYZx59P8kFpHx1RWkGVsJFJp5ebjYcQC43qGZl8
         GD8WgeI+vHUdw==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so5443598edh.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zIzvjzWPwb88RX7Be5mzyc2hwLD5m8zhDYIVz1aVBLU=;
        b=NPI2XZkyAE8/8gup+c5yv3b32kg2iW4XjZBTJlgH84fnG5I2fINz4Qz50iswa7pKsM
         /rf7xrBvQ0YIJHv2ze2tYP+KPNPvECPu7VBKEJZe0JwfCFRtvvqdm80EaiLPHETbtBQd
         aObw/d5eTfS3Cfi8Yu6Wxfru0QezZkfYOrNqN44VwsIPGK02/MnW7B2wirj7Q+3qmAHG
         KOLaMGbgeKqjVzfqThteb1dFmGZkNzrpNdRz7LUCK1Eye1kMFhGosUsw4NriQLOOncgZ
         udrnDSvEti80a7SqPGU03gO8lQe2p7RS7YgG6/05MKJaJIxu/1tj1sXZTiFMPHika3+4
         4WIg==
X-Gm-Message-State: AOAM533nvzPfGJ5M7Bk6zV+8+EwFnS2IYI+zj/D3baAsk4igz+d4WP+T
        UgxFXqHeMMm/bqFOTNxF48zcmcEfnRPSESOwdgNtc/KVfx6JyciQNrMdoSVPyoj1s9lAb1Tx5AD
        Dc4HgwOdiIhdWShj0jH86MTcyWO0tVVsHimgoVNs9Vg==
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id m4-20020a17090679c400b006cf5489da57mr14589524ejo.48.1646040046613;
        Mon, 28 Feb 2022 01:20:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtS4BULGnHYR4a2TLg9KjNh6wGTwF0AEjW8HK1zVCNGkkiiiZWwK4NQJMYwdBYd5Z+WirWqQ==
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id m4-20020a17090679c400b006cf5489da57mr14589507ejo.48.1646040046450;
        Mon, 28 Feb 2022 01:20:46 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y18-20020a056402271200b0041110d6b80asm5784327edd.39.2022.02.28.01.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:20:40 -0800 (PST)
Message-ID: <39ce4a12-ff56-e0cf-b0b2-2a3545a9cb7f@canonical.com>
Date:   Mon, 28 Feb 2022 10:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh@kernel.org>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
 <498e89dd-c438-68dc-69b5-8de82045ffbd@canonical.com>
 <97cf98c598a04b77bb6de6e91fcdcc0b@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <97cf98c598a04b77bb6de6e91fcdcc0b@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 07:31, qinjian[覃健] wrote:
>>> +examples:
>>> +  - |
>>> +    clkc: clock-controller@9c000000 {
>>> +      compatible = "sunplus,sp7021-clkc";
>>> +      #clock-cells = <1>;
>>> +      reg = <0x9c000000 0x280>;
>>> +      clocks = <&extclk>, <&clkc PLL_SYS>;
>>
>> Except the warning pointed out by Rob's bot, it looks like you feed this
>> clock-controller with a clock from itself. Is there a point to express
>> it in DTS at all?
>  
> Yes, pllsys is an internal clock, but it also as a parent clock for some other
> clocks in this clock-controller.

What is the point to express it in DTS? Usually such internal
parent-child relation is described in the driver.

And how does it even work? How can you get a clock from a device before
you registered that device?


Best regards,
Krzysztof
