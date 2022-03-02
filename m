Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD94C9FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiCBIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiCBIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:46:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D506BAB9C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:46:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m6so1508444wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=OAGdmlBU750HPm6uS/2rXxP2qybmRe1eYS45j7gSSxk=;
        b=WP4yMtfpQleDkk9wS69RYgsd68w6DMQxWIrclmUo4ldChNykmhvZIvGgi45qagVVL0
         UM9bmwGhBpdP8zVcFR071ykfwaDmXmlr2ZJCi+E0Qhw2yvSw3V9asr736pAim0U5wGpt
         enFSpLql7sLfSqYp5bvc1GJ2tLchgQkdateHkYFSSo3CnNOstJzQnynEB1JGCcNYVjFt
         XcpGwRjNrBhq6+TLM/u/r3cesiY5jqJ6imlF8CzyurvZSBtCDEbqxNgWUbFzXHb+XZHH
         u8Kvv5U8rqogA7drPeghTaWJCRa8BFA2RzR4YtjnghgYZeyhAftCkO43oHmYFlySK5UT
         578A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=OAGdmlBU750HPm6uS/2rXxP2qybmRe1eYS45j7gSSxk=;
        b=dN/ljmkqNtPGv9rhI0eRluRkzRIlcLQQELfHa60KfwF6mVaSAd93suW1tfw9/xnub+
         VG6bqyZxmK1zQkI80nOSpmYlQaAyW10q2czcZq+H6eFpVHuV8NY6z2rf+MSA+m1qLbIO
         wUfcYryV8OCiwDi4DfwCfHdCPf1bEvUS3wH2pqc/C3AQVz0QdxR9/gEnaKMuJVn0A5QR
         WO3DolU3U0/SOv4/VxMeFuqR4gl+mWu+nFfGhgwFVhOTBDvVsldYjnNapH38YDT69d/Y
         FjIt4AM5w/Ut/wLFvRokTmsTAndJCXQRu0158tryho8Q8aPfvt2RVlla4L3oqxs+OwmX
         VvMw==
X-Gm-Message-State: AOAM533sCWJVNeJIwSi409E8grgl65DAuJUdEMKLoj0GF3YWzjyGjTkm
        JUmkF0v/04lO4TpGKnhBYV5LYQ==
X-Google-Smtp-Source: ABdhPJw5nDmQ7R5dprkc1DDIySxAi6zQnYTihowhbWzCteml7VcyIvHFYuoM8SHpvqOj/d50zsSxUg==
X-Received: by 2002:a05:6000:15cb:b0:1ea:78fc:2201 with SMTP id y11-20020a05600015cb00b001ea78fc2201mr22973825wry.362.1646210772967;
        Wed, 02 Mar 2022 00:46:12 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b001efd7eb7c37sm7983296wrp.34.2022.03.02.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:46:12 -0800 (PST)
References: <20220217063346.21691-1-liang.yang@amlogic.com>
 <20220217063346.21691-3-liang.yang@amlogic.com>
 <1jv8wzw78r.fsf@starbuckisacylon.baylibre.com>
 <4741f36a-e17a-75c3-124f-447e4426c436@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "Liang.Yang" <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] dt-bindings: nand: meson: refine Amlogic
 NAND controller driver
Date:   Wed, 02 Mar 2022 09:42:06 +0100
In-reply-to: <4741f36a-e17a-75c3-124f-447e4426c436@amlogic.com>
Message-ID: <1jczj47ne5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 02 Mar 2022 at 13:19, Liang.Yang <liang.yang@amlogic.com> wrote:

> Hi Jerome,
>
> On 2022/2/28 19:36, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> On Thu 17 Feb 2022 at 14:33, Liang Yang <liang.yang@amlogic.com> wrote:
>> 
>>> convert txt to yaml and refine the meson NFC clock document.
>>>
>>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>>> ---
>>>   .../bindings/mtd/amlogic,meson-nand.txt       | 60 ----------------
>>>   .../bindings/mtd/amlogic,meson-nand.yaml      | 70 +++++++++++++++++++
>>>   2 files changed, 70 insertions(+), 60 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>> deleted file mode 100644
>>> index 5794ab1147c1..000000000000
>>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>> +++ /dev/null
>>> @@ -1,60 +0,0 @@
>>> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>>> -
>>> -This file documents the properties in addition to those available in
>>> -the MTD NAND bindings.
>>> -
>>> -Required properties:
>>> -- compatible : contains one of:
>>> -  - "amlogic,meson-gxl-nfc"
>>> -  - "amlogic,meson-axg-nfc"
>>> -- clocks     :
>>> -	A list of phandle + clock-specifier pairs for the clocks listed
>>> -	in clock-names.
>>> -
>>> -- clock-names: Should contain the following:
>>> -	"core" - NFC module gate clock
>>> -	"device" - device clock from eMMC sub clock controller
>>> -	"rx" - rx clock phase
>>> -	"tx" - tx clock phase
>>> -
>>> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>>> -				controller port C
>>> -
>>> -Optional children nodes:
>>> -Children nodes represent the available nand chips.
>>> -
>>> -Other properties:
>>> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
>>> -
>>> -Example demonstrate on AXG SoC:
>>> -
>>> -	sd_emmc_c_clkc: mmc@7000 {
>>> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>>> -		reg = <0x0 0x7000 0x0 0x800>;
>>> -	};
>>> -
>>> -	nand-controller@7800 {
>>> -		compatible = "amlogic,meson-axg-nfc";
>>> -		reg = <0x0 0x7800 0x0 0x100>;
>>> -		#address-cells = <1>;
>>> -		#size-cells = <0>;
>>> -		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>> -
>>> -		clocks = <&clkc CLKID_SD_EMMC_C>,
>>> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
>>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>>> -		clock-names = "core", "device", "rx", "tx";
>>> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>>> -
>>> -		pinctrl-names = "default";
>>> -		pinctrl-0 = <&nand_pins>;
>>> -
>>> -		nand@0 {
>>> -			reg = <0>;
>>> -			#address-cells = <1>;
>>> -			#size-cells = <1>;
>>> -
>>> -			nand-on-flash-bbt;
>>> -		};
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>> new file mode 100644
>>> index 000000000000..671f0a8fdc7c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>> @@ -0,0 +1,70 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>>> +
>>> +maintainers:
>>> +  - liang.yang@amlogic.com
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - "amlogic,meson-gxl-nfc"
>>> +      - "amlogic,meson-axg-nfc"
>>> +
>>> +  reg:
>>> +    maxItems: 2
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: "core", "device"
>>> +
>>> +  "#clock-cells":
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - "#clock-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    nand-controller@7800 {
>>> +	compatible = "amlogic,meson-axg-nfc";
>>> +	reg = <0x0 0x7800 0x0 0x100>,
>>> +	      <0x0 0x7000 0x0 0x1>;
>> Please name the register ressources instead of relying on the order
> ok
>> Also, use the actual size of region, not the size you are using in the
>> driver. AFAIK, the size of the 2nd region is not 0x1
> yes, it should be 0x4 here, i will fix it.
> we only need to use a 32bits SDEMMC_CLOCK register.
> thanks.

No, it is not the point.
What register you need in the driver is not relevant.
What is relevant is the actual size of the memory region - so it not 0x1
or 0x4 ... more likely 0x800 from what I see in the AXG dts.

>> 
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +	interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>> +
>>> +	clocks = <&clkc CLKID_SD_EMMC_C>,
>>> +		<&clkc CLKID_FCLK_DIV2>;
>>> +	clock-names = "core", "device";
>>> +
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&nand_pins>;
>>> +
>>> +	nand@0 {
>>> +		reg = <0>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +
>>> +		nand-on-flash-bbt;
>>> +	};
>>> +     };
>>> +
>>> +...
>>> \ No newline at end of file
>> .

