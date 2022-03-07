Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FEA4D0712
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiCGS6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiCGS6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:58:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E011A20
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:57:40 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3AC33F4C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679459;
        bh=Xy6MdIJ1JZ9Av676oic2sRFwBOpZq/tlPRFQIZOvVVo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=am/q5y50SWdpD9yPWvEwNLQUOql3uPs1Dbg2Z0fuaDIXoHf778EknmFu4yxuO+ir2
         v/6I426oaBtRLhCkNQ0uQ7mrUQEvNCYhYRtMYqbbf2UHjK1c0JKH8lx2GQVQkS4qTC
         y2SvBwQVmu6+isqhY0JBeOcxWcBY7ZR21bZ9B7i8lL7ZL7RonA0gWNGJgDOqA8pRMr
         6DrN3M9T0Z1ZuzNQHCvnkxyOgFMB8+phktYAQ68mQVc2ygu6+jrUSv9qEdB/TUzTcd
         S8X238FL26gSnC6Lib6XIwB++dGvR7btIrLtO9SLakMQanPxzwPtyVKDh7vGCi2VwL
         fgTKuFQAcGr7Q==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020a056402344e00b0041593c729adso9183660edc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xy6MdIJ1JZ9Av676oic2sRFwBOpZq/tlPRFQIZOvVVo=;
        b=3EAnVBxE2KqbbMQhCp8LrLuRPR8jHQ35Pwum6TWB7d9bKBob4VoE018wHYh339s2HA
         DmCVnEqSW7qxAXz6sHf6j5K54LvmSz/TvJSqQHUe4djp7JfXJpNAjEVDVevCIdc6wCjj
         7OVQ5LDE9KMsUob6IjVZDHuF3s6kYjJ1Sw94pg8FIBBJhlr5MGM7lUcVUNLm+pyEmQZX
         pDbGUnDkWGLmtq3GYaD6eBtbqI2ZzzXOhruyYFmSw2/nabkzvBD+DdApISd3/8OMMKHv
         BH5fNi3KCvI0xD6y8E6JmDN2Uwikzp+MSB2Im15szfurRGRxcnHYTyJaS4+Q8WZLk+4u
         Z0pw==
X-Gm-Message-State: AOAM5318rwMmEvr5Z88QddXrifX/DYsnFx0QVV5AoYCQC3riaSWlcnf6
        tyRXWjCdzvn/cQ/UCOA1BysKkQMoXqY+W+HWNH46WOtc5J5VA9a2V1Q4HBYseTQJsq8vNEhVZOJ
        9sLNzKNsYZR860Krqs+58eZwyC14Rzb4TCwfwv3Q7/Q==
X-Received: by 2002:a17:907:9622:b0:6db:a30:8bb8 with SMTP id gb34-20020a170907962200b006db0a308bb8mr8103688ejc.475.1646679458586;
        Mon, 07 Mar 2022 10:57:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbw5jzHRiBUPGzW87WJtQ5FkmPc5d1NjPaESWeFD6YzdTpSqPNUVHDARbSb6sfuT75Z3pO8g==
X-Received: by 2002:a17:907:9622:b0:6db:a30:8bb8 with SMTP id gb34-20020a170907962200b006db0a308bb8mr8103654ejc.475.1646679458293;
        Mon, 07 Mar 2022 10:57:38 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b006da9e406786sm4598892ejb.189.2022.03.07.10.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:57:37 -0800 (PST)
Message-ID: <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
Date:   Mon, 7 Mar 2022 19:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-2-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122151.11666-2-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 13:21, Tim Chang wrote:
> convert Mediatek cpufreq devicetree binding to YAML.

Start with capital letter please.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.yaml    | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml

You wrote "convert" but where is the removal of TXT?

> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> new file mode 100644
> index 000000000000..584946eb3790
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek CPUFREQ driver Device Tree Bindings

Please remove "driver Device Tree Bindings" because the title should
describe the hardware. Therefore it could be something like "Mediatek
SoC CPU frequency and voltage scaling".

How is it related to cpufreq-mediatek-hw.yaml? The names/title look
unfortunately too similar.

In general this does not look like proper bindings (see also below lack
of compatible). Bindings describe the hardware, so what is exactly the
hardware here?

> +
> +maintainers:
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> +
> +description: |
> +  CPUFREQ is used for scaling clock frequency of CPUs.
> +  The module cooperates with CCI DEVFREQ to manage frequency for some Mediatek
> +  SoCs.
> +
> +properties:

How is this schema going to be applied? I don't see here select neither
compatible.

> +  clocks:
> +    items:
> +      - description:
> +          The first one is the multiplexer for clock input of CPU cluster.
> +      - description:
> +          The other is used as an intermediate clock source when the original
> +          CPU is under transition and not stable yet.
> +
> +  clock-names:
> +    items:
> +      - const: "cpu"
> +      - const: "intermediate"
> +
> +  operating-points-v2:
> +    description:
> +      For details, please refer to
> +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> +
> +  opp-table: true

You have operating-points-v2. What is this for? Did it exist in original
bindings?

> +
> +  proc-supply:
> +    description:
> +      Phandle of the regulator for CPU cluster that provides the supply
> +      voltage.
> +
> +  sram-supply:
> +    description:
> +      Phandle of the regulator for sram of CPU cluster that provides the supply
> +      voltage. When present, the cpufreq driver needs to do "voltage tracking"
> +      to step by step scale up/down Vproc and Vsram to fit SoC specific needs.
> +      When absent, the voltage scaling flow is handled by hardware, hence no
> +      software "voltage tracking" is needed.
> +
> +  "#cooling-cells":
> +    description:
> +      For details, please refer to
> +      Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

Skip description, it's obvious. Instead add here const with value.


Best regards,
Krzysztof
