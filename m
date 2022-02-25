Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA14C4177
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiBYJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiBYJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:30:57 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5CE18F214;
        Fri, 25 Feb 2022 01:30:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j15so8310024lfe.11;
        Fri, 25 Feb 2022 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5AzSht2nyeyY1UVfwN1DSU/s7HgEVJ2AdBOgPEuvAS4=;
        b=W7dBn+KZvH/dwbC5M82ju8KQZO9rpK6NjiO2mKISrctDmuhwUxmuFO+/h4DS12WgWf
         I9a5z/5L/kiozkUxjDZPY//qN5cCge8x6u/GrHeXx/ORDpCIGc3Iaqrf+EYo6xQKVFi5
         6HoJt0B5h00do6rhuI3cj9ZcnuqSzG6QP6zbSGGjcemGz+oAs7eRqRa/8FHK5PhTu0+g
         /wzIBDv+s3ESTHOVsKCyjmrmgqU4Iyv8G0mE/7TRMM5xNS8LmIQTOmh7AwiFYILrVzFA
         ioFVEqpZkPTOT55mLZYJHm3VV+mOiSQA4wAOH3zP9FUeJxgo4i/3JuvKN8KCdHFk31Iw
         eCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5AzSht2nyeyY1UVfwN1DSU/s7HgEVJ2AdBOgPEuvAS4=;
        b=LEuTyuQMgNzF9k/TDnX2688qb2Ok9635TJ/336k5UbtdothTHOgcKtNComa4IBF/6m
         oxGsQMOW7Hr7CuUA8fLKsA/iLVG9Z9Sv54ditxfsvZr6+PMGxNh06LvGm4r5ZyfZCosT
         KAzxXtO2ZBK04QMLVrVCI8WLWW5gosqjr3vFfBH+MlOyU4V7a4KnUyg+y6zaAt0uQRZM
         jaWcnAtNjK788fMgvxKkEAJsBlfPoXGivn/jh3SVdkJpq9CTTMncukRaRZQa4tMALp8S
         n86XsMqCxaj/9IZeJCEGXSDK5mmOAjhy6UI5tpNw2ajD+6ODlbRf8T5wwGF8FkVrxAS0
         1E5g==
X-Gm-Message-State: AOAM533HrNdbqLfacyjRZXX7TidGx1hwh5TkhUws0FO0/occJloE64fX
        KKZWAkYVs+lfbnmLjnByAR8=
X-Google-Smtp-Source: ABdhPJzqjAQkDVhMqvwqNRM/3Gi5fq3FONQyGaq9x87//cjXPx8Pce+JQEZ8Gw8XTdlydFrpW1TTCQ==
X-Received: by 2002:a05:6512:3a95:b0:443:1624:3be1 with SMTP id q21-20020a0565123a9500b0044316243be1mr4304250lfu.355.1645781424140;
        Fri, 25 Feb 2022 01:30:24 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l9-20020a2ea809000000b002466c11ee8asm212995ljq.77.2022.02.25.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:30:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:30:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/dp: Fix out-of-bounds reads
Message-ID: <YhihqzqPW7qbYnB9@orome>
References: <20220225035610.2552144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akPJIWxgBZHniLnc"
Content-Disposition: inline
In-Reply-To: <20220225035610.2552144-1-keescook@chromium.org>
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


--akPJIWxgBZHniLnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 07:56:08PM -0800, Kees Cook wrote:
> Hi,
>=20
> I'm sending these again, as they still need fixing. They have been
> rebased due to the drm_dp_helper code being moved into a subdirectory.

Yeah, I noticed the other day that this had been partially reverted by
the DP code move. I've applied this now, though it didn't apply cleanly,
so I'll do a couple of test builds to make sure my resolution is correct
and will push this out later on.

Thanks,
Thierry

--akPJIWxgBZHniLnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIYoakACgkQ3SOs138+
s6G6ZhAAwXanqGZpI3dY+3mEMff9651PrD8RgficbLnWLnZXd1JsRFE0vDHqaKUL
WzxwaH+ctqQHXe+f7VTcypE+IV3iZ5cwe7AzEco8kg0wz4i3PesAc7XstmM3FTJA
FjGbOrUh2XO3epk/lmDyOQz35rNu9nU2ptJiavk+E+zO+KhRV7u7s4WyGYFlIi0M
y4dQl1IAgF9JaLU57yQ00EuyCShPdyUaTDE0Ow1AVMADWXZ81t+0enV+vO16Z0Gj
Nm7+gBKg+o6m390BYZYRq8cAxuTW2Hqlu4SEvTQGI899o8AtXe9oqE8lVGAIQQ5+
LAIV2IgyIGXA9S84CMkP6CLIZDDl24ppVGHtgrUD2GDiMdPYkjo4CuD/bviRzrNV
3+IbBOjusGycgXp4GJ735h+eq9HMBSqoaQLeMY6BPj9jbzwAfV3IyPbHSRAHE/ii
VzGG0iBPkWJ0P7+y1iuZAzZPv1Cd/k8+dXzxnsap9D3JvfKCvI/uUrQV5FCtJ7Fl
txdz7QeDI/TFEcov63wLVZoVJMTNkmdujKkagmrwtokdDMBGwb8gQX+RJI7GIFje
Mpc+ZjLNzs5NpsVfRRH9h6lks5Sk8u2cNv9lzf0UnnPYYKXie0gtIwspniQi/naR
TYTZh/Hy91tS88lH16DKwgodoSc9EnrU2d9xT0ykcccQg9GyNRo=
=tyf3
-----END PGP SIGNATURE-----

--akPJIWxgBZHniLnc--
