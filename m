Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851BB463D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbhK3Rrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:47:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhK3Rrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:47:32 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C4F020DED70;
        Tue, 30 Nov 2021 09:44:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C4F020DED70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638294252;
        bh=EAfl+8ZtWcOr7MGbBjK12p6Zs4Xgqan1DBcDEBeNGnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVCqwbrC42Rctjz/oCpjE/+qfi10+tb44cz1rY8RbAY38zDia0+kOb2v9DpH0RspM
         7/QeFddVmlCumensX99JkbMURgZkHs+zeHVwD0wwJOwmbGqNZlICiY1FoYdHHyQOMH
         waJpJtmqcw+AOflqAgICWUEGPijV4fajkxCCUnC8=
Date:   Tue, 30 Nov 2021 09:44:11 -0800
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: add minimal DTS for Microsoft Surface
 Duo2
Message-ID: <20211130174411.GA18994@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20211122190552.74073-1-kaperez@linux.microsoft.com>
 <20211122190552.74073-2-kaperez@linux.microsoft.com>
 <YZxnQfB6V7GOlygq@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZxnQfB6V7GOlygq@matsya>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:30:01AM +0530, Vinod Koul wrote:
> On 22-11-21, 11:05, Katherine Perez wrote:
> > This is a minimal devicetree for Microsoft Surface Duo 2 with SM8350
> > Chipset
> > 
> > Signed-off-by: Katherine Perez <kaperez@linux.microsoft.com>
> > ---
> > 
> > Changes since v1:
> > - Change remoteprocs firmware-naming scheme to qcom/sm8350/microsft/*
> > - Add chassis-type
> > 
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../qcom/sm8350-microsoft-surface-duo2.dts    | 369 ++++++++++++++++++
> >  2 files changed, 370 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 6b816eb33309..a8cc6bd3c423 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -106,4 +106,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> > new file mode 100644
> > index 000000000000..d4963c9015cb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
> > @@ -0,0 +1,369 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (C) 2021, Microsoft Corporation
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include "sm8350.dtsi"
> > +#include "pm8350.dtsi"
> > +#include "pm8350b.dtsi"
> > +#include "pm8350c.dtsi"
> > +#include "pmk8350.dtsi"
> > +#include "pmr735a.dtsi"
> > +#include "pmr735b.dtsi"
> > +
> > +/ {
> > +	model = "Microsoft Surface Duo 2";
> > +	compatible = "microsoft,surface-duo2", "qcom,sm8350";
> > +	chassis-type = "handset";
> 
> This is interesting, I see it used at lot of place, unfortunately, it
> does not seem to be documented :(
> 
> -- 
> ~Vinod

Hi Vinod,

Looks like "chassis-type" is documented in the Devicetree Specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html.

-Katherine
