Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687C58BAF5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiHGNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiHGNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:17:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89B63F6;
        Sun,  7 Aug 2022 06:17:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so8442656edd.13;
        Sun, 07 Aug 2022 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=zfLHI7kFYa9QqzX7jm3Dg9uXF+tlKoVCc88jlw3/8KQ=;
        b=oVLItqJws2allNf5cNYLRsBjpe4cMJxw3wyvlDesdNvOtva6JdH5tYs8uRlvw4kbJf
         f29NtFqbkJAaD9UsgZjDLKxdWapHtuAln4azG0nl8ztNN1gkZ8kIw+8rFK29tU9eBmz6
         W8oo8bG35OMlBkaYqz0LxIdR8eKBp1LXSJWux1OL7okrr5raclBeI/kQUSHMsQ0KQScC
         0Jv6XvjOwhq9YbNcxMbRCNxe4zCaVjMu5XtDrub+b+YzvtttjbLuLrAZOZ7PzqBUZdWK
         XKzdmUTV36KAp0XdGGBlKH25zyd8llkWxncXcdz/E+s2Nnve4UaWm4Qh7AnnjwyEei2J
         cKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfLHI7kFYa9QqzX7jm3Dg9uXF+tlKoVCc88jlw3/8KQ=;
        b=6dOywnvAyO+cW3sGENnyAhTLs4G1s1PEzXugQyqPnsoCUn8xVPigjVveA5b+1etVkd
         RHBKhTLOsUTMBpCgk0fHos5lH9D2+1EdewQPOgXBahfWat4U45snyXU/RDCnBECr62+o
         aWL8NSYVjYDtC67Dndmyvcejuy3rcUk7eDkw6P5Bvgs7wOyjQg2s/6X98n+OELV4vFmM
         tWKStA7MH0V44T3Max3lX/5D4nmnGWH2Et1/RoRgSrZku9ufLsTgAPuZj4mEe5bo+mUR
         PPYvUQqSBgtYICSgsOKiDzGXlB4k123/g/fjIJlna34pA7DObSqfoBSiDHQ/VjBpAMdK
         QmoQ==
X-Gm-Message-State: ACgBeo3OgVxoHKEbzA7JujCK4nUEitLh33cpzqhiwQ3+oUvsQqs4NfmQ
        mzxiwkVJO+YGAw2QayFXpM4=
X-Google-Smtp-Source: AA6agR4onaAEfG8SYXpc3i+szZ7HPi7aOmntQ9idJByRZWNmdzi8I27IsQWkDZ0PFTl66W32C/s4qQ==
X-Received: by 2002:a05:6402:378a:b0:431:6d8d:9023 with SMTP id et10-20020a056402378a00b004316d8d9023mr14512494edb.98.1659878248925;
        Sun, 07 Aug 2022 06:17:28 -0700 (PDT)
Received: from Ansuel-xps. (host-87-20-249-30.retail.telecomitalia.it. [87.20.249.30])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709063a4400b006fe8c831632sm3786523ejf.73.2022.08.07.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 06:17:28 -0700 (PDT)
Message-ID: <62efbb68.170a0220.88a00.8207@mx.google.com>
X-Google-Original-Message-ID: <Yu+3UG8OqWPaHB55@Ansuel-xps.>
Date:   Sun, 7 Aug 2022 15:00:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718161826.4943-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:18:24PM +0200, Christian Marangi wrote:
> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
> some additional pcie, sata and usb configuration values, additional
> reserved memory and serial output.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Any news for this?

> ---
>  .../boot/dts/qcom-ipq8064-v2.0-smb208.dtsi    | 37 ++++++++++
>  arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi      | 69 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
> new file mode 100644
> index 000000000000..0442580b22de
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qcom-ipq8064-v2.0.dtsi"
> +
> +&rpm {
> +	smb208_regulators: regulators {
> +		compatible = "qcom,rpm-smb208-regulators";
> +
> +		smb208_s1a: s1a {
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1150000>;
> +
> +			qcom,switch-mode-frequency = <1200000>;
> +		};
> +
> +		smb208_s1b: s1b {
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1150000>;
> +
> +			qcom,switch-mode-frequency = <1200000>;
> +		};
> +
> +		smb208_s2a: s2a {
> +			regulator-min-microvolt = < 800000>;
> +			regulator-max-microvolt = <1250000>;
> +
> +			qcom,switch-mode-frequency = <1200000>;
> +		};
> +
> +		smb208_s2b: s2b {
> +			regulator-min-microvolt = < 800000>;
> +			regulator-max-microvolt = <1250000>;
> +
> +			qcom,switch-mode-frequency = <1200000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> new file mode 100644
> index 000000000000..2f117d576daf
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qcom-ipq8064.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ8064-v2.0";
> +
> +	aliases {
> +		serial0 = &gsbi4_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rsvd@41200000 {
> +			reg = <0x41200000 0x300000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&gsbi4 {
> +	qcom,mode = <GSBI_PROT_I2C_UART>;
> +	status = "okay";
> +
> +	serial@16340000 {
> +		status = "okay";
> +	};
> +	/*
> +	 * The i2c device on gsbi4 should not be enabled.
> +	 * On ipq806x designs gsbi4 i2c is meant for exclusive
> +	 * RPM usage. Turning this on in kernel manifests as
> +	 * i2c failure for the RPM.
> +	 */
> +};
> +
> +&pcie0 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&pcie1 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&pcie2 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&sata {
> +	ports-implemented = <0x1>;
> +};
> +
> +&ss_phy_0 {
> +	qcom,rx-eq = <2>;
> +	qcom,tx-deamp_3_5db = <32>;
> +	qcom,mpll = <5>;
> +};
> +
> +&ss_phy_1 {
> +	qcom,rx-eq = <2>;
> +	qcom,tx-deamp_3_5db = <32>;
> +	qcom,mpll = <5>;
> +};
> -- 
> 2.36.1
> 

-- 
	Ansuel
