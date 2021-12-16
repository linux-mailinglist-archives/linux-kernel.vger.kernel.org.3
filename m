Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0055476943
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhLPExG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:53:06 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44353 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhLPExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:53:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF09S34mPz4xbt;
        Thu, 16 Dec 2021 15:52:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639630382;
        bh=3pzn/Q+npQUwEAQyNXc4+AdZJMqQa58gNawlMpXS7p8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o6DxnGA5brqcihBOJMs21ChGhmpakuiizvxWDcec8vlr3hZXDK4i0srSDTbmrv/2l
         hbLK6UUKzMhugiAoPtUHkc+TvIMggS9EmvgbeP4dSdkNk6Gja5p4ydNorfYvcR3vRj
         pwh4sF/nXIT5FtEwp8i/7zxVrT6Y+aBTIrtQCHAjifdcBWU0HCQy7bRe/1KynzMPz4
         HN980p2SjXKnjSTHNsPPP2r+2T93KJLw8PtVHd2yYXOQHujed75e5JJnkH+q2/8M+P
         gBXNjTORYx890yAG1Y4MMUDytmBDxSc+q08Iz+R8vUhvyBQH5Rq9nmQFF+iivAehmH
         2YXFN9M65mM0A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rtc: nintendo: Add a RTC driver for the
 GameCube, Wii and Wii U
In-Reply-To: <20211215175501.6761-1-linkmauve@linkmauve.fr>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
Date:   Thu, 16 Dec 2021 15:52:59 +1100
Message-ID: <87tuf9kv6c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Gil Peyrot <linkmauve@linkmauve.fr> writes:
> These three consoles share a device, the MX23L4005, which contains a
> clock and 64=C2=A0bytes of SRAM storage, and is exposed on the EXI bus
> (similar to SPI) on channel 0, device 1.  This driver allows it to be
> used as a Linux RTC device, where time can be read and set.
>
> The hardware also exposes two timers, one which shuts down the console
> and one which powers it on, but these aren=E2=80=99t supported currently.
>
> On the Wii=C2=A0U, the counter bias is stored in a XML file, /config/rtc.=
xml,
> encrypted in the SLC (eMMC storage), using a proprietary filesystem.  In
> order to avoid having to implement all that, this driver assumes a
> bootloader will parse this XML file and write the bias into the SRAM, at
> the same location the other two consoles have it.
>
> Changes since v1:
> - Rename the driver to rtc-gamecube.
> - Switch to the regmap API for debugfs support.
> - Report low battery and unstable power as invalid data.
> - Remove Wii=C2=A0U support in Kconfig, nothing specific to this console
>   needs to be changed in the code.
> - Don=E2=80=99t attempt to change HW_SRNPROT on the GameCube, this regist=
er
>   doesn=E2=80=99t exist so we can use SRAM just fine without doing anythi=
ng.
> - Add needed changes to the wii device tree.
> - Enable this driver on the gamecube and wii platforms.
>
> Changes since v2:
> - Report low battery correctly.
>
> Emmanuel Gil Peyrot (5):
>   rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
>   rtc: gamecube: Report low battery as invalid data
>   powerpc: wii.dts: Expose HW_SRNPROT on this platform
>   powerpc: gamecube_defconfig: Enable the RTC driver
>   powerpc: wii_defconfig: Enable the RTC driver
>
>  drivers/rtc/Kconfig                     |  11 +
>  drivers/rtc/Makefile                    |   1 +
>  drivers/rtc/rtc-gamecube.c              | 377 ++++++++++++++++++++++++

This is basically an rtc series as far as I'm concerned.

>  arch/powerpc/boot/dts/wii.dts           |   5 +
>  arch/powerpc/configs/gamecube_defconfig |   2 +-
>  arch/powerpc/configs/wii_defconfig      |   2 +-

I have nothing queued in the powerpc tree that touches any of those
files, so conflicts are unlikely.

So I'm happy for this to go via the rtc tree whenever it's ready.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
