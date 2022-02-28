Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F24C6AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiB1Ljo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiB1Ljl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:39:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11794FC71
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:39:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so5860952wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=cDBGScHfkVSTv36VXkfG5X5AthUAMH7efzJ/5wfVXyk=;
        b=G19khUKoVFopgICadeMBa+MJ/QxUS1CYLQM10sGrMuv4xiIf33Axd54WyOPvKfIO3Y
         L7UkSenO9jqNGoD4EfqXVUKiXmaD1slGcuu30Kg6qIpu9HT/C4JmQKbcoBdJxlo6JJYY
         DtLAgxgVdnSpHGyMEk7kzzPQX793n9H3lTi3h6Ty+Lx1r0Bt6V16IX8QG2D84erqJYdw
         BFouAKSguSLyVVpUqukrJSBESoyRCx2owYdqFzEIg8LthZIjAWyr2xofBcIFLl+rmMWa
         fmjOmhLEaQ2uKiawrWl8tUKZ70lpDjhNQBfQ0fZ2CPaVCfdczeBu6dxaiNB+iA90vu2i
         bhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=cDBGScHfkVSTv36VXkfG5X5AthUAMH7efzJ/5wfVXyk=;
        b=nNogKXHPv8hvVkpbTUIUHjboj5xevLmiEAq8yeCIgR5nbMDiJa5Fpslc829Rn0FbJG
         wO8ApcVRKJRqjmgW0XAmSU+Gco7+1tYYxF9QcEhQey1WlLc1XgW8K4ih4OqRveQ/6mTk
         1dVtEDC26Ae1Nf1NqzloMNZDU54Dwo925FbFzt35hDRQ4Ko4N3dKK1fK3Y0IGq+P+86I
         x8JNrTRCgenWk8XcFchAt4OBwrFGFLa4pzcNukTfYeunZ6U/guRDpLjsPGFA8Y8xycog
         YrWVvHUF0glaZjjd/orD5hXDF6RFUc7k2JZvna+eTbIgk9Hz3ro/SSlepo/PoriGzlsA
         960w==
X-Gm-Message-State: AOAM531GmSGOalEaDhHCirsGym+pckOIOddYf8mCwp0czcjtxI7W0aY7
        9qmKKmK2voLRXazerb5pbSw5qQ==
X-Google-Smtp-Source: ABdhPJyQvLDg5tgx3z4pz1Ltnv/7yUVwwyIUa7+ilIX3vUU4XiuriGiFjBw7ZvViVN8Ear/bk8xMzQ==
X-Received: by 2002:a7b:c24e:0:b0:380:e16c:a040 with SMTP id b14-20020a7bc24e000000b00380e16ca040mr12751486wmj.186.1646048341137;
        Mon, 28 Feb 2022 03:39:01 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u14-20020adfed4e000000b001e3323611e5sm10275935wro.26.2022.02.28.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:00 -0800 (PST)
References: <20220217063346.21691-1-liang.yang@amlogic.com>
 <20220217063346.21691-3-liang.yang@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
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
Date:   Mon, 28 Feb 2022 12:36:32 +0100
In-reply-to: <20220217063346.21691-3-liang.yang@amlogic.com>
Message-ID: <1jv8wzw78r.fsf@starbuckisacylon.baylibre.com>
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


On Thu 17 Feb 2022 at 14:33, Liang Yang <liang.yang@amlogic.com> wrote:

> convert txt to yaml and refine the meson NFC clock document.
>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 60 ----------------
>  .../bindings/mtd/amlogic,meson-nand.yaml      | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> deleted file mode 100644
> index 5794ab1147c1..000000000000
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> -
> -This file documents the properties in addition to those available in
> -the MTD NAND bindings.
> -
> -Required properties:
> -- compatible : contains one of:
> -  - "amlogic,meson-gxl-nfc"
> -  - "amlogic,meson-axg-nfc"
> -- clocks     :
> -	A list of phandle + clock-specifier pairs for the clocks listed
> -	in clock-names.
> -
> -- clock-names: Should contain the following:
> -	"core" - NFC module gate clock
> -	"device" - device clock from eMMC sub clock controller
> -	"rx" - rx clock phase
> -	"tx" - tx clock phase
> -
> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> -				controller port C
> -
> -Optional children nodes:
> -Children nodes represent the available nand chips.
> -
> -Other properties:
> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
> -
> -Example demonstrate on AXG SoC:
> -
> -	sd_emmc_c_clkc: mmc@7000 {
> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> -		reg = <0x0 0x7000 0x0 0x800>;
> -	};
> -
> -	nand-controller@7800 {
> -		compatible = "amlogic,meson-axg-nfc";
> -		reg = <0x0 0x7800 0x0 0x100>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> -
> -		clocks = <&clkc CLKID_SD_EMMC_C>,
> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
> -		clock-names = "core", "device", "rx", "tx";
> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&nand_pins>;
> -
> -		nand@0 {
> -			reg = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			nand-on-flash-bbt;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> new file mode 100644
> index 000000000000..671f0a8fdc7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +maintainers:
> +  - liang.yang@amlogic.com
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "amlogic,meson-gxl-nfc"
> +      - "amlogic,meson-axg-nfc"
> +
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: "core", "device"
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    nand-controller@7800 {
> +	compatible = "amlogic,meson-axg-nfc";
> +	reg = <0x0 0x7800 0x0 0x100>,
> +	      <0x0 0x7000 0x0 0x1>;

Please name the register ressources instead of relying on the order

Also, use the actual size of region, not the size you are using in the
driver. AFAIK, the size of the 2nd region is not 0x1

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +
> +	clocks = <&clkc CLKID_SD_EMMC_C>,
> +		<&clkc CLKID_FCLK_DIV2>;
> +	clock-names = "core", "device";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_pins>;
> +
> +	nand@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		nand-on-flash-bbt;
> +	};
> +     };
> +
> +...
> \ No newline at end of file

