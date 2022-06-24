Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDB55991A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiFXMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFXMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:05:14 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5917E008;
        Fri, 24 Jun 2022 05:05:10 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 996271BF206;
        Fri, 24 Jun 2022 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656072308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtimK2j9hjJLarYb6jxp0BccsheWgcp8ThrrZdPqS0o=;
        b=lt6EZbzuYv4GcSMuTExbY1eY89PGvcNJc6+vh5TlzmLPI8POGBDxBsUHEjPiBRtsJCHbP6
        jwwgLHJA92XZFsUGodAMK05CQupmO86ogKIAs2lh/oJag4dNkoYexbDM4YPuLXnF2gtdKN
        hhIGz/AQlbD/sin5T0EdNj70t9wYUAfy0Uspl5HqXPGYqXcjx93qhcoKikhumys8+cSZyS
        /gsDLEkE/pZaQ/oSM/m4gnoHHEHapNbOALYVIWS3ufUcptiAVvMu4PqPfxI7mJLcHB5ZZ4
        8TqJx4ESolKJpK0pwDCxg5i4jiarIqepHL2UkvHGr0L+BMAgg4ARmBxOcey5bg==
Date:   Fri, 24 Jun 2022 14:04:15 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/2] of: base: populate of_root node if not set
Message-ID: <20220624140415.677a12c1@fixe.home>
In-Reply-To: <ecf13de1-531f-b73b-b325-44ef78a3f818@gmail.com>
References: <20220623105044.152832-1-clement.leger@bootlin.com>
        <20220623105044.152832-2-clement.leger@bootlin.com>
        <ecf13de1-531f-b73b-b325-44ef78a3f818@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

Le Thu, 23 Jun 2022 18:15:31 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> Hi Clement,
>=20
> I said that I would send a patch to do this, but have failed to follow
> through.  Sorry about that.

Hi Frank, no worries, I just needed this topic to move forward, that's
why I decided to sent this .

Thanks !

Cl=C3=A9ment

>=20
>=20
> On 6/23/22 06:50, Cl=C3=A9ment L=C3=A9ger wrote:
> > When enabling CONFIG_OF on a platform where of_root is not populated by
> > firmware, we end up without a root node. In order to apply overlays and
> > create subnodes of the root node, we need one. Create this root node
> > by unflattening an empty builtin dtb with of_fdt_unflatten().
> >=20
> > Co-developed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >  drivers/of/Makefile       |  2 +-
> >  drivers/of/base.c         | 18 ++++++++++++++++--
> >  drivers/of/empty_root.dts |  6 ++++++
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/of/empty_root.dts
> >=20
> > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > index e0360a44306e..ce56c8b95c83 100644
> > --- a/drivers/of/Makefile
> > +++ b/drivers/of/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-y =3D base.o device.o platform.o property.o
> > +obj-y =3D base.o empty_root.dtb.o device.o platform.o property.o
> >  obj-$(CONFIG_OF_KOBJ) +=3D kobj.o
> >  obj-$(CONFIG_OF_DYNAMIC) +=3D dynamic.o
> >  obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index d4f98c8469ed..43e0f027a49c 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_fdt.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/slab.h>
> > @@ -163,6 +164,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
> >  		phandle_cache[handle_hash] =3D NULL;
> >  }
> > =20
> > +extern const char __dtb_empty_root_begin[];
> > +
> >  void __init of_core_init(void)
> >  {
> >  	struct device_node *np;
> > @@ -176,6 +179,18 @@ void __init of_core_init(void)
> >  		pr_err("failed to register existing nodes\n");
> >  		return;
> >  	}
> > +
> > +	if (!of_root) {
> > +		void *dt;
> > +		const unsigned long *fdt =3D (const unsigned long *)
> > +							__dtb_empty_root_begin;
> > +		dt =3D of_fdt_unflatten_tree(fdt, NULL, &of_root);
> > +		if (!dt) {
> > +			pr_err("Failed to setup empty root dt\n");
> > +			return;
> > +		}
> > +	}
> > +
> >  	for_each_of_allnodes(np) {
> >  		__of_attach_node_sysfs(np);
> >  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)=
])
> > @@ -184,8 +199,7 @@ void __init of_core_init(void)
> >  	mutex_unlock(&of_mutex);
> > =20
> >  	/* Symlink in /proc as required by userspace ABI */
> > -	if (of_root)
> > -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> > +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> >  } =20
>=20
> This approach is adding an additional method of unflattening the tree.
> I would prefer to consolidate in a single location.
>=20
> I have leveraged this patch series into a different patch series to
> accomplish that.  I have boot tested with one configuration, but want
> to test two more configurations before sending the new series.  It
> should only take "a few minutes".
>=20
> -Frank
>=20
> > =20
> >  static struct property *__of_find_property(const struct device_node *n=
p,
> > diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> > new file mode 100644
> > index 000000000000..cf9e97a60f48
> > --- /dev/null
> > +++ b/drivers/of/empty_root.dts
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/dts-v1/;
> > +
> > +/ {
> > +
> > +}; =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
