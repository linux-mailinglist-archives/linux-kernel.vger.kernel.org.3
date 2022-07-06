Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09991569492
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiGFViu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiGFVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:38:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6A205E7;
        Wed,  6 Jul 2022 14:38:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so23783894wrh.3;
        Wed, 06 Jul 2022 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNJEnCZHpDkko/55ZKJIsVKv437PuCqDONd5JHLMG0M=;
        b=qQAx2IGpgQJicBvqsM59pe7nq9XCSxEAniOBzmcnFZyM1GPNMKrtsJQ1etXpi8l99r
         42R2ywcqwaJXZqwy0svhMOzz5hDFuIPgLaxEIdjQ/xGDGKXrFq708RBeTTPTeKfXjKCV
         nD6A+vc4qinjAECxVOO4XJ8dgYempYrbaFTTKOL4T0JNZwrtMJhcHPUFi6q9B6FiEyyO
         QBbzbw1/COEvpIs+lv4GOqzvOJvvQsGQfD+UrtvFeZfkXtelDRg0JlJDOmCjThcimpVr
         e3d1Yg9P/eEm2igDbrP5kta/LKP09QzhRvcfv7oeraDTLG9a/e/HNbtivMwGK+JiBpjy
         8NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNJEnCZHpDkko/55ZKJIsVKv437PuCqDONd5JHLMG0M=;
        b=DLix4Nq8K+TnWaV0rJ5qzobUchHpALLrd1idsSMq9tFo06kH/ukwj4J4kqBC/OYVMa
         qCdq3vH3CXzFO6E0IwVqUZUiahypMsIk/LCE29l4uSmkWFBUWbzNDoUCSalqwmfMEHsv
         8n3Lw2TMfdNfL6oxf4zZFSyF2KqGXXZleiJBxyYw/UZH4ZZf6puHfR90X5NKBstAewcs
         lYwzYojQM3L8eFXTDxEV5Ykwb5nnkt/M5CU19yfLlSud/p6dyMzhRzT9ytTCjCobtvux
         Jd/zjRcjeDs0VbxLrLcxq7xeXC/i0MYb9XNAv/ArCabpCPCaSoaKrUnvGKnRomhVC0K8
         N+hg==
X-Gm-Message-State: AJIora/EeRnYs4dK5lae1HHdGMuCJh5Gv137qbYE7mCpkV2Xj1XGASCU
        qwn8PrLxliMwk2qyhDVgqi5nDwpkCG4=
X-Google-Smtp-Source: AGRyM1u7MdSTttnX4VYBzOqWL7R+/VG7dccZMxStVn8w+bSP3hC+I0auxDQ+R4NCWA0E8vm4kBsIsA==
X-Received: by 2002:a05:6000:15c6:b0:21b:ccda:fc69 with SMTP id y6-20020a05600015c600b0021bccdafc69mr39777205wry.411.1657143523440;
        Wed, 06 Jul 2022 14:38:43 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600000c700b0021d76985929sm4860696wrx.80.2022.07.06.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:38:42 -0700 (PDT)
Date:   Wed, 6 Jul 2022 23:38:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 17/20] tegra194-hte.rst: fix reference to its binding
Message-ID: <YsYA35VDnF7V76wk@orome>
References: <cover.1656234456.git.mchehab@kernel.org>
 <2e2c86485cb0642455cee01796f9a74de21403e6.1656234456.git.mchehab@kernel.org>
 <729aeab5-f3d7-a5fc-c1a6-c07a18572b11@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/tql2Wv+jkOEc6cT"
Content-Disposition: inline
In-Reply-To: <729aeab5-f3d7-a5fc-c1a6-c07a18572b11@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/tql2Wv+jkOEc6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2022 at 10:14:45AM -0700, Dipen Patel wrote:
> On 6/26/22 2:11 AM, Mauro Carvalho Chehab wrote:
> > The binding directory for hte was renamed. Update references accordingl=
y.
> >
> > Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> >
> > To avoid mailbombing on a large number of people, only mailing lists we=
re C/C on the cover.
> > See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.g=
it.mchehab@kernel.org/
> >
> >  Documentation/driver-api/hte/tegra194-hte.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentat=
ion/driver-api/hte/tegra194-hte.rst
> > index 41983e04d2a0..d29b7fe86f31 100644
> > --- a/Documentation/driver-api/hte/tegra194-hte.rst
> > +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> > @@ -37,7 +37,7 @@ LIC (Legacy Interrupt Controller) IRQ GTE
> > =20
> >  This GTE instance timestamps LIC IRQ lines in real time. There are 352=
 IRQ
> >  lines which this instance can add timestamps to in real time. The hte
> > -devicetree binding described at ``Documentation/devicetree/bindings/ht=
e/``
> > +devicetree binding described at ``Documentation/devicetree/bindings/ti=
mestamp``
> >  provides an example of how a consumer can request an IRQ line. Since i=
t is a
> >  one-to-one mapping with IRQ GTE provider, consumers can simply specify=
 the IRQ
> >  number that they are interested in. There is no userspace consumer sup=
port for
>=20
> Reviewed-by: Dipen Patel <dipenp@nvidia.com>

Hi Jonathan,

I think you'll need to pick this one up since it applies on top of your
earlier patch that moves this documentation into driver-api/.

Thierry

--/tql2Wv+jkOEc6cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLGAN8ACgkQ3SOs138+
s6ETWQ/+N85PYHztcyY57mNQ+nWbaLfq4vuiqkNmLxSAIWQu5boz2VFZwRs5q8ia
4lmhvNwkWRpEK3XVrQIXCbztyT8uTURnuI92dvLncDZrvDYuVl6ugGvr4KEVMPSH
y5uJq4aFKVTAGkg+3hFwxt/exeBcc7FnkYLhJ04BexQ3uOM18463PC+5ok0u6nEa
4re0iDIIceRj/u0a2M8SGFQzDnnQpAsUp5Pwwubmf5A1SVUaiDcLhLN+6D/oBOXT
AcyUkYZy21CnYT1KkfEDCNvBt7WeqMBrX+A/PBLbBxXGUD6s3fSRzlEb+yC48sg5
f2EIE9bxK4R2huEqm+VBLR0mFpx9CYZ6i1KeUCpnPAQAj7Qk2mSF0qTnlubJRgbm
/uCnkyRiq11MFlRWHkx258+BLwPpl1/2POliUEHUdVYh6ZJB8+vHXhUuBHn5cr+v
cfSMoC/YifcuITi+4mkxvPUJp16Qpyub7NWkRvrD7vforGWG23or62uRyLLs+K4C
643oghH3xUEyjYUJxAaFe3riGYhK0llQMMZcQ6+l8gkXQmaSIHTJeS7s5iOPHruq
oOVjCFvany7RfySnEDKE8DbyFjGRKKkuSVM6fm7lZYOelS+DHXLWneV2II9x7cFX
oCgpawWPFTRkv0uz7dgaBTm7zPsXye3B0ES9pQPlJ2N+hWu3lY0=
=qYzB
-----END PGP SIGNATURE-----

--/tql2Wv+jkOEc6cT--
