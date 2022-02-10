Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22984B10C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbiBJOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiBJOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:47:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60710C4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F210B61A78
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5729CC004E1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644504440;
        bh=O3JOfPmpBwP/gmoNJ7OcEd8I9SFz30bb2+bBccRllQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UG557PE0zKLLnOzvvt/XPxcYZtX2VYIeGz3rd+I50f5mCxayksCvm3SOIoREvUKDz
         yeqHjK1VhFBiHZLF+qPoeRhxg1qcRqUrL0klmNDz1o54X3PFsW5nISll9zhmP7nys0
         GzYRGHTit0QS+ZSuiqTvMz3Am3kgREsZaFhKgAuTT0NhojJBjzVEj3Jk7KTxi7FQRI
         xBFrokui8CvRxiAc3RoZcWSvUW5spHTQyYJlknePvkdBSORrdXhPpLYeFozH/0deBD
         N/Z4eElMKAqfBmseWEctG1HPJeeH2gHgsenDcApGh8IxivUeZ9yD4PLelHZpFA1mz6
         XCWVFLLNt6Riw==
Received: by mail-ed1-f44.google.com with SMTP id f17so11405827edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:47:20 -0800 (PST)
X-Gm-Message-State: AOAM53388Ryx5PmBJfswDaI9etGF6nOZhwcBBNTu1aZ+dsU+Qn/0UN5a
        bf2tBsF4szxmTigLA+zMHnBjQCbHQjesYDpjBQ==
X-Google-Smtp-Source: ABdhPJxpwUZeJ0qluZsLz3I68UmvPC5zgdCoTcIEq2Zdeqtnc4dwKsGWjpYJoB+Qs4sdmpTJIWsWCoOUl8JTom8pf4k=
X-Received: by 2002:aa7:c418:: with SMTP id j24mr8683068edq.451.1644504438640;
 Thu, 10 Feb 2022 06:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20220210124638.2330904-1-jstephan@baylibre.com>
In-Reply-To: <20220210124638.2330904-1-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Feb 2022 22:47:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY__gw5GZT3+=R4CiaVX=DTRGTs2vtOvXxV6v+tw7LwnU2g@mail.gmail.com>
Message-ID: <CAAOTY__gw5GZT3+=R4CiaVX=DTRGTs2vtOvXxV6v+tw7LwnU2g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: allow commands to be sent during video mode
To:     Julien STEPHAN <jstephan@baylibre.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Julien STEPHAN <jstephan@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:47=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Mipi dsi panel drivers can use mipi_dsi_dcs_{set,get}_display_brightness(=
)
> to request backlight changes.
>
> This can be done during panel initialization (dsi is in command mode)
> or afterwards (dsi is in Video Mode).
>
> When the DSI is in Video Mode, all commands are rejected.
>
> Detect current DSI mode in mtk_dsi_host_transfer() and switch modes
> temporarily to allow commands to be sent.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Changes in v2:
>   - update commit message to be more descriptive
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 34 ++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 5d90d2eb0019..7d66fdc7f81d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -891,24 +891,34 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>         u8 read_data[16];
>         void *src_addr;
>         u8 irq_flag =3D CMD_DONE_INT_FLAG;
> -
> -       if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
> -               DRM_ERROR("dsi engine is not command mode\n");
> -               return -EINVAL;
> +       u32 dsi_mode;
> +
> +       dsi_mode =3D readl(dsi->regs + DSI_MODE_CTRL);
> +       if (dsi_mode & MODE) {
> +               mtk_dsi_stop(dsi);
> +               if (mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500=
)) {
> +                       recv_cnt =3D -EINVAL;
> +                       goto restore_dsi_mode;
> +               }
>         }
>
>         if (MTK_DSI_HOST_IS_READ(msg->type))
>                 irq_flag |=3D LPRX_RD_RDY_INT_FLAG;
>
> -       if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
> -               return -ETIME;
> +       if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0) {
> +               recv_cnt =3D -ETIME;
> +               goto restore_dsi_mode;
> +       }
>
> -       if (!MTK_DSI_HOST_IS_READ(msg->type))
> -               return 0;
> +       if (!MTK_DSI_HOST_IS_READ(msg->type)) {
> +               recv_cnt =3D 0;
> +               goto restore_dsi_mode;
> +       }
>
>         if (!msg->rx_buf) {
>                 DRM_ERROR("dsi receive buffer size may be NULL\n");
> -               return -EINVAL;
> +               recv_cnt =3D -EINVAL;
> +               goto restore_dsi_mode;
>         }
>
>         for (i =3D 0; i < 16; i++)
> @@ -933,6 +943,12 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi=
_host *host,
>         DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
>                  recv_cnt, *((u8 *)(msg->tx_buf)));
>
> +restore_dsi_mode:
> +       if (dsi_mode & MODE) {
> +               mtk_dsi_set_mode(dsi);
> +               mtk_dsi_start(dsi);
> +       }
> +
>         return recv_cnt;
>  }
>
> --
> 2.35.1
>
