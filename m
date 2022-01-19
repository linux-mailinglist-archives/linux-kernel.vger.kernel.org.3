Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9938493FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356680AbiASSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:20:08 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:54931 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235941AbiASSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:20:05 -0500
Received: from tarshish (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 49918440636;
        Wed, 19 Jan 2022 20:19:52 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1642616393;
        bh=YiIEY8EdhFZDp3IMZEZpIN5BqRDWJATtLtyWjFrte0I=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=NfteVB8o9UgTp3risSYPPfx0t2Ljb7tRlOACyxYlYuOXbP1XT0Yt1HTJVFWIn8ko6
         tpsesLrXuTlmSGyMNUvS8dFWWY66SxlPj8PoOT+hFq8QCpjRl2gkcEEVV+Fl/bVEHo
         7gF/EsMuv8+SPcU06rJfjx0vxx8Lqm4jSXGlJXlsm3hB0HtERYCTKApvEmC7I3jhBh
         8QA2dMzKOTz6Qoco4IF+fL7bKdxvoojNfV292IC7mt0LQUk13TEQ4sKwSTGWmyZm+T
         V+kgBw1OLNzY1VfXhdnSqluAY5gqL7iyNAkFBQc1j3dgIi53nni8XhjfX2uvtH8bnJ
         v/OSnLXf4ox2w==
References: <20220119002438.106079-1-sean.anderson@seco.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Date:   Wed, 19 Jan 2022 20:14:06 +0200
In-reply-to: <20220119002438.106079-1-sean.anderson@seco.com>
Message-ID: <87ee53fv01.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Tue, Jan 18 2022, Sean Anderson wrote:
> This is a rework of patches 3-5 of [1]. It attempts to correctly program
> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
> we no longer need a special property duplicating this configuration,
> snps,ref-clock-period-ns is deprecated.
>
> Please test this! Patches 3/4 in this series have the effect of
> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
> the "ref" clock. I have build tested, but not much else.

Tested here on IPQ6010 based system. USB still works. But the with "ref"
clock at 24MHz, period is calculated as 0x29. Previous
snps,ref-clock-period-ns value used to be 0x32.

Is that expected?

Thanks,
baruch

>
> [1] https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/
>
> Changes in v2:
> - Document clock members
> - Also program GFLADJ.240MHZDECR
> - Don't program GFLADJ if the version is < 2.50a
> - Add snps,ref-clock-frequency-hz property for ACPI
>
> Sean Anderson (7):
>   dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
>   usb: dwc3: Get clocks individually
>   usb: dwc3: Calculate REFCLKPER based on reference clock
>   usb: dwc3: Program GFLADJ
>   usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
>   arm64: dts: zynqmp: Move USB clocks to dwc3 node
>   arm64: dts: ipq6018: Use reference clock to set dwc3 period
>
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   3 +-
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   4 +-
>  drivers/usb/dwc3/core.c                       | 112 +++++++++++++++---
>  drivers/usb/dwc3/core.h                       |  17 ++-
>  6 files changed, 120 insertions(+), 27 deletions(-)


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
