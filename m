Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199F4BA417
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiBQPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:16:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiBQPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:16:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB22A228B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E0ADB822A4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEB3C340E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645110962;
        bh=ltIrHZ5kE+koRIY5ZxoTB2ezjOerynjz7q6O20tGhjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mN5wEfgIdmp7WvMgItg/375+CzWUq3y/DG1UoUgNxSar3uCXmNRFT1j0ytnIPknj3
         Lvz7VjBLwb41kdBaQFcz30Je3OwD6x6f4Lfm3XVIvrpGH40riEzhRWs0mHPbRIpQ2n
         GPEcLYzKiXl/0uCxgOTVhogzjVZUxJy4JkqF6DcpPwaeNY6s8ykkTpA0tttHxipDP8
         Ix9ZmdMa1PjJBtJCGTQMQ8Ffre1IegmkFirwrDl1LLuTcGOF/nNss45Sm054rEhMSi
         UciSy5cfk+LdIXEzJPi3+yC2nXKJdw0f7+4AfYC+LL/30b5XL+/V+AwRuXmMYX2pac
         VAwRZ/S5cLwrw==
Received: by mail-ej1-f53.google.com with SMTP id qx21so7987568ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:16:01 -0800 (PST)
X-Gm-Message-State: AOAM531v6XjszMtQmtrjPeZAtW4IRc8rMyMJRecD8QtgMeLPmYVOOd6r
        l6MyMmR01Pgr1YRw1o+lH1MPhMOwieqQVsGeGw==
X-Google-Smtp-Source: ABdhPJwWhmmbYUMUpT41cY1OCQWwTtA0ZK/OW2pNlNGzpnqu/sg0IPf8wGGwkq3V2cNbK5F8ACQlP6EYpC31RW+Gb1k=
X-Received: by 2002:a17:906:8143:b0:6cf:73c1:8a0 with SMTP id
 z3-20020a170906814300b006cf73c108a0mr2822909ejw.406.1645110960294; Thu, 17
 Feb 2022 07:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20220214092742.3461587-1-jstephan@baylibre.com> <0a331caa-7578-60f5-cbd8-f6c8c29a629f@collabora.com>
In-Reply-To: <0a331caa-7578-60f5-cbd8-f6c8c29a629f@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 17 Feb 2022 23:15:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_82E2BK1cxwbsDsj5DURrY245Xnd-04N=4vevCRMjkZpw@mail.gmail.com>
Message-ID: <CAAOTY_82E2BK1cxwbsDsj5DURrY245Xnd-04N=4vevCRMjkZpw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/mediatek: allow commands to be sent during video mode
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Julien STEPHAN <jstephan@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [1Hi, Julien:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B42=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:4=
3=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 14/02/22 10:27, Julien STEPHAN ha scritto:
> > Mipi dsi panel drivers can use mipi_dsi_dcs_{set,get}_display_brightnes=
s()
> > to request backlight changes.
> >
> > This can be done during panel initialization (dsi is in command mode)
> > or afterwards (dsi is in Video Mode).
> >
> > When the DSI is in Video Mode, all commands are rejected.
> >
> > Detect current DSI mode in mtk_dsi_host_transfer() and switch modes
> > temporarily to allow commands to be sent.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> >
> > Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
> > Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Please, next time, don't drop the tags that reviewers are giving to you, =
unless
> the patch changes radically.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> > ---
> > Changes in v4:
> >      - fix missing space:  "ret : recv_cnt;"
> > Changes in v3:
> >      - increase readability of code and use correct return variable (se=
e
> >        comment
> > https://lore.kernel.org/linux-mediatek/4907bdc1-b4a6-e9ad-5cfa-266fc20c=
0bec@collabora.com/)
> >
> > Changes in v2:
> >      - update commit message to be more descriptive
> >
> >   drivers/gpu/drm/mediatek/mtk_dsi.c | 33 ++++++++++++++++++++++-------=
-
> >   1 file changed, 24 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 5d90d2eb0019..abdd9cdebd86 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -891,24 +891,33 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_=
dsi_host *host,
> >       u8 read_data[16];
> >       void *src_addr;
> >       u8 irq_flag =3D CMD_DONE_INT_FLAG;
> > +     u32 dsi_mode;
> > +     int ret;
> >
> > -     if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
> > -             DRM_ERROR("dsi engine is not command mode\n");
> > -             return -EINVAL;
> > +     dsi_mode =3D readl(dsi->regs + DSI_MODE_CTRL);
> > +     if (dsi_mode & MODE) {
> > +             mtk_dsi_stop(dsi);
> > +             ret =3D mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG,=
 500);
> > +             if (ret)
> > +                     goto restore_dsi_mode;
> >       }
> >
> >       if (MTK_DSI_HOST_IS_READ(msg->type))
> >               irq_flag |=3D LPRX_RD_RDY_INT_FLAG;
> >
> > -     if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
> > -             return -ETIME;
> > +     ret =3D mtk_dsi_host_send_cmd(dsi, msg, irq_flag);
> > +     if (ret)
> > +             goto restore_dsi_mode;
> >
> > -     if (!MTK_DSI_HOST_IS_READ(msg->type))
> > -             return 0;
> > +     if (!MTK_DSI_HOST_IS_READ(msg->type)) {
> > +             recv_cnt =3D 0;
> > +             goto restore_dsi_mode;
> > +     }
> >
> >       if (!msg->rx_buf) {
> >               DRM_ERROR("dsi receive buffer size may be NULL\n");
> > -             return -EINVAL;
> > +             ret =3D -EINVAL;
> > +             goto restore_dsi_mode;
> >       }
> >
> >       for (i =3D 0; i < 16; i++)
> > @@ -933,7 +942,13 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_d=
si_host *host,
> >       DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
> >                recv_cnt, *((u8 *)(msg->tx_buf)));
> >
> > -     return recv_cnt;
> > +restore_dsi_mode:
> > +     if (dsi_mode & MODE) {
> > +             mtk_dsi_set_mode(dsi);
> > +             mtk_dsi_start(dsi);
> > +     }
> > +
> > +     return ret < 0 ? ret : recv_cnt;
> >   }
> >
> >   static const struct mipi_dsi_host_ops mtk_dsi_ops =3D {
> > --
> > 2.35.1
> >
>
>
>
