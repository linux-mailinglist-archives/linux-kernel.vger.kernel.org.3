Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3F4B0384
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiBJCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:43:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiBJCnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:43:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA3B2409A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:43:32 -0800 (PST)
X-UUID: 555a339b79d549fba260c56417648fe2-20220210
X-UUID: 555a339b79d549fba260c56417648fe2-20220210
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 662158609; Thu, 10 Feb 2022 10:43:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 10 Feb 2022 10:43:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Feb 2022 10:43:28 +0800
Message-ID: <f2fffc0a7d60d454f1722585f1352823910c30b3.camel@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: allow commands to be sent during video
 mode
From:   CK Hu <ck.hu@mediatek.com>
To:     Julien STEPHAN <jstephan@baylibre.com>
CC:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Feb 2022 10:43:28 +0800
In-Reply-To: <20220124152250.441809-1-jstephan@baylibre.com>
References: <20220124152250.441809-1-jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

On Mon, 2022-01-24 at 16:22 +0100, Julien STEPHAN wrote:
> When the DSI is in video mode, all commands are rejected.
> 
> Detect current DSI mode in mtk_dsi_host_transfer() and switch modes
> temporarily to allow commands to be sent.

Is this patch a bug-fix or new feature? If this is a bug-fix, add Fixes
tag [1] in this patch. If this is a new feature, describe more about
more about this feature, such as support more panel or something.

[1] 
https://www.kernel.org/doc/html/v5.16/process/submitting-patches.html

Regards,
CK

> 
> Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 34 ++++++++++++++++++++++----
> ----
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 5d90d2eb0019..7d66fdc7f81d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -891,24 +891,34 @@ static ssize_t mtk_dsi_host_transfer(struct
> mipi_dsi_host *host,
>  	u8 read_data[16];
>  	void *src_addr;
>  	u8 irq_flag = CMD_DONE_INT_FLAG;
> -
> -	if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
> -		DRM_ERROR("dsi engine is not command mode\n");
> -		return -EINVAL;
> +	u32 dsi_mode;
> +
> +	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
> +	if (dsi_mode & MODE) {
> +		mtk_dsi_stop(dsi);
> +		if (mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG,
> 500)) {
> +			recv_cnt = -EINVAL;
> +			goto restore_dsi_mode;
> +		}
>  	}
>  
>  	if (MTK_DSI_HOST_IS_READ(msg->type))
>  		irq_flag |= LPRX_RD_RDY_INT_FLAG;
>  
> -	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
> -		return -ETIME;
> +	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0) {
> +		recv_cnt = -ETIME;
> +		goto restore_dsi_mode;
> +	}
>  
> -	if (!MTK_DSI_HOST_IS_READ(msg->type))
> -		return 0;
> +	if (!MTK_DSI_HOST_IS_READ(msg->type)) {
> +		recv_cnt = 0;
> +		goto restore_dsi_mode;
> +	}
>  
>  	if (!msg->rx_buf) {
>  		DRM_ERROR("dsi receive buffer size may be NULL\n");
> -		return -EINVAL;
> +		recv_cnt = -EINVAL;
> +		goto restore_dsi_mode;
>  	}
>  
>  	for (i = 0; i < 16; i++)
> @@ -933,6 +943,12 @@ static ssize_t mtk_dsi_host_transfer(struct
> mipi_dsi_host *host,
>  	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
>  		 recv_cnt, *((u8 *)(msg->tx_buf)));
>  
> +restore_dsi_mode:
> +	if (dsi_mode & MODE) {
> +		mtk_dsi_set_mode(dsi);
> +		mtk_dsi_start(dsi);
> +	}
> +
>  	return recv_cnt;
>  }
>  

