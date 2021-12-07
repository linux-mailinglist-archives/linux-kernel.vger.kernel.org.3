Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383646BA66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhLGLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhLGLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:52:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B264C061574;
        Tue,  7 Dec 2021 03:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9176CE1A7B;
        Tue,  7 Dec 2021 11:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE7C341C3;
        Tue,  7 Dec 2021 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638877754;
        bh=q9FusEARpAC40FeZ9GPHdLCLTJa+GAIlXi6moNLPaz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6Y642ZjxFuqi6574ZdmKCMSWyjZd5jRNZoSs09W7OVWU2SeVdiC+6LvtRVIJQD8r
         5chX82a3XGiZt6wyF1/0XSI0f/rSx5Qu9hnVzEd2P9xvvxzWcqzx+RmFDqGzbSfv9U
         XFRcyP/YTvJgJsas0rNPMJx/+zd1lGK7zpmkC7CpPWleV9RNh9fJSE49l/2LjAbSxm
         t620LFQ2hQPPVPMeIJ0pRmysYIqcyzdZlT88zKZ7RavqhafDReZ7MatBFTJMqzar9/
         J3JsGkx4BxP0IJsPb8SCWxYeZoDfD245aEu15Fup65ZRWzbi3WOQKju6j0l+lh04mt
         S3mtbyhdfUCxQ==
Date:   Tue, 7 Dec 2021 17:19:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <Ya9KNkw1mPpZtwDK@matsya>
References: <20211201072718.3969011-1-vkoul@kernel.org>
 <20211202230624.C05F3C00446@smtp.kernel.org>
 <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 15:51, David Collins wrote:
> On 12/2/21 3:06 PM, Stephen Boyd wrote:
> > Quoting Vinod Koul (2021-11-30 23:27:18)
> >> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
> >>         pmic_arb = spmi_controller_get_drvdata(ctrl);
> >>         pmic_arb->spmic = ctrl;
> >>  
> >> +       /*
> >> +        * Don't use devm_ioremap_resource() as the resources are shared in
> >> +        * PMIC v7 onwards, so causing failure when mapping
> >> +        */
> >>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
> >> -       core = devm_ioremap_resource(&ctrl->dev, res);
> >> +       core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
> > 
> > What does this mean? We have two nodes in DT that have the same reg
> > properties? How does that work?
> 
> PMIC Arbiter v7 has two SPMI bus master interfaces.  These are used to
> communicate with two sets of PMICs.  The SPMI interfaces operate
> independently; however, they share some register address ranges (e.g.
> one common one is used for APID->PPID mapping).  The most
> straightforward way to handle this is to treat them as two independent
> top-level DT devices.
> 
> In this case the "cnfg" address is used in the DT node name as that is
> unique between the two instances.
> 
> Here are the DT nodes used downstream on a target with PMIC Arbiter v7:
> 
> spmi0_bus: qcom,spmi@c42d000 {
> 	compatible = "qcom,spmi-pmic-arb";
> 	reg = <0xc42d000 0x4000>,
> 	      <0xc400000 0x3000>,
> 	      <0xc500000 0x400000>,
> 	      <0xc440000 0x80000>,
> 	      <0xc4c0000 0x10000>;
> 	reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
> 	interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> 	interrupt-names = "periph_irq";
> 	interrupt-controller;
> 	#interrupt-cells = <4>;
> 	#address-cells = <2>;
> 	#size-cells = <0>;
> 	cell-index = <0>;
> 	qcom,channel = <0>;
> 	qcom,ee = <0>;
> 	qcom,bus-id = <0>;
> };
> 
> spmi1_bus: qcom,spmi@c432000 {
> 	compatible = "qcom,spmi-pmic-arb";
> 	reg = <0xc432000 0x4000>,
> 	      <0xc400000 0x3000>,
> 	      <0xc500000 0x400000>,
> 	      <0xc440000 0x80000>,
> 	      <0xc4d0000 0x10000>;
> 	reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
> 	interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
> 	interrupt-names = "periph_irq";
> 	interrupt-controller;
> 	#interrupt-cells = <4>;
> 	#address-cells = <2>;
> 	#size-cells = <0>;
> 	cell-index = <0>;
> 	qcom,channel = <0>;
> 	qcom,ee = <0>;
> 	qcom,bus-id = <1>;
> };
> 
> Note the inclusion of a new DT property: "qcom,bus-id".  This was
> defined in a DT binding patch that isn't present in Vinod's submission.
> Here is its definition:
> 
> - qcom,bus-id : Specifies which SPMI bus instance to use.  This property
> 		is only applicable for PMIC arbiter version 7 and
> 		beyond.
> 		Support values: 0 = primary bus, 1 = secondary bus
> 		Assumed to be 0 if unspecified.

I havent picked that part yet. This was not needed for base stuff to
work yet. Feel free to send that as additional change

-- 
~Vinod
