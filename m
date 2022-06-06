Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6853E2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiFFIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiFFIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:49:54 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623A1737DC;
        Mon,  6 Jun 2022 01:46:41 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F32042000A;
        Mon,  6 Jun 2022 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654505199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75qgHKwIKgnIiICyryatdq8N2BG0ZYToQkeJFKYpOyQ=;
        b=mNWUkWHTOojrTe6HLV5mYj/qDyPD6Vjoj1Th6VxIj0hphRoWzffGlNykUXVPF6H2qtdv2x
        ZWZJvlotPhnOqS+XIidmjHGe5FlnuRprs++sr89G5cCNuleyoMKzZ4d2ak9ajaNdWx6PX6
        IR1Ne6HRAJXVFlXplfiU7z83IfU4d0HdTXDlNgdS+mdlHnw4z6/wdTgOE9UbvAC6O7BCBS
        cwAxCXdwozmZYTkHroRsjoradSXM9mog5qt7rSSZ2E8hkT13/hce1tI/r1jsu06ZqqsivV
        m+ufnT/aWk27MkbiBzwPIBhm8bmow8PpVH1RDlp2ZDA6xz4B5i7getTbRKJTgA==
Date:   Mon, 6 Jun 2022 10:45:31 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
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
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
Subject: Re: [PATCH v2 4/4] powerpc/pseries: use of_property_alloc/free()
 and of_node_alloc()
Message-ID: <20220606104531.6ec997ef@fixe.home>
In-Reply-To: <20220603201407.GA688883-robh@kernel.org>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
        <20220601081801.348571-5-clement.leger@bootlin.com>
        <20220603201407.GA688883-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

Le Fri, 3 Jun 2022 15:14:07 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> >  static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccw=
a)
> >  {
> > -	struct device_node *dn;
> >  	const char *name;
> > =20
> > -	dn =3D kzalloc(sizeof(*dn), GFP_KERNEL);
> > -	if (!dn)
> > -		return NULL;
> > -
> >  	name =3D (const char *)ccwa + be32_to_cpu(ccwa->name_offset);
> > -	dn->full_name =3D kstrdup(name, GFP_KERNEL);
> > -	if (!dn->full_name) {
> > -		kfree(dn);
> > -		return NULL;
> > -	}
> > =20
> > -	of_node_set_flag(dn, OF_DYNAMIC);
> > -	of_node_init(dn);
> > -
> > -	return dn;
> > +	return of_node_alloc(name, GFP_KERNEL); =20
>=20
> Do you have any need for different flags? I can't really see a need for=20
> atomic or dma allocs or ???, so drop it I think.

Hum no, i copied this behavior from an existing function. I'll remove
that.

>=20
> >  }
> > =20
> >  static void dlpar_free_one_cc_node(struct device_node *dn)
> > @@ -102,11 +66,10 @@ static void dlpar_free_one_cc_node(struct device_n=
ode *dn)
> >  	while (dn->properties) {
> >  		prop =3D dn->properties;
> >  		dn->properties =3D prop->next;
> > -		dlpar_free_cc_property(prop);
> > +		of_property_free(prop); =20
>=20
> We should be able to just put the node and all the properties already=20
> attached will be freed.

Indeed !

>=20
> Looking at the history of this code, it originally did the kref_init=20
> much later in dlpar_attach_node(). So there was a window of allocating=20
> the node and adding properties where you'd need to manually free=20
> everything. Now that the node is referenced from the start, a put should=
=20
> free everything.
>=20
> > @@ -91,9 +82,7 @@ static void release_prop_list(const struct property *=
prop)
> >  	struct property *next;
> >  	for (; prop; prop =3D next) {
> >  		next =3D prop->next;
> > -		kfree(prop->name);
> > -		kfree(prop->value);
> > -		kfree(prop);
> > +		of_property_free(prop); =20
>=20
> Looks like you need this because code does: alloc properties, alloc=20
> node, add properties, attach node. It would need to be refactored to=20
> alloc the node first, but that's a bit more complex needing someone to=20
> test on pSeries.

Acked.

>=20
> >  	}
> > =20
> >  }
> > @@ -167,27 +156,17 @@ static char * parse_next_property(char *buf, char=
 *end, char **name, int *length
> >  static struct property *new_property(const char *name, const int lengt=
h,
> >  				     const unsigned char *value, struct property *last)
> >  {
> > -	struct property *new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> > +	struct property *prop;
> > =20
> > -	if (!new)
> > +	prop =3D of_property_alloc(name, NULL, length + 1, GFP_KERNEL);
> > +	if (!prop)
> >  		return NULL;
> > =20
> > -	if (!(new->name =3D kstrdup(name, GFP_KERNEL)))
> > -		goto cleanup;
> > -	if (!(new->value =3D kmalloc(length + 1, GFP_KERNEL)))
> > -		goto cleanup;
> > -
> > -	memcpy(new->value, value, length);
> > -	*(((char *)new->value) + length) =3D 0;
> > -	new->length =3D length;
> > -	new->next =3D last;
> > -	return new;
> > -
> > -cleanup:
> > -	kfree(new->name);
> > -	kfree(new->value);
> > -	kfree(new);
> > -	return NULL;
> > +	memcpy(prop->value, value, length);
> > +	*(((char *)prop->value) + length) =3D 0; =20
>=20
> Looks to me like this could be avoided with this change:
>=20
> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/pla=
tforms/pseries/reconfig.c
> index cad7a0c93117..614753fc5f27 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -148,7 +148,7 @@ static char * parse_next_property(char *buf, char *en=
d, char **name, int *length
>         /* now we're on the value */
>         *value =3D tmp;
>         tmp +=3D *length;
> -       if (tmp > end) {
> +       if (tmp >=3D end) {
>                 printk(KERN_ERR "property parse failed in %s at line %d\n=
",
>                        __func__, __LINE__);
>                 return NULL;
> @@ -158,6 +158,7 @@ static char * parse_next_property(char *buf, char *en=
d, char **name, int *length
>                        __func__, __LINE__);
>                 return NULL;
>         }
> +       *tmp =3D '\0';
>         tmp++;
> =20
>         /* and now we should be on the next name, or the end */
>=20
>=20
> Based on the comments, 'buf' should be nul terminated, so I would think=20
> that tmp =3D=3D end would be an error. But I really don't know.
>=20
> Really need some pSeries people to comment on all this.
>=20
> Another option is if value is NULL, then of_property_alloc() should=20
> ensure the buffer is zeroed. Then you just need the memcpy.

Probably looks like a safe behavior anyway to zero the value buffer.
I'll add that.

Thanks,

Cl=C3=A9ment

>=20
> Rob



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
