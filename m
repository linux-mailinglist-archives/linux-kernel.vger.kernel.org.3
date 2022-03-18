Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACC4DE21D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiCRUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCRUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:08:54 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45220827E;
        Fri, 18 Mar 2022 13:07:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1FEA2DFE54;
        Fri, 18 Mar 2022 13:07:05 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xqDTUhigpXzr; Fri, 18 Mar 2022 13:07:04 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion macros
Date:   Fri, 18 Mar 2022 21:06:59 +0100
Message-ID: <7342538.iIbC2pHGDl@pliszka>
In-Reply-To: <1c4a7088-bcef-ca5c-ff3e-efd1049dc402@redhat.com>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm> <f15c415a-ad08-ae4f-c79c-574964ab9cb0@kernel.org> <1c4a7088-bcef-ca5c-ff3e-efd1049dc402@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12830340.CDJkKcVGEf"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12830340.CDJkKcVGEf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Fri, 18 Mar 2022 21:06:59 +0100
Message-ID: <7342538.iIbC2pHGDl@pliszka>
In-Reply-To: <1c4a7088-bcef-ca5c-ff3e-efd1049dc402@redhat.com>

Hi Krzysztof, hi Hans,

thanks for the review!

On pi=C4=85tek, 18 marca 2022 10:51:26 CET Hans de Goede wrote:
> Hi,
>=20
> On 3/18/22 10:06, Krzysztof Kozlowski wrote:
> > On 18/03/2022 10:00, Hans de Goede wrote:
> >> Hi,
> >>=20
> >> On 3/18/22 09:16, Krzysztof Kozlowski wrote:
> >>> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> >>>> Instead of sprinkling the code with magic numbers, put the unit
> >>>> definitions used by the gauge into a set of macros. Macros are
> >>>> used instead of simple defines in order to not require floating
> >>>> point operations for divisions.
> >>>>=20
> >>>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.s=
m>
> >>>> ---
> >>>>=20
> >>>>  drivers/power/supply/max17042_battery.c | 40 +++++++++++++++-------=
=2D--
> >>>>  1 file changed, 24 insertions(+), 16 deletions(-)
> >>>>=20
> >>>> diff --git a/drivers/power/supply/max17042_battery.c
> >>>> b/drivers/power/supply/max17042_battery.c index
> >>>> ab031bbfbe78..c019d6c52363 100644
> >>>> --- a/drivers/power/supply/max17042_battery.c
> >>>> +++ b/drivers/power/supply/max17042_battery.c
> >>>> @@ -51,6 +51,15 @@
> >>>>=20
> >>>>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
> >>>>=20
> >>>> +#define MAX17042_CURRENT_LSB		1562500ll /* =C2=B5V */
> >>>=20
> >>> Is this really long long? The usage in max17042_get_status() is with =
int
> >>> operand and result.
> >>=20
> >> The "ll" is part of the original code which these macros replace,
> >> dropping the "ll" is IMHO out of scope for this patch, it would
> >> clearly break the only change 1 thing per patch/commit rule.
> >=20
> > Not in max17042_get_status(). The usage there is without ll. Three other
> > places use it in 64-bit context (result is 64-bit), so there indeed. But
> > in max17042_get_status() this is now different.
>=20
> Ah, good catch and there is a reason why it is not a ll there, a divide
> is done on it, which is now a 64 bit divide which will break on 32 bit
> builds...
>=20
> Note that e.g. this existing block:
>=20
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
>                 if (chip->pdata->enable_current_sense) {
>                         ret =3D regmap_read(map, MAX17042_Current, &data);
>                         if (ret < 0)
>                                 return ret;
>=20
>                         data64 =3D sign_extend64(data, 15) * 1562500ll;
>                         val->intval =3D div_s64(data64, chip->pdata->r_sn=
s);
>                 } else {
>                         return -EINVAL;
>                 }
>                 break;
>=20
> Solves this by using the div_s64 helper. So the code in
> max17042_get_status() needs to be fixed to do the same.
>=20
> The "ll" is necessary because 32768 * 1562500 =3D 51200000000 which does =
not
> fit in a 32 bit integer.
>=20
> So fixing max17042_get_status() to use sign_extend64 + div_s64 fixes
> a potential bug there and as such that really should be done in
> a separate preparation patch with a Cc stable.
>=20
> Regards,
>=20
> Hans

Yes, I've already noticed that max17042_get_status was broken, but it manag=
ed=20
to slip out of my mind before sending the series - although I haven't caugh=
t=20
that I'm introducing a yet another breakage there :) I've actually thought=
=20
about removing the unit conversion from this place whatsoever, because this=
=20
function only ever cares about the sign of what's in MAX17042_Current, so i=
t=20
doesn't really need to do any division at all.

Best regards,
Sebastian
--nextPart12830340.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIt2frgBqEUNYNmF86PI1zzvbw/8FAmI05mMACgkQ6PI1zzvb
w/+rMBAAs2N32NouV7IdL8UY0uvxI9Xd9yWLCfcSd3fIYvQG0fgFAm5DLfL5L/3X
kVB8Pu7zp59c4aDKDwHbRrufJAQ8LyMwKZ8dIWQBsrOTxY1BrEnlXM+kYQxYMCPX
7q82qeyAtSgOzXQjAeT03owx1VxgHxsvnQ2EcRygie42lJnnzA7Oaq6bAHKikhWf
jUPEYgCBnLzo85HFB+/QWORlpi1pOggGa/rJziMn3VE4lYl7CcDFxLPjqnsFtCqr
gdUCuMQbcJB9BrNtOw0IfFyCAb9W9iXZVWS7xT7FtelpG38FuwqgAJpuGW13JrEO
bvpohLMZx2J3aEklXgCc8zEnXaEtEC94s6z98Ms4i9gccfx7ItAmWxjEJGgxgpPJ
PxN7Wq6jbEdx0zIgCas+w4cxWyoTskFxxBVdGoRhPVixh37NAFfNWISoL5QFVA6/
RzuO3xlAll/ulmbJinlgQsDEsUSyYVEJJpPfWIBUgYTanJF+z4d/xvuQBUFKE9LR
ivB/S9KEZyzzZ8UhOB1wDaku8HMY58BZDjtoYHDyUf3v2d0ICHoXTXJhWyLJf3zQ
sftWx1KKRv9HtSxRh9ZQlSMcB26YGFCgK8fWTndqfngPzFNFy4h483xYVSMEp0Hr
Ete62DQNo8C8TxpAs/ArWFVm0S0hswuDXK2N9xw/d46//7wOVUY=
=52Ex
-----END PGP SIGNATURE-----

--nextPart12830340.CDJkKcVGEf--



