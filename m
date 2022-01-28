Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6749F222
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiA1Dz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345847AbiA1Dzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:55:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AAC061714;
        Thu, 27 Jan 2022 19:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D0561E49;
        Fri, 28 Jan 2022 03:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56152C340EA;
        Fri, 28 Jan 2022 03:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643342149;
        bh=K+SfeAbX1bUe1d/GsoMyFyiy2kEurGJjge3zAm42YSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vtv8XbwO40Smxe5Cf1na8MrARTVumUuCrbxXXFy7W5xwIdJfYykT61gKBVOAQuVvz
         v3+vhnuPMmnc0PVILCaXacKZ//z5rsbM0ja4+q3HVrQam5bS62+ibgH83VDfSzty9S
         PQWgU2jnchVem1I4EMX5OBZPqoK1ECzUyqHlBGZz9zomnVfcRyEYp+NVnXWptFqwzh
         qHYpt/GUNEMWw6L7RfwvTPRfge1wR1Y+Zrszm5W6gdGssB8URPUKSOd8Aa6/uPfqGg
         sKcz6CuQY10q3Gi/SJ43hC8fM8AwFsRXvZgGwJhZYCM+/c864NZG42h/Mq1aosUwex
         54KWter8MhTjw==
Date:   Fri, 28 Jan 2022 11:55:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
Subject: Re: [PATCH RESEND 1/2] ARM: dts: imx6: phyFLEX: add missing pmic mfd
 subdevices
Message-ID: <20220128035544.GA4686@dragon>
References: <20211216115529.2331475-1-andrej.picej@norik.com>
 <20220126092426.GJ4686@dragon>
 <38498017-dd47-ac02-0db7-85cf7fc48a59@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38498017-dd47-ac02-0db7-85cf7fc48a59@norik.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:28:27AM +0100, Andrej Picej wrote:
> Hi Shawn,
> 
> On 26. 01. 22 10:24, Shawn Guo wrote:
> > On Thu, Dec 16, 2021 at 12:55:28PM +0100, Andrej Picej wrote:
> > > phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
> > > mfd subdevices so they can be used.
> > > 
> > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > > ---
> > >   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> > > index f3236204cb5a..2ec154756bbc 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> > > @@ -205,6 +205,14 @@ vdd_mx6_high_reg: ldo11 {
> > >   				regulator-always-on;
> > >   			};
> > >   		};
> > > +
> > > +		pmic_rtc: rtc {
> > 
> > Maybe a more specific label like the following?
> > 
> > 		da9063_rtc: rtc
> > 
> > And it's more aligned with da9063_wdog below.
> > 
> > > +			compatible = "dlg,da9063-rtc";
> > > +		};
> > > +
> > > +		da9063_wdog: wdt {
> > 
> > watchdog for the node name.
> > 
> 
> I'll apply your suggestions and send v2.
> Do you agree that I also change the commit subject line to "ARM: dts:
> imx6qdl-phytec: ...", as you suggested in patch 2/2?

Yeah, even better, thanks!

Shawn
