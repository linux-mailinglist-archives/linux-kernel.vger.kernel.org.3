Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F222249B91B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585861AbiAYQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:45:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584097AbiAYQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:37:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BDE0B818FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12369C340F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643128620;
        bh=MqT1/YM8yz57ScwjXyZoESAPskHYwhQ6QYACyXMLxHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=baad0ljDsifAga31C+GMBV2wWKEAMCAn9FJoBa4SbeXnn0Fk6SfWhhMNXe5KOmasI
         y3dIUwXIGEm+wkRuDDZCG/3Xf3SmcGxzSK2ogMmQ5X2N5krIFLDqfcPuqUAHQkbSKc
         OjSYjIJXnoY5ltIuDqB5sXFP0Adle5oOYMNnoSCQGAMBOADLlgrp/AtolHO5kO+cy8
         vEKMX6rqx5VkzWdkI/azoCRN8RmYM/BIrkjg15M5lZ1cirtxQbPxfKD+Cl3arsuZmq
         ypAFaA+gBuRowSOeEA7kLqmgQ16W8VXhVZ5H/CA/9+osg0L2gU6UT5KPxiWBxy94ma
         2T9qN/thp+9KQ==
Received: by mail-ed1-f43.google.com with SMTP id b13so64630315edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:36:59 -0800 (PST)
X-Gm-Message-State: AOAM530MXwWsBrfWo/nZeuBNkF7G6IkdZ086Hb2zlzo33RIHk8umwl4t
        2rAa2hz/z37UdpXw6EvMtCE/F0kPgcj8BjT1Iw==
X-Google-Smtp-Source: ABdhPJxGM+g3Uu2HDqaNpJm+NgUad4fQE8NjbMLaTbNsb2LzJkuECmijFPehPNLukaqDLw10PRHtgG/M/Xr+zx1eZCg=
X-Received: by 2002:a05:6402:1003:: with SMTP id c3mr21574647edu.405.1643128618189;
 Tue, 25 Jan 2022 08:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 Jan 2022 00:36:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY__59-tYZNAQqFytdZgAYs+hmFxHUrF1FAj4zphiguv12g@mail.gmail.com>
Message-ID: <CAAOTY__59-tYZNAQqFytdZgAYs+hmFxHUrF1FAj4zphiguv12g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: mediatek: mtk_drm_plane: Use kmalloc in mtk_plane_duplicate_state
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, AngeloGioacchino:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B41=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:3=
8=E5=AF=AB=E9=81=93=EF=BC=9A
>
> There is no need to zero out the newly allocated memory because we are
> duplicating all members of struct mtk_plane_state: switch to kmalloc
> to save some overhead.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index c74cb94e445e..39cb9a80d976 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -57,7 +57,7 @@ static struct drm_plane_state *mtk_plane_duplicate_stat=
e(struct drm_plane *plane
>         struct mtk_plane_state *old_state =3D to_mtk_plane_state(plane->s=
tate);
>         struct mtk_plane_state *state;
>
> -       state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
>         if (!state)
>                 return NULL;
>
> --
> 2.33.1
>
