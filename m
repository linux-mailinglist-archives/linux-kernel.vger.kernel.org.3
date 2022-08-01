Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D306B586E36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiHAQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiHAQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:02:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB443336A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:02:42 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8047630494D;
        Mon,  1 Aug 2022 18:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659369760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3hxkzXi+pvt7W5ZxfDPzIuf1Pn6WGDyIat0IzyBqWI=;
        b=mgSsDPTPqVRBw5neJ4ZiTWwWKEzCSFvdhB4aniGxBHWR8tBd2oNHfBl71GOfnkobzjNuRq
        wNrMAV7/5acfFp8711h9Fvf5QMkm24fXqJMLM/VpRfD6JdBZMm6pn/rBBvYRycCuhE/aiq
        vd6+OmzcorvzcLwwHGL/ssdpV6dtyiy9mOCyAU7OY4Ca2YcrEhKm5rrkyBwrzJebZB7Iia
        lF+9N1rVkyn4rOHIZgZGuIZdtGK/e53QywBk29NzC734jL68m9hVPlfV+bEeZEZ34ebQyD
        MEyBxbVoQ/kJWAfHVcwoiSJPIgreyDdNZTWu+w1SMr7QY9WS25AckUwx6DK9ZA==
Message-ID: <0dbe47388183bf17830e5c77513ca78c58e32612.camel@svanheule.net>
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Aug 2022 18:02:38 +0200
In-Reply-To: <20220801152559.GA9041@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
         <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
         <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
         <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
         <20220707100630.GC9894@alpha.franken.de>
         <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
         <20220707143930.GA14693@alpha.franken.de>
         <CAFBinCBq3ydoxtj1VG=kjqbq5NjP1ZnQe_dOAS2Gjm2fNkK9Yg@mail.gmail.com>
         <20220801152559.GA9041@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, 2022-08-01 at 17:25 +0200, Thomas Bogendoerfer wrote:
> On Thu, Jul 28, 2022 at 05:50:10PM +0200, Martin Blumenstingl wrote:
> > I think for the Realtek SoC's this would be problematic because it's
> > using MIPS_GENERIC. My understanding is that in an ideal world all
>=20
> which SOC are these ?

That would be the SoCs supported by MACH_REALTEK_RTL. More specifically, th=
e
ones affected by this issue are the RTL8391M, RTL8392M, RTL8393M, and RTL83=
96M
which have two VPEs.

The SoC interrupt controller on these chips can route interrupts to all CPU=
 HW
interrupts. If only IP6 and IP7 are enabled on the second VPE, anything rou=
ted
there to IP2-IP5 ends up in a black hole.

Best,
Sander

>=20
> > platforms would switch to MIPS_GENERIC.
> > As an alternative to making irq-mips-cpu capable of changing another
> > CPU's registers: would you also be happy with a change that implements
> > the following idea (pseudocode) in vsmp_init_secondary():
> > =C2=A0=C2=A0=C2=A0 struct device_node *root_node =3D of_find_node_by_pa=
th("/");
> >=20
> > =C2=A0=C2=A0=C2=A0 if (mips_gic_present() ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_device_is_compatible(root=
_node, "lantiq,xrx200") ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_device_is_compatible(root=
_node, "realtek,some-relevant-soc"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change_c0_status(ST0_IM, STA=
TUSF_IP2 | STATUSF_IP3 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STAT=
USF_IP4 | STATUSF_IP5 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STAT=
USF_IP6 | STATUSF_IP7);
> > =C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >=20
> > =C2=A0=C2=A0=C2=A0 of_node_put(root_node);
> >=20
> > That way we don't risk enabling interrupt lines which shouldn't be
> > enabled (on SoCs which we don't know).
> > And also it would not cause any issues with MIPS_GENERIC support.
>=20
> well it's not exactly the abstraction I'm looking for, but it's ok for me
> as a short term way to move forward.
>=20
> Thomas.
>=20

