Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EF34DB553
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357271AbiCPPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiCPPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:52:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B240E6E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:50:56 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B3AE3F221
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647445854;
        bh=HvaRNfutCNKLhahjNo+JQfIF58rvJReA0Z+kiiuJ6gw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pLPSyt4Dfl6KXFSCeVSvapJubJTqUCfiz4heTB4zSul1wzEUxa/eBaHfmJcgUxnAe
         sRjr9a06MeBDNiT5gHRmdmDhZMXl2It5hXq9xNZEnqeUv3Nmqwqg2PPmKlhLFYNsGk
         dnj/UzqY4LOpE2H8b5zGA2Hxfv2zRgo4CFnharelMqmWTZZhiDpgpXpF1CzEDVTyN+
         xcqpE8rJtC9iFoDK0+8eeBEYsOxD96T5dW4DZTgMN3HfsRIELFMM67+YoFyBgr5ddr
         p2VESvHxd5VhWCIdJvx9ZvG6duol/5ZsJdFRydOqoOnoAyQzanEtH+TSPYIVK3QMgQ
         IJZAPVeELIAUQ==
Received: by mail-wr1-f70.google.com with SMTP id d17-20020adfc3d1000000b00203e2ff73a6so485157wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvaRNfutCNKLhahjNo+JQfIF58rvJReA0Z+kiiuJ6gw=;
        b=qUOPxpR7SjfdiLeO5HA2new/BGmNAx7mcZavjolO2Y7rwkAgckdoTqJItVX6eroteW
         1JGFVGNqBcu62ZvmstAMw3Zj8/CI7+BREKPaDPL0y9JLfTAMA4pC+v+ikUpPjp2T4olR
         npO2chUb4mtl4v0XHpKMWtz0iorzieLydRzzGhjcAKY0ezDl3BwOqMywQPGjux7sjPmu
         oZA4WUHOwgcX/qHWoCuVgF6+X8J8kcc7j2F6CinX2hHvRJVK53hwUTtgNzoZru3n1Uha
         3Urw5muHVDcwlBAhCx24YbmwPGm6YHffhTslIRHR78jzme1KL9zFZiMrk0WH82f95BR6
         gC+w==
X-Gm-Message-State: AOAM530Dn4olF+8W+iME5Yr1AtYkN8hb2UjzSktAfRySZx5u0vCq/Vfx
        62WPkP95faSiTQKRCPYPreNDkCWvneiC3t4UIMq3D+FaG3/XjjZHCqfXScDjwQuyBIGfAiHRSZ4
        B6db8GGuT5j8E1Oy8cbkwwQkD+iXQdIo6b8NSmw+z7w==
X-Received: by 2002:adf:a551:0:b0:1f0:23fd:6f11 with SMTP id j17-20020adfa551000000b001f023fd6f11mr436404wrb.7.1647445854080;
        Wed, 16 Mar 2022 08:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQqqJ+nDGKXrOS1VEARwnjbWFRztgMdeejd2f0SHoTsOezIbLIQvsvGOybcrd8b3UelpB/+A==
X-Received: by 2002:adf:a551:0:b0:1f0:23fd:6f11 with SMTP id j17-20020adfa551000000b001f023fd6f11mr436386wrb.7.1647445853859;
        Wed, 16 Mar 2022 08:50:53 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm2043363wmh.33.2022.03.16.08.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:50:53 -0700 (PDT)
Message-ID: <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
Date:   Wed, 16 Mar 2022 16:50:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 16:41, Hawkins, Nick wrote:
> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
> Sent: Friday, March 11, 2022 4:30 AM
> To: Hawkins, Nick <nick.hawkins@hpe.com>>; Verdun, Jean-Marie <verdun@hpe.com>>
> Cc: Arnd Bergmann <arnd@arndb.de>>; Olof Johansson <olof@lixom.net>>; soc@kernel.org; Rob Herring <robh+dt@kernel.org>>; linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
> 
> On 10/03/2022 20:52, nick.hawkins@hpe.com wrote:
>>> From: Nick Hawkins <nick.hawkins@hpe.com>>
>>>
>>> The HPE SoC is new to linux. This patch creates the basic device tree 
>>> layout with minimum required for linux to boot. This includes timer 
>>> and watchdog support.
>>>
>>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>>
>>> ---
>>>  arch/arm/boot/dts/Makefile               |   2 +
>>>  arch/arm/boot/dts/hpe-bmc-dl360gen10.dts |  27 +++++
>>>  arch/arm/boot/dts/hpe-gxp.dtsi           | 148 +++++++++++++++++++++++
>>>  3 files changed, 177 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
>>>  create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile 
>>> index e41eca79c950..2823b359d373 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1550,3 +1550,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>  	aspeed-bmc-vegman-n110.dtb \
>>>  	aspeed-bmc-vegman-rx20.dtb \
>>>  	aspeed-bmc-vegman-sx20.dtb
>>> +dtb-$(CONFIG_ARCH_HPE_GXP) += \
>>> +	hpe-bmc-dl360gen10.dtb
> 
>> Alphabetically, also in respect to other architectures, so before CONFIG_ARCH_INTEGRATOR.
> 
> Done
> 
>>> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
>>> b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
>>> new file mode 100644
>>> index 000000000000..da5eac1213a8
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
>>> @@ -0,0 +1,27 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree file for HPE DL360Gen10  */
>>> +
>>> +/include/ "hpe-gxp.dtsi"
>>> +
>>> +/ {
>>> +	#address-cells = <1>>;
>>> +	#size-cells = <1>>;
>>> +	compatible = "hpe,gxp";
> 
>> Missing board compatible.
> 
> Will become compatible =  "hpe,gxp","hpe,bmc-dl360gen10"; If that seems okay to you.

Yes, except hpe,gxp goes at the end.

> 
>>> +	model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
>>> +

(...)

>>> +
>>> +		usb0: usb@cefe0000 {
>>> +			compatible = "generic-ehci";
> 
>> I think one of previous comments was that you cannot have "generic-ehci"
>> only, right?
> 
> Yes there was, I removed the usb0: ehci@cefe0000. I see now that this is in reference to the compatible. This is our ehci controller. What would be a more appropriate compatible? Do we need hpe,gxp-ehci perhaps?

Yes,, see other cases in generic-ehci.yaml bindings. Your current choice
would be pointed out by dtbs_check, that it's invalid according to
current bindings.

> 
>>> +			reg = <0xcefe0000 0x100>>;
>>> +			interrupts = <7>>;
>>> +			interrupt-parent = <&vic0>>;
>>> +		};
>>> +
>>> +		usb1: usb@cefe0100 {
>>> +			compatible = "generic-ohci";
>>> +			reg = <0xcefe0100 0x110>>;
>>> +			interrupts = <6>>;
>>> +			interrupt-parent = <&vic0>>;
>>> +		};
>>> +
>>> +		vrom@58000000 {
>>> +			compatible = "mtd-ram";
>>> +			bank-width = <4>>;
>>> +			reg = <0x58000000 0x4000000>>;
>>> +			#address-cells = <1>>;
>>> +			#size-cells = <1>>;
>>> +			partition@0 {
>>> +				label = "vrom-prime";
>>> +				reg = <0x0 0x2000000>>;
>>> +			};
>>> +			partition@2000000 {
>>> +				label = "vrom-second";
>>> +				reg = <0x2000000 0x2000000>>;
>>> +			};
>>> +		};
>>> +
>>> +		i2cg: syscon@c00000f8 {
> 
> 
>>> +			compatible = "simple-mfd", "syscon";
>>> +			reg = <0xc00000f8 0x08>>;
>>> +		};
>>> +	};
>>> +
>>> +	clocks {
>>> +		osc: osc {
> 
>> Keep node naming consistent, so just "clk"... but it's also very generic comparing to others, so I wonder what is this clock?
> 
> We are in the process of redoing the clocks. This was the oscillator but no longer needed for the minimum boot config.
> 
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>>;
>>> +			clock-output-names = "osc";
>>> +			clock-frequency = <33333333>>;
>>> +		};
>>> +
>>> +		iopclk: iopclk {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>>;
>>> +			clock-output-names = "iopclk";
>>> +			clock-frequency = <400000000>>;
>>> +		};
>>> +
>>> +		memclk: memclk {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>>;
>>> +			clock-output-names = "memclk";
>>> +			clock-frequency = <800000000>>;
>>> +		};
> 
>> What are these clocks? If external to the SoC, then where are they? On the board?
> 
> This was the internal iopclk and memclk they were both internal to the chip.
> For now I am removing osc and memclk and will just have an iopclk that Gxp-timer will refer to.

You should rather have a clock controller driver which defines this (and
many others). They can stay as a temporary work-around, if you really
need them for some other nodes.

Best regards,
Krzysztof
