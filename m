Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A84E88B3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiC0QN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiC0QNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C1022B19;
        Sun, 27 Mar 2022 09:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D8A6106E;
        Sun, 27 Mar 2022 16:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62632C340EC;
        Sun, 27 Mar 2022 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648397504;
        bh=NSeryNnkj69DaAR2H5ykOSi3ChtK6EsLFYoZgqVQBjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4dJRnH8SPye953DLDoK5WSTi3XJFbZpmHki/3pKZnNyyEIML33fXjoQgbblBcwM5
         5gmfkWjWHUeFke4kA9WrWBWlNIRnyj0w5hja+oiDGGfSfpHY0prTMoNkgfFCvXJqZr
         eydyYw8sTa63rHnC/DkhmU5moDiZg9NoxWW6+93vwRJcUhzNZWWOg5upVU30H7si70
         niwHt0uWAAHgMKXlfDqjqeyjGoOcplXXEufTMjpwS7c4PRgs7Y6LLFuIdbErsDWYnZ
         Fw+Tl6CAlKlCwdOGzU2pMiKuKFO8zxJmmxslr4Ddl2Tk4fNRExCRiUbonVOH2d5ff3
         BLh5uA88gskGA==
Date:   Sun, 27 Mar 2022 17:19:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zizhuang Deng <sunsetdzz@gmail.com>, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH] iio: dac: ad5592r: Fix the missing return value.
Message-ID: <20220327171916.5d6c7b18@jic23-huawei>
In-Reply-To: <OZ839R.NWJC2LY54LGX@crapouillou.net>
References: <20220310125450.4164164-1-sunsetdzz@gmail.com>
        <20220320152047.2a04a62e@jic23-huawei>
        <OZ839R.NWJC2LY54LGX@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Mon, 21 Mar 2022 09:28:36 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
>=20
> Le dim., mars 20 2022 at 15:20:47 +0000, Jonathan Cameron=20
> <jic23@kernel.org> a =C3=A9crit :
> > On Thu, 10 Mar 2022 20:54:50 +0800
> > Zizhuang Deng <sunsetdzz@gmail.com> wrote:
> >  =20
> >>  The third call to `fwnode_property_read_u32` did not record
> >>  the return value, resulting in `channel_offstate` possibly
> >>  being assigned the wrong value.
> >>=20
> >>  Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com> =20
> > Hi,
> >=20
> > Definitely rather odd looking and I think your conclusion is correct.
> > +CC Paul for confirmation that this isn't doing something clever.. =20
>=20
> It's been a while, but I don't think there was anything clever going on=20
> here - so the patch is fine.

Added a fixes tag (it was driver introduction) and marked for stable
given this could have some weird side effects if anyone actually
had a dt that hit this path.  Applied to the fixes-togreg branch of iio.git
but not pushed out yet as I'll be rebasing that branch on rc1 next week.

Thanks,

Jonathan

>=20
> Cheers,
> -Paul
>=20
> >  =20
> >>  ---
> >>   drivers/iio/dac/ad5592r-base.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >>  diff --git a/drivers/iio/dac/ad5592r-base.c=20
> >> b/drivers/iio/dac/ad5592r-base.c
> >>  index a424b7220b61..4434c1b2a322 100644
> >>  --- a/drivers/iio/dac/ad5592r-base.c
> >>  +++ b/drivers/iio/dac/ad5592r-base.c
> >>  @@ -522,7 +522,7 @@ static int ad5592r_alloc_channels(struct=20
> >> iio_dev *iio_dev)
> >>   		if (!ret)
> >>   			st->channel_modes[reg] =3D tmp;
> >>=20
> >>  -		fwnode_property_read_u32(child, "adi,off-state", &tmp);
> >>  +		ret =3D fwnode_property_read_u32(child, "adi,off-state", &tmp);
> >>   		if (!ret)
> >>   			st->channel_offstate[reg] =3D tmp;
> >>   	} =20
> >  =20
>=20
>=20

