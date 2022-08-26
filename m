Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038F5A24AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbiHZJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbiHZJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:39:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F86E02;
        Fri, 26 Aug 2022 02:39:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso1032455pjj.4;
        Fri, 26 Aug 2022 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CePpmj5PRr490c3slomKoNVDyInNj7Ql1pzKOd9PePw=;
        b=K4RWVYN5tUkmGn+act7NmASyML51weN4Ixk+L/zVwdmxGo54CMYvxdOR+IGQJhV4Wu
         TB7MuZ9qRvGTp643RlKn9oDhHRPNREm8HbpUbCzohubtKK26BKSPn3n94qCSyonAx7n+
         wq8XLuI8ZwF0tTKSnWrNn3sT6/znQnNk0QOMJOAAHccHpVQAJI1PblCximjkm7xk1l3V
         kvft9cQXFvlegdvea11c5nJ+VB1tG58Bk7Hau4+5TGeDoI7mzckKe/Vuszq0cy4q5Qw9
         37fRUPKuvRZtmb4x+4QkBOolA0ZxJxdycjAfrY6XKV9IvpETv7g20zaHekQCNJZL3AkU
         hJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CePpmj5PRr490c3slomKoNVDyInNj7Ql1pzKOd9PePw=;
        b=fp20qX9qrMggbmWqKSo/OMyIKYXwUslRtSj+WKOYNPv7+gYEDDr7iW4C+5SYMrJ2CS
         ksXwyjKHz0OgbHDDsXO/6JluPXGkjfmQHc252yhzUJV876SdYnxQ0BxPUHpbxQUJm0Ij
         1nu63zKw6ZX1viZnr0PTMCFgBpKtnoU+O7Ye/f28ZttkiTCUH9+IV+Zj7hcqcqPx/It8
         yRPbaq/ZPNOl+gydEcipIxM3hw4n+xEdWO1c19dXs15aQ0VMiYG1lt/yqN5egcRGlLhL
         +9Y+2xLOGNhYFB+YrbyGTvSuIQcNFsyPY5XioAYs0/bKmRQMn6U9OC76g9j8HObMRXso
         T4pg==
X-Gm-Message-State: ACgBeo1joAHCT15ni3ZprwO8+IznGH/GT3mi9zd+2D5xURfuIeyzfo1c
        b5jXZOL+9nDC6NVIs0iurFQ=
X-Google-Smtp-Source: AA6agR5ZMUGDEa8ZE7fEn58zLldulFL4vmWORKZNk3znn8mdCa2iAIGVL/XyJx5t3MX0QNzyKyuIMA==
X-Received: by 2002:a17:90a:db90:b0:1fb:2267:586 with SMTP id h16-20020a17090adb9000b001fb22670586mr3331770pjv.141.1661506789056;
        Fri, 26 Aug 2022 02:39:49 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id i13-20020a63cd0d000000b0042ad3214a88sm1042977pgg.74.2022.08.26.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:39:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F1140103AEB; Fri, 26 Aug 2022 16:39:44 +0700 (WIB)
Date:   Fri, 26 Aug 2022 16:39:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     menglong8.dong@gmail.com
Cc:     kuba@kernel.org, sfr@canb.auug.org.au, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next] docs/conf.py: add function attribute
 '__fix_address' to conf.py
Message-ID: <YwiU4DPEPryi1cMZ@debian.me>
References: <20220826061914.816239-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rqWF7VzPFLV8W9NN"
Content-Disposition: inline
In-Reply-To: <20220826061914.816239-1-imagedong@tencent.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqWF7VzPFLV8W9NN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 02:19:14PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
>=20
> Stephen Rothwell report that the function attribute '__fix_address'
> causes a warning when create html docs with the command:
>=20
>   make htmldocs
>=20
> Therefor, add this attribute to c_id_attributes in Documentation/conf.py
> to clean this warning.
>=20
> BTW, I'm not able to reproduce this warning (both ubuntu and centos are
> tested). I will appreciate it if anyone can have a test for this
> commit.
>=20
Hi,

The patch description can be improved, like:
"Stephen Rothwell reported htmldocs warning when merging net-next:

Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in =
declarator or parameters
Invalid C declaration: Expecting "(" in parameters. [error at 19]
  void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_r=
eason reason)
  -------------------^

Add __fix_address keyword to c_id_attributes array in conf.py to fix the
warning."

So next time when you spot documentation warnings like above, specify the
exact warning in the patch description. This will help reviewers what warni=
ng
the patch is fixing.

> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Also, don't forget to add Link tag, like:
Link: https://lore.kernel.org/linux-next/20220825154105.534d78ab@canb.auug.=
org.au/

Otherwise, the warning disappeared on my htmldocs build, thanks.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--rqWF7VzPFLV8W9NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwiU3AAKCRD2uYlJVVFO
o2v6AQDAyaR3WdaiUTy/JoBcbB4HfvKf5CBxQeYG2ZIYnx3rvQEAl/OwnJ7f8S3P
KhcUyu885NB/tUz4+UzIbK12Jtrc5QE=
=m/WF
-----END PGP SIGNATURE-----

--rqWF7VzPFLV8W9NN--
