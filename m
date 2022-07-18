Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA7578A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiGRTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiGRTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:07:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC62FFC5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:07:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sz17so23034393ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d1EsRYsrFcVhqYe4UO8ZXO5ahBBHcUfIDb3IMgr66Ww=;
        b=IYWMUEl2BSZV6xQvtzRcNY0qngRJdMFUes9ugI+BerQqsM5fZKdDGB2xwuRKwpfGq8
         iOH4V98s78W5N3OtOhjZDKkpY2QwHX6FdgSZBKT6PFXinZPORQLp9tq+2gNRpFg5t/KZ
         IjM9S8Ao11YOHs3IQOI/YXTezsUT7HHKLdtg2XeZXT3SMcGGNthEveOEtERNLFcC4snx
         QLJ3DC0vqvRyE5/ZTQmD0g7V//AoynVNiyTIubGWBZdjtCpqzQGJkc5EUSxxEfupK0ZJ
         vEpTyEil24KJD1wVCVy+x7hg0CLzJ0Iq4wyUor1ZL9ZvUyBhfbADr+7qUeYRJ4PMt+C0
         mU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d1EsRYsrFcVhqYe4UO8ZXO5ahBBHcUfIDb3IMgr66Ww=;
        b=sMSEUyIqZwxUM+bIb0rCv0NpxKu/ARosYa2YoOoDMrFa7qt1Pw7H/xT7yZq1UJ2/F0
         Know2tUAw0L8NgMo58kkJzregrSNZb0bB4grXlS/7nE9zt3imXgyb8TBy1gukUZ+em/1
         UXWjaeTlym7Hbo/DAvqvrVGCrd6CMKxztE6+C7PHnO5R7fzckAY+E6p60beccmFz+8tJ
         pbO+VesREWs/8P4PaImaLJoeSYud7DGyRuVbdIaq1J6T1R1mSb24UbvcDTPNS8kBJJ9i
         RpETFIJr2P+BROUE7jt8rpEMFrAufCRSxzfjNzJh2hNJQtAzEfm1Mzna5YvOOQd1sr5k
         E7Eg==
X-Gm-Message-State: AJIora8f78NmcwRYfjNF7bDIiR0P7NVteHHl5oRAwivYfIReADLZksZL
        ueHqeFQBWKiKeyYYxD4Gjm8DLSRXTUQuD8RZjD4=
X-Google-Smtp-Source: AGRyM1t9iiOJzTdQ5QsGPH8QnERUgZ9dLU+MGZoKziZttmoPDFnU6cxZsBdgcMSilSHpLxooQdnjL5v0Pm6EmHwzOu4=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr26111910ejc.564.1658171261957; Mon, 18
 Jul 2022 12:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 15:07:30 -0400
Message-ID: <CADnq5_NaOO0MNy=84U9GJboVziAakYNMt_qqWVxm6p2At+rzfg@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> should be written into the control register instead of 0.
>
> Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index f5a29526684d..0a7b1c002822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -339,7 +339,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
>                 tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> -               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);
> +               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], tmp);
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 780a8aa972fe..f57f4a25cf5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -333,7 +333,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
>                 tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> -               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);
> +               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], tmp);
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> --
> 2.36.1
>
