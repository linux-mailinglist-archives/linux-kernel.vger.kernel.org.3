Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD24B5F09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiBOA1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiBOA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:27:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A815117CBE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:27:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id om7so16005987pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GYB1fI0D9nYciFwdD6JzesTCxp+5pmAN8brR7fAFLtk=;
        b=NYZx6FyeL1UAVX/3ox6vx7GmLRlAzYVafPuQkb3hPQUX8qfjFlu7Uq3Ok7jVvkKjST
         SLXaLFK+vJ6FmlcDLcnsd9tshLfQRMPcagZFda2MsTJr0GB4wLB06vkiBINn9neDwdy4
         XbYDRiAaBTLemkLGH2E5mQp6WoiuEen53D8/+g8tBcCXsCaADdLfkebat+zaCNZfT/kF
         j3zaFr06jgaod7L0TuFXLmQ/s7JWZ5195WaedVmVcE6Ym7+umEILwoyterY0hFNBzqL5
         Yv7BLYnzAFXlQpn4qOBxWaFfKCdieh3n3C0F9KIBJgU2Jqmg+pBuELewq5NnOvUJC/u+
         VyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GYB1fI0D9nYciFwdD6JzesTCxp+5pmAN8brR7fAFLtk=;
        b=FrLOpPasvKv9MI6jYbxBjBedlnh4t4qS1RzubqwIO8OF/SpOeJIcP3dJywV5gkYjOG
         TJmvEKy/Wpvb+kXez5V1EKkXUY+p0GXKEB+uMKmckD5XoJMpu3QGYfdPCkUcXZxmhwkI
         iPohvFI7xstnKHkW/JPIgDYIzATQQK5w4zf7c3ERzeOd4hZ1aIRowTFvOqnX9A4b3FFG
         IO19r1RnOOj45jpplR/v4qFChK6vrMcyYwqyCVP/ku0PWpjpn5f5i4oNyksDlma0uANN
         H/7fVUB6Q9aVTbqLXFjmFLr8ASeQJKEHnYNmVqLDtiPUPaiYOJZ+x3cJkUpQOMXBVyhB
         xc5Q==
X-Gm-Message-State: AOAM530aEN25TgNWVyBA/KaW0UlL5aLN7iL9JpN/+QC75rx8IkHjWlu8
        9MKJ+0uXiw+SzOSoHjjAwFnqag==
X-Google-Smtp-Source: ABdhPJwj0FJ3FoZR2POBi7bG76fKWAmmfSySxjxP0by9wYaGl3FyQMOX13/KDEhoL1DpjJMUTCunEw==
X-Received: by 2002:a17:90b:1c01:: with SMTP id oc1mr1380135pjb.161.1644884853084;
        Mon, 14 Feb 2022 16:27:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f672:8368:e22c:5ae9])
        by smtp.gmail.com with ESMTPSA id a9sm611010pgb.56.2022.02.14.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:27:31 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:27:25 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 3/4] platform/chrome: cros_ec_typec: Configure muxes
 at start of port update
Message-ID: <YgrzbQViMLRTC4XB@google.com>
References: <20220208184721.1697194-1-pmalani@chromium.org>
 <20220208184721.1697194-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcHVd+HjoMipoP7y"
Content-Disposition: inline
In-Reply-To: <20220208184721.1697194-4-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mcHVd+HjoMipoP7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Tue, Feb 08, 2022 at 06:47:22PM +0000, Prashant Malani wrote:
> There are situations where the mux state reported by the Embedded
> Controller (EC), might lag the partner "connected" state. So, the mux
> state might still suggest that a partner is connected, while the PD
> "connected" state, being in Try.SNK (for example) suggests that the
> partner is disconnected.
>=20
> In such a scenario, we will end up sending a disconnect command to the
> mux driver, followed by a connect command, since the mux is configured
> later. Avoid this by configuring the mux before
> registering/disconnecting a partner.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v2:
> - Change return at end of port_update() to just return 0.
>=20
>  drivers/platform/chrome/cros_ec_typec.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 3d34ece7f790..3019e29f200d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_=
data *typec, int port_num)
>  	if (ret < 0)
>  		return ret;
> =20
> +	/* Update the switches if they exist, according to requested state */
> +	ret =3D cros_typec_configure_mux(typec, port_num, &resp);
> +	if (ret)
> +		dev_warn(typec->dev, "Configure muxes failed, err =3D %d\n", ret);
> +
>  	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
>  	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
>  	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
> @@ -980,12 +985,7 @@ static int cros_typec_port_update(struct cros_typec_=
data *typec, int port_num)
>  	if (typec->typec_cmd_supported)
>  		cros_typec_handle_status(typec, port_num);
> =20
> -	/* Update the switches if they exist, according to requested state */
> -	ret =3D cros_typec_configure_mux(typec, port_num, &resp);
> -	if (ret)
> -		dev_warn(typec->dev, "Configure muxes failed, err =3D %d\n", ret);
> -
> -	return ret;
> +	return 0;
>  }
> =20
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> --=20
> 2.35.0.263.gb82422642f-goog
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--mcHVd+HjoMipoP7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYgrzbQAKCRBzbaomhzOw
wmsmAP4osevqyWmDrkfwKbxgKbYaAxsyYlmk2daeEsBiCz5oGQD/UjyH6XvZGqrE
1g76TY7mzdZcD9yPVEjWDF8a4xK8lwk=
=3lFf
-----END PGP SIGNATURE-----

--mcHVd+HjoMipoP7y--
