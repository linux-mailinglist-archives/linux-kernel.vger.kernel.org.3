Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969CF53B3FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFBG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiFBG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:59:45 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B024DE54;
        Wed,  1 Jun 2022 23:59:40 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9314B20000E;
        Thu,  2 Jun 2022 06:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654153179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ukpk2PhTNgnldCy67ZFRAl2tgnnTsdT1m3HaHzQ3lmU=;
        b=TYqxujkmVKqU+VxmpJpCxk7SVMB0b6DXFe4sKxtH/hD3Y6fko286gmLEAZcAm0LAxOqAr9
        QU/anKOonLufbm7E7DrcnjBPEBndSVbmWnIZ2BU139vl3nTPZTvbw/tIEF9bE0ct07L5rI
        cIDmpAf5jb/u5Lf2CK4P4tlfxeBleDMUTq2Fl76cYxKMeHFs1iVjjlZA8hHGGc7ODs0Qez
        jaJJCZYfh7HVUfzvn6mdn3P+lS4z7uGPvluCC1EnkBAG7ThHvgqIlLHgG6+xBzUrzyCNe6
        1ng6MwmFwcb2t8vxMvZBtOrNAxgrdyYl/THFP5oKy3eWirnPxkHjKQxNM86MHg==
Date:   Thu, 2 Jun 2022 08:58:28 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
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
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH v2 2/4] of: dynamic: add of_property_alloc() and
 of_property_free()
Message-ID: <20220602085828.2138554a@fixe.home>
In-Reply-To: <4b92277e-5133-2362-8d3a-fa82b0c7a045@linux.ibm.com>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
        <20220601081801.348571-3-clement.leger@bootlin.com>
        <4b92277e-5133-2362-8d3a-fa82b0c7a045@linux.ibm.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

Le Wed, 1 Jun 2022 15:32:29 -0700,
Tyrel Datwyler <tyreld@linux.ibm.com> a =C3=A9crit :

> >  /**
> > - * __of_prop_dup - Copy a property dynamically.
> > - * @prop:	Property to copy
> > + * of_property_free - Free a property allocated dynamically.
> > + * @prop:	Property to be freed
> > + */
> > +void of_property_free(const struct property *prop)
> > +{
> > +	if (!of_property_check_flag(prop, OF_DYNAMIC))
> > +		return;
> > + =20
>=20
> This looks wrong to me. From what I understand the value data is allocate=
d as
> trailing memory that is part of the property allocation itself. (ie. prop=
 =3D
> kzalloc(sizeof(*prop) + len, allocflags)). So, kfree(prop) should also ta=
ke care
> of the trailing value data. Calling kfree(prop->value) is bogus since
> prop->value wasn't dynamically allocated on its own.

kfree(prop->value) is only called if the value is not the trailing data
of the property so I don't see what is wrong there. In that case, only
kfree(prop) is called.

>=20
> Also, this condition will always fail. You explicitly set prop->value =3D=
 prop + 1
> in alloc.

The user that did allocated the property might want to provide its own
"value". In that case, prop->value would be overwritten by the user
allocated value and thus the check would be true, hence calling
kfree(prop->value).

>=20
> Maybe I need to go back and look at v1 again.
>=20
> -Tyrel
>=20
> > +	if (prop->value !=3D prop + 1)
> > +		kfree(prop->value);
> > +
> > +	kfree(prop->name);
> > +	kfree(prop);
> > +}
> > +EXPORT_SYMBOL(of_property_free);
> > +


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
