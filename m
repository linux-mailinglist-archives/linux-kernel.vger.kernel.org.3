Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD34C416E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiBYJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbiBYJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:28:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0AA179254
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:28:23 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 82C103F1B7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645781302;
        bh=kGwkKU8L/fn7aVH4SNRnVpay291DKpyh1Xqm8qPEDW0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=X7Eg2X55/6TfKmAePi5LbGiJOvzXiB2eyV8u4Pd228JsAQywYyzW3rdkrg7weCAnc
         TmCEUljOpWfeX3foDevNn+ztUCK0cM6cYSxjK4XZRxWuKxcV3c4TdkK1wU6K9hLHdN
         sEr2G2L4T9CaAyvT3fu/eDt+Je0breL1Sp+BB7UlbwsnDxm09QIQK8W8Ip9O/Pv7mR
         +eHXWqFLSOA6hFVTm/URHGAx0S5pGSQx7IBLhf/mtfv6Cvn0g9isA4ygzLXpqfr0t+
         DeJ63obxsHG0yurkvp8Fi3g2gqKnFEw5S+p8b3YH4iTdR/JtcRavoyYUJ4Po0nRD0P
         wDuVAl1bgpEkA==
Received: by mail-ej1-f70.google.com with SMTP id m4-20020a170906160400b006be3f85906eso2382017ejd.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kGwkKU8L/fn7aVH4SNRnVpay291DKpyh1Xqm8qPEDW0=;
        b=ZeKhBEol2bhk07CuanLFZ9rNAd8NBvD+tGIKAe6grlkb4qT359UkuGNE2hHT51Myi7
         A/JR14J+rzGuSVy1GkUngNifT2SjrfNtFqAGTFrXONvCGQdyIkz8+airn0Hlq3HxaoFv
         kCJdgZ/yFzoI8D35BsRzUua5HUBXRZ3/9BB/+NAdzVKF77TPOJOsCrlJilhEOl4yOb/M
         ouAkUdDlzMLJJ+jQUE7YsWwPmCFqlgcVFWh3BgUSxEa2t6Mz0q+gjyuS2KnULhPn3v5T
         y/3UIFCGt6UnNG2EdMeFeaEoOnN8sluZ1Htc3ByMQKxA8maTR8hQzg1YlMI74dPyf+1U
         7H7A==
X-Gm-Message-State: AOAM531NSkTV53I8w/CiBKCRyzCwrDs0k85Ghyrfk9fZh0D/cw3+VXeg
        sU6uRN9KbJXhl/iY84KlDV33jYb/IlJq3GlqzlpOyLB9B+uVr19PDxKo2kZMyYMns1ux9o7Scjn
        /3ryjnpv6NtMm1t0feqgBauH2CMwQfK3UgZuIDJJ3Iw==
X-Received: by 2002:a17:906:4d51:b0:6b8:78e0:565a with SMTP id b17-20020a1709064d5100b006b878e0565amr5351317ejv.587.1645781302264;
        Fri, 25 Feb 2022 01:28:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8c3ZhY7jr+/X0AvJodZEzeopQeOKXYiLB34QdycL3m21MYR4q1dg62gQBFvoYHXY7gyalew==
X-Received: by 2002:a17:906:4d51:b0:6b8:78e0:565a with SMTP id b17-20020a1709064d5100b006b878e0565amr5351308ejv.587.1645781302107;
        Fri, 25 Feb 2022 01:28:22 -0800 (PST)
Received: from [192.168.0.130] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b006cdf8a1e146sm770803ejd.217.2022.02.25.01.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:28:21 -0800 (PST)
Message-ID: <f77b2f7d-9a22-3e1f-a5f4-90766bdc232f@canonical.com>
Date:   Fri, 25 Feb 2022 10:28:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/13] dt-bindings: rcc: stm32: add new compatible for
 STM32MP13 SoC
Content-Language: en-US
To:     gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220224160141.455881-1-gabriel.fernandez@foss.st.com>
 <20220224160141.455881-2-gabriel.fernandez@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224160141.455881-2-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 17:01, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> New compatible to manage clock and reset of STM32MP13 SoC.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  .../bindings/clock/st,stm32mp1-rcc.yaml       |   2 +
>  include/dt-bindings/clock/stm32mp13-clks.h    | 229 ++++++++++++++++++
>  include/dt-bindings/reset/stm32mp13-resets.h  | 100 ++++++++
>  3 files changed, 331 insertions(+)
>  create mode 100644 include/dt-bindings/clock/stm32mp13-clks.h
>  create mode 100644 include/dt-bindings/reset/stm32mp13-resets.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
