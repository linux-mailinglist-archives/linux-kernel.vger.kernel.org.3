Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A234662B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbhLBLwl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Dec 2021 06:52:41 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40113 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbhLBLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:52:29 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4E29B240004;
        Thu,  2 Dec 2021 11:48:58 +0000 (UTC)
Date:   Thu, 2 Dec 2021 12:48:55 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] spear: Fix SPEAr3XX plgpio support
Message-ID: <20211202124855.1c1298e7@bootlin.com>
In-Reply-To: <20211202112700.mkjmwibabj2cpr6u@vireshk-i7>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
        <20211202112700.mkjmwibabj2cpr6u@vireshk-i7>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 16:57:00 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 02-12-21, 10:52, Herve Codina wrote:
> > Hi,
> > 
> > This patch series fixes the plgpio support on SPEAr3xx SOCs.
> > 
> > The first four patches of this series fixes a ressources
> > sharing issue between the plgpio driver and the pinmux
> > driver.
> > Indeed, these two drivers can use the same IO address range
> > on some SPEAr3xx SOCs.
> > To solve the issue, a regmap (syscon managed) is used in both
> > drivers and the plgpio driver can reference the pinmux regmap
> > to use it.
> > 
> > The second part of this series is related to IRQs.
> > The plgpio on SPEAr320s SOC uses an IRQ line in the reserve
> > range (from SPEAr320 point of view).
> > This issue is fixed enabling all the 'reserved' IRQs and
> > adding a dtsi file for the SPEAr320s with the correct interrupt
> > for the plgpio node.  
> 
> Are these changes backwards compatible ? I mean new kernel will work
> with old DTBs ? It may be quite important to not break that here.
> 

Yes they are.
- the regmap reference (phandle) is optional.
- The IRQ for plgpio is used only on the new spear320s.dtsi.

I have not seen any issues on my board (spear320s SOC) when I only add support
for the 'reserved' IRQs (ie no spurious interrupts occur when I apply the patch
related to shirq).
I cannot test on SPEAr320 SOC as I haven't got any board with this SOC.

Herve

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
