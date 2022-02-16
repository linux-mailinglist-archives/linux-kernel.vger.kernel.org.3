Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0B4B8B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiBPOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:23:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiBPOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:23:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80561269AA5;
        Wed, 16 Feb 2022 06:23:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m14so4145415lfu.4;
        Wed, 16 Feb 2022 06:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=va/yWTy9MrRSSdtZcieKKV2PhylVY4vI/a5Ddx5B+oU=;
        b=lM7kOT9InRBydE6wj3ozrEtILhkUXKE0lRwyZfwgVo0OE/7OXKVw/b4fE20H782RkQ
         vVFOPqY1UizuWCzYR2/nebNYI5nxSpXh+LET0j2L9i+Imfv8uCx6KM6NBwUWhLkRbvp3
         L3eYchz4fSa9N/CJ28phJ/9xRBxRVRvQUix6vKBVr7iowJS4yrn79a0rdWXhmjb+IFt6
         mfDeUb+5VpJgMfUW1ahMwkUvlu0MBFNn9O5+9favxP1ttxoON4/ujSgw+IJ90zlj6N+j
         XcKHVoqjp1ofl3L/ZPNyMEfULiyJ7jTMK4bNFwDANpC1iZSNSzc2SaczvhDhldXryhFH
         q28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=va/yWTy9MrRSSdtZcieKKV2PhylVY4vI/a5Ddx5B+oU=;
        b=Q0M+2f9voBjxTdoWPjkrewNVGlKODN/Nb1CtKvbpuM8C5F7rLvB3uyB544Ic1N56b0
         VQMG6RBDI148gi34lWdZizqtGZNOcCu8d3R5lnZNfU5ef2FbTGqwN07DEeLeXFzSjyRM
         Tmkaa9yB+JhMylO1UTwGrL8Y+a9XBVO2Ep0awKEy3D9tsE2Zj9q2KGBD2rnf2o3YFZl0
         V5/ubcR9bb4BmWWFWEsqe7zomWL2NYb5LSYhI0lvjz0s2zH7qpJ2o9oXV/OH2xe0WPwZ
         WnVJ+WezQ+LATCmG513vToAGEcW7cT+JNBs8uWhPAmK6BDk5Z7KML3CRQACCIElA4Ck9
         JsGg==
X-Gm-Message-State: AOAM5305h/aLfQc217JpF4qsASSaJBuHLKFwCF4nncr3C8GULq3qZnXG
        qHjkxmE5LHBXsBfa8306GN4=
X-Google-Smtp-Source: ABdhPJxvhWFbRVVGJ1Sq8mFAIA7VycYW4svgIQxOm7tAeOrNQS/KdIxux7uuPOhFeYxqpbqlDIld3Q==
X-Received: by 2002:a05:6512:12c3:b0:42b:461e:36a0 with SMTP id p3-20020a05651212c300b0042b461e36a0mr2309960lfg.462.1645021410687;
        Wed, 16 Feb 2022 06:23:30 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z9sm1250518lja.53.2022.02.16.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 06:23:29 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:23:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mohan Kumar <mkumard@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        jonathanh@nvidia.com, spujar@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add Tegra234 HDA support
Message-ID: <Yg0I312RA5gh1Rra@orome>
References: <20220210065057.13555-1-mkumard@nvidia.com>
 <s5hmtiscl65.wl-tiwai@suse.de>
 <s5hk0dwckza.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WpdOLmAFG2mpJZKT"
Content-Disposition: inline
In-Reply-To: <s5hk0dwckza.wl-tiwai@suse.de>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WpdOLmAFG2mpJZKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 02:34:01PM +0100, Takashi Iwai wrote:
> On Tue, 15 Feb 2022 14:29:54 +0100,
> Takashi Iwai wrote:
> >=20
> > On Thu, 10 Feb 2022 07:50:51 +0100,
> > Mohan Kumar wrote:
> > >=20
> > > This series add the support for TEGRA234 HDA driver support
> > >=20
> > > Mohan Kumar (6):
> > >   ALSA: hda/tegra: Add Tegra234 hda driver support
> > >   ALSA: hda/tegra: Hardcode GCAP ISS value on T234
> > >   ALSA: hda/tegra: Update scratch reg. communication
> > >   dt-bindings: Add HDA support for Tegra234
> > >   dt-bindings: Document Tegra234 HDA support
> > >   arm64: tegra: Add hda dts node for Tegra234
> >=20
> > Applied all six patches to for-next branch now.
>=20
> ... and now I realized that it's conflicting with the latest Tegra234
> reset stuff on linux-next.
>=20
> Maybe better to split the patches to be merged through several trees?

It's usually best for me to pick up at least the DT changes (patch 6)
into the Tegra tree, that way I can easily resolve conflicts there when
they arise.

The device tree bindings (patches 3 & 4) traditionally go along with
the driver changes, though.

If you prefer the patch series to be split, that's fine. For other
subsystems we usually deal with this by having one series and then the
subsystem maintainer picking up all the non-DT changes and I take the
rest.

Thierry

--WpdOLmAFG2mpJZKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmINCNwACgkQ3SOs138+
s6EXuw/9F6JKANiIO2CI2JqhaJ2UxIofJCAM5RgH9vFvU5emWUcF9WDUvAx6C967
rd5ThJkit9WTy+Am+40xvky1siWsoQ3K3VfNI2oH6ZqTmM7aE62DF7eqUcz7Cwp/
k+09/jx+ESF9Pvrirk06EtPsKpz2nJmvqNEoZ4/81mAkyZBYK9lHp7GPUpYusxfq
t7bq9ru4sOyV/PA6sPeellMCmr5OBhoIs/GH4R0P0WimCG5+KP9rPQSGHX6ec3XL
WB4vQLAyHU+2kyuCq+Y4JQeprlkrIS1oeke8En7uRsH7gTOvdjonwZ5M2ttvOC6r
Vj3Sky6S+IirTA42LAVoPweJy4ZtygB7yeTc1xwO0vGBD0SlLocCmNmlvagbF/eK
ERlMgwT2XinPvtsJav0hrxB3yDN4qnkbUaK7GB+ixoiZ97HKhEqknAI9nA3QLjV0
Klgqr+HRURMYdOhUgQ+fUbV8yqcTidI+tjz1N9XTvhudlM9/jYTx1Y81WhPejqt+
NAV4PFWmn1iFaKDtlxl9owqkOmaaiwNiy/e6CCUIb7uF3t/ro0gayrW55gutW704
BT59C8XFocHSE8WO+6Ak7tADGUxgWZDw+evIXpkEPODEmI+AlSRMQrw//L0c7Xqe
bYqQyKtukPxQ6glL9fueg6OIFy/xQYxysXxMmk+1e0nRFHmyx48=
=tDWF
-----END PGP SIGNATURE-----

--WpdOLmAFG2mpJZKT--
