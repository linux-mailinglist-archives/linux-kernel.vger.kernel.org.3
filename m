Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83E598D86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbiHRUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbiHRUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:13:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E12B6D77
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:10:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e4so2000060qvr.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=5elQUG5HHcj3mEYzvaC4MbKkQn6e3RoTtYW6B/1LrV8=;
        b=UGrvQE4OlWqs7pH7cOcHgy5pksB/bkhhgk5KDebeUkL4N5ewjBIeRzQv8SA7yulSYO
         667QF4dZoYU8sR00BCHJJDuYKQ+zFEGY10gQPeEp63BbwGVSLDbgNk8vLAnhAisLh0DU
         b1sWmRg4AioXLwGkt2dD/uRPKkSFvbUZ1Dzy+6UruyASxf+c3N7/mcw4dNzMwIqjNnJ6
         wdNt/Z5CSMzT/ZFAMYkRI3G90IofSJbHCVmCGKcRWIC4Rn1qSV05p0GOrTNo/6HjtiXa
         HGEq3aNstdxLqBPrx7x3c2VqqwU3Ptb7P5cI9odFTbf877Gsjl3EjzWvh0d8XWsWHQ71
         3cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=5elQUG5HHcj3mEYzvaC4MbKkQn6e3RoTtYW6B/1LrV8=;
        b=DsesDPfvFQ8z+4S8NZL54Or9Cd1exjHSBDSRPM1e769q4nvxt2gbx5lfC3KLtx6lFc
         RVwjWudUfGS1u2C14QfzmdL5siRhf8MfHK3khEFI5qV6CDi8+4PVXJVB5krnqqdppOmt
         bWSIiWYejpJMUaYzl/XcELhsWi6ldJfYp8qFdw5nXKpNmVKYQUwK9ZcCZJvOG2qSS8o3
         bePRwlYODsoVTXBKaBDnVIcmzTLC0Gd76+AXa/xQXYFR3Gs3ZKYvaSs/77q3HLaWIAH3
         DQSmtcWviKwEmDDpcyRbuof9b5uP25q4H7S+h9CVDtTJ11w+izRgmEvF9lIPA9cnBaVV
         0xuQ==
X-Gm-Message-State: ACgBeo0q7RJ5+d5CHApWo8R0peaVBqbmgJ8FZG964e/3kcM4A4J7pnMw
        H95QrfwLrsSn0yrjfckJiUoCwPjb9nvchYmshiI=
X-Google-Smtp-Source: AA6agR4ubQvpOeuhH+FFjch01GC6e21xBDy0pYRbVbUu6JYoL9NbyI4sF32ne8rZOX1i8DxNFYE9hTEu8i3Cp62kGyE=
X-Received: by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr3820807qvb.97.1660853445593; Thu, 18
 Aug 2022 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220817200335.911-1-kabel@kernel.org> <20220817200335.911-3-kabel@kernel.org>
 <CAHp75Vcn1MXEB_+kJuR3qY8qxi6oq0pEFFSFrmKv2-tE-YP-zA@mail.gmail.com> <20220818214137.29ccb13a@thinkpad>
In-Reply-To: <20220818214137.29ccb13a@thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 23:10:09 +0300
Message-ID: <CAHp75VeenutmdUZW4Zb6JVz2h5AgwzWmC-okaVtsgRzm99HZ5g@mail.gmail.com>
Subject: Re: [PATCH linux-phy v2 2/4] device property: Add {fwnode/device}_get_tx_p2p_amplitude()
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:41 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> On Thu, 18 Aug 2022 22:22:31 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Aug 17, 2022 at 11:09 PM Marek Beh=C3=BAn <kabel@kernel.org> wr=
ote:
> > >
> > > Add functions fwnode_get_tx_p2p_amplitude() and
> > > device_get_tx_p2p_amplitude() that parse the 'tx-p2p-microvolt' and
> > > 'tx-p2p-microvolt-names' properties and return peak to peak transmit
> > > amplitude in microvolts for given PHY mode.
> > >
> > > The functions search for mode name in 'tx-p2p-microvolt-names' proper=
ty,
> > > and return amplitude at the corresponding index in the 'tx-p2p-microv=
olt'
> > > property.
> > >
> > > If given mode is not matched in 'tx-p2p-microvolt-names' array, the m=
ode
> > > name is generalized (for example "pcie3" -> "pcie" -> "default", or
> > > "usb-ss" -> "usb" -> "default").
> > >
> > > If the 'tx-p2p-microvolt-names' is not present, the 'tx-p2p-microvolt=
'
> > > property is expected to contain only one value, which is considered
> > > default, and will be returned for any mode.
> >
> > It's very specific to a domain. NAK for putting it to the generic
> > code, otherwise explain how it can be useful outside of the PHY world.
>
> The property may be also useful for drivers that don't depend on
> generic PHY subsystem. At least the mv88e6xxx DSA driver already reads
> the property [1] although it simply uses of_property_read_u32(),
> because it does not expect more complicated definition yet.
>
> There are three subsystem which may want to use this function: generic
> PHY, ethernet PHY and DSA. Since ethernet PHY subsystem nor DSA
> subsystem do not depend on generic PHY, I thought putting it in base
> would be sensible.
>
> If you think it should be in generic PHY subsystem anyway, and that
> other drivers needing it should depend on GENERIC_PHY, I can move it.

Yes, I have no objection to put it there, just that the above
justification doesn't allow it to be in the generic code (yes, we may
still have some awkward APIs in the property.c and ideally they should
be moved to the respective subsystems).

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/dsa/mv88e6xxx/chip.c?h=3Dv6.0-rc1#n3504

...

> > > +       cnt =3D fwnode_property_string_array_count(fwnode, names_prop=
);
> > > +       if (!cnt || cnt =3D=3D -EINVAL)
> > > +               /*
> > > +                * If the names property does not exist or is empty, =
we expect
> > > +                * the values property to contain only one, default v=
alue.
> > > +                */
> > > +               return fwnode_property_read_u32(fwnode, vals_prop, am=
plitude);
> > > +       else if (cnt < 0)
> > > +               return cnt;
> >
> > You may count the values and read them all,
>
> What do you mean? Count the values and read them all via one
> call to fwnode_property_string_array_count() ?

No, you obviously may not read them via string_array APIs, esp. one
that is related to counting.

Count the vals first, read them all (it seems you need it in all
branches of your flow). Then count names and compare them to the
number of values, and so on... Also try to assign "default" only once.

> > and then check the names
> > and compare count to the read values. In such a case you don't need
> > too many (overlapped) checks. I think the current implementation is
> > far from being optimal. Take your time and try to get rid of 20% of
> > lines in this function. I believe it's doable.

--=20
With Best Regards,
Andy Shevchenko
