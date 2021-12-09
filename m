Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB346F6E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhLIWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:34:44 -0500
Received: from foss.arm.com ([217.140.110.172]:34878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhLIWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:34:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4DBD6E;
        Thu,  9 Dec 2021 14:31:09 -0800 (PST)
Received: from bogus (unknown [10.57.33.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 936383F73D;
        Thu,  9 Dec 2021 14:31:06 -0800 (PST)
Date:   Thu, 9 Dec 2021 22:31:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8qxp: add cache info
Message-ID: <20211209223103.br2scdg2j6gpfnpl@bogus>
References: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
 <20211112062604.3485365-4-peng.fan@oss.nxp.com>
 <CAL_JsqLD6=a==nx=aXjqRwQ3xTamrPVk8LwmqygC_q0UCrL9iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLD6=a==nx=aXjqRwQ3xTamrPVk8LwmqygC_q0UCrL9iw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:15:09PM -0600, Rob Herring wrote:
> On Fri, Nov 12, 2021 at 12:27 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8QXP A35 Cluster has 32KB Icache, 32KB Dcache and 512KB L2 Cache
> >  - Icache is 2-way set associative
> >  - Dcache is 4-way set associative
> >  - L2cache is 8-way set associative
> >  - Line size are 64bytes
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 617618edf77e..dbec7c106e0b 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -58,6 +58,12 @@ A35_0: cpu@0 {
> >                         compatible = "arm,cortex-a35";
> >                         reg = <0x0 0x0>;
> >                         enable-method = "psci";
> > +                       i-cache-size = <0x8000>;
> > +                       i-cache-line-size = <64>;
> > +                       i-cache-sets = <256>;
> > +                       d-cache-size = <0x8000>;
> > +                       d-cache-line-size = <64>;
> > +                       d-cache-sets = <128>;
> 
> Why do you need all this for the L1? Isn't it discoverable with cache
> ID registers?
> 

No, not after the following:
Commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")

which removed ID register based cache probing and we now expect to obtain
the same via DT/ACPI unfortunately.

-- 
Regards,
Sudeep
