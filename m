Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B5490DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiAQREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:04:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241831AbiAQRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:02:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A756D;
        Mon, 17 Jan 2022 09:02:30 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57253F766;
        Mon, 17 Jan 2022 09:02:28 -0800 (PST)
Date:   Mon, 17 Jan 2022 17:02:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Boris Lysov <arzamas-16@mail.ee>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Missing ARM TWD Watchdog driver?
Message-ID: <20220117170225.GB94025@C02TD0UTHF1T.local>
References: <20220117190112.2b2c2f53@pc>
 <60dceae6-5c7c-9f2d-9fcb-5e849f1d8ce5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60dceae6-5c7c-9f2d-9fcb-5e849f1d8ce5@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 08:34:57AM -0800, Guenter Roeck wrote:
> On 1/17/22 8:01 AM, Boris Lysov wrote:
> > Hello everyone,
> > 
> > I stumbled upon the ARM TWD Watchdog driver which seems to be missing (or I'm
> > just blind).
> > 
> > As per commit a33f5c380c4bd3fa5278d690421b72052456d9fe ("Merge tag
> > 'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux"), multiple
> > device trees declare usage of arm-twd:
> > 
> > arch/arm/boot/dts/arm-realview-eb-mp.dtsi
> > arch/arm/boot/dts/arm-realview-pb11mp.dts
> > arch/arm/boot/dts/arm-realview-pbx-a9.dts
> > arch/arm/boot/dts/bcm5301x.dtsi
> > arch/arm/boot/dts/bcm63138.dtsi
> > arch/arm/boot/dts/bcm-hr2.dtsi
> > arch/arm/boot/dts/bcm-nsp.dtsi
> > arch/arm/boot/dts/berlin2cd.dtsi
> > arch/arm/boot/dts/highbank.dts
> > arch/arm/boot/dts/mmp3.dtsi
> > arch/arm/boot/dts/owl-s500.dtsi
> > arch/arm/boot/dts/spear13xx.dtsi
> > arch/arm/boot/dts/ste-dbx5x0.dtsi
> > arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> > arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > 
> > and it is documented in
> > Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
> > 
> > However I could not find the driver itself. I tried running case-insensitive
> > grep and ripgrep to no avail. Does this driver actually exist? Is it gone?
> > 
> 
> I may be missing it, but I do not see any evidence that it ever existed.

Likewise, AFAICT we added the binding but never the driver.

Looking at the git history, that schema was introduced in commit:

  50e02e9a030a9ae3 ("dt-bindings: timer: arm,twd: Convert to json-schema")

... and replaced Documentation/devicetree/bindings/timer/arm,twd.txt

Per:

  $ git log --follow Documentation/devicetree/bindings/timer/arm,twd.txt

That was introduced alongside a driver in commit:

  d8e0364364d333fe ("ARM: smp_twd: add device tree support")

... which only introduced a driver for the timer, and not the watchdog,
as the commit message notes.

Thanks.
Mark.
