Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45774C46F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiBYNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiBYNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:55:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB911DD0E8;
        Fri, 25 Feb 2022 05:54:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so1721906wml.3;
        Fri, 25 Feb 2022 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLSDSpKnF2fZg407QahPP5rqpFnTUg7DoD0LmbyWE/g=;
        b=n3WGgyCMUnOHf7Jq76Xv+3aGeCryNaw5N97pg0yAcTC9wC+LbpS6QG97qfm5DwGzwQ
         VY1sX/4msCDC5Dy/oTC5CMc7ZOUy/d7sZmX+AzWb5y5/68Kf+5b4t/5/bvx4M2F2dVi4
         uq25EFNfdcVV8oc0aCB2b07FS2eIG4fIlhjpSuNLo1qI4s/dNxQ+g9cdSk7ij2Zt1V6g
         m5qyt7TX15J3hRwaAuAzQyrXVD+a7iUfuTw3+qHSWwWdIc4NIGaPGqewc3//3j1RR1kv
         ZBY9MGGydT2rhuPBfItIaboi4klJ/nLbEwIFnS3BbCBXlzRanIsafFSRh42I/PLkbBvB
         V78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLSDSpKnF2fZg407QahPP5rqpFnTUg7DoD0LmbyWE/g=;
        b=ljgpvp1dbdHgXMp35qpBkyBxGASde61jKHCe0IBOMUCzL8X8KX5cwxmIbj+QPBmYlA
         uEVPLkjSU8v0uE9VGntUHhN1j29JWny26IcTtG/tfOLBcCB+dz/Y8B78uAvmxGc/WS3j
         vN46+mbDDnUbeyFYwvwp/tl2VJdt3AH7PWPZIvhqavG6/f1XCRBW4GLWVI0hi4UpeUGY
         uzpfGeeh536QeYsS2ojiNTVZrxzqdNpDXb9MCUKtwV1/wOKrgFTUBurFsfaoo2K6Bh+0
         ynwkMX5w5bUVmaq1uKEfBgye6SbAzB937s/1Y60lOJ6KIII0zCpL/cDAA+PoNJC4SqTL
         DEag==
X-Gm-Message-State: AOAM5320QbIlS2+vuyniQGi9QjQDxEUfCYuugcoelq+KWgyVZpDtgLIm
        jfaduNgoNmEJvGYEZ2zi9fM=
X-Google-Smtp-Source: ABdhPJxG5b3eC6gJYDGRexdLtixN8Cuygm4mlA7HPg2sjRFWNhtkx6nRffUsponysqKy997ugyvOXA==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr2745834wmp.124.1645797279400;
        Fri, 25 Feb 2022 05:54:39 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b00352cdcdd7b2sm16893002wmq.0.2022.02.25.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:54:38 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:54:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] gpu: host1x: Fix a memory leak in 'host1x_remove()'
Message-ID: <Yhjflxp64MvxRxls@orome>
References: <05c1932b66048ebf6742705e2ab16eea852c46d9.1636319710.git.christophe.jaillet@wanadoo.fr>
 <f3dc9c70f3dca6462a98d595e276c9d00f607bc8.1636319710.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YM/PX6IwOvzzi6Ng"
Content-Disposition: inline
In-Reply-To: <f3dc9c70f3dca6462a98d595e276c9d00f607bc8.1636319710.git.christophe.jaillet@wanadoo.fr>
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


--YM/PX6IwOvzzi6Ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 07, 2021 at 10:16:36PM +0100, Christophe JAILLET wrote:
> Add a missing 'host1x_channel_list_free()' call in the remove function,
> as already done in the error handling path of the probe function.
>=20
> Fixes: 8474b02531c4 ("gpu: host1x: Refactor channel allocation code")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/host1x/dev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--YM/PX6IwOvzzi6Ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY35cACgkQ3SOs138+
s6EcPg//dMwTPNSZfdsrAdvf+nmBPDK1RxMflarRWxBHMT+SQ63l8aip4rIskjXE
6DAXZStv36XLmqxetcEjpUpmUFaSGOa3fDeGy6XWpl4ZjTnzCElbyknHL13Ke5QX
hGCQxkxNSz4O7QbEVfWxWQ+TBT6aV/lwZBxW+f1qshgLEp40ovZJoyZzSZVp5cJr
Zpl91rtFURk24Y6m/ZAr9s3xMHyCkZjHludKio/gjY7ozaxih9ZW9rwAjOMi/iS0
o3vdtmVVnteOucYrgxy///kHtO/Otx7RP2zgN8438KklWhLVz/Fi1Nm9HsMcQqKN
h4OWhdXW/nYiVCgKIhNuBl625sfidLDFR1oYT6FDIbpm7JG4Sj2cAykYSiZ449az
81PRNbTW1usCBbR9iLk/fwcEpNNk3lamslA1MZW7xhq9FLpAaT68lGbdXhIwH1br
zQrHRsvvc0KppccFadcWQ2sGACqnB6ESsB+vBxK1ZeUPi7uW9REXf12ssFxFt6t9
FxsvmQitS2QaZaQ9GxPom6VMEyY0J6AZyK+iRILn93pEqZJu515BamNGuqIfeCh1
CCRkmsQOI1iYbGsHYdshCJ9e5SO9HhlCZ4RClf+A1Vc9sAgS31E2b8qEv5EYtASq
eMbGPqeNd7YSL26K6CNcVofpExF4eBKZGiPbNh+USOiGx+u5Ukc=
=5eoA
-----END PGP SIGNATURE-----

--YM/PX6IwOvzzi6Ng--
