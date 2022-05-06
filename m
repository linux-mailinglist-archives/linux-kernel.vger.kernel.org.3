Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECF51D280
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389665AbiEFHsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiEFHsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:48:45 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF8674D0;
        Fri,  6 May 2022 00:45:02 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B0FE240010;
        Fri,  6 May 2022 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651823100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGzNB4W4WfGK9PIJGUcSrH2CG36WKRbfkNH89DZr2pM=;
        b=JEfgnl+VgeNXkCi9WmNelq7MqYYGqUqE3V8lLJ1ouTRKtV4ZB+l7Y+vuBy9sONaFi/4Tss
        TpNmuLn+7xCOsMnTcXpQp1TdMztRBXLDwUtfL8Dx3WvdHairjaIGwDjd03qf61hDvOYOPW
        3RsFKkZrQ8O7/c4fviwabahTxavVQ4NGYV990U6lWeMHvqUY12Xd0XqvXr0HutdQ7f818m
        dUq4rLktDIy/KAhfqcn+z7ZwkcgRDZUJmfeKxinV0HLx/aO0hkBoR5fG8lUSmX3a+uOYpL
        kB0dkTCQE4coldMuQ5k4HA2OuH3CMNo8/V1HkFe2rUkGwHhbSEWoKk2Bnq8FWQ==
Date:   Fri, 6 May 2022 09:43:39 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 1/3] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <20220506094339.55b8aa63@fixe.home>
In-Reply-To: <YnQLYjcIc0PjvWYR@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
        <20220504154033.750511-2-clement.leger@bootlin.com>
        <9e470414-67a5-10ce-95eb-f8093fde70d4@csgroup.eu>
        <YnQLYjcIc0PjvWYR@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

Le Thu, 5 May 2022 12:37:38 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> > >  =20
> > > -	/* mark the property as dynamic */
> > > -	of_property_set_flag(new, OF_DYNAMIC);
> > > +	prop->value =3D kzalloc(alloc_len, allocflags);
> > > +	if (!prop->value)
> > > +		goto out_err;
> > >  =20
> > > -	return new;
> > > +	if (value)
> > > +		memcpy(prop->value, value, value_len); =20
> >=20
> > Could you use kmemdup() instead of kzalloc+memcpy ? =20
>=20
> I'd prefer there be 1 alloc for struct property and value instead of 2.=20
> And maybe 'name' gets rolled into it too, but that gets a bit more=20
> complicated to manage I think.=20

At least for value it should be easy indeed. i'll check what I can do
for the name.

>=20
> With memcpy, note this series[1].

Ok, good to know, should I base my series on that one ?

>=20
> Rob
>=20
> [1] https://lore.kernel.org/all/20220504014440.3697851-30-keescook@chromi=
um.org/


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
