Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F79470461
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbhLJPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:48:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59308 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbhLJPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1C6BCE2A72;
        Fri, 10 Dec 2021 15:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C2CC00446;
        Fri, 10 Dec 2021 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639151056;
        bh=U+1FevzHmy0ZqiqdIP2yUZ4w5TY9qcZ0u/4j+FLtE+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GhSaAGP2sxqzy7xVxl/46uNuDQrqLhGwawyIV8ldS0VQsAn6RLmfJjbRmyrpqH4Aq
         i4YVW0sznbgC7VW6WAbpMCk0NyHc3QX/OqwIWmqAbOKJcu2dMsRToY8zXDaDtJgAeb
         /xx6XbVA3TVSJr48y3G2y8Cf4BflDUSWlrP+wEyU7u7Lk/RJQuRDc06pVx5y5hGb4o
         blyexbqvFqrnik9SY7pYbJ+otfQb6MSnhMdzFjjcG4vcy+oNmeajduKlYgtC7+N+Rq
         l6228myrQ4YZqQDBSuxCFu4Ksm9beKJRxvd8QHtSsFlBtZDzPP46BKMGlm37GLqmAn
         idsgwbMepZsUg==
Received: by mail-ed1-f48.google.com with SMTP id y13so30795718edd.13;
        Fri, 10 Dec 2021 07:44:15 -0800 (PST)
X-Gm-Message-State: AOAM530L2+ZelcdwxE/hJj5+1HQ9+7+vyPGjOtyXcX4xQAXZj+Ded78p
        mSPdk2XntYT2K41l580Dw66vnrQ0oYrOcznddw==
X-Google-Smtp-Source: ABdhPJwXCU+Z5NaN2BTHX/zMqkJH+ZZTVToTgcBEJQr6kwb8d7FIu3S+CacUJxCflUZLiBN1DbqE7KciG3vLx8r6e2w=
X-Received: by 2002:a17:906:7955:: with SMTP id l21mr25651980ejo.6.1639151054211;
 Fri, 10 Dec 2021 07:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20211210061138.9943-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20211210061138.9943-1-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 10 Dec 2021 23:44:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-dO9hXaPCEhJymrCDYU-P-wOvS0YLYQ-gyYX1_morteg@mail.gmail.com>
Message-ID: <CAAOTY_-dO9hXaPCEhJymrCDYU-P-wOvS0YLYQ-gyYX1_morteg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: add control_by_sw for mt8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, tzungbi@google.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> To make sure the GCE request signal to SPM is not trigger by
> other HW modules and cause suspend premature wake.
>
> Set 0x7 (the bit 0~2 as 1) to GCE_GCTL_VALUE, to configure the
> request signal control by SW and release the request to SPM.

How does mt8173, mt8183, and mt6779 prevent this? Or these SoCs could
not prevent this?

Regards,
Chun-Kuang.

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index a8845b162dbf..342b91f16e65 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -664,7 +664,7 @@ static const struct gce_plat gce_plat_v5 =3D {
>  static const struct gce_plat gce_plat_v6 =3D {
>         .thread_nr =3D 24,
>         .shift =3D 3,
> -       .control_by_sw =3D false,
> +       .control_by_sw =3D true,
>         .gce_num =3D 2
>  };
>
> --
> 2.18.0
>
