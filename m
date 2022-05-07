Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1973851E7D4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385481AbiEGOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347909AbiEGOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F781580B;
        Sat,  7 May 2022 07:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 402A960B3D;
        Sat,  7 May 2022 14:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A3C385A9;
        Sat,  7 May 2022 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651934019;
        bh=QTQsvBXAXq+u552u7h6IkbyqINQY/MTcAhV9CyC5H2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GzlWpqVpg2p5jIuObrLhrKSOypv6RjDK7ZulDZ7jfkMvZEDa7Zs8hykQeqF1/Cl9h
         RYNvslJFfV+TFq4bmUhbTLIFG2g5HX6KMAqJ4OiEdg7RCQ8pMI6qHj/SRhWv0dz/hE
         j4Qu4C9rYj5/saYBgjvTz+EmHx9Nc2cuSzwdgxrSQ7KQqxlDKE9UVYTnfyMONxDTbq
         HnG4zvJeNBdqobtbokkaUMUc8S+wVWPxnTMP5ROMW4/hE/6738HgqLh/YW5mzfkKNI
         xaK2BV805J08yvxEVtVdQ8P4C5DI7/HTwqfU5og+aUVewHEVXQuv9VUGeIzcyBUuiD
         QriFlCg/yDJhQ==
Date:   Sat, 7 May 2022 15:42:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <20220507154206.328e2877@jic23-huawei>
In-Reply-To: <CAHp75VcD-UpG=ppuE2Du2SsQK66MYdrwhXvjHksN5=gqcppYqA@mail.gmail.com>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
        <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
        <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
        <CAHp75VfEK_TXXA3NdGgjis7duHgoDo4aSOZntdO0wEGLw0sQ7g@mail.gmail.com>
        <AM9PR06MB7844C01CA580F046FA570B43D7C29@AM9PR06MB7844.eurprd06.prod.outlook.com>
        <CAHp75VcD-UpG=ppuE2Du2SsQK66MYdrwhXvjHksN5=gqcppYqA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 20:01:22 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, May 5, 2022 at 4:12 PM LI Qingwu
> <qing-wu.li@leica-geosystems.com.cn> wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, May 4, 2022 10:39 PM
> > > On Wed, May 4, 2022 at 4:35 PM LI Qingwu
> > > <qing-wu.li@leica-geosystems.com.cn> wrote: =20
> > > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Sent: Wednesday, May 4, 2022 10:20 PM On Wed, May 4, 2022 at 3:36=
 PM
> > > > > LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote: =20
>=20
> ...
>=20
> > > > > > +struct sca3300_chip_info {
> > > > > > +       const struct iio_chan_spec *channels;
> > > > > > +       const int (*accel_scale_table)[2];
> > > > > > +       const int *accel_scale_modes_map;
> > > > > > +       const unsigned long *scan_masks;
> > > > > > +       const int *avail_modes_table;
> > > > > > +       const int *freq_modes_map;
> > > > > > +       const int *freq_table;
> > > > > > +       const u8 num_accel_scales;
> > > > > > +       const u8 num_avail_modes;
> > > > > > +       const u8 num_channels;
> > > > > > +       const u8 num_freqs;
> > > > > > +       const u8 chip_id; =20
> > > > >
> > > > > Why do you have const qualifier on all members?  The last one is
> > > > > understandable, but the rest, esp. pointers should be justified. =
=20
> > > > Because I thought it was static and has fix value for each chip, un=
acceptable =20
> > > for you?
> > >
> > > But why const qualifier? What is the point of it for example for u8 m=
embers if
> > > the entire object is qualified as const below in the same patch?
> > >
> > > On top of that, please explain what in your opinion the "const ...
> > > *foo" gives us, and what we will lose if we remove the "const" part o=
ut of them. =20
> >
> > Ah, you are right, those const are unnecessary for nonpointer members.
> > for the pointers, the contexts that the pointer points to are still wri=
table.
> > what about if I remove all the const from nonpointer and keep it for th=
e pointers?
> > Like=EF=BC=9A
> > const struct iio_chan_spec *channels;
> > const int (*accel_scale_table)[2];
> > const int (*incli_scale_table)[2];
> > const int *accel_scale_modes_map;
> > const int *incli_scale_modes_map;
> > const unsigned long *scan_masks;
> > const int *avail_modes_table;
> > const int *freq_modes_map;
> > const int *freq_table;
> > const char *name;
> > u8 num_accel_scales;
> > u8 num_incli_scales;
> > u8 num_avail_modes;
> > u8 num_channels;
> > u8 num_freqs;
> > u8 chip_id;
> > bool angle; =20
>=20
> It's better, but you still need to justify the rest with explanation
> in the commit message.
> And I leave this to maintainers to say if the const:s are needed or not.
Where they are being set to point to
static const int array[]=20
then to my mind it makes sense to have them as const as makes it nice and o=
bvious
what is going on.

Jonathan

>=20
> > > > > > +       const char *name;
> > > > > > +}; =20
>=20

