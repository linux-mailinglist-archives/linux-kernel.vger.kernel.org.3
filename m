Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F24AD6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359326AbiBHLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356649AbiBHKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:53:33 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B4C03FEC0;
        Tue,  8 Feb 2022 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644317611; x=1675853611;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbrGQyvULXin7BBC8wqdS8uqSO3Rl+MipBC4/fpyAFA=;
  b=A70yp/lnOBAI3gXLtwTmKGkj8F3WQbzguuqxghR3rKFV9AsDK8JmYRBG
   t368KlgLlyOinM6/Yp00c+a4ngRFQTDvs+CDj8TFwI4zusg3jaoIGwfuZ
   krx1oxtKoubB5IvNPGaAY8dTVjqlYFjAwD1HMteMkZ5fnIcCydOOc/WjI
   BqCF3kZDPgUYvKbTwc5C6FkHVt/PkXvt7ng//CKXPKz9z3+rTRCivoWcd
   2i0kPA4X1v2wgnQKMjTY/EgmxYM7b/cA2tEXoMWkNw4ehgHDly04CG16M
   9u7NC1ljE7teZzvm9mOPfNwDQGnvW3LkyLIU5sJgvOEse8myB+UOzepKM
   w==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635199200"; 
   d="scan'208";a="21957534"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Feb 2022 11:53:29 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 08 Feb 2022 11:53:29 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 08 Feb 2022 11:53:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644317609; x=1675853609;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbrGQyvULXin7BBC8wqdS8uqSO3Rl+MipBC4/fpyAFA=;
  b=VWnvEgqtDGvLWpFibWP78PUxgQe4FS9HDx/QNP3mgMele6QiMfx+TOYn
   WkoDBxcdmrChiv28+5qECk6WOShr8EBEiPiDAxgB8FEY+JNyuD1C279JE
   oTAac32IfRRg1AFGZE5pcLbT9thlMFtvb4uHPVB3wB6EdbDdfWp5jnjfx
   SBa8eo5NFRVDC2wSbEmWtFvMLn9xXghyL+KYLcGmfUOY3JOcNHuoIz/30
   Ap9danfx8+pIpDiK2VyIo3puV44kUkzyGG4drWcxVtrFtB40sYM5zKXdp
   hOHeKy7XtK628/97U7w9Z9THRGrW4zXI+t3XFMUJvsuHjfwrMFrSn2RVz
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635199200"; 
   d="scan'208";a="21957533"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Feb 2022 11:53:29 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3B223280065;
        Tue,  8 Feb 2022 11:53:29 +0100 (CET)
Message-ID: <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, jan.kiszka@siemens.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Date:   Tue, 08 Feb 2022 11:53:27 +0100
In-Reply-To: <YgEBml9HvFzSl289@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
         <20220204143108.653qk2ihnlhsr5aa@prior> <YgDCLaBHA3DDQAUd@atomide.com>
         <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
         <YgEBml9HvFzSl289@atomide.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 13:25 +0200, Tony Lindgren wrote:
> * Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220207
> 08:45]:
> > Generally I think that it's a bootloader's responsiblity to disable
> > unneeded devices - the kernel may not even have a driver for some
> > peripherals, leading to the same behaviour as a "disabled" status.
> > For
> > this reason I believe that it should always be okay to set unneeded
> > devices to "disabled", and it should be considered a safe default.
> 
> Not possible, think kexec for example :) How would the previous
> kernel
> even know what to disable if Linux has no idea about the devices?

Well, optimally, bootloader and all kernels would agree on the devices
that are actually available, but I get your point.

> 
> If there are issues you're seeing, it's likely a bug in some of the
> device drivers for not checking for the necessary resources like
> pinctrl for i2c lines.

I don't think it's common for individual drivers to care about pinctrl
unless switching between different pin settings is required at runtime.
Many drivers can be used on different hardware, some of which may
require pinmuxing, while others don't.

Also, what is the expected behavior of a driver that is probed for an
unusable device? Wouldn't this require some as-of-yet nonexisting
status between "okay" and "disabled" that conveys something like "probe
this device, initialize (and disable) PM, but don't register anything",
so no unusable devices become visible to userspace (and possibly other
kernel drivers)?

> 
> > I'm not sure what the consensus on these issues is. I'm more
> > familiar
> > with NXP's i.MX and Layerscape SoCs, where it's common to have all
> > muxable peripherals set to "disabled" in the base DTSI, and a quick
> > grep through a few dts directories gives me the impression that
> > this is
> > the case for most other vendors as well.
> 
> This approach only works for SoCs that don't need the kernel to idle
> devices for runtime PM.

I'm pretty sure that most modern SoCs I looked at have runtime PM, and
it is simply expected that unusable devices are never enabled in the
first place, so there is no need for the kernel to know about them.

Regards,
Matthias




> Regards,
> 
> Tony

