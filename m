Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6374BC84C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiBSLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:51:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiBSLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:51:14 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210AE20B390;
        Sat, 19 Feb 2022 03:50:55 -0800 (PST)
Received: from g550jk.localnet (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 77DD3C7237;
        Sat, 19 Feb 2022 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645271453; bh=nC99qo7DWCTFKJZfG2BsUuk/w+zIZq2q7Fu2YsHaMEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LIknI+e8nDnvXuaxUFMR2hDoxj3FbWPl8v1dNgkoE1GN7n88yWcSMWUrFLppE7cC4
         7jOMGB7CaF4OMSEzYEdm3MB33EbEIByi/qeJiD3NJzk8FdDCMZ4JyQXXjOSyDt6btx
         dWCpmS0OMxHFpj0vqmQzbJNsUWbvc/htZ7stmZ2o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] arm64: dts: qcom: Add MSM8953 device tree
Date:   Sat, 19 Feb 2022 12:50:52 +0100
Message-ID: <4689218.GXAFRqVoOG@g550jk>
In-Reply-To: <YgvXdFZfWEzHF2Oy@yoga>
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-11-luca@z3ntu.xyz> <YgvXdFZfWEzHF2Oy@yoga>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Dienstag, 15. Februar 2022 17:40:20 CET Bjorn Andersson wrote:
> On Wed 12 Jan 13:40 CST 2022, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > 
> > Add a base DT for MSM8953 SoC.
> > 
> > Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  arch/arm64/boot/dts/qcom/msm8953.dtsi | 1337 +++++++++++++++++++++++++
> >  1 file changed, 1337 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8953.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > b/arch/arm64/boot/dts/qcom/msm8953.dtsi new file mode 100644
> > index 000000000000..59918b527750
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > @@ -0,0 +1,1337 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> > +
> > +#include <dt-bindings/clock/qcom,gcc-msm8953.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/qcom-rpmpd.h>
> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +/ {
> > +	interrupt-parent = <&intc>;
> > +
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> 
> Why do you have address/size-cells of 2, and then limit them to 1 in
> /soc?

Quite a few arm64 qcom dtsi files use #address-cells & #size-cells = <1> which 
also makes reg properties quite more readable - and we don't need the 64 bits 
on 8953.

> 
> > +
> > +	aliases {
> > +		i2c1 = &i2c_1;
> > +		i2c2 = &i2c_2;
> > +		i2c3 = &i2c_3;
> > +		i2c4 = &i2c_4;
> > +		i2c5 = &i2c_5;
> > +		i2c6 = &i2c_6;
> > +		i2c7 = &i2c_7;
> > +		i2c8 = &i2c_8;
> 
> It was expressed a while back that you should specify alias only for the
> things that you have enabled in your .dts.

Sure, I'll remove it.

> 
> > +	};
> 
> [..]
> 
> > +		tcsr_mutex: hwlock@1905000 {
> > +			compatible = "qcom,tcsr-mutex";
> > +			reg = <0x1905000 0x20000>;
> > +			#hwlock-cells = <1>;
> > +		};
> > +
> > +		tcsr: syscon@1937000 {
> > +			compatible = "qcom,tcsr-msm8953", "syscon";
> > +			reg = <0x1937000 0x30000>;
> > +		};
> > +
> > +		tcsr_phy_clk_scheme_sel: syscon@193f044 {
> 
> I don't fancy exposing a single word from the middle of &tcsr using a
> syscon. The tcsr node should express the TCSR region and if we need to
> reference bits of information within that we should do that in some
> structured way.
> 
> Wouldn't nvmem be a good candidate for this?

The qusb2 bindings expect the reference like this as far as I can tell, 

qphy->tcsr = syscon_regmap_lookup_by_phandle(dev->of_node,
                                           "qcom,tcsr-syscon");

So I don't think we can change this without changing the driver as well?

Regards
Luca

> 
> > +			compatible = "syscon";
> > +			reg = <0x193f044 0x4>;
> > +		};
> > +
> 
> Regards,
> Bjorn




