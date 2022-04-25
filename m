Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69150DDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiDYKeR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 06:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiDYKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:33:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4121110
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:30:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1nivzH-0005Ci-Ci; Mon, 25 Apr 2022 12:30:35 +0200
Message-ID: <72c1f0b80e76b7f4ab1c59f09e6edeffe892fbdc.camel@pengutronix.de>
Subject: Re: [PATCH 6/8] ARM: dts: stm32: enable optee firmware and SCMI
 support on STM32MP15
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Marek Vasut <marex@denx.de>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Date:   Mon, 25 Apr 2022 12:30:32 +0200
In-Reply-To: <71c0dd94-8cd3-9ca0-f06d-ee13ad063618@denx.de>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
         <20220422150952.20587-7-alexandre.torgue@foss.st.com>
         <174bea56-3e99-e01c-4133-f1350d34448d@denx.de>
         <PAXPR10MB4687B8C3DF485E814AE8158BFDF89@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
         <71c0dd94-8cd3-9ca0-f06d-ee13ad063618@denx.de>
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2022-04-25 at 12:25 +0200, Marek Vasut wrote:
> On 4/25/22 12:19, Etienne CARRIERE wrote:
> > Hello Marek,
> 
> Hi,
> 
> > > From: Marek Vasut <marex@denx.de>
> > > 
> > > > On 4/22/22 17:09, Alexandre Torgue wrote:
> > > > Enable optee and SCMI clocks/reset protocols support.
> > > > 
> > > > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > > 
> > > > diff --git a/arch/arm/boot/dts/stm32mp151.dtsi
> > > > b/arch/arm/boot/dts/stm32mp151.dtsi
> > > > index 7fdc324b3cf9..1b2fd3426a81 100644
> > > > --- a/arch/arm/boot/dts/stm32mp151.dtsi
> > > > +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> > > > @@ -115,6 +115,33 @@
> > > >                  status = "disabled";
> > > >          };
> > > >     
> > > > +     firmware {
> > > > +             optee: optee {
> > > > +                     compatible = "linaro,optee-tz";
> > > > +                     method = "smc";
> > > > +                     status = "disabled";
> > > > +             };
> > > 
> > > Doesn't this TEE node get automatically generated and patched into DT by
> > > the TEE ? I think OpTee-OS does that.
> > 
> > OP-TEE OS does that if it gets passed the DT from early boot stage which is not always the case.
> 
> Shouldn't that be something to fix ?
> 
> I think R-Car3 does that already.

FWIW it's also possible for OP-TEE to generate a device tree overlay
which can be applied by later boot stages.

Drawback is that you either need an additional parameter to pass
between boot stages (address of the DT overlay) or it needs to be
hardcoded. Hardcoding has it's own bag of drawbacks, but it's what we
do for some i.MX6 platforms within barebox. However there is no TF-A
there, so only OP-TEE and Barebox need to agree on the fixed location
beforehand.

Best regards,
Rouven Czerwinski

-- 
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |

