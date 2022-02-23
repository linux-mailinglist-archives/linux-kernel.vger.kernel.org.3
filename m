Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6964C1160
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiBWLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiBWLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:35:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AA92D22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:34:59 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B14293F1D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645616097;
        bh=HvxEgZTvOAS5E5aJCd0nq0jn+4aEfsidxtadlOakdCE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eAwkmdfkKuY7oiZojTcDHLjePkoLo5i64Q1WGxCxiZ2R90/r/kEdZSRRRs90AyWXX
         6Rd7inLigpMtf/i9W1KuS3va0Uv+eJ60DM8FrRL76ycBElISK6+KOIJJpl1ES1j/gH
         L+G63DoeEkArT4cMuQBEaI+/ETMH/8u4fntWTsNXGkFylLc4VMxlewKJXpCAkj8mI7
         stXqJdkdx3h8EGnYw1ieCEwZ8+urC0/41ou0gd+YrXPn80N9JELMY/NcG7bEhm4a4S
         swEkCItC/IWPyLIhbCeIQSDBrMaN+l7Vq4HACeRmkuwPanZgN+dnOHRE0VJT8co7lO
         nr+vIGNzIRj6g==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so13329964edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvxEgZTvOAS5E5aJCd0nq0jn+4aEfsidxtadlOakdCE=;
        b=B+HWwGRZhBS0+aLbTKpAd4smI7hWDMUkj7mKPSMZMzyrVNhwzkWB68/X6nK56Nz6R/
         2BF3uoWIvGCYckSu+KiuZfsgJC19mSGZobpHCnEiEtlpCjQxxjHiBvYgeYuEmAKAucnB
         5MKXsRrFvklDBB9qY245qL7sm+0tpUIzkuHqsDYJUZYCCLqUTdxyzHOUtWX6cM99ICCU
         U3RiUSXtg2otwUEg5seEq9l606hyLQ8XdhdIMx7MuVBiin/z52y3HbFrIR9r3BOQL9lw
         8qOvIUG4rm1L9HDcHzGqCVtgl1DdEnIUvFO6nB1AWTILPtHbY0Ivka4/Y6OzMvyDt0r6
         YAnw==
X-Gm-Message-State: AOAM533dsfuojTJRy11nOFYEe/M8dwBPSfaqGRtCvQSxbpg2gHszwEWd
        4tCyPqe/6146MWqiuZcSbdMZFE3c0AR1xO+uPLRhI6MM+Hwg2NrTqxDTjvgaO6AY6MRCysCMZbt
        M3ofMOWne+jhTEVqN3cOHNtnqCaHhnNwNv1PJ1dIErw==
X-Received: by 2002:a05:6402:27c7:b0:412:80f9:18af with SMTP id c7-20020a05640227c700b0041280f918afmr30760029ede.127.1645616097324;
        Wed, 23 Feb 2022 03:34:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7tPZm6P8JOYR88/LLpFjG69g/bVWBdnsMBUAkSUmzYfftrQjVlV0mGSIV792d+yte+AmjwQ==
X-Received: by 2002:a05:6402:27c7:b0:412:80f9:18af with SMTP id c7-20020a05640227c700b0041280f918afmr30760018ede.127.1645616097165;
        Wed, 23 Feb 2022 03:34:57 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id d25sm7386899ejz.4.2022.02.23.03.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:34:56 -0800 (PST)
Message-ID: <498e89dd-c438-68dc-69b5-8de82045ffbd@canonical.com>
Date:   Wed, 23 Feb 2022 12:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Rob Herring <robh@kernel.org>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
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

On 21/02/2022 04:29, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  52 ++++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> new file mode 100644
> index 000000000..e6d098cf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Clock Controller Binding
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: External oscillator clock
> +      - description: System clock
> +
> +  clock-names:
> +    items:
> +      - const: extclk
> +      - const: pllsys
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc: clock-controller@9c000000 {
> +      compatible = "sunplus,sp7021-clkc";
> +      #clock-cells = <1>;
> +      reg = <0x9c000000 0x280>;
> +      clocks = <&extclk>, <&clkc PLL_SYS>;

Except the warning pointed out by Rob's bot, it looks like you feed this
clock-controller with a clock from itself. Is there a point to express
it in DTS at all?

> +      clock-names = "extclk", "pllsys";
> +    };

Best regards,
Krzysztof
