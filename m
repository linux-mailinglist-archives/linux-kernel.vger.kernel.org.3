Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CE4CFBA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiCGKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbiCGKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:32:47 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89D75600
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:04:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 55757C0013;
        Mon,  7 Mar 2022 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646647439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4uHhj1CCnWZRfuCOfp7/fI/39ufjP0eZTALccVmhWQ=;
        b=MztK9YvLBUH4+wVXdxK6nOXMPfVOI20sAv/B6KNgGuEOTfdLW9NgvtQM8s7PQWRlTvzd0s
        9msa//FvEya7xsl4NTWSr8mCJBXIbHjgXT7aStZHE9YkwDvdyLy8XVv9uyyU23o0Gf0+9l
        jzU6l6IClC8p6RZVHmHjIokpclErEf7hGHPkGv3SmEfIVAPCJxWl8nBFTFJAJda7KwVpX/
        y3xydcno1zLCl4rURCaEEvmM/gd0T495TJRRiRltSsf2AEahBeBqYVm7vG+XDNyxSctMwq
        RHBl2KE1ilMCzugA0wGKUF1v/rzplhGC1CzeQf0XCcuHUudzKE+E/qxyiWX0iw==
Date:   Mon, 7 Mar 2022 11:03:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Message-ID: <20220307110357.20d50176@xps13>
In-Reply-To: <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
References: <20220220004415.GA1519274@roeck-us.net>
        <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
        <20220304165451.0129012e@xps13>
        <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Sat, 5 Mar 2022 00:50:14 +0200:

> Hi Miquel,
>=20
> On 04/03/2022 17:54, Miquel Raynal wrote:
> > Hi Guenter, Roger,
> >=20
> > rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
> >  =20
> >> On 2/19/22 16:44, Guenter Roeck wrote: =20
> >>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:   =20
> >>>> The root of the problem is that we are selecting symbols that have
> >>>> dependencies. This can cause random configurations that can fail.
> >>>> The cleanest solution is to avoid using select.
> >>>>
> >>>> This driver uses interfaces from the OMAP_GPMC driver so we have to
> >>>> depend on it instead.
> >>>>
> >>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configura=
tion and build error")
> >>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>   =20
> >>>
> >>> Tested-by: Guenter Roeck <linux@roeck-us.net>   =20
> >>
> >> Tested-by: Randy Dunlap <rdunlap@infradead.org> =20
> >=20
> > Sorry for noticing that just now, but there is still a problem with
> > this patch: we now always compile-in the OMAP_GPMC driver whenever we
> > need the NAND controller, even though it is not needed. This grows the
> > kernel for no reason. =20
>=20
> Sorry, I did not understand what you meant.
>=20
> We no longer explicitly enable OMAP_GPMC since we dropped the "select".
> This fixes all build issues that were reported recently.
>=20
> MTD_NAND_OMAP2 will not be enabled if OMAP_GPMC is not since we added
> the "depends on". This fixes the original build issue that we started to
> fix with select initially.

Yes, this side is fine.

In the initial commit, you proposed:

--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
        tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
        depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TE=
ST
        depends on HAS_IOMEM
+       select OMAP_GPMC if ARCH_K3

Which creates a dependency over OMAP_GPMC only for a single
architecture. Which means that other OMAP platforms do not necessarily
need OMAP_GPMC for the NAND controller to work. Now, you propose:

--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on HAS_IOMEM
	depends on OMAP_GPMC

This means any of the other OMAP architectures will compile the GPMC
driver even though they might not need it, which would unnecessarily
increase the kernel size.

Am I missing something?

> > In fact, Roger once said:
> >=20
> > 	"We will figure out how to enable OMAP_GPMC for K3 architecture
> > 	some other way."
> >=20
> > It turns out this is not what was finally proposed. Could we try yet
> > another solution? =20
>=20
> This issue is still present i.e. we cannot enable MTD_NAND_OMAP2 driver on
> K3 platform since OMAP_GPMC config is hidden and not select-able
> by user or defconfig file.
>=20
> But it is not yet a deal breaker since NAND on K3 is not yet enabled upst=
ream.
>=20
> For this I think OMAP_GPMC has to be a visible config entry and select-ab=
le
> from a defconfig file as I had done initially [1].
>=20
> Now we have a lot of explanation to write as to why we need to do it ;)

We certainly do :)

> [1] - https://lore.kernel.org/lkml/20211123102607.13002-3-rogerq@kernel.o=
rg/
>=20

Thanks,
Miqu=C3=A8l
