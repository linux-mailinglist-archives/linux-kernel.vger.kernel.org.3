Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A374DB495
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357135AbiCPPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358079AbiCPPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E148DCB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44DEAB81C07
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D9DC36AE5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647443571;
        bh=VE2DXOOKaALNyxqEYAqcoNhJQKuXktb8DsEEEWfPm7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oCX68D9wEM8MvGW4hb57YAovriw4woglHyo8ypN2hogZPfIM1X5BLPhsyEHQrIe/C
         4oZtCtKADSf9WH4hvAIfqOzVjBYeHqxZvFU9UWGE8l+g/bXCQ9dHrKETZScv1VkC/P
         um5J0EsF6Y3zm7N9yXa6S1JWFUlnQa0BDTxRSyHpUqp1TlNkG96k65QCJD/TUPPNEl
         rRVWGzcRlNiId83N21mAe8ABvO/J+fmtjubV2rWW9i2iJS4lKIDFZA+pUsoKq/Ld2Y
         9EYN8PooW9ZNlBjk1I+Zc8mkLDhm/7GTQzt5Y8XV9P5BbJgA0ET5lE0EdZzqTcHb4N
         4HT/BIVJR75Rw==
Received: by mail-ej1-f45.google.com with SMTP id a8so4851808ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:12:51 -0700 (PDT)
X-Gm-Message-State: AOAM532Scr8xeQNqlHP8GeqIBl5KWy/MUY3KDLfQgnLEVI0GLp0VFB2k
        MoJq6cKWsLqo+V960Yf1GR8+r5UdTRLMP2jHMA==
X-Google-Smtp-Source: ABdhPJxH6AKaRwRhd04EuZiQxCRbgcOf0ZjvjbnJCf4qreX1Iy/cGxh/T+kaHO+5f78cTLXQ26lxsW6xxxAaU5Wqgzo=
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id
 o3-20020a170906358300b006d10c07fac0mr312656ejb.749.1647443569882; Wed, 16 Mar
 2022 08:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
 <CAAOTY__59-tYZNAQqFytdZgAYs+hmFxHUrF1FAj4zphiguv12g@mail.gmail.com> <e4b16e67-ccb5-78d1-bbbb-a4a7f82b7c11@collabora.com>
In-Reply-To: <e4b16e67-ccb5-78d1-bbbb-a4a7f82b7c11@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Mar 2022 23:12:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-3zZvu32gWeactYOfDX4i3O6HhPcZp1XHCvAPDZU1a+A@mail.gmail.com>
Message-ID: <CAAOTY_-3zZvu32gWeactYOfDX4i3O6HhPcZp1XHCvAPDZU1a+A@mail.gmail.com>
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B43=E6=9C=8816=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:4=
0=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 25/01/22 17:36, Chun-Kuang Hu ha scritto:
> > Hi, AngeloGioacchino:
> >
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
=E6=96=BC
> > 2022=E5=B9=B41=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=
=889:38=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> There is no need to zero out the newly allocated memory because we are
> >> duplicating all members of struct mtk_plane_state: switch to kmalloc
> >> to save some overhead.
> >
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
>
> Hello,
>
> this series was sent and reviewed two months ago, but it hasn't been pick=
ed
> in any maintainer tree.
>
> This is a friendly ping to not let these two patches to be lost and forgo=
tten.

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Cheers,
> Angelo
