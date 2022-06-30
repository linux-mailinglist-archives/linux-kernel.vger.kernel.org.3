Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E265615ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiF3JQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiF3JPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:15:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C12138D97;
        Thu, 30 Jun 2022 02:15:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so22356034wrh.3;
        Thu, 30 Jun 2022 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qs5w4mXuxTGM+ANX6aO1XbOmipxzruUkk3yjzx/1m5M=;
        b=Nxg1/Tz+7NmXT7PN4DRl96HH/dnYCeyzAmCpGGPJO94V2LQY/Pv9ZvvK+KXVSFyWJG
         LmEffNuq+MGRK6Ln5VbwJQSDeX0pvMljGL2Wo0URtPtHOkocBs4W7eDxv3Wid809cqdw
         wEEcDPnD9Ve0MjXKzX5TEufvyz8DjbHkqJCpxBOlKVLxM99p76zxsb/gk7m7rcI+bICb
         iZ+cbJhluyhfCKjcdoeBlKsfuy5AU4hFNHDiBeGfiXz3EkTEU4vi7dFUEjMWTQjApXVd
         h0yF3DBfiMAVmKMex/PMYCPJ5Z2V2nOXNhJu5tTWJMrUaa/434dvcVTtiZnSduSf+jzQ
         DwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qs5w4mXuxTGM+ANX6aO1XbOmipxzruUkk3yjzx/1m5M=;
        b=t7Fr6M0KK53FKbs2XjFDMdFe9m3BaDnvJbFk/2+djyWNtgwCdoqNmv4gfHCIhLwGUm
         OoKWD+AIxu7RwpGUBA4DXkGzc/RH6ysYyOzGK1niKtxsBbuNiND4e+SeCIxhAkgYfY4h
         VogjAJd+ac2yIUU7LiAeiVRuvelvJYAFtaEBw17JCd0B8cXlgKfiYUC7L+64Afs/QR8m
         J4Qx9DTGtkzmhuDQZevvy/Si6k4rF+v7V8449F0WZ+YQGUJHQu3Z/Xrmb7j+DbDtMPmM
         PMKn2KB0h6CWRsUcc+1fLSyvLvEytxdx0XfwdXA7i+E4X/8DEg5HYMNNk5iKux0UsLNt
         MG7A==
X-Gm-Message-State: AJIora/YuY0A9K2tTNS1KQ4Qy3YPGGFnBtk6U3Zti4heM2x4XwwXH9JI
        98MLPYcEtRXVjyxBJuVVsKg=
X-Google-Smtp-Source: AGRyM1uSdCfWkJvQdIqiusHWM74RinDF4sSDArFlNmspUI7tsygjA00oqo2g1lG7SW6cb7DySb0KMQ==
X-Received: by 2002:a5d:64ae:0:b0:21b:b923:7ad5 with SMTP id m14-20020a5d64ae000000b0021bb9237ad5mr7068522wrp.460.1656580499792;
        Thu, 30 Jun 2022 02:14:59 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m2-20020adffa02000000b0021d163daeb0sm11623695wrr.108.2022.06.30.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:14:58 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:14:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathanh@nvidia.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clocksource/drivers/timer-tegra186: Add support
 for Tegra234 SoC
Message-ID: <Yr1pkVSyL5c2Upot@orome>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-4-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YaXGqWVK0MNVNA+1"
Content-Disposition: inline
In-Reply-To: <1656527344-28861-4-git-send-email-kkartik@nvidia.com>
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


--YaXGqWVK0MNVNA+1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 11:59:01PM +0530, Kartik wrote:
> The timer IP block present on Tegra234 SoC supports watchdog timer
> functionality that can be used to recover from system hangs. The
> watchdog timer uses a timer in the background for countdown.
>=20
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/clocksource/timer-tegra186.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--YaXGqWVK0MNVNA+1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK9aZEACgkQ3SOs138+
s6H2kxAAnVIhlBIvG4c9Owk/ZtFX96RF4Jt9EWdPmTyr/G9sYbZVar+FkfzfE6ug
4fOwrV8YFUx1sRuxvVpd/hRjBKcwMsoGHfFvfh26xaGgsqZRcua7/vNtzKxuGEF4
18mfJ17pJdksMGeUyXwaFz6hfqpNxJjTQ1NV6eCQoQN/tSsvVNtQ1odfvDcI96+K
1GQ/YfTJfl4r4luhl+ba7hXVmEAnUOpgLUrYZ0pjXxAPTa5qRJC1Z+kphzno6v5F
p9I2vgFf4vh7Zxdeu5EreGlkR0KhKmkmFVoYMS9xa+3m1dHFra2850M+gKank0+k
4p0FHWpyngwm1Q/8BTeFaIPZ57van8l3PAcnnRkTd5ZiiiAUfy2wyohSFDE0aDr6
Uhx+ueIxYfT26zOv/iKMd78yvayTQKQnOfqgny5KgbjUwmJMvFqwFjmkt43NVTB7
0LgCvgBasb/ZC5c+iFCFNy+FmXhzdFapGr9gaH+aHpH/sXo4F4SXWPOjbOGD2oJn
QODrlUBFbJoIk4AUnWIt6+QxZPNXpT7MCfuQqAq2rzSLb3c/VukEZ2oYm74DtZL3
VD8pgW8zZtd2Hr73hErbkK/7LhTlUq9/6AffaNOaN9IfARrdJ1HOpddipsdeeyRu
5JEdLy7ugdRbPxDvsTi3yHb4J065d3JcRFrw+vATciL716Y6LyA=
=Ma1N
-----END PGP SIGNATURE-----

--YaXGqWVK0MNVNA+1--
