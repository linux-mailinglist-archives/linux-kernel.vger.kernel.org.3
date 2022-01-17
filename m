Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464B49061A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiAQKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:39:40 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:52576 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229744AbiAQKjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:39:39 -0500
Received: from tarshish (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 95CE3440242;
        Mon, 17 Jan 2022 12:39:29 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1642415970;
        bh=9Wg6psWGSMPUmDfhFxRofL+wpsigvBX363eYVFLuJnw=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=JO7OKIChuye2W6vXIBuASeSEzoc2VJTsqP4Nrt/8hySPQx4xjozgcWoQcMaBXHdQ/
         /8otSTLG8P5JGQA3bS9+8rx2PqdtOUrRUgnHCmcwxFIjtu0hblB9+XWEdDdk72Dbg5
         BWsJZ4B5MBphAIQtMn8fr4zHVjiJ5VduzDSBA3UDtB1+CBUj+NlBpg/Llb0L+NSGlg
         vqWcBoGMW7fCiQ5zekYPrX2STR7GbJydLpApb4fjr7VIjWC9Sz4OmMeSFkRLH9Dpfs
         mbQDbJfLcU+24n47Ev0tthaSWr4J6n5masxmyIBTumQn58+mtfgU1qOsuDEvFu6EgM
         ffbR2+3ONnXNw==
References: <20220114233904.907918-1-sean.anderson@seco.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Date:   Mon, 17 Jan 2022 12:36:25 +0200
In-reply-to: <20220114233904.907918-1-sean.anderson@seco.com>
Message-ID: <87iluifxy1.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean, Thinh,

On Fri, Jan 14 2022, Sean Anderson wrote:
> This is a rework of patches 3-5 of [1]. It attempts to correctly program
> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
> we no longer need a special property duplicating this configuration,
> snps,ref-clock-period-ns is deprecated.
>
> Please test this! Patches 3/4 in this series have the effect of
> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
> the "ref" clock. I have build tested, but not much else.
>
> [1] https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/

Thinh, you suggested the dedicated DT property for the reference clock:

  https://lore.kernel.org/all/d5acb192-80b9-36f7-43f5-81f21c4e6ba0@synopsys.com/

Can you comment on this series?

Thanks,
baruch

> Sean Anderson (6):
>   dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
>   usb: dwc3: Get clocks individually
>   usb: dwc3: Calculate REFCLKPER based on reference clock
>   usb: dwc3: Handle fractional reference clocks
>   arm64: dts: zynqmp: Move USB clocks to dwc3 node
>   arm64: dts: ipq6018: Use reference clock to set dwc3 period
>
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  7 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  3 +-
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  4 +-
>  drivers/usb/dwc3/core.c                       | 98 ++++++++++++++++---
>  drivers/usb/dwc3/core.h                       |  6 +-
>  6 files changed, 98 insertions(+), 24 deletions(-)


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
