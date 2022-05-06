Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D151D290
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387617AbiEFHyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389728AbiEFHyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:54:17 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ECB186F5;
        Fri,  6 May 2022 00:50:30 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98185E000D;
        Fri,  6 May 2022 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651823429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mL7sWko/zEY1GKDqcFPw+UFI+rxOeH7QwJrlHZfz4xY=;
        b=AK/nPydJipqNR7/LTq0Oh0NBKO5Xpwgy2vPit48NwT+fXefQVBBFNbZBGu4uzLX8zh+R8E
        l98COuBzajZ62Ma6Yr5qHS/RX4ZT8dZi/0iPa8gISwhl1IOLq0wDl7vPK5+S5tBrSfRS3S
        Vv2WvRTuOMcQTvHJypbz5lwne8EUK1namBL6Gs2g4GaZFwUhWTnlfdYmUIUcoflzQpL7cL
        khQVgoVMxc2hCLixlzDABxy8HT9C5JOVX6lPD9DPuYSjZBuRY034T15iZ/T3TDzEpc+dz8
        rvQLkCKD31v8tVr0jpiVApbQ24Az7LAY0Df5s4RFgvRx4l6bBKQoM1j2DTRUfw==
Date:   Fri, 6 May 2022 09:49:05 +0200
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <20220506094905.27bc99aa@fixe.home>
In-Reply-To: <YnQnayouXw9/jp/E@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
        <20220504154033.750511-2-clement.leger@bootlin.com>
        <YnQnayouXw9/jp/E@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 5 May 2022 14:37:15 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :


> > +
> > +/**
> > + * of_property_alloc - Allocate a property dynamically.
> > + * @name:	Name of the new property
> > + * @value:	Value that will be copied into the new property value
> > + * @value_len:	length of @value to be copied into the new property val=
ue
> > + * @len:	Length of new property value, must be greater than @value_len=
 =20
>=20
> What's the usecase for the lengths being different? That doesn't seem=20
> like a common case, so perhaps handle it with a NULL value and=20
> non-zero length. Then the caller has to deal with populating=20
> prop->value.

That was actually something used by powerpc code but agreed, letting
the user recopy it's values seems fine to me and the usage will be more
clear.

> >  	/*
> > -	 * NOTE: There is no check for zero length value.
> > -	 * In case of a boolean property, this will allocate a value
> > -	 * of zero bytes. We do this to work around the use
> > -	 * of of_get_property() calls on boolean values.
> > +	 * Even if the property has no value, it must be set to a
> > +	 * non-null value since of_get_property() is used to check
> > +	 * some values that might or not have a values (ranges for
> > +	 * instance). Moreover, when the node is released, prop->value
> > +	 * is kfreed so the memory must come from kmalloc. =20
>=20
> Allowing for NULL value didn't turn out well...
>=20
> We know that we can do the kfree because OF_DYNAMIC is set IIRC...
>=20
> If we do 1 allocation for prop and value, then we can test=20
> for "prop->value =3D=3D prop + 1" to determine if we need to free or not.

Sounds like a good idea.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
