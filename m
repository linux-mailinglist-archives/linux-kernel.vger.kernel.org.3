Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEF4E3B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiCVIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiCVIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:48:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3F4B87F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:46:40 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6748C3F1AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647938799;
        bh=Ns6x5qMhMdYQ14F/6CRmR+MC5tPxoh9wJPntlRcRYM8=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=G+Olx9Md9meqEykoylcqCQC6FS/40I21hSAJfWO/IHGkrSjBXUCerHDQdqJfj53zs
         r5U+QinvztUqprZzRznp3iR2P5PczRKgBJfceSVo2rIhgOJAvs67DqXwq87RvRdFsk
         lvBChBR1ra3yrNUAqPyMwVUnzbZoRgnkDW4XEmOn8KGpy/8nUULron8UdlYPaDyhuS
         f4C3BuHub8TjkWUFSZRNjC7Q9SS2bGvTUc6+6diOPVPwyjmdoiVQklGKtyA4HQBvIF
         q+fYHL4q+7wYgd2pNSTsLQFcSvrAuAjm2pCvxikaC2GH/04wRPC3vWB/cyi81eL+Ns
         0oj/vQmz9crNg==
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf802c000000b00203f27bebddso2326415wrk.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Ns6x5qMhMdYQ14F/6CRmR+MC5tPxoh9wJPntlRcRYM8=;
        b=k8xev0+1/36Il/+cHO9Ox2YxGkVQVKXw6GCobCxnuf5Z0MIJ7JVoNRM3jjUWlHCgCb
         bdncVW31lN+DYDXAaZ2977vjPsp8XYdg5Fkaruu2ZdlgcktP5ZUR8/33WplT3oMF/Toz
         hzetnr1qavYWvX4XYOPMarTZ3a8qKQMn7Ldji8OLzqBIDMXv2WjGDytHs3EaEZJ3//zH
         HXvNXXbG4NMqAf8CfUyOMWERmQuHdfO1DnOyybYHo+2tSzosNPKh3C8FEaGsN7Yy/f22
         7iF7eVrtPIXHzH9LHGPjtOjSUg32EnNdDFMD3V0dmXbAjYpS+2gy+PJgXmO5M73At+y8
         i/8A==
X-Gm-Message-State: AOAM532f7MzKLEFZ6ym2/BskVnyM7OilE41Uma51L3u6PgqdgBMJIfR7
        1ueSCxnshAUaXJrbdvHpaDdRz2YYMdX9eYUXXbJ+go6OITJX7vlEhRoUCGRA+vgrM4EWSSS+a3C
        wN4jUkw0XUIET8u4YPjBiP2sUzL0Tj0djKuXrcLuCnw==
X-Received: by 2002:a5d:47a7:0:b0:203:d1b4:8f6 with SMTP id 7-20020a5d47a7000000b00203d1b408f6mr22185069wrb.36.1647938788906;
        Tue, 22 Mar 2022 01:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhYewicFouwHmI7LoZatc4e5+uyx8QH11LnUERCGbNVF6UFm3eYkF8CEUxLw1D82wG8LV7FA==
X-Received: by 2002:a5d:47a7:0:b0:203:d1b4:8f6 with SMTP id 7-20020a5d47a7000000b00203d1b408f6mr22185047wrb.36.1647938788647;
        Tue, 22 Mar 2022 01:46:28 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0038ca92f175csm2416313wmq.32.2022.03.22.01.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 01:46:27 -0700 (PDT)
Message-ID: <13878c88-487b-2546-0af8-3031fdc8e308@canonical.com>
Date:   Tue, 22 Mar 2022 09:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: drop useless consumer example
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Shiyan <shc_work@mail.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
 <20220316130858.93455-2-krzysztof.kozlowski@canonical.com>
 <YjjCpQ9vwFoEmFFi@robh.at.kernel.org>
 <ca6c4fe5-93c5-9ad4-0c9f-86ec3213d44e@gmail.com>
 <a8290aa4-8a2c-68c3-bc55-82abcd27385e@canonical.com>
In-Reply-To: <a8290aa4-8a2c-68c3-bc55-82abcd27385e@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 09:45, Krzysztof Kozlowski wrote:
> On 22/03/2022 02:45, Jesse Taube wrote:
>>
>>
>> On 3/21/22 14:23, Rob Herring wrote:
>>> On Wed, Mar 16, 2022 at 02:08:58PM +0100, Krzysztof Kozlowski wrote:
>>>> Consumer examples in the bindings of resource providers are trivial,
>>>> useless and duplication of code.  Remove the example code for consumer
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>   .../bindings/clock/bitmain,bm1880-clk.yaml           | 12 ------------
>>>>   .../devicetree/bindings/clock/idt,versaclock5.yaml   |  7 -------
>>>>   .../devicetree/bindings/clock/imx1-clock.yaml        |  9 ---------
>>>>   .../devicetree/bindings/clock/imx21-clock.yaml       |  9 ---------
>>>>   .../devicetree/bindings/clock/imx23-clock.yaml       |  9 ---------
>>>>   .../devicetree/bindings/clock/imx25-clock.yaml       |  8 --------
>>>>   .../devicetree/bindings/clock/imx27-clock.yaml       |  9 ---------
>>>>   .../devicetree/bindings/clock/imx28-clock.yaml       |  9 ---------
>>>>   .../devicetree/bindings/clock/imx31-clock.yaml       |  8 --------
>>>>   .../devicetree/bindings/clock/imx35-clock.yaml       |  8 --------
>>>>   .../devicetree/bindings/clock/imx7ulp-pcc-clock.yaml | 11 -----------
>>>>   .../devicetree/bindings/clock/imx7ulp-scg-clock.yaml | 11 -----------
>>>>   .../devicetree/bindings/clock/imx8qxp-lpcg.yaml      | 11 -----------
>>>>   .../devicetree/bindings/clock/imxrt1050-clock.yaml   |  8 --------
>>>>   .../bindings/clock/nvidia,tegra124-car.yaml          |  7 -------
>>>>   .../bindings/clock/nvidia,tegra20-car.yaml           |  7 -------
>>>>   16 files changed, 143 deletions(-)
>>>
>>> Doesn't apply to my tree (no imxrt1050-clock.yaml), so
>> merge against linux-next I can submit another patch if needed.
>>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Let me send it after the merge window - all dependencies should be there.

Optionally this could be picked up by Stephen/Michael (clock).


Best regards,
Krzysztof
