Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1904B1268
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiBJQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:12:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244072AbiBJQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:12:38 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FAC51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:12:38 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 535D740260
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644509551;
        bh=UqplXcK8UtxJT/txE7jNL0wD1nuJxIhREgfiQibRdZg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fnAGvyUoTS7wiEXyAzrfbET7HNcVxYvQtwmJnYIujG4x4GuknspW2alVl1dh90fPS
         k1jvrNcISgOrOz+VmgLK6dz8v13O+Wq/kV+XgnWVkjP4UomDKmOqT4ZWBnRu9ldakL
         +O8YdmbawCBdg4lDuz8Qc35EnutQklk+lEZtOLjPbFLz6hn9Cc07Wn9ceHfNxgyH2m
         P0TW3LBDRTM9JiOqoVkQhrAXHuUEUiYs9yzo9L2Ke4xuDCtLRCllvY2md/QWAR/mHK
         nOs2rlvvPMwjnymxu3nFNmpfIEmW+CrMA5G949vlkm/iZ6XxL+ZKC4BKZVHdXRztpl
         Z+BckMBwylAXg==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso2932237ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UqplXcK8UtxJT/txE7jNL0wD1nuJxIhREgfiQibRdZg=;
        b=NxDTWaLuaKFovmOYorQetJK88pmEfgcocmrR0mqmOAMk9qdN8YHw2w2BgrBGtLSA82
         sBflow9jHrB/ty+D5qUr4tJKpcBdEH52DcZvC478WV0bpQaVhMnc8nHwPHhD2RaNcGOL
         0/X9GbU4jpMTroi35FsARTTBynsDAe+b0MXdybZFe02D5rdsPQSK4J7N3To8Sp5q9ySU
         mWRjEfCEN3sph1qVTElTwdWpUlcvkWcjXfdkKJN6Jtk5x/lpSBTwBi14Sq7AyOv0lk93
         u/EIkqVitAi81UksQ9F/0Bfjan3QggVa56m7CRCkNG272sUfKHGkgQB1ezOX4u0mia66
         dupA==
X-Gm-Message-State: AOAM5313nQLHgUfzz3AZKpe44XR6Yaqkpaymtlp0gGPTBsNh+rqG85oZ
        5OtxLYv4J1y+8ic9H0rUimqXcvOWlIuiG0alBamvigcB3iiQf9UtJE09VT8hLGQe4Wk43ItQQLf
        K4mR+nnwllfT/9pPBZztBWg9ebn4YZZ45gDtS8e2IJA==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr9006663edo.131.1644509550960;
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWpMYTLzQraEPVvwNMVUaVC0aP/A+UTcgF1OpK8OGFsd9WgRVlZDhDMlFIxuCpnawuKs8OkQ==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr9006643edo.131.1644509550680;
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id cn15sm4513144edb.37.2022.02.10.08.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
Message-ID: <838394d2-bc47-1a8b-56dd-320d0df39dfe@canonical.com>
Date:   Thu, 10 Feb 2022 17:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] dt-bindings: convert ata/cortina,gemini-sata-bridge to
 yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>,
        damien.lemoal@opensource.wdc.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220210160712.2962810-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210160712.2962810-1-clabbe@baylibre.com>
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

On 10/02/2022 17:07, Corentin Labbe wrote:
> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed cosmetic nits reported by Damien Le Moal
> Changes since v2:
> - Added blank lines between properties
> - Removed useless quotes and label
> - Re-indented description
> Change since v3:
> - fixed all min/maxitems reported by Krzysztof Kozlowski
> 
>  .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> deleted file mode 100644
> index 1c3d3cc70051..000000000000
> --- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Cortina Systems Gemini SATA Bridge
> -
> -The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> -takes two Faraday Technology FTIDE010 PATA controllers and bridges
> -them in different configurations to two SATA ports.
> -
> -Required properties:
> -- compatible: should be
> -  "cortina,gemini-sata-bridge"
> -- reg: registers and size for the block
> -- resets: phandles to the reset lines for both SATA bridges
> -- reset-names: must be "sata0", "sata1"
> -- clocks: phandles to the compulsory peripheral clocks
> -- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
> -- syscon: a phandle to the global Gemini system controller
> -- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
> -  the ATA controller and SATA bridges. Values 0..3:
> -  Mode 0: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata0 slave interface brought out on IDE pads
> -  Mode 1: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata1 slave interface brought out on IDE pads
> -  Mode 2: ata1 master <-> sata1
> -          ata1 slave  <-> sata0
> -          ata0 master and slave interfaces brought out
> -               on IDE pads
> -  Mode 3: ata0 master <-> sata0
> -          ata0 slave  <-> sata1
> -          ata1 master and slave interfaces brought out
> -               on IDE pads
> -
> -Optional boolean properties:
> -- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
> -  The muxmode setting decides whether ATA0 or ATA1 is brought out,
> -  and whether master, slave or both interfaces get brought out.
> -- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
> -  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> -  be muxed out and how.
> -
> -Example:
> -
> -sata: sata@46000000 {
> -	compatible = "cortina,gemini-sata-bridge";
> -	reg = <0x46000000 0x100>;
> -	resets = <&rcon 26>, <&rcon 27>;
> -	reset-names = "sata0", "sata1";
> -	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> -		 <&gcc GEMINI_CLK_GATE_SATA1>;
> -	clock-names = "SATA0_PCLK", "SATA1_PCLK";
> -	syscon = <&syscon>;
> -	cortina,gemini-ata-muxmode = <3>;
> -	cortina,gemini-enable-ide-pins;
> -	cortina,gemini-enable-sata-bridge;
> -};
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> new file mode 100644
> index 000000000000..77af2559b097
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cortina Systems Gemini SATA Bridge
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> +    takes two Faraday Technology FTIDE010 PATA controllers and bridges
> +    them in different configurations to two SATA ports.
> +
> +properties:
> +  compatible:
> +    const: cortina,gemini-sata-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2
> +    description: phandles to the reset lines for both SATA bridges
> +
> +  reset-names:
> +    items:
> +      - const: sata0
> +      - const: sata1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +    description: phandles to the compulsory peripheral clocks
> +
> +  clock-names:
> +    items:
> +      - const: SATA0_PCLK
> +      - const: SATA1_PCLK
> +
> +  syscon:
> +    maxItems: 1

My bad, I am sorry for misleading you earlier, this is just a phandle,
so should be without any min/maxItems.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the global Gemini system controller
> +

With maxItems removed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
