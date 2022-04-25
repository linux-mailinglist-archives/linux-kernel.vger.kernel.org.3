Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF14550E1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiDYNgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiDYNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86711CE6;
        Mon, 25 Apr 2022 06:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B768B817CF;
        Mon, 25 Apr 2022 13:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE98BC385AD;
        Mon, 25 Apr 2022 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650893588;
        bh=uUdOOm568rK7RuFDvgybG0cdg/NEgZ8We82vdTXHL6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6ZT7zsiyniAqHXRoBvDeDPxJOkZwjC+Q1PCXuiwmT8/CtHtG/GHhswgENI6vpZsn
         Qo2hYa2v+Py4v0x0F6IBIgzffhoyoge8PrOA8wURB/9SSjQvCht9F8mTlEehD5ziut
         f3wujf23LkadumwIApsgIWQv5VTnw8cHumTpJvtsjOi/ie3fHk3gcLMFPqgn2X8QeK
         smskJHjQ78Rm4NsPAsDfFlyJDiXAaA/jafPThy/zgo3pq6/S2Ifm2nfhFS2P7C6UyG
         tw5AOd6pUdIu65wMVXaSeC7GkOj/v4ezjZ0LZfSoawAxpG7dUMcScJi8G5TbxLb8rB
         jMiIxRqaxc9EA==
Received: by mail-yb1-f174.google.com with SMTP id h7so3706146ybj.1;
        Mon, 25 Apr 2022 06:33:08 -0700 (PDT)
X-Gm-Message-State: AOAM530SVyQw+20D7kY6LN/nW3/ZQyhvio1wHV8oUUjypwtAHz++rTuk
        lq0+OqtAp+jWm5XJciqQhBjz7vYlhkMoN3pMbg==
X-Google-Smtp-Source: ABdhPJx1LinCS1pOqWEkgprmbR0KqvlB+UwCup/pn2fKM40C2TTP+BRtcH8NDydUzPiPForDxp/bLl8r9BLHa4F/ckY=
X-Received: by 2002:a25:c604:0:b0:645:d969:97a7 with SMTP id
 k4-20020a25c604000000b00645d96997a7mr12121163ybf.134.1650893587786; Mon, 25
 Apr 2022 06:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220416020749.29010-1-nancy.lin@mediatek.com>
 <20220416020749.29010-12-nancy.lin@mediatek.com> <2cd07faf-e903-e55b-85c1-ce7a823ddb8b@gmail.com>
In-Reply-To: <2cd07faf-e903-e55b-85c1-ce7a823ddb8b@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 25 Apr 2022 21:32:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8Ei1e+Y==y+e7LoHBH3-SZEiz4M0SSqecRfWVMsLKH3Q@mail.gmail.com>
Message-ID: <CAAOTY_8Ei1e+Y==y+e7LoHBH3-SZEiz4M0SSqecRfWVMsLKH3Q@mail.gmail.com>
Subject: Re: [PATCH v17 11/21] drm/mediatek: add display merge start/stop API
 for cmdq support
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        llvm@lists.linux.dev, singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=88=
22=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 16/04/2022 04:07, Nancy.Lin wrote:
> > Add merge start/stop API for cmdq support. The ovl_adaptor merges
> > are configured with each drm plane update. Need to enable/disable
> > merge with cmdq making sure all the settings taken effect in the
> > same vblank.
> >
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  2 ++
> >   drivers/gpu/drm/mediatek/mtk_disp_merge.c | 20 +++++++++++++++++---
> >   2 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/=
mediatek/mtk_disp_drv.h
> > index 53aa988dde3b..43a412525b75 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > @@ -66,6 +66,8 @@ void mtk_merge_stop(struct device *dev);
> >   void mtk_merge_advance_config(struct device *dev, unsigned int l_w, u=
nsigned int r_w,
> >                             unsigned int h, unsigned int vrefresh, unsi=
gned int bpc,
> >                             struct cmdq_pkt *cmdq_pkt);
> > +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pk=
t);
> > +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt=
);
> >
> >   void mtk_ovl_bgclr_in_on(struct device *dev);
> >   void mtk_ovl_bgclr_in_off(struct device *dev);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/dr=
m/mediatek/mtk_disp_merge.c
> > index 40da0555416d..c0d9b43b2a66 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> > @@ -67,17 +67,31 @@ struct mtk_disp_merge {
> >   };
> >
> >   void mtk_merge_start(struct device *dev)
>
> Probably not my call, but wouldn't it make sense to enhance mtk_merge_sta=
rt to
> pass 'struct cmdq_pkt *cmdq_pkt' directly instead of adding this 'adapter=
'?

In [1], mtk_merge_start() should match the function prototype of
mtk_ddp_comp_funcs.start, so keep the non-cmdq interface.

static const struct mtk_ddp_comp_funcs ddp_merge =3D {
 .clk_enable =3D mtk_merge_clk_enable,
 .clk_disable =3D mtk_merge_clk_disable,
 .start =3D mtk_merge_start,
 .stop =3D mtk_merge_stop,
 .config =3D mtk_merge_config,
};

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2022041909414=
3.9561-5-jason-jh.lin@mediatek.com/

Regards,
Chun-Kuang.

>
> In the end this is up to Chun-Kuang.
>
> Regards,
> Matthias
>
> > +{
> > +     mtk_merge_start_cmdq(dev, NULL);
> > +}
> > +
> > +void mtk_merge_stop(struct device *dev)
> >   {
> >       struct mtk_disp_merge *priv =3D dev_get_drvdata(dev);
> >
> > -     writel(MERGE_EN, priv->regs + DISP_REG_MERGE_CTRL);
> > +     mtk_merge_stop_cmdq(dev, NULL);
> >   }
> >
> > -void mtk_merge_stop(struct device *dev)
> > +void mtk_merge_start_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pk=
t)
> > +{
> > +     struct mtk_disp_merge *priv =3D dev_get_drvdata(dev);
> > +
> > +     mtk_ddp_write(cmdq_pkt, 1, &priv->cmdq_reg, priv->regs,
> > +                   DISP_REG_MERGE_CTRL);
> > +}
> > +
> > +void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt=
)
> >   {
> >       struct mtk_disp_merge *priv =3D dev_get_drvdata(dev);
> >
> > -     writel(0x0, priv->regs + DISP_REG_MERGE_CTRL);
> > +     mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
> > +                   DISP_REG_MERGE_CTRL);
> >   }
> >
> >   static void mtk_merge_fifo_setting(struct mtk_disp_merge *priv,
