Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602FE55F90E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiF2Hbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Hbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:31:35 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035635ABD;
        Wed, 29 Jun 2022 00:31:30 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0BB991BF211;
        Wed, 29 Jun 2022 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656487889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUAlH3rFjhmrOjOV0b6OevGjDLJyfHSl54JsM43oRMk=;
        b=p5bFqL6oNfEebvGBqtMtdm1HT21o/xzkez1UFN6wxRpJGJVWOxQcWCQa2jc/i2szAnFZBU
        sGFhEf45OvZwJWJVGXnUQDPikRmrUDczEus2xt0y9Vg3h9BHZJ4nPVPcM68xTUlHcyKJEe
        VOGhqI+5JLkp33wLRCRZ3yT9tWdMRld3sf5/lqfkxHxb+DBz3zD4D2uaOyj7UwgqXwZLbc
        VERzbiasLFtYMgm+kI083AnEdL005NQ3dTe5Y/YG8Yo3k7mrwS2sRxsSAPQL4fuFJmm3kY
        B02Sn4UxRxbw75XP3KIDBIcZDhxrRQIc1t9U50jZdlcr1+RiriO5QreQJaU4Vg==
Date:   Wed, 29 Jun 2022 09:30:35 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH v3 5/5] powerpc/pseries: use of_property_alloc/free()
 and of_node_alloc()
Message-ID: <20220629093035.281c8cd6@fixe.home>
In-Reply-To: <a6068e53-80ea-600b-0b54-0a1d0c784c54@csgroup.eu>
References: <20220620104123.341054-1-clement.leger@bootlin.com>
        <20220620104123.341054-6-clement.leger@bootlin.com>
        <a6068e53-80ea-600b-0b54-0a1d0c784c54@csgroup.eu>
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

Le Tue, 28 Jun 2022 17:00:45 +0000,
Christophe Leroy <christophe.leroy@csgroup.eu> a =C3=A9crit :

> > -static int pSeries_reconfig_add_node(const char *path, struct property=
 *proplist)
> > +static struct device_node *pSeries_reconfig_add_node(const char *path)
> >   {
> > -	struct device_node *np;
> > -	int err =3D -ENOMEM;
> > -
> > -	np =3D kzalloc(sizeof(*np), GFP_KERNEL);
> > -	if (!np)
> > -		goto out_err;
> > -
> > -	np->full_name =3D kstrdup(kbasename(path), GFP_KERNEL);
> > -	if (!np->full_name)
> > -		goto out_err;
> > -
> > -	np->properties =3D proplist;
> > -	of_node_set_flag(np, OF_DYNAMIC);
> > -	of_node_init(np);
> > +	struct device_node *np, *parent;
> >  =20
> > -	np->parent =3D pseries_of_derive_parent(path);
> > -	if (IS_ERR(np->parent)) {
> > -		err =3D PTR_ERR(np->parent);
> > -		goto out_err;
> > +	np =3D of_find_node_by_path(path) =20
>=20
> Missing ;
>=20
> Did you test build ?

I generally test build for powerpc but it seems like I forgot to rebuild
my powerpc kernel build after this modification. It seems like only
this error did not pass through the test build. I'll try to be more
careful next time.

Sorry for that.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
