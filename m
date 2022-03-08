Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6D4D130C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiCHJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiCHJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:07:45 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A233FBE0;
        Tue,  8 Mar 2022 01:06:49 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id g39so30951063lfv.10;
        Tue, 08 Mar 2022 01:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=ZSSqssguaqD2tjMmjJKfil49rhUxKlYemuYgWRJDFc4=;
        b=i8KUKVpplsOozfpS14HotNRNIdGXHN1AJwMaWOsj/7F1Z/kamP4qLBs1oQDWZJFPQp
         IjgvlodAyvdg4SoaDmaGyc+bxGAuQUi3+QsWoG7ibRCJN+/hUy/CwnDceCejBmQfuwYd
         fe9E7f1yKxtRd30ECx58R64okM17jy8ojVQcvuUxAGPYcpkNfKUQjM8AP2tMV7cVA1FZ
         UW6+c6/e5A9PdwjoykmWlafGXizCSH6U1CcDMu7qSQhl/po96hOnF6wGaaVpChd8s0r0
         zHy3iLteMOKwp8mJCqEFLjU7La0luzdqGLLByI6GgBoGEn1GRP6suqma9mi7yNp7Uc7N
         aB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=ZSSqssguaqD2tjMmjJKfil49rhUxKlYemuYgWRJDFc4=;
        b=xejnvqwttB317hl/WQ2wGQo0lt7kL/3SUdFvxY63RnxKi8L7+3MR6P1aa59qG1gU30
         mbQjcEmdV5dWP1SIC7kx9TNcuA73IiNiTASB/LK/7yskrtfaBR89IgmJOz/5/TP63rzt
         fo7dDeo5uc5Ziha5FgNZEmDQv+nHeoPAjx/tJJ1WALMhQYaF2c8GJaYti3SY4ec+SwFP
         +YeN9B1aC+iB4RdTscBRB+5X3rRKmrQD7GPLYFU84XBsd1f0/5TNS0AB4j088Tgx5YxV
         ix5afYfGJvfyDgQ7aV8j9F2IosmLuD9bpxQ3sem9hQBf9mjJaQeyjdhQhyYILlRZGl3z
         EPLQ==
X-Gm-Message-State: AOAM532DXCzAecIH0HhPHiSwPXS0s03kyTI5jiax4HzitBVuO2jgof9w
        vJzlGYYYqq5TmJ06mxYEgxU=
X-Google-Smtp-Source: ABdhPJw9TP6u4KkztcCyk+LiyHCv0kAMZ0i30SGTKsh3ic6MF4I9uJqKFnh7OrKajZI+ONY2va6a6Q==
X-Received: by 2002:a05:6512:b19:b0:446:f1c6:81bd with SMTP id w25-20020a0565120b1900b00446f1c681bdmr10299826lfu.320.1646730407178;
        Tue, 08 Mar 2022 01:06:47 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f21-20020ac251b5000000b004478fa4a744sm2871298lfk.56.2022.03.08.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:06:46 -0800 (PST)
Date:   Tue, 8 Mar 2022 11:06:43 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/10] drm/fourcc: Document that single-channel
 "red" can be any color
Message-ID: <20220308110643.5220f8ae@eldfell>
In-Reply-To: <585dc03acb4016bba910e7d15fec3ef4f0aec5b0.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
        <585dc03acb4016bba910e7d15fec3ef4f0aec5b0.1646683502.git.geert@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hJXpHsxaCnYZ11VUzvhv1th";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hJXpHsxaCnYZ11VUzvhv1th
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Mar 2022 21:52:43 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Traditionally, the first channel has been called the "red" channel, but
> the fourcc values for single-channel "red" formats can also be used for
> other light-on-dark displays, like grayscale.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> RFC, as I have no immediate need for these formats.
>=20
> v2:
>   - New.
> ---
>  include/uapi/drm/drm_fourcc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 457ed39cc48f08e1..f0187cf20e4619d2 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -104,16 +104,16 @@ extern "C" {
>  #define DRM_FORMAT_C4		fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:=
4 two pixels/byte */
>  #define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one =
pixel/byte */
> =20
> -/* 8 bpp Red */
> +/* 8 bpp Red (or generic light-on-dark) */
>  #define DRM_FORMAT_R8		fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> =20
> -/* 10 bpp Red */
> +/* 10 bpp Red (or generic light-on-dark) */
>  #define DRM_FORMAT_R10		fourcc_code('R', '1', '0', ' ') /* [15:0] x:R 6:=
10 little endian */
> =20
> -/* 12 bpp Red */
> +/* 12 bpp Red (or generic light-on-dark) */
>  #define DRM_FORMAT_R12		fourcc_code('R', '1', '2', ' ') /* [15:0] x:R 4:=
12 little endian */
> =20
> -/* 16 bpp Red */
> +/* 16 bpp Red (or generic light-on-dark) */
>  #define DRM_FORMAT_R16		fourcc_code('R', '1', '6', ' ') /* [15:0] R litt=
le endian */
> =20
>  /* 16 bpp RG */

Hi Geert,

this is a good idea. I just wonder whether light-on-dark is an accurate
description. To me, light-on-dark means things like bright characters
on a dark background, but that is a property of the image as a whole and
not a property of the pixel format. What I think you are after here is
that increasing channel value mean increasing brightness.

How to word that concisely...

Direct relationship to brightness (vs. inverse relationship to brightness)?

This does not imply a linear relationship, and I'd also use
"brightness" to denote that it is a qualitative factor relating to
human observation.


Thanks,
pq

--Sig_/hJXpHsxaCnYZ11VUzvhv1th
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmInHKMACgkQI1/ltBGq
qqe1FhAAhV61IfBbTfh9T9cYYsQ6Hh2uefFJl1NqodXNWfd7nLXNxgkcTZ5YeMYY
WvKAbNrIX24tS4ZJWjQWK0o/L+TPilrKph0QgB7qeAsPL/uXomH0YJI3YQ70/eCF
JHFt3aQH8ne8VTN5IwGdDh+4vpyO/S5924QbxyXG8yVRAnKL1e0dfGFmNM8luQd+
4ON5X2Fw2jwC61bZfvPVo2lO+2Osw84nrgkMOpCqJLxjPzxjBRH8V4UPi6UPru+Z
7BkXVAqoSby15cM2fsSGEd4OnTRbsdkCX9uptsPaqVenhM6pzE6pN9E9plzckmjW
mWGwxsUPT5AHRCQPxRPak6ClYCIpmg9AA8aMngRmcUjXuPqH1/s6q0tPFPCDkbbL
brrvRgUYtBVdwKeJ1uUsfsAbqRl2rDIlCu3MdrrOlMthDx4llBJ89gmrYgemvqbV
ZuPg5fx/n5sQfROyU9HFboaFyBkP6t7xsc8Wdp/3tsDuPZiwCNzmfOy0qTes4pya
craCaUJf9VXE2F8ZBOOIgYzAlt/nso4JZE/Dzt2bUb86FWOQhP79qo6qSZSxqfEY
NKPKGiWEqnpe8q26KTSgbV5ACiy3rW/o/H7Rz0sdmkwm0j3pcWYqcSyLnwvJdmCl
SsiBN+ZkqdxpjnVc2uvYaJc5Vw6t6lTzE+sPyTp6/1aEFlIFFvw=
=nrsn
-----END PGP SIGNATURE-----

--Sig_/hJXpHsxaCnYZ11VUzvhv1th--
