Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A095675D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiGERcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiGERcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:32:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156120BC7;
        Tue,  5 Jul 2022 10:32:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so16218331eda.2;
        Tue, 05 Jul 2022 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZv/MvaJzJ12Z8fK0e0CUHxmTF9xt4EFwQubLhM9s/Y=;
        b=AMPV7rk4xh2rBEX8Sk/nvrCexCQ3LHCjKSFE40+c+WEQiZYQH0lfrjCB5kjDaLOJwO
         SxJ4I9NsBfyFZouYBFlA4X+ZEcqq8w6WiXD7cU6M7hnWqU30Gnk1IhfRJgdqyMfs3xNo
         HevsrPMzZuPrQXDEF9eU4L5gaK6y7DAcnGQWOT1KsWMTJDTNA4zbzS1GomLNzGEsZmnM
         LZOaWVMxzMuz9QAWcVDFBYn4ZmVsZT1q1LW++KsW1K6Swpm08TaOgbEhn/IsDJB6F8La
         D6fuNkZE0E1b2KQ/nfgUZWhRLCrRu/UOuB6Hj2vIDn1HljlbUVStZy5RrM/x3OTxDryc
         BQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZv/MvaJzJ12Z8fK0e0CUHxmTF9xt4EFwQubLhM9s/Y=;
        b=1wpENLaIItZ59jECPiHuJY5W5YKRrM/1lD4xcIqLJAi35LD/n96pTQ8lzk2Kwvx8eA
         iLEkqKTMVEDrNgjoTpcB5wX1MQuhKn1Urpft6RuzGc0k0cJKNwrLUUodZsKASOrFOHXh
         77uI4Fu71igA8y4Xm+me9mahNocTKvmiE0mnsr3Wtyj5QsgR9NoJycMLSniYQT6sDNVj
         GWKeVqOwX1r0G7RqeJ6x8Tmp0K1p0jBwwTpuHBjyvsIm5/h9G/JCoeqY+fmOZnALDSOy
         OIWctxgSwc10SdDscsYrkTzKHJVs4VJWe0YaVEA2ooxdkv1vivX+0+/9DinjkvuVRWzB
         eh/Q==
X-Gm-Message-State: AJIora9c+YA5m+jt4j+ck36wkhjcZb5KeXAn8+Qm1akJb2Hxp/0IQVJO
        baS/1WYR3MOaJ11kGghJzpoOF7yhmNCYUg==
X-Google-Smtp-Source: AGRyM1tjBsxr/6Cf+mS9+yoyn08ekChEWeNzhULrN9w6aMjqLgSb6YIo0DQlLKfoFXveqbVFcObxLg==
X-Received: by 2002:a05:6402:380a:b0:437:d11f:b8b0 with SMTP id es10-20020a056402380a00b00437d11fb8b0mr48073069edb.425.1657042347939;
        Tue, 05 Jul 2022 10:32:27 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm16082817ejj.160.2022.07.05.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:32:27 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Date:   Tue, 05 Jul 2022 19:32:26 +0200
Message-ID: <5278570.Sb9uPGUboI@kista>
In-Reply-To: <20220704225534.3e1a901a@slackpad.lan>
References: <20220428230933.15262-1-andre.przywara@arm.com> <22699277.6Emhk5qWAg@kista> <20220704225534.3e1a901a@slackpad.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 04. julij 2022 ob 23:58:02 CEST je Andre Przywara napisal(a=
):
> On Mon, 04 Jul 2022 20:42:47 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne ponedeljek, 04. julij 2022 ob 15:30:57 CEST je Andre Przywara=20
napisal(a):
> > > On Sat, 02 Jul 2022 23:16:53 +0200
> > > Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> > >=20
> > > Hi Jernej,
> > >=20
> > > > Dne =C4=8Detrtek, 30. junij 2022 ob 02:04:10 CEST je Andre Przywara=
=20
napisal(a):
> > > > > On Tue, 03 May 2022 21:05:11 +0200
> > > > > Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> > > > >=20
> > > > > Hi Jernej,
> > > > >=20
> > > > > many thanks for taking the time to wade through this file!
> > > > >=20
> > > > > > Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara
> >=20
> > napisal(a):
> > > > > > > This (relatively) new SoC is similar to the H6, but drops the
> >=20
> > (broken)
> >=20
> > > > > > > PCIe support and the USB 3.0 controller. It also gets the
> > > > > > > management
> > > > > > > controller removed, which in turn removes *some*, but not all=
 of
> > > > > > > the
> > > > > > > devices formerly dedicated to the ARISC (CPUS).
> > > > > > > And while there is still the extra sunxi interrupt controller,
> > > > > > > the
> > > > > > > package lacks the corresponding NMI pin, so no interrupts for
> > > > > > > the
> >=20
> > PMIC.
> >=20
> > > > > > > The reserved memory node is actually handled by Trusted Firmw=
are
> >=20
> > now,
> >=20
> > > > > > > but U-Boot fails to propagate this to a separately loaded DTB,
> > > > > > > so we
> > > > > > > keep it in here for now, until U-Boot learns to do this
> > > > > > > properly.
> > > > > > >=20
> > > > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > > > ---
> > > > > > >=20
> > > > > > >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574
> > > > > > >  +++++++++++++++
> >=20
> > +++
> >=20
> > > > > > >  1 file changed, 574 insertions(+)
> > > > > > >  create mode 100644
> > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > >=20
> > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > > b/arch/arm64/
> > > > > >=20
> > > > > > boot/dts/allwinner/sun50i-h616.dtsi
> > > > > >=20
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..cc06cdd15ba5
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > > > > @@ -0,0 +1,574 @@
> > > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > > +// Copyright (C) 2020 Arm Ltd.
> > > > > > > +// based on the H6 dtsi, which is:
> > > > > > > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > > > > > > +
> > > > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > > > > > > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > > > > > > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > > > > > > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > > > > > +
> > > > > > > +/ {
> > > > > > > +	interrupt-parent =3D <&gic>;
> > > > > > > +	#address-cells =3D <2>;
> > > > > > > +	#size-cells =3D <2>;
> > > > > > > +
> > > > > > > +	cpus {
> > > > > > > +		#address-cells =3D <1>;
> > > > > > > +		#size-cells =3D <0>;
> > > > > > > +
> > > > > > > +		cpu0: cpu@0 {
> > > > > > > +			compatible =3D "arm,cortex-a53";
> > > > > > > +			device_type =3D "cpu";
> > > > > > > +			reg =3D <0>;
> > > > > > > +			enable-method =3D "psci";
> > > > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > > > +		};
> > > > > > > +
> > > > > > > +		cpu1: cpu@1 {
> > > > > > > +			compatible =3D "arm,cortex-a53";
> > > > > > > +			device_type =3D "cpu";
> > > > > > > +			reg =3D <1>;
> > > > > > > +			enable-method =3D "psci";
> > > > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > > > +		};
> > > > > > > +
> > > > > > > +		cpu2: cpu@2 {
> > > > > > > +			compatible =3D "arm,cortex-a53";
> > > > > > > +			device_type =3D "cpu";
> > > > > > > +			reg =3D <2>;
> > > > > > > +			enable-method =3D "psci";
> > > > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > > > +		};
> > > > > > > +
> > > > > > > +		cpu3: cpu@3 {
> > > > > > > +			compatible =3D "arm,cortex-a53";
> > > > > > > +			device_type =3D "cpu";
> > > > > > > +			reg =3D <3>;
> > > > > > > +			enable-method =3D "psci";
> > > > > > > +			clocks =3D <&ccu CLK_CPUX>;
> > > > > > > +		};
> > > > > > > +	};
> > > > > > > +
> > > > > > > +	reserved-memory {
> > > > > > > +		#address-cells =3D <2>;
> > > > > > > +		#size-cells =3D <2>;
> > > > > > > +		ranges;
> > > > > > > +
> > > > > > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31)=20
*/
> > > > > > > +		secmon_reserved: secmon@40000000 {
> > > > > > > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > > > > > +			no-map;
> > > > > > > +		};
> > > > > > > +	};
> > > > > >=20
> > > > > > I'm not a fan of above. If anything changes in future in BL31,
> > > > > > U-Boot
> > > > > > would
> > > > > > need to reconfigure it anyway. Can we just skip it?
> > > > >=20
> > > > > I am not a fan neither, but last time I checked this is needed to
> > > > > boot.
> > > > > Indeed TF-A inserts this node, with the right values, into U-Boot=
's
> > > > > DT.
> > > > > And that's nicely preserved if you use that DT ($fdtcontroladdr) =
for
> > > > > the kernel as well.
> > > > > But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
> > > > > U-Boot fails to propagate the /reserved-memory node into that cop=
y.
> > > > > There does not seem to be a global notion of reserved memory in
> > > > > U-Boot.
> > > > > Some commands (like tftp) explicitly parse the control DT to find
> > > > > and
> > > > > respect reserved memory regions. bootm does that also, but only to
> > > > > avoid placing the ramdisk or DTB into reserved memory. The
> > > > > information
> > > > > ends up in images->lmb, but is not used to generate or amend nodes
> > > > > in
> > > > > the target DT.
> > > > > So the bits and pieces are there, but it will require some code to
> > > > > be
> > > > > added to the generic U-Boot code.
> > > > >=20
> > > > > So what do you think? Leaving this out will prevent loading DTBs
> > > > > into
> > > > > U-Boot, at the moment, which sounds bad. I suggest we keep it in,
> > > > > for
> > > > > now, it should not really hurt. U-Boot will hopefully start to do
> > > > > the
> > > > > right thing soon, then we can either phase it out here (maybe when
> > > > > we
> > > > > actually change something in TF-A), or let U-Boot fix it.
> > > >=20
> > > > TBH, if "soon" is really soon, I would rather wait with H616 DT unt=
il
> > > > U-
> >=20
> > Boot
> >=20
> > > > supports carrying over reserved memory nodes.
> > >=20
> > > But this also carries compatibility issues. U-Boot support the H616 f=
or
> > > more than a year now, and the earliest possible U-Boot release having
> > > that
> > > propagation code would be the one released in October.
> >=20
> > I was hoping you would say July (next U-Boot release) :).
>=20
> Well, 2022.07 was supposed to be released today, and even if that is
> delayed by a bit, that's obviously far too late ;-)
>=20
> > > And then people
> > > would still need to update first, so that's quite some months out.
> > > And I was actually hoping to get at least the H616 DT patches off my
> > > plate, and get them into the tree to have a stable and agreed upon ba=
se
> > > (before this series turns into a teenager ;-)
> >=20
> > Yeah, I would like that too.
> >=20
> > > Then we could for instance update the U-Boot H616 support.
> > >=20
> > > > Whatever we do now, it will have
> > > > compatibility issues. If we introduce reserved memory node now, we
> > > > can't
> > > > easily drop it later. Bootloaders are not very often updated, but
> > > > kernels
> >=20
> > and
> >=20
> > > > DTB files are, at least in my experience. So when we decide to drop
> > > > the
> >=20
> > node?
> >=20
> > > I think of the three possibilities:
> > > - Drop the node now, and ask people to not load DTBs explicitly
> > > - Drop the node when U-Boot learned to propagate the reservation
> > > - Keep the node
> > > the last one is the least painful: having this node in does not really
> > > hurt, so we can be very relaxed with this removal decision:
> > > - If U-Boot does not add the reserved node, we are covered.
> > > - If U-Boot adds the node, it will do so in a way where it deals with
> > > existing reservations. So either it doesn't actually change anything,=
 or
> > > it extends the reservation.
> > > - Should the TF-A location actually move (and we have no plans or nee=
ds
> > > to
> > > do that), people would only get this by updating the firmware, at whi=
ch
> > > point the U-Boot part would surely be in place already. We don't real=
ly
> > > support updating just BL31 in an existing binary firmware image, so y=
ou
> > > would get an updated U-Boot as well.
> > >=20
> > > I think the worst case scenario is that users end up with an unneeded
> > > 512K
> > > reservation. If they care, a firmware update should solve this proble=
m.
> > >=20
> > > As for the time to remove that node: we could do that at the time when
> > > (or rather: if) we actually change the TF-A reservation. At the moment
> > > there are no plans to do this, and the size reservation is more than
> > > generous (the current debug build is actually 77 KB or so only). If
> > > there
> > > is no change, and the node stays in the .dtsi, it doesn't really hurt,
> > > see
> > > above.
> >=20
> > I see your point, but I would like to get some input from Samuel first.
> >=20
> > Samuel, what do you think?
> >=20
> > > > After 10 years? Alternatively, reserved memory node can be just
> > > > dropped
> >=20
> > and
> >=20
> > > > anyone loading DTB file from outside would need to make sure it's
> > > > patched.
> >=20
> > But
> >=20
> > > > that's unexpected from user perspective, although patching DT files=
 is
> > > > done
> >=20
> > by
> >=20
> > > > some distros.
> > >=20
> > > Yeah, let's not go there. As you know, I already dislike the idea of
> > > explicitly loading DTBs at all, but I understand this is what people,
> > > and
> > > distributions, do, so I'd rather have them covered. Hence the node to
> > > work with existing firmware.
> >=20
> > Reusing DTB from U-Boot is only useful when you're happy with completen=
ess
> > of DT and with the lack of bugs in it. Then you can save troubles with
> > skipping external DTB load step and life is easier. But as you know,
> > features and thus nodes are added in steps and sometimes some bugs are
> > fixed, which means it's extremely handy to have easily updatable DTB
> > file.
>=20
> Yes, definitely, see my reply to Samuel. I just held back with the DT
> update in U-Boot because of the conflict between "we only take pure
> kernel tree DTs" and "there is a breaking change" (r_intc binding).
>=20
> If we find a way forward with the DT stability problem, I am happy to
> push for a much more frequent DT update, or even update just the DT in
> an existing firmware installation. This can be automated, since the DTB
> is just a member in the FIT image, which can be re-assembled with an
> updated DTB by some tool or script. Or we use capsule updates, of just
> the DTB, separately (if this is possible)?

I would like to have forward compatibility too, but IMO it's not very=20
realistic. Sooner or later we'll find something, like r_intc, again that wo=
n't=20
be possible to integrate in forward compatible manner.=20

>=20
> > Yes, U-Boot can be
> > automated, but it's tedious for distro to maintain one bootloader packa=
ge
> > per board. Ideally, distro shouldn't care at all about that,
>=20
> Yes, I totally agree, distros should not ship firmware. Since leaving
> this to the board vendors is not realistic, I wonder if we (as "the
> sunxi community") should step up here, and provide binary builds (purely
> for convenience reasons) of board firmware? That could be updated from
> a running Linux, or put on an SD card, or fetched by distros to
> generate an installer? Wasn't there even some central storage offered
> lately by Linux, to hold (UEFI) firmware update files?

As someone who's working on distro which supports many SoCs from variety of=
=20
vendors, I can tell you that we'll ship bootloader integrated into our imag=
e=20
for years to come. Anyway, I also like to build U-Boot using my own options=
=2E=20
=46or example, I disable HDMI driver for A64, H3 and H5, because it turns o=
ut=20
that at least on H5, it can clash with Linux driver. Other distros prefer t=
o=20
show some splash screen, etc. One size fits all solution doesn't seems=20
realistic to me. Maybe only if *everything* would be configurable and there=
=20
would be a way for distro to preconfigure it.

TBH, building U-Boot, Crust and TF-A is easy and ability to customize them =
is=20
very handy.

>=20
> > but many boards don't
> > have designated bootloader storage (SPI NOR flash in AW case), so they
> > have to be combined on same storage, partition even, as distro.
>=20
> Have you tried eMMC boot partitions? I found them equally convenient as
> SPI flash, and while not too many boards actually have SPI flash,
> quite some have eMMC (thinking about TV boxes). I recently even
> used "dual boot" with a BSP installation.
> And even the smallest eMMCs seem to have 4 MB per boot partition, so
> plenty of space for U-Boot (plus TF-A plus crust).

No, I didn't. I don't see any benefit of using eMMC boot partition over=20
treating eMMC as usual SD card and installing bootloader to sector 16.

Anyway, that won't change situation at all. SD card image with integrated=20
bootloader is still king. There are several reasons for that:
=2D cheapest boards are most popular and usually have only SD card for stor=
age=20
(think OrangePi PC). There is nothing that you can do about it, except=20
including bootloader on SD card image.
=2D if you want to switch from Android to our distro, you need bootable SD =
card=20
due to higher boot priority (speaking for AW SoCs)
=2D not everyone wants to overwrite eMMC. Some prefer keeping Android, so i=
t can=20
be used later for whatever purpose.
=2D some users have several distros for same board, each on it's own SD car=
d.=20
Needless to say, each distro adjusted bootloader to its needs.

I like to offer flexibility in boot options, especially because it's curren=
tly=20
easy, thanks to integrated customized bootloader and external loading of dt=
b=20
files :)

>=20
> > On the other hand,
> > when building kernel, you automatically build all relevant DTB files,
> > which you can then just copy to common place. No device specific handli=
ng
> > needed. Also, U-Boot doesn't sync DT files every release, so latest
> > U-Boot doesn't necessarly mean latest DT.
>=20
> Yes, for the compatibility reasons mentioned. I am more than happy to
> make this a regular exercise (say at each kernel's -rc3 or so).

What about breaking changes? They can be important for new, useful=20
functionality but older kernels won't know what to do.

> Sadly, I don't think we're even close to avoiding shipping bootloader in=
=20
distro images or even external DTB loading.
> > Above is a bit off topic, but I hope you understand why distros opt to =
use
> > external DTB files (speaking from my own experiences).
>=20
> Yes, I understand where they (including LE) are coming from, to provide
> a pragmatic solution to the users' problems. And that's why I wanted to
> still give the possibility to load a DTB, even though I think this
> should not be the standard way.

I think loading external DTB support is important and shouldn't be ditched=
=20
anytime soon. If I understand correctly, that's an issue only on SoCs with =
TF-
A, which means only 64-bit AW SoCs. Yes, 32-bit AW SoCs are still a thing a=
nd=20
still used and no, I don't want TF-A there :).

Best regards,
Jernej



