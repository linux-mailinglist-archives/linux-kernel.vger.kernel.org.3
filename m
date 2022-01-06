Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1F4486B33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiAFUax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:30:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51710 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiAFUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:30:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7E84B823E0;
        Thu,  6 Jan 2022 20:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEA9C36AE3;
        Thu,  6 Jan 2022 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641501049;
        bh=K8mTTccfCj509MFPxiApJokBHf56ZuhckMHO+0tHFVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBHhjFHLgckiN9DF1RAqUQyHflKADFj7JiQG6B+vWXMb0unQLsZmiAFLUpnADQlD1
         TYQZbgssqP5myvzSm4LkuDvcyD+oLGzcpLpsCkf8EimWcDxC8Nv5Bssm2hKZYkgPU6
         aCnTmggn9tXCh6qdHt4GWi7NngM20juQlKMSAZsAV6Iw/ppHuAAG+e0TJ/gH7FuCbo
         F1iMO7iINSenb2emWbAoK9/Tv0uDHv/SwG3JhUn5A6CZyvR3A7noUKq33Fpl0FM976
         6FjaCJ66eEfYXR2SAft+EYLcLKhusbnh5d31jnB+KzIjmyfk8bN41OSsRp4vDlvUa1
         +R+1tGtubTtHQ==
Date:   Thu, 6 Jan 2022 21:30:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Schlabbach <Robert.Schlabbach@gmx.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] media: si2157: add support for 1.7MHz and 6.1 MHz
Message-ID: <20220106213045.6afe5a35@coco.lan>
In-Reply-To: <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
References: <cover.1639140967.git.mchehab+huawei@kernel.org>
        <76c2ea87882c87bd35066a85cb48292a36a79fce.1639140967.git.mchehab+huawei@kernel.org>
        <trinity-b5cc1284-ccc2-477c-ac90-56ee40da91af-1641483579446@3c-app-gmx-bs50>
        <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 6 Jan 2022 19:25:25 +0100
Robert Schlabbach <Robert.Schlabbach@gmx.net> escreveu:

> It turns out there are actually two bugs in there:
> =C2=A0
> + if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
> + bandwidth =3D 0x10;
>=20
> The si2157 code for bandwidth 6.1MHz is _decimal_ 10, not
> hexadecimal 0x10. Removing the "0x" from the above line makes
> the tuner work again, even with the other bug that makes it use
> the 6.1MHz setting when 6MHz is requested.

Gah, true.

> Another issue with the bandwidth setting: The si2157 code is
> also stored in dev->bandwidth and returned in the get_bandwidth()
> call. Now this was not well before, because the call is supposed
> to return the bandwidth in Hz, not in MHz, but now it can return
> 9 and 10, but those do not correspond to 9 and 10MHz.

I suspect that the entire get_bandwidth() code on drivers are
dead code, as the core doesn't call it anymore. This used to be
needed before DVBv5 API.

Probably, the right fix here would be to simply strip this function
from all drivers.

> Also, the default case uses si2157 code 0x0f, which also seems
> like a bad idea.

Yes. it should default to the maximum bandwidth (8MHz on those
chipsets).

> And another, unrelated issue: The delivery_system switch is
> missing case DVBC_ANNEX_C, even though it should operate just as
> DVBC_ANNEX_A.

The rolloff is different for Annex/A and Annex/C. Annex/A uses
1.15, while Annex/C uses 1.13.

The DVB core already handles it when it calculates the bandwidth
for a given symbol rate, though, so, it shouldn't make any
difference at the tuner, except if the rolloff filter there
can be adjusted.

Btw, I suspect that the 6.1 MHz bandwidth could be there due to
Annex/A and Annex/C differences.

> I'll see if I can come up with a patch which addresses all of the
> above.

OK! I'll wait for your patch.

>=20
> Best Regards,
> -Robert Schlabbach=C2=A0
>=20
>=20
> Gesendet:=C2=A0Donnerstag, 06. Januar 2022 um 16:39 Uhr
> Von:=C2=A0"Robert Schlabbach" <Robert.Schlabbach@gmx.net>
> An:=C2=A0"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
> Cc:=C2=A0mauro.chehab@huawei.com, "Antti Palosaari" <crope@iki.fi>, linux=
-kernel@vger.kernel.org, linux-media@vger.kernel.org
> Betreff:=C2=A0Re: [PATCH 2/3] media: si2157: add support for 1.7MHz and 6=
.1 MHz
>=20
> Sorry for the late test and response, but there is a BAD BUG in this patc=
h:
> =C2=A0
> + if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 1700000)
> + bandwidth =3D 0x09;
> if (c->bandwidth_hz <=3D 6000000)
> bandwidth =3D 0x06;
> + if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
> + bandwidth =3D 0x10;
> else if (c->bandwidth_hz <=3D 7000000)
> bandwidth =3D 0x07;
> else if (c->bandwidth_hz <=3D 8000000)
>=20
> The additions omitted the "else", which resulted in the bandwidth setting=
 for
> 6MHz being overwritten with the one for 6.1MHz - and that completely brea=
ks
> 6MHz channels, as the tuner then refuses to accept the tune command!
>=20
> As a result, e.g. MCNS aka ClearQAM aka DVB-C Annex B no longer works aft=
er
> this patch.
>=20
> I don't know if the 1.7Mhz and 6.1MHz settings are even usable, if the tu=
ner
> (in my case, the Si2157-A30) then no longer accepts the tune command. May=
be
> they're not suited for frequency-based tuning, but only for channel-based
> tuning? That would not fit the DVB-API, I think.
>=20
> And the 1.7MHz bandwidth setting currently can't do any harm, as it is al=
ways
> overwritten by the 6MHz bandwidth setting, also due to an "else" missing.
>=20
> Best Regards,
> -Robert Schlabbach
> =C2=A0
> =C2=A0
>=20
> Gesendet:=C2=A0Freitag, 10. Dezember 2021 um 13:59 Uhr
> Von:=C2=A0"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
> An:=C2=A0unlisted-recipients:;
> Cc:=C2=A0linuxarm@huawei.com, mauro.chehab@huawei.com, "Mauro Carvalho Ch=
ehab" <mchehab+huawei@kernel.org>, "Antti Palosaari" <crope@iki.fi>, "Mauro=
 Carvalho Chehab" <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux=
-media@vger.kernel.org
> Betreff:=C2=A0[PATCH 2/3] media: si2157: add support for 1.7MHz and 6.1 M=
Hz
> Some tuners allow setting the bandwidth filter to 1.7MHz and
> 6.1 MHz. Add support for it upstream, as the narrower is the
> bandwidth filter, the better.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>=20
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1639140967.git.mche=
hab+huawei@kernel.org/
>=20
> drivers/media/tuners/si2157.c | 4 ++++
> drivers/media/tuners/si2157_priv.h | 5 +++++
> 2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
> index aeecb38b147f..2d3937af4f5f 100644
> --- a/drivers/media/tuners/si2157.c
> +++ b/drivers/media/tuners/si2157.c
> @@ -458,8 +458,12 @@ static int si2157_set_params(struct dvb_frontend *fe)
> goto err;
> }
>=20
> + if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 1700000)
> + bandwidth =3D 0x09;
> if (c->bandwidth_hz <=3D 6000000)
> bandwidth =3D 0x06;
> + if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <=3D 6100000)
> + bandwidth =3D 0x10;
> else if (c->bandwidth_hz <=3D 7000000)
> bandwidth =3D 0x07;
> else if (c->bandwidth_hz <=3D 8000000)
> diff --git a/drivers/media/tuners/si2157_priv.h b/drivers/media/tuners/si=
2157_priv.h
> index df17a5f03561..24849c8ed398 100644
> --- a/drivers/media/tuners/si2157_priv.h
> +++ b/drivers/media/tuners/si2157_priv.h
> @@ -66,6 +66,11 @@ struct si2157_cmd {
> unsigned rlen;
> };
>=20
> +#define SUPPORTS_1700KHz(dev) (((dev)->part_id =3D=3D SI2141) || \
> + ((dev)->part_id =3D=3D SI2147) || \
> + ((dev)->part_id =3D=3D SI2157) || \
> + ((dev)->part_id =3D=3D SI2177))
> +
> /* Old firmware namespace */
> #define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01.fw"
> #define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01.fw"
> --
> 2.33.1
> =C2=A0



Thanks,
Mauro
