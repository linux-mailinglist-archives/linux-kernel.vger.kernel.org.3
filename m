Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8C469037
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhLFFnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLFFnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:43:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349BC0613F8;
        Sun,  5 Dec 2021 21:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9241AB80FAB;
        Mon,  6 Dec 2021 05:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9176AC341C2;
        Mon,  6 Dec 2021 05:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638769192;
        bh=b6SZUCSoC3LppH5vyyLx69ea2nt0KsHAOn/6kyvdBSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoeBmnNfldqVBpoGlXixiMPn7xpnPoesZujcC/ei8KOW2PNiGdV8IBXnHyCMFh4h5
         CqLRy1XQmEnyMeX/zZ3PqDR8pgsaKYChAmn92DosiI9RUXB7e/4qKFk1ovwZaHzgOm
         yug5XKrQZvIl5PxW8jAm5QTtw/s1fQmT8p7YzUocNSmJMBbi6Ud+SWWvKnHxD+729x
         TuFWQKLzBsJW8rXndbaGPSOURCClAuG1Ji60tirtvXKIRYGD5OMcBD3gFqU42cT1P6
         Ni6Xgm/CnJjTkoz91SwrbL/kdfTxdUcWkgQVfx/MZ2/qNXZzOVQ20gIup0u6EerHz0
         Ndoh3qFnUYVOg==
Date:   Mon, 6 Dec 2021 11:09:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm64: dts: qcom: Add base SM8450 DTSI
Message-ID: <Ya2iJD8kfFfj/MpY@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-2-vkoul@kernel.org>
 <3fe36e35-8c4b-f772-be43-8e8c49e97f63@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe36e35-8c4b-f772-be43-8e8c49e97f63@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:03, Konrad Dybcio wrote:
> 
> On 01.12.2021 08:29, Vinod Koul wrote:
> > This add based DTSI for SM8450 SoC and includes base description of
> > CPUs, GCC, RPMHCC, UART, interuupt-controller which helps to boot to
> > shell with console on boards with this SoC
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 476 +++++++++++++++++++++++++++
> >  1 file changed, 476 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sm8450.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > new file mode 100644
> > index 000000000000..d838283bde4b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -0,0 +1,476 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/qcom,gcc-sm8450.h>
> > +#include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +
> > +/ {
> > +	interrupt-parent = <&intc>;
> > +
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	chosen { };
> > +
> > +	clocks {
> > +		xo_board: xo-board {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <76800000>;
> > +			clock-output-names = "xo_board";
> > +		};
> > +
> > +		sleep_clk: sleep-clk {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <32000>;
> > +			#clock-cells = <0>;
> > +		};
> 
> No clock-output-names for this one?

This should have one, will fix and update in v2
> 
> 
> Other than that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Thanks for the review!

-- 
~Vinod
