Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D205A19D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiHYTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbiHYTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:48:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9B753AD;
        Thu, 25 Aug 2022 12:48:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n17so1278570wrm.4;
        Thu, 25 Aug 2022 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EEQaOMPMio1TV/1T2nsXijwtVuTW2Re2GSl+fTHb2hE=;
        b=EOSwTGoA0nee7KFDbY0hqShMabo5lvAZLhzj+GVpXhf++Nzj9OmUn1OmWPoyWldHhh
         dbnv+/P4Q5eGuNwR8TRpA5vnA71y/Ce1/+KcGBQ6tdxjU8neWPGCvfemSOgYsxBw8wWD
         /r9CrCVNubmy7oRWc7HuFASont4/bo0USnvpHoPD4sH8l2EyTnNC/e/T0T/K21K+q93v
         ZgCFsmmoNiygJD27wzIH2Y0gk2krAVmjCcEsgBCs8+912zcjpv5PrvliOdMBJuwshUXM
         5AuVZDl8hY1dUgNxix/rwOXM95rTapj4RVl6B2/HXjH88mM8Vf/D4YhYMVe3E0VrWWyE
         q9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EEQaOMPMio1TV/1T2nsXijwtVuTW2Re2GSl+fTHb2hE=;
        b=j+pyGv0GL5IDSommsaBkXxuF6HWewVQJ/l01KChEAqZsxaucuJ/vgntbGyt+gum0Jf
         KRsIxpi6nCst9okm+ZbiNov6kCaguQKPKwxp3QIHG/fTZ7DZKlFQpb77R7NKnqzN8nMT
         5LFxbmN0ijwaupvtpf/Cbld4wYrucKisyyUXB93jPPOKM0uw4KvZPqXJIgltUZ8vljfQ
         h6GMkjGqzLrfvruOf1qHCgTznojjRrk9zMcX2XEm9SjIX+VLbLE/BTPJdVcLmz0zVBcd
         bujz55uFW3ck7zd++uNsZy74x4MV5j9KqkkFIEwcJkFrSlto6RQI2YnVVg9fXawrna2i
         Ry0Q==
X-Gm-Message-State: ACgBeo2cgwnl5/FdXOefNGxUBj2+AS18NOaq8VPcBdDXsNGz7KyQgc9s
        Nr6PVJwMkfpX80QN04aEdVY=
X-Google-Smtp-Source: AA6agR6a+jB85i972kXbhLkKKpllW7496fpWqVVpOsWOvIO65uvf0tz0QQyG4Bto1DkO00QbeWBtGA==
X-Received: by 2002:a5d:514d:0:b0:225:3507:79e6 with SMTP id u13-20020a5d514d000000b00225350779e6mr3063920wrt.85.1661456935527;
        Thu, 25 Aug 2022 12:48:55 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d4dc5000000b002235eb9d200sm120536wru.10.2022.08.25.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:48:54 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, Stefan Hansson <newbie13xd@gmail.com>
Cc:     Stefan Hansson <newbie13xd@gmail.com>
Subject: Re: [RESEND PATCH] ARM: configs: replace CONFIG_NO_HZ=y with CONFIG_NO_HZ_IDLE=y
Date:   Thu, 25 Aug 2022 21:48:52 +0200
Message-ID: <2642863.mvXUDI8C0e@kista>
In-Reply-To: <20220825162034.5901-1-newbie13xd@gmail.com>
References: <20220825162034.5901-1-newbie13xd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 25. avgust 2022 ob 18:20:35 CEST je Stefan Hansson napisa=
l(a):
> According to https://www.kernel.org/doc/html/latest/timers/no_hz.html,
> CONFIG_NO_HZ=3Dy should be replaced by CONFIG_NO_HZ_IDLE=3Dy for newer
> kernels, so let's reflect that in the 32-bit ARM defconfigs.
>=20
> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # Samsung
> ---
>  arch/arm/configs/bcm2835_defconfig       | 2 +-
>  arch/arm/configs/cm_x300_defconfig       | 2 +-
>  arch/arm/configs/davinci_all_defconfig   | 2 +-
>  arch/arm/configs/dove_defconfig          | 2 +-
>  arch/arm/configs/exynos_defconfig        | 2 +-
>  arch/arm/configs/ezx_defconfig           | 2 +-
>  arch/arm/configs/hisi_defconfig          | 2 +-
>  arch/arm/configs/imx_v4_v5_defconfig     | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig     | 2 +-
>  arch/arm/configs/integrator_defconfig    | 2 +-
>  arch/arm/configs/lpc32xx_defconfig       | 2 +-
>  arch/arm/configs/magician_defconfig      | 2 +-
>  arch/arm/configs/milbeaut_m10v_defconfig | 2 +-
>  arch/arm/configs/moxart_defconfig        | 2 +-
>  arch/arm/configs/multi_v5_defconfig      | 2 +-
>  arch/arm/configs/multi_v7_defconfig      | 2 +-
>  arch/arm/configs/mv78xx0_defconfig       | 2 +-
>  arch/arm/configs/mvebu_v5_defconfig      | 2 +-
>  arch/arm/configs/mxs_defconfig           | 2 +-
>  arch/arm/configs/omap1_defconfig         | 2 +-
>  arch/arm/configs/omap2plus_defconfig     | 2 +-
>  arch/arm/configs/orion5x_defconfig       | 2 +-
>  arch/arm/configs/oxnas_v6_defconfig      | 2 +-
>  arch/arm/configs/pcm027_defconfig        | 2 +-
>  arch/arm/configs/pxa168_defconfig        | 2 +-
>  arch/arm/configs/pxa910_defconfig        | 2 +-
>  arch/arm/configs/pxa_defconfig           | 2 +-
>  arch/arm/configs/qcom_defconfig          | 2 +-
>  arch/arm/configs/s5pv210_defconfig       | 2 +-
>  arch/arm/configs/shmobile_defconfig      | 2 +-
>  arch/arm/configs/sunxi_defconfig         | 2 +-

=46or sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm/configs/tegra_defconfig         | 2 +-
>  arch/arm/configs/vt8500_v6_v7_defconfig  | 2 +-
>  arch/arm/configs/xcep_defconfig          | 2 +-
>  34 files changed, 34 insertions(+), 34 deletions(-)



