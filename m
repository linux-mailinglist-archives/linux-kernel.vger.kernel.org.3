Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE44CD85D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiCDPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCDPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:55:44 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800F1AEEF1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:54:55 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E0AE16000C;
        Fri,  4 Mar 2022 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646409294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ec6eYE2jjP5qQ4uc1Qr8kOb9YqX2txQlHqrAKoDAs98=;
        b=bCwmt7vcHr3YmtgJ6VDG9Y8RiLR6PNFDLjLoemJQm3u3lLhbs4iAvsJ3nRJxoiynpIzA3j
        aG41ugctm8E5NR5eXVYngAbKr6r2hK/pmqkwnIt0jwAkEmVLIDV13nbsN39qWgR8Olq0zy
        dp6V/8lChs14am4+czPHrGVm5NM2eJ+JvPYfWwY/IaqbldUwx60/pZys/P3NbLoCdINO5C
        Uq+NezG1maz5gwxfreJhij20JZKWHXQDYB00MrTSLXzRHQVqWA3oiopv/M/wSqOJ8vG+51
        csuEdx5kG4sZQNX01GOoSAf8wIXrTLZLhuYPZO7SbjtGCpAqukDpD6Pskqz8Lw==
Date:   Fri, 4 Mar 2022 16:54:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Roger Quadros <rogerq@kernel.org>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Message-ID: <20220304165451.0129012e@xps13>
In-Reply-To: <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
References: <20220220004415.GA1519274@roeck-us.net>
        <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Roger,

rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:

> On 2/19/22 16:44, Guenter Roeck wrote:
> > On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote: =20
> >> The root of the problem is that we are selecting symbols that have
> >> dependencies. This can cause random configurations that can fail.
> >> The cleanest solution is to avoid using select.
> >>
> >> This driver uses interfaces from the OMAP_GPMC driver so we have to
> >> depend on it instead.
> >>
> >> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configurati=
on and build error")
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org> =20
> >=20
> > Tested-by: Guenter Roeck <linux@roeck-us.net> =20
>=20
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Sorry for noticing that just now, but there is still a problem with
this patch: we now always compile-in the OMAP_GPMC driver whenever we
need the NAND controller, even though it is not needed. This grows the
kernel for no reason.

In fact, Roger once said:

	"We will figure out how to enable OMAP_GPMC for K3 architecture
	some other way."

It turns out this is not what was finally proposed. Could we try yet
another solution?

>=20
> Thanks.
>=20
> >  =20
> >> ---
> >>  drivers/mtd/nand/raw/Kconfig | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconf=
ig
> >> index 36e697456ec4..9b078e78f3fa 100644
> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
> >>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> >>  	depends on HAS_IOMEM
> >> -	select MEMORY
> >> -	select OMAP_GPMC
> >> +	depends on OMAP_GPMC
> >>  	help
> >>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
> >>  	  and Keystone platforms.
> >> --=20
> >> 2.17.1
> >> =20
>=20

Thanks,
Miqu=C3=A8l
