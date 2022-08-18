Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABDB598CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiHRTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHRTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754ED021A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C256132A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFE4C433D6;
        Thu, 18 Aug 2022 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660851704;
        bh=4FgQMLBChYeexHrpum2+OfTBS1r6DlALKEiuH7ZxKDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YHY0zAbBPDFN4L8RsInVQ4m+k4k5VJPaoLl2/0QS9nwcUV/mW5/GJx9zGFO9LcbTA
         g5KzQLlYX9dfc86QvJrtTR8IRe9I2eqB4Tf5o8OfU4ldSwjGev3SFiCUC3S4z1nt89
         brucRxbGWs79V1FeavgEzOgP2Jx88Uu/rgYBjh4M7lWNV3oZy16leFf/JoppMmaPFx
         mN5PL2NNNv/6zA+nkDE4xm+4IXN4Py7bEVddgtGoOVICoWKU8zCwtglWl9NRaTOfei
         H9iW4LSU2N84jDebgaB2uwaMP/zs4MDLosbaLlb5QAxnYcn0i1Y5KpVLpjWs5ZncDT
         sa54P3PUUqYQA==
Date:   Thu, 18 Aug 2022 21:41:37 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pali =?UTF-8?B?Um9o?= =?UTF-8?B?w6Fy?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Subject: Re: [PATCH linux-phy v2 2/4] device property: Add
 {fwnode/device}_get_tx_p2p_amplitude()
Message-ID: <20220818214137.29ccb13a@thinkpad>
In-Reply-To: <CAHp75Vcn1MXEB_+kJuR3qY8qxi6oq0pEFFSFrmKv2-tE-YP-zA@mail.gmail.com>
References: <20220817200335.911-1-kabel@kernel.org>
        <20220817200335.911-3-kabel@kernel.org>
        <CAHp75Vcn1MXEB_+kJuR3qY8qxi6oq0pEFFSFrmKv2-tE-YP-zA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 22:22:31 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 17, 2022 at 11:09 PM Marek Beh=C3=BAn <kabel@kernel.org> wrot=
e:
> >
> > Add functions fwnode_get_tx_p2p_amplitude() and
> > device_get_tx_p2p_amplitude() that parse the 'tx-p2p-microvolt' and
> > 'tx-p2p-microvolt-names' properties and return peak to peak transmit
> > amplitude in microvolts for given PHY mode.
> >
> > The functions search for mode name in 'tx-p2p-microvolt-names' property,
> > and return amplitude at the corresponding index in the 'tx-p2p-microvol=
t'
> > property.
> >
> > If given mode is not matched in 'tx-p2p-microvolt-names' array, the mode
> > name is generalized (for example "pcie3" -> "pcie" -> "default", or
> > "usb-ss" -> "usb" -> "default").
> >
> > If the 'tx-p2p-microvolt-names' is not present, the 'tx-p2p-microvolt'
> > property is expected to contain only one value, which is considered
> > default, and will be returned for any mode. =20
>=20
> It's very specific to a domain. NAK for putting it to the generic
> code, otherwise explain how it can be useful outside of the PHY world.

The property may be also useful for drivers that don't depend on
generic PHY subsystem. At least the mv88e6xxx DSA driver already reads
the property [1] although it simply uses of_property_read_u32(),
because it does not expect more complicated definition yet.

There are three subsystem which may want to use this function: generic
PHY, ethernet PHY and DSA. Since ethernet PHY subsystem nor DSA
subsystem do not depend on generic PHY, I thought putting it in base
would be sensible.

If you think it should be in generic PHY subsystem anyway, and that
other drivers needing it should depend on GENERIC_PHY, I can move it.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/dsa/mv88e6xxx/chip.c?h=3Dv6.0-rc1#n3504

>=20
> ...
>=20
> > +       cnt =3D fwnode_property_string_array_count(fwnode, names_prop);
> > +       if (!cnt || cnt =3D=3D -EINVAL)
> > +               /*
> > +                * If the names property does not exist or is empty, we=
 expect
> > +                * the values property to contain only one, default val=
ue.
> > +                */
> > +               return fwnode_property_read_u32(fwnode, vals_prop, ampl=
itude);
> > +       else if (cnt < 0)
> > +               return cnt; =20
>=20
> You may count the values and read them all,

What do you mean? Count the values and read them all via one
call to fwnode_property_string_array_count() ?

> and then check the names
> and compare count to the read values. In such a case you don't need
> too many (overlapped) checks. I think the current implementation is
> far from being optimal. Take your time and try to get rid of 20% of
> lines in this function. I believe it's doable.
>
> ...
>=20
> > + * Gets the peak to peak transmit amplitude in microvolts for a given =
PHY mode
> > + * by parsing the 'tx-p2p-microvolt' and 'tx-p2p-microvolt-names' prop=
erties.
> > + * If amplitude is not specified for @mode exactly, tries a more gener=
ic mode,
> > + * and if that isn't specified, tries "default". =20
>=20
> Gets --> Get
> tries --> try
>=20
> Otherwise add a subject to the sentences.
>=20

