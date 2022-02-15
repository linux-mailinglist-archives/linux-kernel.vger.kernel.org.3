Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B34B6507
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiBOICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBOICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:02:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FF2408E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:02:38 -0800 (PST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BEB063F1E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644912157;
        bh=p0wXUzG9Qlg9XGpXItbSdQyLJQ63vtplPmOBRka8DjY=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=Bul6c5mZ7d2CR9Ltht+CN7+BfxzxaHOaI/Y9bFhOLWgYmtTCEeHWYLC4hn6S9izq6
         CFsDKAjAh+4iZmaFyOWfaIIn0WzTr+TZTWJJ/9W4o8Qlub0iwKObIqTjJGec9rOLuY
         u4ULjo9IV6tfkheQz/Bc068GqgimmPrVokMjpVPw/ul5Mk+Y+ympd1fvhprwILla4M
         xQD3W7Mde5I1tqxD7FgyONcdmMAi6KpoTXgG9KUKF/CjBbSSrsnuIA8oWULUBH6FEg
         tz8bGxUDGs1bUkZNaqfdj7ExaqnUos9MiKvGfwRHbiLQ9YL9DjMfrsW0HXu449g+Qg
         gMvUZVltpPdIw==
Received: by mail-lf1-f70.google.com with SMTP id h16-20020a056512221000b00442f7ad732bso3345427lfu.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=p0wXUzG9Qlg9XGpXItbSdQyLJQ63vtplPmOBRka8DjY=;
        b=YWVwkzu8mg6Wqn6cmIPDqP+SfG/ch7usxgN4jKVhwSSgzuXchsp8LOKxfUX6riN8Fx
         +3JCNXLwcNCrvdSIOMCxmhL3si8OVA7d+gmc5XHi1EI1YNJrF5gZaJqgLu3ndoPL3HKj
         TFHekOnlfZEr0C4diCZzHWsbPMnzWEK+2zEIQ1Hk5q+o8Rxghb877lq7FrU362DhmL0L
         OImESuVctFNBT1L26hjiRShaCO5Puc9OZfJYgFIGen270/pbSV1wHfeo0kwbuhpQoxLd
         BB2dHTp4VFyixuJwI/sJ3xXJqt2LLpMAMB0tBSSTcSM1Q70EyU4SukwPOalsIlMeowAe
         yWvw==
X-Gm-Message-State: AOAM531VJyGTqnYvmlZUjl3nRyHLSmQbRYUZDDKmgmn4wR/RpOGJ3n4F
        wlY84W7cSx8I+czM98FrMFaMnW6zHBFbClXBaYParBzFF97ZYoAfrNr5RiC+K6Aiuc1Cpvw1wlr
        jLW9YmN2vIzXyWaQrrpSFOzXcpn6sAsVqDHbjLQSTNA==
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr2757494edb.158.1644912147102;
        Tue, 15 Feb 2022 00:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJL82lo1kjPeRqjS+9jNzssv8tXjpHeHazeL4p0HZJxneIppz7pU1JsXMs2O9NT8eS3yVbFg==
X-Received: by 2002:a05:6402:424f:: with SMTP id g15mr2757450edb.158.1644912146878;
        Tue, 15 Feb 2022 00:02:26 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id jz17sm11534425ejb.195.2022.02.15.00.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 00:02:26 -0800 (PST)
Message-ID: <7df71f8d-cdc3-4b2e-cf0a-7112eff28142@canonical.com>
Date:   Tue, 15 Feb 2022 09:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220215074030.3nugwproxjh3lwhl@pengutronix.de>
 <CA+Eumj42Hojp1m4deuWnqMOaaNaupTSkzPaNbL_0eyBL-aDi_g@mail.gmail.com>
In-Reply-To: <CA+Eumj42Hojp1m4deuWnqMOaaNaupTSkzPaNbL_0eyBL-aDi_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 08:59, Krzysztof Kozlowski wrote:
> On Tue, 15 Feb 2022 at 08:40, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> Hello,
>>
>> [dropped Anson Huang and Yash Shah from Cc: which were not reachable for
>> my last mail]
>>
>> On Mon, Feb 14, 2022 at 10:21:39PM +0100, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changes since v1:
>>> 1. Add tags.
>>> 2. Adjust subject (Uwe).
>>
>> However you only took a part of my suggestion ...
>>
>>> Krzysztof Kozlowski (15):
>>>   dt-bindings: pwm: allwinner,sun4i-a10: Include generic pwm schema
>>>   dt-bindings: pwm: imx: Include generic pwm schema
>>>   dt-bindings: pwm: intel,lgm: Include generic pwm schema
>>>   dt-bindings: pwm: iqs620a: Include generic pwm schema
>>>   dt-bindings: pwm: mxs: Include generic pwm schema
>>>   dt-bindings: pwm: rockchip: Include generic pwm schema
>>>   dt-bindings: pwm: sifive: Include generic pwm schema
>>>   dt-bindings: pwm: renesas,pwm: Include generic pwm schema
>>>   dt-bindings: pwm: toshiba,visconti: Include generic pwm schema
>>>   dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
>>>   dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice
>>
>> ... The actual patch has a space after the comma, I like this variant
>> without comma better as this is a compatible string.
> 
> I am confused. My patch does not have comma after space. Your reply
> had such in the subject, but not in the proposed new subject you wrote
> in msg, so I left it as is. Without comma. If you still see comma, it
> is something with your mail client.
> 
> See:
> https://lore.kernel.org/linux-devicetree/20220214212154.8853-12-krzysztof.kozlowski@canonical.com/T/#u
> 
> Also reply from Vijayakannan does not have comma:
> https://lore.kernel.org/linux-devicetree/20220214081605.161394-11-krzysztof.kozlowski@canonical.com/T/#m80af695f2c751341bc971114aefa00ccc929a3ec
> 
>> Also a # before
>> pwm-cells would be nice.
> 
> I can add this.

Just one more clarification - you proposed also to remove "pwm:"
middle-prefix. Shall I remove it from every patch and use instead full
file name?


Best regards,
Krzysztof
