Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5A598006
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiHRIXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiHRIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:22:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911A94EFA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:22:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v4so1059636ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Oukdp3ac9qqmQBD3wCXZkJHdViHJb4roazf84j0mgps=;
        b=rgrYDh4DIWTHc1pC+Hr4CW2Fhzft/HWBMPrRDWCf6mJB4iZEDrQqT3Ktaezc6UzbVB
         DZrlU+a5yCfeUiQVbQPQ4zyNRRmNyIh8N6F1RZQJgvfmbqrnxnxmWQV0m1r4TT4UyOSK
         l+W0nhRkuiiXDVgpH9rZpU1urn1eR95WGh+dIgfClasl5WbcJ1SEBH7DH0vltvi+5Fyu
         QOAL540HAh+vJA5hc+wnHAJ2lZNFYp1SCcV5UpLau+/6VL0+EIyoV33B/r0FIO2+jtvW
         jm1gB2/AonIl9wC0z2c3+CTXXcTOqcV0idgg6bkHY6qEDS4Xj0AdQXSTMggBJRL5/PkG
         RnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Oukdp3ac9qqmQBD3wCXZkJHdViHJb4roazf84j0mgps=;
        b=zFFwW2yN+gMFGqtXaYTJqJlBrAn8GOyx1t9wPldA6GH6m6IT8sMQihfcoJOI2Gf1zN
         ktpSUelLANWcLne+D1tW3FL6Z2PB9M0ScqkogU8ccEmurHFDy7Ts25Vfc6QB6oiRR4aZ
         NWWMsn+yWTsyWPqz76wGBnbwC5G7EZG3jR+zO7TZZa04ovf/t79lgKq7ipmHjK2rLAOX
         omx7BtbXR853gLdw2s4zVgiE2Ax/olnuELIUJIqJIILp4nHgfms19Xj9quKKSkS/tyRT
         voQKoDe5rAqA6KuYSL9gC/krHcQlDfmQwl4toQn32X7JYhgYa+BZBRy22DsjPXoXpwK+
         xbqg==
X-Gm-Message-State: ACgBeo2WX8C90VTghFZc4gvs2qzL+uQNJ3ZC6CyNRN9vWF2VrR1RT+wK
        iZr0RjxzMp2LuQP0JIW7SrCaag==
X-Google-Smtp-Source: AA6agR6oiQVF7XV1u0uY0tip2B6M7NTHF39GGUO71n6giDIrB2ZiB9S6KSEf4dkqS6QFJEoPXpXycw==
X-Received: by 2002:a05:651c:168f:b0:25e:59f6:24d3 with SMTP id bd15-20020a05651c168f00b0025e59f624d3mr597703ljb.456.1660810976407;
        Thu, 18 Aug 2022 01:22:56 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b0048b0bc13615sm135193lfq.88.2022.08.18.01.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:22:55 -0700 (PDT)
Message-ID: <f71cf3c7-9e1d-12ba-035f-70c63510d44a@linaro.org>
Date:   Thu, 18 Aug 2022 11:22:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 3/4] ARM: dts: stm32: add pin map for CAN controller
 on stm32f4
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
 <20220817143529.257908-4-dario.binacchi@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817143529.257908-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 17:35, Dario Binacchi wrote:
> Add pin configurations for using CAN controller on stm32f469-disco
> board. They are located on the Arduino compatible connector CN5 (CAN1)
> and on the extension connector CN12 (CAN2).
> 


> +
> +			can2_pins_b: can2-1 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
> +
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
> +					bias-pull-up;
> +				};
> +			};
> +

No need for blank line.



Best regards,
Krzysztof
