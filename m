Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDD483957
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiADAAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiADAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:00:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04252C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:00:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2662F6121D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C138C36AF5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641254448;
        bh=TNarL2hfu8eJEcGtDz9+dQGA77tHSc49VlWpuvPnZ1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eo0d+CTN+FJuwECto80YDNRaqot6AcT3Bxh3XoliN0XewK/BjDNPG0IJYL4In1zX2
         ZiuXIrm8SfnDNb5bMmNkrufSwrLApanTc7G+RtQlJj+rijosScqsTz9SwHvQLSBXLH
         Uk2dcIKVJJ9NX87GoqC7Fk1dxMqCx+VJba42HV6AI1vJXjFU4lvQVgjqt2ZwcStE7+
         kqa9OAjitm67zTlz8D8gCQnFnktwYLenpRFHNNgAfXGWo2DBYmltqnwXYROXpV0GCv
         aJDVh8vm98EBjS7gM2ILCtHb8DmFQJa2VAnhsbnhkpWC6EIBmnjD1bwVJky0e2tOIH
         3XPFll6PKc3YQ==
Received: by mail-ed1-f43.google.com with SMTP id j21so141496962edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 16:00:48 -0800 (PST)
X-Gm-Message-State: AOAM531Rlur/5RQlegNDsf1FrhHjpVLa0qj16bcPr4LXwYT3jp1ivqPd
        Pbj2YBGBifOhl+31Y/Z8jiqV83ye9QsQioaesA==
X-Google-Smtp-Source: ABdhPJyaz7BnlYjQMVi+kdPY5KTdRWwNiolCizpj3tNIG5pA43f+7YnaYUahBNDOYOQUnP476RsDvzNIT9t6xMhhfW8=
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr37211153ejc.48.1641254446823;
 Mon, 03 Jan 2022 16:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20220103054706.8072-1-miles.chen@mediatek.com>
In-Reply-To: <20220103054706.8072-1-miles.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Jan 2022 08:00:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-WX8p=Ba_4JPgnX4Wmh66bNF09RiP5C7+0=7V-ngdsLA@mail.gmail.com>
Message-ID: <CAAOTY_-WX8p=Ba_4JPgnX4Wmh66bNF09RiP5C7+0=7V-ngdsLA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/mediatek: Fix mtk_cec_mask()
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        Zhiqiang Lin <zhiqiang.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miles:

Miles Chen <miles.chen@mediatek.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In current implementation, mtk_cec_mask() writes val into target register
> and ignores the mask. After talking to our hdmi experts, mtk_cec_mask()
> should read a register, clean only mask bits, and update (val | mask) bit=
s
> to the register.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
>
> Cc: Zhiqiang Lin <zhiqiang.lin@mediatek.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>
> ---
>
> Change since v1:
> add Fixes tag
>
> Change since v2:
> add explanation of mtk_cec_mask()
>
> Change since v3:
> change misleading subject and modify the commit message since this is a b=
ug fix patch
>
> ---
>  drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediate=
k/mtk_cec.c
> index e9cef5c0c8f7..cdfa648910b2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -85,7 +85,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned =
int offset,
>         u32 tmp =3D readl(cec->regs + offset) & ~mask;
>
>         tmp |=3D val & mask;
> -       writel(val, cec->regs + offset);
> +       writel(tmp, cec->regs + offset);
>  }
>
>  void mtk_cec_set_hpd_event(struct device *dev,
> --
> 2.18.0
>
