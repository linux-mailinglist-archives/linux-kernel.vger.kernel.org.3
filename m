Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F35925AB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiHNQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiHNQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D11EC46;
        Sun, 14 Aug 2022 09:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6E5603F6;
        Sun, 14 Aug 2022 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C2C433D6;
        Sun, 14 Aug 2022 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660495588;
        bh=yyw6coq5uenQ2Z/EFRGEVGSSgqlo1xB9T6OhB8ulWI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n7vVb891z3+DuQcx4hnlX4aNALJLAaeRVMbG+VkIvLIIKeg9McY+1f7o9Z5b0ELr8
         99woumZLIk41hUfOg6BLo1VP5+dqCGEDmgWoOFZ5e2Yqr3paMCwg1JKB+p7+Fpsi6U
         QZgOTM2xoDeAXvr7bI4tv8I6z0NEKh3a24+MYnYdzSnrGVWwGkZg2d5fzaohEvSjpp
         XsOa4owsGZuYsgcV2vMhw7c1w5QaoeSzGAfyG/r6UvU5WpwJCwSZaeNJ4iLoCi2Rk/
         1NsI9NIBgklhFBaeQxLZWnViIscHRc+TQf+OnX7vEHf2EvcmAlOz0nX0P3Zec6AEas
         VW6ymFlWyV0iA==
Date:   Sun, 14 Aug 2022 17:56:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220814175656.1d09f897@jic23-huawei>
In-Reply-To: <53b0132936a98943fb4284c4f72e3f4e6faa402d.camel@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
        <20220814151512.097c7779@jic23-huawei>
        <53b0132936a98943fb4284c4f72e3f4e6faa402d.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2022 16:37:58 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Sun, 2022-08-14 at 15:15 +0100, Jonathan Cameron wrote:
> > On Sun,=C2=A0 7 Aug 2022 13:55:52 +0200
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >  =20
> > > Adds compatibility with the new generation of this sensor, the BMP380
> > >=20
> > > Includes basic sensor initialization to do pressure and temp
> > > measurements and allows tuning oversampling settings for each channel.
> > >=20
> > > The compensation algorithms are adapted from the device datasheet and
> > > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> > >=20
> > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com> =20
> >=20
> > One additional comment from me inline.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > @@ -1124,6 +1471,13 @@ int bmp280_common_probe(struct device *dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* BMP3xx requires soft-re=
set as part of initialization */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip_id =3D=3D BMP380_=
CHIP_ID) { =20
> >=20
> > I'd prefer this to be based on a flag in chip_info so that we can
> > trivially add it to future devices by just setting that flag for the
> > chip_info added for the new device. =20
>=20
> How a new init or preinit callback? For now only BMP380 chip would use it=
, but I
> would like to get my hands on a BMP390 and the new BMP580 and extend the =
driver
> to support for them.

Hmm. Good point, I'd failed to noticed the register is bmp380 specific curr=
ently.
Maybe one to leave for a future refactor if you get those newer parts.

Jonathan

>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn ret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D data->chip_in=
fo->chip_config(data);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret; =20
> >  =20
>=20
> Kind regards,
> Angel

