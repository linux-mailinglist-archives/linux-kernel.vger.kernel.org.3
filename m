Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403664D30C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiCIOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiCIOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:04:32 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB0EBA1476;
        Wed,  9 Mar 2022 06:03:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1289480C1;
        Wed,  9 Mar 2022 14:02:07 +0000 (UTC)
Date:   Wed, 9 Mar 2022 16:03:29 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, jan.kiszka@siemens.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
Message-ID: <YiizsYnKB0X9bDY2@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
 <20220204143108.653qk2ihnlhsr5aa@prior>
 <YgDCLaBHA3DDQAUd@atomide.com>
 <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
 <YgEBml9HvFzSl289@atomide.com>
 <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
 <YgJZbdOlazrde7O/@atomide.com>
 <1356e93cd5b101c3d896e35250c66959ed631544.camel@ew.tq-group.com>
 <YihvWFdr1cT7cyk5@atomide.com>
 <5058591a3e0f0cb82b26cffe888d87b4d1bdd713.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5058591a3e0f0cb82b26cffe888d87b4d1bdd713.camel@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220309 11:09]:
> while I agree that it would be great if drivers could just detect when
> hardware is not available, this is simply not how most drivers work -
> when you instantiate the driver via a non-disabled(/reserved/...) DT
> node, the driver expects a usable device.
> 
> Especially for busses like I2C, there is no way for a driver to
> reliably detect whether the bus is usable or not. (There are several
> states that can't really be distinguished: Is pinmuxing missing, or
> does the device not need any muxing? Is a line low because it is not
> actually connected to anything, or is there another master currently
> using the bus, or is the bus stuck due to a faulty device?)

Well how about set only the problem devices with status = "disabled"
with a proper comment in the SoC dtsi file?

See for example what has been done in arch/arm64/boot/dts/apple that
has been pretty widely reviewed and done with a good taste :)

Not sure what can be done to idle the unused devices in the disabled
case though, maybe some firmware call to disable all unclaimed devices
could be done if it does not exist already. The firmware may not have
the capability to idle devices that need firmware loaded to idle them
for example though.

Regards,

Tony
