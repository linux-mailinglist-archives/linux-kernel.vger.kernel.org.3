Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70078475C65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbhLOPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbhLOPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:55:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB285C06173E;
        Wed, 15 Dec 2021 07:55:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a18so39013817wrn.6;
        Wed, 15 Dec 2021 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R67lTnWwXbUTzFzCGUUL+WExD12deXb0Qh98T1uTW0w=;
        b=OhHVBsH+JSjXGRjWW3dS71NC/5sbYxFPZeF0Q4crce9RPU1G+fwh5oGbAJmZOtYSDn
         yjuE+M/vGo+HcrEQy22dlJU89eYUIQKX9sy91E3wHpbdRpvBDG7E9pqh+KnpWWxUSq9v
         PNF4kbB9qDszar6MdLFK6vUT3qHSmSkZinyZ9tTuRpB9k8dn911giQKHsHtqs8Ub7qfH
         d+kpMd6Mn09M8+dSrQ6c/fZrNlAwgj2PLcnx4Skskb/YzyUvtGrwTTyqbbEG/OT3HkPf
         3zJ8bhxulq+9LmiMbMGftBQwPezCtnNWvi9+c4T4qCyJR3jP+j7uHUtw5ctkZOex5L9X
         70hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R67lTnWwXbUTzFzCGUUL+WExD12deXb0Qh98T1uTW0w=;
        b=sHHcAsmUjlzPDcQmpUcHYEWzDHwclvEfs/QMK4iRWxkeFCQLhMnd1hSl1pZMh8AdR2
         YIyxH57lgz0pVB2uTGAsHgo2ihxGo9EClg6HyXl2xzPMUJcBd528Znr0OzSHg4pToYeX
         uuQjuGDDQ/Wz0bqeiNbhQAiVOTOohfEpLbnnVx32YT3Q/txiVzXRykczoYfjVyBuZA4A
         dIWfBUqbc8XRjntCVQx6Nx5qwnRULtZ3jF/bKQmy8fffjJFJ+/vSXjjVKtc3uEqNqBHP
         EtRXxf/x+SdSMKnY3h9FDEsIZ94nwSAlEFakeB6oPE2+HeMDVZBYuIkz/Q1i3XxBzd4N
         8ctA==
X-Gm-Message-State: AOAM533EILDOO9SFdZxZP07B661BqVHsly5rnNjGK/7/BZsEOUR4MQHy
        yZ6KtbUR4syzhdnLBo1RNh0=
X-Google-Smtp-Source: ABdhPJxHztDvenoHWfBqOVDnmyiUgaQWSSLPpt6XX3/VYHhw8RSChI7rhoZIlA+1HRtQtKu2hou5Tg==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr5000272wri.631.1639583737576;
        Wed, 15 Dec 2021 07:55:37 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id n7sm2363354wro.68.2021.12.15.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:55:36 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:55:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v16 00/40] NVIDIA Tegra power management patches for 5.17
Message-ID: <YboP9IFMUrUnEzrU@orome>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HWWUr3zWZyjxMtnU"
Content-Disposition: inline
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HWWUr3zWZyjxMtnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 02:23:07AM +0300, Dmitry Osipenko wrote:
> This series adds runtime PM support to Tegra drivers and enables core
> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
>=20
> All patches in this series are interdependent and should go via Tegra tree
> for simplicity.

So these can be applied in any order without breaking anything?

Thierry

--HWWUr3zWZyjxMtnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6D/QACgkQ3SOs138+
s6HzZw//SGRlSbxYGcf2puc+SV4jxqHgVmBVp8biQjzJoeSIatV6B+8n7NAvS0x/
qMBw7S5I7uFy8rqsIUHNQI929PW2XNbz2H8qid5UjtDVlUo5ir1qtVgvH8HYQruX
l+PlVayuhBblIEemscYhMNeuyKgrAMeho9ZnnJjITvMVBKRGOxGp38RUgf+Tzrpc
lF7KIxOcm9FoYTeLxAiVFKtI6Evkt+xJbEvqxkIpaNAzo/AvX6ognGeUQCg7USWu
v2Km4gqjV0bvZUi+HlMPnYGAFpt3X9ws5NCR5ED4huHislttMacNlkfWGpHw/KkU
/VJlYrSnlpJkppzOio+g91qdXXlTfXpa3g5ZHSOLqsNFOPFppN9PU9K2DhwFN3Ej
mNIVbs8Oarq/bJdCftc6dX9saiL9AdKCD1MJO+XgsJuHtQ4FkJHnxMk/p8m9KH33
HurZ3qmVir9YQh9kyE3MVT95o3gSR+M6hpPcSDiCf4g9XjwvEfJ+sDSg7B8lmM+0
ZYOmkLu0iLKGOLOn/gBU9Z/Zw9Kw2iW2J/glHU4E5/GI2MNgs99GQPOwyFEq6AvQ
B4V/SN10i1F0RzeuqsFacfr25c9UGwcXUDNxJqebib27ZRhcGkwu53tEBqYWXep9
7MAMtQ8il969lajf/1tAlUVPR6AXLiuGcKgZZTEcDUReMvR4Dqk=
=drq6
-----END PGP SIGNATURE-----

--HWWUr3zWZyjxMtnU--
