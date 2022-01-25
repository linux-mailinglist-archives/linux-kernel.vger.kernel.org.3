Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1C49BD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiAYUkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:40:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37472 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiAYUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E03B81A29;
        Tue, 25 Jan 2022 20:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D09C340E0;
        Tue, 25 Jan 2022 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643143206;
        bh=RUJ918iEX3MuMXSIBIgjXfg8HKd6kX+Z35rkfk4Qzu4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Q7vG8ygrYGGJegIsF9SmIe9kkWW5NLPEhrvS3NPHY/kS2AeEU3CxqMtsYCTUK0WAb
         vluUuVzaaiJmZEc6BMhswBhF8P+HD95ViXZs4HEv9+4MSJWTjxS0WTidG2iXKGHRDd
         LtKz+0YVPc+QD5MI1n4PML4NPA8NaAb/tWyeBSPiJoUtCzXeEdXuNGbFOoOlTar3ca
         Jz2FajMn+Aw6sbGo8iGxqQVfCZFGKT4rAkYLiCsWrFCti4Z3hdKPvNEqLzfyHAhZz6
         FpzNgiv5ipkOXz85BL/3hVRnYLJyEfiYIBK9D4D/DWe8WP6wqxtV2Jco1aa+YioEh8
         Fauz5GV/pixOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220120092641.o4ffzeyakhuuf3c7@pali>
References: <20211015093701.pfvkighxsndj4ujg@pali> <20211016064210.7ahqfqcvf66wtt66@pali> <20220115080213.0CCAFC36AE3@smtp.kernel.org> <20220115115018.he4hnnhlvrb6kann@pali> <20220115130509.4a240730@thinkpad> <20220115122618.plhiqnjh2755bv5h@pali> <20220119231655.EFFF3C004E1@smtp.kernel.org> <20220120000651.in7s6nazif5qjkme@pali> <20220120060149.0FF24C340E0@smtp.kernel.org> <20220120092641.o4ffzeyakhuuf3c7@pali>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Tue, 25 Jan 2022 12:40:04 -0800
User-Agent: alot/0.10
Message-Id: <20220125204006.A6D09C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2022-01-20 01:26:41)
> On Wednesday 19 January 2022 22:01:47 Stephen Boyd wrote:
> > >=20
> > > Ok, now I see what you mean.
> > >=20
> > > But problem is that this is not backward compatible change. And would
> > > not work per existing DT bindings definitions, which defines how
> > > bootloader should set configured clocks.
> > >=20
> > > As I wrote in emails 3 months ago, this new "proposed" DTS definition=
 is
> > > something which I would have chosen if I had designed this driver and
> > > bindings in past. But that did not happen and different approach is
> > > already widely in used.
> > >=20
> > > To support existing DTS definitions and bootloaders, it is really
> > > required to have current structure backward compatible like it is
> > > defined in current DT bindings document. And my changes in this patch
> > > series are backward compatible.
> >=20
> > I'm lost. Is the bootloader the one that's expecting some particular
> > serial node format and updating something? What is the bootloader doing?
>=20
> If bootloader uses or configures UART to different clock it needs to
> update "clocks" property in DT. Otherwise UART would be unusable and
> there would be no dmesg output.

Got it! I didn't see that part mentioned anywhere in the commit text
though. To the uninformed reviewer like me it is hard to know about this
bootloader design unless the commit text explains that there's no other
way to do this.

>=20
> A3720 heavily depends that bootloader patches at boot time DTB file to
> the layout of the current hardware.
>=20
> > >=20
> > > To change DTS structure, it would be needed to provide uart nodes in =
DTS
> > > files two times: once in old style (the current one) and second time =
in
> > > this new style.
> >=20
> > That's not a good idea. Why do we need to support both at the same time?
>=20
> Because old bootloaders do not and will never support this new style. It
> is not only linux kernel project who provides DTB files. Also bootloader
> itself has own DTB files and use it for booting (e.g kernel). For some
> boards is in-kernel-tree DTS file only as a reference. So it is
> important that kernel can use and support DTS files from old version and
> also from the new patched version. Gregory (A3720 DTS files maintainer)
> always ask me what happens if I try to boot new patched kernel drivers
> with old unmodified DTS files and wants to know if nothing is broken by
> introduced changed.
>=20
> > >=20
> > > But such thing would even more complicate updating driver and it needs
> > > to be implemented.
> > >=20
> > > Plus this would open a question how to define default stdout-path if
> > > there would be 4 serial nodes, where one pair would describe old style
> > > and second pair new style; meaning that 2 cross nodes would describe
> > > same define.
> >=20
> > Huh? We shouldn't have both bindings present in the DTB.
>=20
> Ideally yes, I would like to see to prevent it. But for backward
> compatibility we really need old bindings still present (as explained
> above).
>=20
> So really I see two options here: Make changes in patches backward
> compatible (old nodes stay in DT and also kernel would be able to use
> old DT). Or let old bindings untouched in DT and new backward
> incompatible definitions would have to be in separate nodes.

Ok I understand now. We have to keep both the serial nodes because the
bootloader is patching them. To make matters worse, one or the other
node may be disabled so we can't even add the new bits to the uart1
node. Can you update the commit text to record this sad state of affairs
and indicate that the only way to support this is to make a new node in
DT that the bootloader doesn't know about?
