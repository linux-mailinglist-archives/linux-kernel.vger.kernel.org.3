Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D714A943C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbiBDHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347553AbiBDHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:02:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B19C061714;
        Thu,  3 Feb 2022 23:02:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d1so4352797plh.10;
        Thu, 03 Feb 2022 23:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zB20MrjJCJ/mahE3hOZDlXYc1ss+ptrbcqWTueisJKs=;
        b=JYxnSeTkltmlLTtg754iDOcmlajfhlOqg38UqUO0D2uxll7/XGrVhHHxCP/1wq/o2E
         AGwkeFyc6BqjvW6xyyjjE27TlArIvGp55nWM2NZHy25BIpOdRmc9VKsG7ovIMj82jehX
         KDr/c9A9l9udRCAkBSVDhm1VpXmiC1LKY7y2REapHBwmqP/ScIbd7pWgS/0R0GSfuH2K
         SI+2qpxEwc5mF3odwtEWjZ5CEoQyhTl+kVW1VQOPX8wMhbA6hBGJnzyEoSrGiFOAKKcX
         E3fo7T6E/ZC1LGzPPCirf7TMvtdj7fM+ag2Kd5gfrqz2LegSM/FCoTlPxYDMqHgn0Gcw
         tzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zB20MrjJCJ/mahE3hOZDlXYc1ss+ptrbcqWTueisJKs=;
        b=zN0jlrRsh4Eyj4NMhG5B+CuhVUH9a7pQRs8VTRXFJNjF4YxU/7XtIsEAXKr/ej0k8c
         s+PbDnxrdtMD1bP78z4RW8p8rvW80+kd/Dn1zeUyJ5tDhHmmggKyKPKFdE/ZsxD3kWA4
         Bo58pC6I9h8RXQi4788TmzDSgluBsjSY9trN9wsYwsnnTRVk64gKtVs8CV1j/CiYZMnX
         f+33TqkVISioGn/ac+MBO9bzDiV8qW3weMBaYKWyl2p238bfESSdj89UQA9YeymULGVF
         hAMtaX0c6+AoExfylbKW2hTlNB2iOpI3as7NG+/AEHxkAZp8U6Qlh54SgX4EauegPgtz
         ISmg==
X-Gm-Message-State: AOAM532pYH/eEtvyRP1Ce7JJrqcKrE61vhbtZPMV3GH6bU3HNZc9vxsM
        AIrwLbOlC0sV4NgScd+PDOE=
X-Google-Smtp-Source: ABdhPJx+qYOYdOWb0sL7TLr0+7+LK+Dci/E0hn9jlKOcPwabLJEMUZGSk7kTDuUFMzenXvGmrgdxHA==
X-Received: by 2002:a17:902:f54c:: with SMTP id h12mr1585641plf.38.1643958139001;
        Thu, 03 Feb 2022 23:02:19 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id b11sm1220522pfv.192.2022.02.03.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:02:18 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:02:11 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v1] counter: fix NULL pointer dereference on
 counter_comp_u8_store()
Message-ID: <YfzPcyusGwAOkys6@shinobu>
References: <20220203135418.2252624-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="npq/AMq6ayJbuCXa"
Content-Disposition: inline
In-Reply-To: <20220203135418.2252624-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--npq/AMq6ayJbuCXa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 02:54:18PM +0100, Oleksij Rempel wrote:
> Current kernel will report NULL pointer dereference with following
> back trace:
>   interrupt_cnt_enable_write from counter_comp_u8_store+0xc0/0xf4
>   counter_comp_u8_store from dev_attr_store+0x24/0x30
>   dev_attr_store from sysfs_kf_write+0x48/0x54
>   sysfs_kf_write from kernfs_fop_write_iter+0x128/0x1c8
>   kernfs_fop_write_iter from vfs_write+0x124/0x1b4
>   vfs_write from ksys_write+0x88/0xe0
>   ksys_write from sys_write+0x18/0x1c
>   sys_write from ret_fast_syscall+0x0/0x1c
>=20
> Add missing dev_set_drvdata() to fix it.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Hi Oleksij,

This dev_set_drvdata() was removed in commit b56346ddbd82 ("counter: Use
container_of instead of drvdata to track counter_device"). It looks like
we overlooked the counter-sysfs.c file when we made that change.

Would you instead replace the dev_get_drvdata() calls in counter-sysfs.c
with respective container_of() calls? Add a Fixes tag referencing commit
b56346ddbd82 as well to your commit message.

Thanks,

William Breathitt Gray

> ---
>  drivers/counter/counter-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 7e0957eea094..1de16d5e9fbc 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -98,6 +98,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
>  	counter =3D &ch->counter;
>  	dev =3D &counter->dev;
> =20
> +	dev_set_drvdata(dev, counter);
> +
>  	/* Acquire unique ID */
>  	err =3D ida_alloc(&counter_ida, GFP_KERNEL);
>  	if (err < 0)
> --=20
> 2.30.2
>=20

--npq/AMq6ayJbuCXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmH8z3MACgkQhvpINdm7
VJKlVg//fx7Qn6VlgplkBrbIHRkO/ZShnQ9i84RQhEEm7gBQ7Lwvcewrstj1imdR
IedgwHTYgctA1MVjrF6SS3fonTL1u5V6F751hIhZ66LqFvbHHPia2P7v773DFi29
Wo1keBwASGFZzUEpHudB1091x1iH7gZINsD46CKTzZ25c/HO+zQNeeAjFu96L7C9
ZdZZHvn+P7JRwP+WZu3sudWQEa34x/kbR7KI1xnybids3lzn0DRXcHNadfAjdxuL
9VseLn6JNBa8fxQ5WJ4kAD1Fck7Q6jnWXvmJeQYW6qGER5WGi42jWx5GyofLAHM4
dosyPm50GTMbil2gC7EZCf8cK7G0J2W/HtWmwOQl8wp39NJ14wejQh0sNhotd8IH
A2igsgxAKXPzjtOE59nU1pPdrBvQZOW3n7rJnVDNkp/SAwG8EI2TSTk4mpRLGEYy
v0QWUrZoeXxyzAqwvYZTn02SavUXqFYlBXO6JaYEUx6E00l4fyvK8rsbzIP9PLi/
beES5nqMZdCOmI7hiUOyqCphDnD517JfiyYCmcBCYJvZ5R1HBj2fZCk8sflEjuJl
/WDoBLDGC2nOfS1fpq5jk8eOJesqqHeNzDYwU0if/4xThm1xzgN0A58ZqzlPvPwB
Nd2GeHyVrqs1R/B6qm5iddZY78igxTzjMkt+zMBrrYLo8NhdJNg=
=9MuS
-----END PGP SIGNATURE-----

--npq/AMq6ayJbuCXa--
