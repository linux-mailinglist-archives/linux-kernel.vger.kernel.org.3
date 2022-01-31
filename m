Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4824A3C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiAaAs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:48:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643590104; x=1675126104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SCkBzve2s8PzHUJlrNqkRFHShNqLksqCk6FrPrsuKd8=;
  b=MycoVpu6e0mV0TJqipEqpoSkPPJH7Xrdw/G8j1M9m9QyIhuK9CVjfHNv
   3uKFgXu5HJuNwm1Sef+fTbwh1rrYnjJoEoBuJ5DfieRobNJDjq7Ysnr7C
   WOuUtPVqkd6zzOmq1m4ZBxNMRg63y1VmB7rAnlPgM4pvKOrX6scRg9Ap/
   UPCz7i38gBSt9iE/KyRdDoE24OGd5+XMai1YA7iAGTAbzFesr/kMYAg++
   iPkuwKVbmkkHhA17ldVx4wD4kShL8z1pGhiyJ9X+zVfofZZj+/jTyGUg5
   N4bCWqMX428hXp1XrokFotsSThwMBdPNKV6APP0LzhXzx38doBhL7BTD9
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,329,1635177600"; 
   d="scan'208";a="191761533"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2022 08:48:23 +0800
IronPort-SDR: +2XmV3hhpFCC6Q6G/W0jKn4Fg2ORde+chOgkXE2LsCEFEmlK3jhd9s/asMCYX3VWCFcUTslpEO
 ISncdf1Oatt4uX0k4q1uDoOhWS5G0fSdQDDc651yDwBBehYX/o8hirBSnIc5DH+/myCOBw9GfX
 ist34PpULvYoKfe4gwMcwWfvIbr6bFJVPk1pzfJgmfvn9PNyk/dVoiPSi4MFZEwDEkDN3eBR/A
 hFr3+p2PxEm/J32x7aHcZkLP/wSxfu31OmwuDZjRrVWKRvvLbMMiPM4IRJsNQQUqPbMfDns4xq
 4govqLVynI1/NE6Njmzbkwpp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:20:25 -0800
IronPort-SDR: u5UI0mE0l67qu0e4VNoLn4wUcctJSXf4hCLXi94G7dmCfdDwr70FLzroU7i0f8kVcpZdgkW7GR
 fWnC04Pwxgu506DeWV6KLlpDmRZ5mIAdTuFdYr+sel6Nekr3z6mcEjpNpXPckrwxT+1jo2g80l
 fZxG6ka//atE5VkbJ0AEZnEKAL8mNwuQLhu7Yh86TAI7WIZOAywDbc5/rVA6jUbat+nwcKrzDO
 UUZgY20YiLHiHAHH5kfl4Ip0Ec+eVw4uc/apps/+125jCPjUcBppXg9QKQU806xF3eqymNu4N6
 Dz8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:48:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jn8Z03HWNz1SVp2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 16:48:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643590103; x=1646182104; bh=SCkBzve2s8PzHUJlrNqkRFHShNqLksqCk6F
        rPrsuKd8=; b=lJ3tOCc4tZpbgFtTON19O0WRIzoWBC2gp0MAnacpLYhTYmRm1O3
        K9XNo9avga72zSwYUbprWkIwPhINGmPhp3lb5+qv3hVSNC9XPycC8COFeMrHg8mz
        /9v4xNeGc0ymG0XLwy79neGEKGBaARU/nwj5UqA51jRl59f3MfKBnxevs1W3Q50W
        8DL7Hztnaea9Rxy2E3uAa2gQumJwxCDMxqfuL2+t8prMJaQQwbJBXIomQTiMpOTR
        gbZ1CZaq8Jscnsbo8XjRLNWKXoxe9b/hHv+IawMTigGannSyHVAK/Pd4PQyBOh/L
        iMhePZlf16qc7jzMe0UTBzi8+vnTF+XY8dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ct5f6iAIDaA for <linux-kernel@vger.kernel.org>;
        Sun, 30 Jan 2022 16:48:23 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jn8Yy2yw8z1RvlN;
        Sun, 30 Jan 2022 16:48:22 -0800 (PST)
Message-ID: <c827a283-a2ba-b89c-2361-627f24e5f86f@opensource.wdc.com>
Date:   Mon, 31 Jan 2022 09:48:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220129204004.1009571-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/30 5:40, Corentin Labbe wrote:
> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../ata/cortina,gemini-sata-bridge.txt        |  55 ----------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 55 deletions(-)
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
> index 000000000000..ff27e4884e21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> @@ -0,0 +1,100 @@
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
> +    const: "cortina,gemini-sata-bridge"
> +  reg:
> +    minItems: 1
> +  resets:
> +    minItems: 2
> +    description: phandles to the reset lines for both SATA bridges
> +  reset-names:
> +    items:
> +      - const: "sata0"
> +      - const: "sata1"
> +  clocks:
> +    minItems: 2
> +    description: phandles to the compulsory peripheral clocks
> +  clock-names:
> +    items:
> +      - const: "SATA0_PCLK"
> +      - const: "SATA1_PCLK"
> +  syscon:
> +    minItems: 1
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the global Gemini system controller

s/a phandle/phandle ?

Saying "a phandle" seems to imply that there may be many. I am not sure here though.

> +  cortina,gemini-ata-muxmode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0
> +      - 1
> +      - 2
> +      - 3
> +    description: |
> +      tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:

Nit: Start the sentence with an uppercase "Tell...".

> +      Mode 0: ata0 master <-> sata0
> +              ata1 master <-> sata1
> +              ata0 slave interface brought out on IDE pads
> +      Mode 1: ata0 master <-> sata0
> +              ata1 master <-> sata1
> +              ata1 slave interface brought out on IDE pads
> +      Mode 2: ata1 master <-> sata1
> +              ata1 slave  <-> sata0
> +              ata0 master and slave interfaces brought out on IDE pads
> +      Mode 3: ata0 master <-> sata0
> +              ata0 slave  <-> sata1
> +              ata1 master and slave interfaces brought out on IDE pads
> +
> +  cortina,gemini-enable-ide-pins:
> +    type: boolean
> +    description: enables the PATA to IDE connection.

Same here.

> +                 The muxmode setting decides whether ATA0 or ATA1 is brought out,
> +                 and whether master, slave or both interfaces get brought out.
> +  cortina,gemini-enable-sata-bridge:
> +    type: boolean
> +    description: enables the PATA to SATA bridge

Ditto. And the line break is a little early. The first line could be longer so
that everything fits in 2 lines.

> +                 inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> +                 be muxed out and how.
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - cortina,gemini-ata-muxmode
> +  - resets
> +  - reset-names
> +  - compatible
> +  - reg
> +  - syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    sata: sata@46000000 {
> +      compatible = "cortina,gemini-sata-bridge";
> +      reg = <0x46000000 0x100>;
> +      resets = <&rcon 26>, <&rcon 27>;
> +      reset-names = "sata0", "sata1";
> +      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> +               <&gcc GEMINI_CLK_GATE_SATA1>;
> +      clock-names = "SATA0_PCLK", "SATA1_PCLK";
> +      syscon = <&syscon>;
> +      cortina,gemini-ata-muxmode = <3>;
> +      cortina,gemini-enable-ide-pins;
> +      cortina,gemini-enable-sata-bridge;
> +    };

With the above cosmetic nits addressed (if necessary):

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
