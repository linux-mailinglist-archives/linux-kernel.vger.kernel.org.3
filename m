Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94A51BC74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbiEEJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiEEJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:52:32 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67E31531;
        Thu,  5 May 2022 02:48:52 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 48466240011;
        Thu,  5 May 2022 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651744130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dz9x7hjALAYRR1gzE0vRrtltM7FrhiyILR91Rd0tJPA=;
        b=J7jAKmhcgDJCHrO7ALoOQwG8k12UJRZJ8RSrEmyRLi/ATbqoN8r/E31uF01Is2wbZTjKfs
        Qde9j+3NYsdvMR61MBMwOhcQoNPcogEq4U0B0QHFS3nb+bG3b3etfxUa2BG9Jz70ocP+z4
        akXu5tMH7e4iHNG5ZdbRP2dKcdP6L6JIv5KkZ88ayUyoN8JDg1q/B8WwlwLRyknYSz2u6+
        ifth7DXaMUp7qZar3f0n9pwi3WyHO5AtPBboFt589pV4tYOQ0b2Nm5PzLI9bVL/UpwJWHW
        XkRa8iedTPVbdbINhI3EPb+vpclOSkojjT92UNbpIfIODzOXzpeUlIe8fhGJAA==
Date:   Thu, 5 May 2022 11:47:28 +0200
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
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 1/3] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <20220505114728.4b2de3a5@fixe.home>
In-Reply-To: <9e470414-67a5-10ce-95eb-f8093fde70d4@csgroup.eu>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
        <20220504154033.750511-2-clement.leger@bootlin.com>
        <9e470414-67a5-10ce-95eb-f8093fde70d4@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

Le Thu, 5 May 2022 07:30:47 +0000,
Christophe Leroy <christophe.leroy@csgroup.eu> a =C3=A9crit :

> >   	/*
> > -	 * NOTE: There is no check for zero length value.
> > -	 * In case of a boolean property, this will allocate a value
> > -	 * of zero bytes. We do this to work around the use
> > -	 * of of_get_property() calls on boolean values.
> > +	 * Even if the property has no value, it must be set to a
> > +	 * non-null value since of_get_property() is used to check
> > +	 * some values that might or not have a values (ranges for
> > +	 * instance). Moreover, when the node is released, prop->value
> > +	 * is kfreed so the memory must come from kmalloc.
> >   	 */
> > -	new->name =3D kstrdup(prop->name, allocflags);
> > -	new->value =3D kmemdup(prop->value, prop->length, allocflags);
> > -	new->length =3D prop->length;
> > -	if (!new->name || !new->value)
> > -		goto err_free;
> > +	if (!alloc_len)
> > +		alloc_len =3D 1;
> >  =20
> > -	/* mark the property as dynamic */
> > -	of_property_set_flag(new, OF_DYNAMIC);
> > +	prop->value =3D kzalloc(alloc_len, allocflags);
> > +	if (!prop->value)
> > +		goto out_err;
> >  =20
> > -	return new;
> > +	if (value)
> > +		memcpy(prop->value, value, value_len); =20
>=20
> Could you use kmemdup() instead of kzalloc+memcpy ?

I could but then, we won't be able to allocate a property value that is
larger than the original one. This is used by the powerpc code to
recopy an existing value and add some extra space after it.

> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 04971e85fbc9..6b345eb71c19 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -1463,6 +1463,11 @@ enum of_reconfig_change {
> >   };
> >  =20
> >   #ifdef CONFIG_OF_DYNAMIC
> > +extern struct property *of_property_alloc(const char *name, const void=
 *value,
> > +					  int value_len, int len,
> > +					  gfp_t allocflags);
> > +extern void of_property_free(const struct property *prop);
> > + =20
>=20
> 'extern' is pointless for function prototypes, you should not add new=20
> ones. Checkpatch complain about it:

I did so that, but I kept that since the existing code is full of them.
Since you mention it, I'll remove the extern.

>=20
> CHECK: extern prototypes should be avoided in .h files
> #172: FILE: include/linux/of.h:1466:
> +extern struct property *of_property_alloc(const char *name, const void=20
> *value,
>=20
> CHECK: extern prototypes should be avoided in .h files
> #175: FILE: include/linux/of.h:1469:
> +extern void of_property_free(const struct property *prop);
>=20
>=20
>=20
>=20
> >   extern int of_reconfig_notifier_register(struct notifier_block *);
> >   extern int of_reconfig_notifier_unregister(struct notifier_block *);
> >   extern int of_reconfig_notify(unsigned long, struct of_reconfig_data =
*rd);
> > @@ -1507,6 +1512,17 @@ static inline int of_changeset_update_property(s=
truct of_changeset *ocs,
> >   	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, pro=
p);
> >   }
> >   #else /* CONFIG_OF_DYNAMIC */
> > +
> > +static inline struct property *of_property_alloc(const char *name,
> > +						 const void *value,
> > +						 int value_len, int len,
> > +						 gfp_t allocflags) =20
>=20
> Can that fit on less lines ?
>=20
> May be:
>=20
> static inline struct property
> *of_property_alloc(const char *name, const void *value, int value_len,
> 		   int len, gfp_t allocflags)

Yes, that seems a better split.

Thanks,


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
