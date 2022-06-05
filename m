Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284BD53DD06
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351251AbiFEQcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiFEQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:32:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0E12D15;
        Sun,  5 Jun 2022 09:32:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q15so8705182wrc.11;
        Sun, 05 Jun 2022 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzGs2OWippNwMA+vRDm0hQE0BwkypdQBXCE4ZyaN0tI=;
        b=C7yYOx09xfL0nVPpNI7jFWYb3ZiGhGhywh67zbWNRguU4sC6Aadh0jmh4MZEfy7Zms
         BKMseVYsrNKSfmHhklYxJJiYIn59THv6ICfzLLKJUKjBpefOhyIn3sdaFHDJNUyOKWkt
         oDjxbGsumpG3kq0CYVqZXjbhOaj5uH7gqR/4svRkV23Hm9ZFD+BFSq8F1BQe8Gqxp876
         j6HygN5V0mfyixgQ5bl00HPSuCB+Wq81n1WejZH5vB91ybYMWOAWLhWvAS71tqGxr2dm
         oZD+BhcuNLe5aghHpZMHrsl/Up16UDkfr5xN2ZvXkQTPU2tEGR4FpWE2b1BhgVMZ5PB2
         W8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzGs2OWippNwMA+vRDm0hQE0BwkypdQBXCE4ZyaN0tI=;
        b=ryIw9YN936j/7aB9N9HCypc7JOgPUWSMrsUl47mT2Y9yJ1Y9cSEY3VNm0N3NH0oLC/
         1lL2Ic4zk1UZMMP1Z4OONieuJSqR5CCdXI3U6xeF93bOLkmbALdokkOtTmoLHSdXJpCJ
         QOU3festKkCwSvG4EPvF0Bgr8k2Lja44MoflunN8r45ZXjJB+S6TmKNTAq5if0kgHqkw
         WIMFUkbrne4eEHjyVEpT+9Dkku/RWZ54ysS4jMMBOVwAp3z15XySpBORQjl7FjVXcEaf
         bSKhjUcsBTK/q5FO2PtnXQTd7DtHCIY0B1nFFB+hhQlFAs90ORwvyKh/xs8A9BfS7cSa
         KXRQ==
X-Gm-Message-State: AOAM5302kcL3Qs8vStQRuKGDxM5i+t92/vmPzl5yhDIErRkYuMZ9hZio
        RuabJBcO1nOmwIl987RNULiCdenXLt0=
X-Google-Smtp-Source: ABdhPJwnQyMI7/dxg3Pi+qG9/8l/5gMtx09RlRydLB/iLvLcFN9Ivlwn4SXSqFFr+ePfC9zNMGNzQQ==
X-Received: by 2002:a05:6000:1565:b0:217:b627:e3d4 with SMTP id 5-20020a056000156500b00217b627e3d4mr3145289wrz.500.1654446734225;
        Sun, 05 Jun 2022 09:32:14 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l65-20020a1c2544000000b00397393419e3sm18118874wml.28.2022.06.05.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:32:13 -0700 (PDT)
Date:   Sun, 5 Jun 2022 18:32:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
Message-ID: <Ypzai+P9BIVhHT7t@orome>
References: <20220603113908.78777-1-thierry.reding@gmail.com>
 <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
 <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
 <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBHY2RA1fzKSPkQj"
Content-Disposition: inline
In-Reply-To: <CAHk-=wirNAe3ApyCWMAyz-QFaNX_oNCzc8SSX7a52pV=+OQ6Qg@mail.gmail.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBHY2RA1fzKSPkQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 05, 2022 at 09:16:21AM -0700, Linus Torvalds wrote:
> On Sat, Jun 4, 2022 at 1:11 AM Linus Walleij <linus.walleij@linaro.org> w=
rote:
> >
> > Another provider did come up, and were requested (by me) to work with
> > Dipen on the subsystem in august last year, that was the Intel PMC in t=
he
> > Elkhart and Tiger Lake platforms and forward
>=20
> Ok, I've pulled this now, even if I don't love the "hte" name. I
> despise specialized TLA's that aren't some obvious "if you're a kernel
> developer, you know what this means".

Thanks. If you prefer we could follow up with a rename for v5.20 and
name this similar to the device tree bindings. There are other cases
where the device tree bindings are named differently from the Linux
subsystem and/or driver directories, but admittedly it'd be easy to
make them match in this case. Given how little this is exposed at
this point, renaming should be fairly unintrusive.

Thierry

--gBHY2RA1fzKSPkQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKc2osACgkQ3SOs138+
s6F4OA//VIWWjlB9I33qZjE32PBLrwy3vrM31STPK+oIur9pdcAZiVW7F6nF3tLp
7ci/TPLPRFCYJ6AcxchTp3nNT66cN/MCo11WroT0NZ8wBg/3WhqtGgXedyBTq8TM
t/u1sH2/AIkXaUByOcJH85DbdUBV57aoiYkKUSdqTGLLV02bU6Kkp7zgddrONa9N
bTh70bJRlRbMFQ35Z5xH872nctksgdtjuOx9cVwBn2m2WyHGKhN0/mONq2mzgQLi
VgMyH1Dg5XAKof99jUmWKi+uFK6JrQTpJjPK6pAQNKM9W0xY/WCLowNV1juOQ06d
SNgpO6dM85KFYqE0U6iwMz+c6ELaFrhQ1d5BXgVAaLiGfrxa8jTFPbZA/jlmXywd
Wkwpzu+cGWCDT79bzH5NV8zsin2HB/zvyViMpQOYsbG2ss9ePgRvQO3b2F7Emt9/
WzimrAMelV1EYBoRnMbMlL0oYQOLC9QR4c7hGslJ0J7s746hdX3QN71ohjEIaTZX
K5N3lEtFPao9hc5OCdAGt4Htl30ZRG0X8Pe+uy9EdvBskTF2NP+g6zXcgrCzKJqf
YzjIMWAlUtfpsn0k2pBeO2Cb3LdwsaZWn1wrgOEv53D7dPYJG3FFvIlMtSilTVgG
qXt0hpfwhH+KHMWiAcpuL/ud9cVERwXyD3suiKRY8uu6Rj8+pbU=
=MFlN
-----END PGP SIGNATURE-----

--gBHY2RA1fzKSPkQj--
