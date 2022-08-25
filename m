Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC175A1A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiHYUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiHYUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:33:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE8A6AE8;
        Thu, 25 Aug 2022 13:33:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s23so10754212wmj.4;
        Thu, 25 Aug 2022 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qVqkkNnf4SASPkgKSjn2GG1shVqF3TWmPJPS8FLXE3I=;
        b=gbr/XcfRW4/g0YwuvJN8eIeMGEpDvRnLXU4M0ltlr36lQlhVjhEpEQ4KTnDurtaN4O
         cmBGpATpwU8rU88mI1DN6YaK3l0BJ2mzyKsaRD0npSylctOnqFCqk171t3zniI/qIvRv
         zS7/eZdHgAM+6FuLuxcLD/wejbAY3PxgCycwMZu42It3h7TZKe7YvnApYlP0+ox3B7l9
         4356e0je1uRA+n5XAfZvswom2ijbgNG9mBOvsQ6VsSn1ruI2P8c7qCgmAj+Yk8Zl9I8T
         8fxPom+kgbvKMiI1xm18KoF59MMrNlXiwvWSWzODSeDm+HEJnYM+GsNVsvnjU62KNuE3
         wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qVqkkNnf4SASPkgKSjn2GG1shVqF3TWmPJPS8FLXE3I=;
        b=PwPHjX3pRxP5ce+Cuh6ZDfrNpowDTgyYcZ4oE065ts46zfdTXtQGlmKKaJnLwOPypq
         XD3cQYRJgJDj79MackIvx8xGY8PbjwD6SpCBB8ZxyhcSGqGEtC0g5tR1S+OMz6xaCEKv
         JmLtOoAzfSwVJsMqcOujEmkb7WPxkPfhnI8t6iimCqoZfymVew0RUY8fSMTbU8YiUdLi
         n6OJlEreNgdIdAvD6xjqDeI7gV+j3Zxvk643tPNoAGSUpfDH/YWa/EIofhgXDWTDiAm9
         lU8IGXXb9Qfa14oleezolt81jtCqvMgb+e3GUby2c/AFDic7WfvcEI3mNeifZ/ZUwloL
         Yyjg==
X-Gm-Message-State: ACgBeo3PJfdyyoC7AWmefHlqhcqbu2XNDcJgjQMdnWA5RYYlppJBd93W
        MxhKhgImAkmziAh2EI94ZTQ4zBaubgyRWA==
X-Google-Smtp-Source: AA6agR5Ynz7Rmm7gcdFxsN3lveFtTF3/kHvW9oN+UTgyFfVQkQRjOaoG2/21rmBBvay2fnTa8CJoVw==
X-Received: by 2002:a05:600c:3d90:b0:3a6:161b:4d77 with SMTP id bi16-20020a05600c3d9000b003a6161b4d77mr9089022wmb.87.1661459629000;
        Thu, 25 Aug 2022 13:33:49 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003a5c75bd36fsm7363625wmg.10.2022.08.25.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:33:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/7] media: sunxi: Add a Kconfig dependencies on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 22:33:47 +0200
Message-ID: <4420213.LvFx2qVVIh@kista>
In-Reply-To: <20220825102035.419087-1-paul.kocialkowski@bootlin.com>
References: <20220825102035.419087-1-paul.kocialkowski@bootlin.com>
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

Dne =C4=8Detrtek, 25. avgust 2022 ob 12:20:28 CEST je Paul Kocialkowski nap=
isal(a):
> Changes since v1:
> - Added collected tag;
> - Added cedrus to the list of drivers to fix;
> - Added fixes tags on all commits as requested.
>=20
> Paul Kocialkowski (7):
>   media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
>   media: sun8i-a83t-mipi-csi2: Add a Kconfig dependency on
>     RESET_CONTROLLER
>   media: sun6i-csi: Add a Kconfig dependency on RESET_CONTROLLER
>   media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
>   media: sun8i-di: Add a Kconfig dependency on RESET_CONTROLLER
>   media: sun8i-rotate: Add a Kconfig dependency on RESET_CONTROLLER
>   media: cedrus: Add a Kconfig dependency on RESET_CONTROLLER

Looks good. Whole series is:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
>  drivers/media/platform/sunxi/sun4i-csi/Kconfig            | 2 +-
>  drivers/media/platform/sunxi/sun6i-csi/Kconfig            | 2 +-
>  drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig      | 2 +-
>  drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig | 2 +-
>  drivers/media/platform/sunxi/sun8i-di/Kconfig             | 2 +-
>  drivers/media/platform/sunxi/sun8i-rotate/Kconfig         | 2 +-
>  drivers/staging/media/sunxi/cedrus/Kconfig                | 1 +
>  7 files changed, 7 insertions(+), 6 deletions(-)
>=20
> --
> 2.37.1


