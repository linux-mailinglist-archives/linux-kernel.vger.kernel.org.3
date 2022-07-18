Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8145781FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiGRMQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiGRMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:16:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B219C2C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:16:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPfj-0006Vm-1w; Mon, 18 Jul 2022 14:16:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPfi-001i4a-BF; Mon, 18 Jul 2022 14:16:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPfh-005xWL-MB; Mon, 18 Jul 2022 14:16:21 +0200
Date:   Mon, 18 Jul 2022 14:16:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 7/8] interconnect: Make icc_provider_del() return void
Message-ID: <20220718121618.rpagy3vinzgdokxa@pengutronix.de>
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
 <20220715203652.89912-8-u.kleine-koenig@pengutronix.de>
 <7bd4f2fb-70ce-3724-130f-f5c75ee7bde2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrigaio6mwohcagq"
Content-Disposition: inline
In-Reply-To: <7bd4f2fb-70ce-3724-130f-f5c75ee7bde2@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qrigaio6mwohcagq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2022 at 12:10:34PM +0300, Georgi Djakov wrote:
>=20
> Hi Uwe,
>=20
> Thanks for the patchset!
>=20
> On 15.07.22 23:36, Uwe Kleine-K=F6nig wrote:
> > All users ignore the return value of icc_provider_del(). Consequently
> > make it not return an error code.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/interconnect/core.c           | 10 +++-------
> >   include/linux/interconnect-provider.h |  2 +-
> >   2 files changed, 4 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > index 808f6e7a8048..25debded65a8 100644
> > --- a/drivers/interconnect/core.c
> > +++ b/drivers/interconnect/core.c
> > @@ -1057,29 +1057,25 @@ EXPORT_SYMBOL_GPL(icc_provider_add);
> >   /**
> >    * icc_provider_del() - delete previously added interconnect provider
> >    * @provider: the interconnect provider that will be removed from top=
ology
> > - *
> > - * Return: 0 on success, or an error code otherwise
> >    */
> > -int icc_provider_del(struct icc_provider *provider)
> > +void icc_provider_del(struct icc_provider *provider)
> >   {
> >   	mutex_lock(&icc_lock);
> >   	if (provider->users) {
> >   		pr_warn("interconnect provider still has %d users\n",
> >   			provider->users);
> >   		mutex_unlock(&icc_lock);
> > -		return -EBUSY;
> > +		return;
> >   	}
>=20
> Looks like provider->users is now useless, so we should remove it. But th=
at
> could be a separate clean-up.

Well, it's still used to emit the warning. If this can trigger there is
indeed a problem though. If there are still users, they should hold a
reference to the device preventing its release.

> >   	if (!list_empty(&provider->nodes)) {
> >   		pr_warn("interconnect provider still has nodes\n");
> >   		mutex_unlock(&icc_lock);
> > -		return -EBUSY;
> > +		return;
> >   	}
> >   	list_del(&provider->provider_list);
> >   	mutex_unlock(&icc_lock);
> > -
> > -	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(icc_provider_del);
> > diff --git a/include/linux/interconnect-provider.h b/include/linux/inte=
rconnect-provider.h
> > index 6bd01f7159c6..191f083d1f3b 100644
> > --- a/include/linux/interconnect-provider.h
> > +++ b/include/linux/interconnect-provider.h
> > @@ -123,7 +123,7 @@ void icc_node_add(struct icc_node *node, struct icc=
_provider *provider);
> >   void icc_node_del(struct icc_node *node);
> >   int icc_nodes_remove(struct icc_provider *provider);
> >   int icc_provider_add(struct icc_provider *provider);
> > -int icc_provider_del(struct icc_provider *provider);
> > +void icc_provider_del(struct icc_provider *provider);
> >   struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args=
 *spec);
> >   void icc_sync_state(struct device *dev);
>=20
> We should also squash the following:
>=20
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -172,7 +172,7 @@ static inline int icc_provider_add(struct icc_provide=
r *provider)
>  	return -ENOTSUPP;
>  }
>=20
> -static inline int icc_provider_del(struct icc_provider *provider)
> +static inline void icc_provider_del(struct icc_provider *provider)
>  {
>  	return -ENOTSUPP;
>  }

Sent a v2 with this change (and also removed the return statement).

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qrigaio6mwohcagq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLVTw8ACgkQwfwUeK3K
7AlgaQf/YQ7Rlm1PuTAUzeYj/3/wPqSWlFti8aneEGYZgWJJ+iUMHr/pGtlbfXcD
QpFrCgYd36+g12jHddOV8zz5inPSyArQSjg34Vgs3lyWsdPYi9O3Kex49ht7SnOW
YKLl+zD/jIB1RayidwBoRE2cPzXZAdERrXy9vI9LR6lSQKluCDvJEPqfDWIzSXgB
k/mnHwhGwcg5BScnOh9rWkasFkqxMSwCVIx43CFaYmG1S/ykLAErzxBXDRUyUlSq
b3+pmqInTaJQDYR8xkhoBLn4wkS52e01e8EV7t501CPJbkpnn5/oyNmUOjKIbRoM
/XqT/KuSugVftsGc96nrCWZnj6brpw==
=72Cu
-----END PGP SIGNATURE-----

--qrigaio6mwohcagq--
