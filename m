Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B116481112
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbhL2Ito (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbhL2Itn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:49:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444DCC061574;
        Wed, 29 Dec 2021 00:49:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c3so2206280pls.5;
        Wed, 29 Dec 2021 00:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mO2cAbVnF3v8h4rhBAATa6/9hT/HObJzVn6RR0z5/AY=;
        b=fD9Kjs5q7zDK2mneIzHPuhxO8bD+RMXyEKIXls+aPyDcecx//wxzObDOrwIqupMoy2
         DNOXSY3d3ZGAeYJN7jxSqgvqGqeiRDlpy/TKwsQQ/dW9eplzpE7KEs51W2IKXh2znZX4
         e4SY0njUaYIY/kyJhYMQG0ssa0mDPU6PJqR0WQav/TBIkZM2jtFQ4730kIGFrtAagIM3
         Zy50s7miw4gOsqxl2NOwLd0qPg4yyrDY+DZEzJAtRj933oIcVyX2hV8JOUl8StKkYxK0
         ++H+4gSDCfQi6xr+EgbHyfX5doQq4aSo3bt55mUf+x1KvpDR8hJE8zlSSM1Fgmz0ai2D
         u19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mO2cAbVnF3v8h4rhBAATa6/9hT/HObJzVn6RR0z5/AY=;
        b=evkjcTHywm6nL+FLiGSRtXwpeSrat23AUE9OoZXpQn35o2ZNl6r1LHt2/FsuDweAJ8
         PKmUisI0TDb8lkYZ6C0M+o93y9KQGSgF7zP4hlwZSohpraFcQ4x9X3AajQZGrYA5iJlz
         0SF0kC+C1F9BF1V3/r4/WL6OJU1WobDbWeLNRxNWYB0sqd/CudZdofKkgdUcu+Q8jTal
         DeIgAMlOj3zzSu5DykmQFPsno5f1Oa97Bjy8Ra06YTQR/pQMYy4ljZdK9GXbhHxnNdGw
         iehZJmGOHQ68+Jyfr+7rSMFtpLJnpZiod7rLoTT5xjrp/WdOoKo2EBIL6ewi/yCM1/er
         5nzg==
X-Gm-Message-State: AOAM531DZgIdksMiNVji2Nch6adAUZ7faB0PH0tUu4Awd9vTV5WnMomu
        VmsgOL/xYIgFcD7PRSf5gh017zZUAickoA==
X-Google-Smtp-Source: ABdhPJzVJgmgsptgAq+TdPzvOb5SL/XOlJJFyjQHNTX1+0ZlJN9DKairduymjzfmUhbXdYu+HVK07A==
X-Received: by 2002:a17:90a:eb12:: with SMTP id j18mr31008291pjz.156.1640767782860;
        Wed, 29 Dec 2021 00:49:42 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id f16sm20733849pfv.191.2021.12.29.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:49:42 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:49:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 00/23] counter: cleanups and device lifetime fixes
Message-ID: <YcwhGmOdP6QPpB3A@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <c8f6446e-748b-5845-ae60-5d6b8f3e8d39@metafoo.de>
 <20211228173558.3702faa2@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulhIPNF0Gpal2K//"
Content-Disposition: inline
In-Reply-To: <20211228173558.3702faa2@jic23-huawei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulhIPNF0Gpal2K//
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 28, 2021 at 05:35:58PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Dec 2021 13:25:25 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>=20
> > On 12/27/21 10:45 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > [...]
> > >
> > >   - I wonder why counter is a bus and not a class device type. There =
is
> > >     no driver that would ever bind a counter device, is there? So
> > >     /sys/bus/counter/driver is always empty.
> > > =20
> > There used to be a time when GKH said that we do not want new driver=20
> > classes. And all new subsystems should use bus since bus is a superset=
=20
> > of class. This restriction has been eased since then.
> >=20
> > But it was around when the IIO subsystem was merged and since the=20
> > counter subsystem originated from the IIO subsystem I assume it just=20
> > copied this.
> >=20
>=20
> Yup. Discussion about this back then with one view being there
> should never have been class in the first place.
>=20
> https://lore.kernel.org/lkml/4B571DA4.6070603@cam.ac.uk/
>=20
> For anyone who loves the history of these things...
>=20
> FWIW I think Greg suggested IIO should be a bus because we were hanging
> a bunch of different types of device off a class and it was getting messy.
> Kay then gave some history on class vs bus and suggested no new
> subsystem should use class.
>=20
> Ah well, opinions change over time!
>=20
> Also interesting to see we were discussing a bridge to input all that
> time ago and it's still not gone beyond various prototypes (with
> exception of touch screens).
>=20
> Jonathan

Yes this is the reason: Counter subsystem just followed the structure of
the IIO subsystem originally which is how it ended up as a bus; changing
it to a class now would break userspace expectations so that is why it
remains a bus still.

William Breathitt Gray

--ulhIPNF0Gpal2K//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMIRoACgkQhvpINdm7
VJKdGw/8DSuO6HGcXF2c1ChPZDJ+eF7e4FwznBOmwFZuui+Etz1RjciazjOGXRwC
qi/+e6qNrOcZoQr5IQ+BNrSbMN+pBR9zFSsxBu1HdfrUAFq6uzmaYdC3cUtrY0OV
jPPldinP4VhASWRokScS1xR+CFrP8YEwzsIljGAhRpYfXlm87EfY8xPcBLW/EOYb
Ex4gBeYBaW3E5Ath2Ho6VMTb9Kcni+jIOSrxvhHv/XkewguyGJIXK8yy57BtwhDv
lLUG8LoV43mFYYQJHi/+UvYC+qoHvvlHGUVPatA6/uRP8JnWp1QN3jO6bQulti3T
SzWYjrOzjOqfomVfuUakaNK1yYNgjhVEH+gykqcqMC0J+DZtg3+1PyAtNNZ38hxe
Vp9+lFTA/06YeWHBuW+bAiskbPZ6LRc3jPB6uSlxd4YRpCqr8K9CU9EaAo3SuPV1
zguKpB3drJ0Ifz6gjcr5mxDrCUoiseTd7Xi9uzDehuOet38g1PXfoisepp5KbYHl
GKnqkVQzceOpLRpWkbv8ryhoMixVFG3mmwPzuxgkNinnEZWDFPskLNy7wAt7hIK9
0r2PalzvaFpP+mh+A6kZwAtiCRtTU54yjEL15QerAeo2Cpb7/SQ60PbGr899MWi5
8GpEW0v8QAjretoQiYeYiuYjcQqKJSiOgWY2FkzLYy01SBfBMSY=
=PvzH
-----END PGP SIGNATURE-----

--ulhIPNF0Gpal2K//--
