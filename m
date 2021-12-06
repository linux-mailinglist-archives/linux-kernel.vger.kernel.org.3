Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0824469058
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhLFGQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhLFGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:16:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A17C0613F8;
        Sun,  5 Dec 2021 22:13:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3A261179;
        Mon,  6 Dec 2021 06:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B86C341C2;
        Mon,  6 Dec 2021 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638771179;
        bh=+4qlYgaMA0MihnPdhm4aqX/UJW902OE0TQ6SXWfLXqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmqnVsRtw3km0kxrYv10PAfcLLasB+AuglLYKUtgsa+YGygxd1WCekjyWW3CDJMmd
         yKrIx6M9QGfPYhgocEe9qvAnQszb7MJumovYYUDakCsrCvbyFpwZ5EX5AmrwCEnkvV
         XL6j8018leuR+EcT1YXy5lMG9PtHbWhRXhW726SYr6pHmRBta1VsMJaOrQFCVi2J7a
         lWcXDiYqXXHW29GMBRFhxdZ3MvJbWAUf8+skDQUKUJXNwN2vFnX/Hdfyeo9VDE7L7d
         p6bJPGOy5NNROgiyq2Fx+CWyTe1DZHyxy/MZ0Gph55UJbGC2VwGWDTEDNePvlziZOa
         ODIqeajQn9AFg==
Date:   Mon, 6 Dec 2021 11:42:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] arm64: dts: qcom: sm8450: add interconnect nodes
Message-ID: <Ya2p55S4J6odMvGK@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-11-vkoul@kernel.org>
 <99e88947-177c-2f39-7f88-de16c24c3e42@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e88947-177c-2f39-7f88-de16c24c3e42@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:20, Konrad Dybcio wrote:
> 
> On 01.12.2021 08:29, Vinod Koul wrote:
> > And the various interconnect nodes found in SM8450 SoC and use it for
> > UFS controller.
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 80 ++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 75827bbfb3ad..4c7cdcea33fa 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -6,6 +6,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/qcom,gcc-sm8450.h>
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/interconnect/qcom,sm8450.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >  
> >  / {
> > @@ -573,6 +574,61 @@ uart7: serial@99c000 {
> >  			};
> >  		};
> >  
> > +		config_noc: interconnect@1500000 {
> > +			compatible = "qcom,sm8450-config-noc";
> > +			reg = <0 0x01500000 0 0x1c000>;
> > +			#interconnect-cells = <1>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		mc_virt: interconnect@1580000 {
> > +			compatible = "qcom,sm8450-mc-virt";
> > +			reg = <0 0x01580000 0 0x1000>;
> > +			#interconnect-cells = <1>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		system_noc: interconnect@1680000 {
> > +			reg = <0 0x01680000 0 0x1e200>;
> > +			compatible = "qcom,sm8450-system-noc";
> 
> Compatible first, please

will fix here and everywhere...

-- 
~Vinod
