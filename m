Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742294C2DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiBXNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiBXNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:53:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB013C3A7;
        Thu, 24 Feb 2022 05:53:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s1so2889518edd.13;
        Thu, 24 Feb 2022 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PsHbpOEJCVknsAa9Ew1MJQLg7HZo/XSZeiEybp+5mZg=;
        b=QDxmyMXJ4i9lHmwVUraX5Rlhf7hv+wUE4GLih8mYSl/hCGo1BUhJX+Y1I3L2c+enob
         vVGhLR9hh7gop8Cd9+9Fu2E8hC2ruBDcwonDLTAUXu7lIp+BB8Z3CS3fsK5uje4RIiLY
         QoOgti+cWfvrzDU6e/JGaF9aParwVVPvQzocuJS1VgnybVST51Qa6WZJJHXfCM7n1KaP
         1TzCCXiMaWKOvNqWIecYig8Dqg14gY2X/xZZGn3kgC/OeeI6CHA64opA52auIsSFqB3B
         gAMnHvg7efk1a2N1H0cbJiHPtCcX6botTUG9kpQbXMsoWLce9e462CquDLW5x+owxfii
         xAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PsHbpOEJCVknsAa9Ew1MJQLg7HZo/XSZeiEybp+5mZg=;
        b=LodDi75dYRQEh+bAsmiO3Ftrl9Lmm/5xu+WatwGVWa/c5lzvy+5p5rkL6w2XNWS/n+
         JDQWMYZmarT6K9PcYt7baZrJJXvr3NBRogQ+XcCVjb3+FgYLKEEch5NNs5O5PTKWPRaz
         vDjIjWIrsqw2lDCquqJ/Q5gVrvio7//LMyANBMS6NZFouer3C3fOn6Bvg3fDEDFbpI+a
         TKDXd8XbP5cqd8kIJkRQc0JOOyCzpRdrz6KorzNApYSrxKH84M4vBmty9bOrSBeOeJ84
         mr8WAYtWOZ4G0fm1RiNmkP/UuU/RTU0Qe7BAAyyiOStneLFqp3RIlNy3MZnb7uBcgOrp
         9CcA==
X-Gm-Message-State: AOAM530Xycj72Rhn2PwY6HFwkP3qbowbgdGFSbf7j15xI60sw/WAsDQ+
        sZXasQpeDSsJXMOXgUYBhEY=
X-Google-Smtp-Source: ABdhPJwYJ1sQPo7eUQ7M9X2zgdVZRDirXqwrTv0tPiXNsHmdAq6JmlyGZffSuNvBcEayqtpPP6YBHQ==
X-Received: by 2002:a05:6402:3583:b0:410:a99b:59ee with SMTP id y3-20020a056402358300b00410a99b59eemr2402863edc.454.1645710785751;
        Thu, 24 Feb 2022 05:53:05 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id c11sm1550197edx.42.2022.02.24.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:53:04 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:53:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] pwm: pwm-mediatek: Simplify error handling with
 dev_err_probe()
Message-ID: <YheNvqKMfDPqM48r@orome>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d2Zfu6vgd3T2uyn0"
Content-Disposition: inline
In-Reply-To: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2Zfu6vgd3T2uyn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 03:03:37PM +0100, AngeloGioacchino Del Regno wrote:
> Use dev_err_probe() to simplify handling errors in pwm_mediatek_probe().
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)

Applied, thanks.

Thierry

--d2Zfu6vgd3T2uyn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXjb4ACgkQ3SOs138+
s6Fk8hAAnIRaKfj9+HXIijwEGPCmMx7BlzgpvJ6PmUHUWirU6k2C3ptFUVxh1p/R
sp1MdzkgMXh1QR6sffWbmJWMrBW9c4tFzjeHTvGls/dEchQi2VWqTaHEvcY6dMB5
yrK4MZfCbGe08jFJfI5CwDirhxNK/cInmKOVxGL60u2QSEMPRKvjjlIl2YvFqf3o
C+TIRlC7C9rc9tuOBKvwQwnixOeJELte3k+E8WSIHBE2/G3lwpCQxCQd8VvERBvQ
+nBAx0vE9b+xe33lYZBnc/C5RhW8FDoIZ2qoXxhycQvrBX1H/2am+F47zGr+097Q
kyX24SIvodLAt/9Al7/W0TrLqYlTh5kL595/sT5ksT8pJqtGeHJKBUhlpjIMD+3K
J8MPsi8jQA7B/bWB34BFjF6OgIT28sCHFUGL3MT1BKEpsyt0py6TBt480LQ7kT8V
T7H+whLUZ5uImhIbCon1z2lP71MneIRG9bUYYVlEX1S1syajKdSlBldmPAX3FUEc
LDkfTSRwFXGsydlLl/qiOhSj03yHymPWBa8UZHlQptZ4PQQJ/tg/Z4kFmZxE/Vca
91FrqBN42oUtjJd2H/NxGsLfB4n6hFWrHL7dHdDwXmMWD919IqFmAzmzj5wwW+sn
zh2J3Lb+vqmhNTZ8PhM3lWG566bR2W9XfzKlCmIpCzokyQf/9Ns=
=wC81
-----END PGP SIGNATURE-----

--d2Zfu6vgd3T2uyn0--
