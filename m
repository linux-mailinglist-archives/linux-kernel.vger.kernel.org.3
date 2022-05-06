Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346251D5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391066AbiEFKsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiEFKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:48:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4F65402;
        Fri,  6 May 2022 03:45:02 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7862AC000E;
        Fri,  6 May 2022 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651833901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGQDY12wXijcoD4wVlIl8GRaAeVSN1VXTWLT8MFX0sY=;
        b=BWZ9TvS5I2P+CsVnRy3GTaTxbed2YCuizlO9DVt7xjLsa1wbjLJfkk2Per51Q8scCAULM1
        6qaLwEtegTL5lDf+ApWcPZCiFNczIenzAHbHUZDe+ZamGFEmL6lv17FXRnUnvYV3qFpnr/
        2iBYMOhBGTVDOaRfNf/R3vktAEPB14JDOO38aMNYZ6XQ3BU7lgUgLKPhLeDABc5oRpscXJ
        oYV7askBk05jakApkWgW86E7GTFeI1mPyyGC+CTqnBn+VvoH4f2GpucadX5e66P/pRX+XU
        cM4E+vDjAi4wNdY7+/gSHbeZ/qeWHeEtZQNia8bcJMcUze7GLHbYAZBmoM+7bQ==
Date:   Fri, 6 May 2022 12:43:39 +0200
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
Subject: Re: [PATCH 2/3] of: dynamic: add of_node_alloc() and of_node_free()
Message-ID: <20220506124339.2c772fa0@fixe.home>
In-Reply-To: <YnQo+mdDBuoKA6Fq@robh.at.kernel.org>
References: <20220504154033.750511-1-clement.leger@bootlin.com>
        <20220504154033.750511-3-clement.leger@bootlin.com>
        <YnQo+mdDBuoKA6Fq@robh.at.kernel.org>
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

Le Thu, 5 May 2022 14:43:54 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Wed, May 04, 2022 at 05:40:32PM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > Add functions which allows to create and free nodes.
> >=20
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >  drivers/of/dynamic.c | 59 ++++++++++++++++++++++++++++++++++++--------
> >  include/linux/of.h   |  9 +++++++
> >  2 files changed, 58 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index e8700e509d2e..ec28e5ba2969 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -455,6 +455,54 @@ struct property *__of_prop_dup(const struct proper=
ty *prop, gfp_t allocflags)
> >  				 prop->length, allocflags);
> >  }
> > =20
> > +/**
> > + * of_node_free - Free a node allocated dynamically.
> > + * @node:	Node to be freed
> > + */
> > +void of_node_free(const struct device_node *node)
> > +{
> > +	kfree(node->full_name);
> > +	kfree(node->data);
> > +	kfree(node);
> > +}
> > +EXPORT_SYMBOL(of_node_free); =20
>=20
> This shouldn't be needed. Nodes are refcounted, so any caller should=20
> just do a put.

Acked. Do you want the name to be allocated as part of the node
allocation also ?

>=20
> Rob



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
