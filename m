Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046964ABC67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378106AbiBGLft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357632AbiBGLZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:25:26 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 943ECC03FED1;
        Mon,  7 Feb 2022 03:25:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EB08280E1;
        Mon,  7 Feb 2022 11:24:52 +0000 (UTC)
Date:   Mon, 7 Feb 2022 13:25:14 +0200
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
Message-ID: <YgEBml9HvFzSl289@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
 <20220204143108.653qk2ihnlhsr5aa@prior>
 <YgDCLaBHA3DDQAUd@atomide.com>
 <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220207 08:45]:
> Generally I think that it's a bootloader's responsiblity to disable
> unneeded devices - the kernel may not even have a driver for some
> peripherals, leading to the same behaviour as a "disabled" status. For
> this reason I believe that it should always be okay to set unneeded
> devices to "disabled", and it should be considered a safe default.

Not possible, think kexec for example :) How would the previous kernel
even know what to disable if Linux has no idea about the devices?

If there are issues you're seeing, it's likely a bug in some of the
device drivers for not checking for the necessary resources like
pinctrl for i2c lines.

> I'm not sure what the consensus on these issues is. I'm more familiar
> with NXP's i.MX and Layerscape SoCs, where it's common to have all
> muxable peripherals set to "disabled" in the base DTSI, and a quick
> grep through a few dts directories gives me the impression that this is
> the case for most other vendors as well.

This approach only works for SoCs that don't need the kernel to idle
devices for runtime PM.

Regards,

Tony
