Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD503508318
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbiDTIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376433AbiDTIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:05:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9603C4B2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:02:33 -0700 (PDT)
X-UUID: 570eca2f66e644ad9aad45a2d6a723d6-20220420
X-UUID: 570eca2f66e644ad9aad45a2d6a723d6-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 633776647; Wed, 20 Apr 2022 16:02:25 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 16:02:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 16:02:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 16:02:23 +0800
Message-ID: <2fb273bc4ba8a7571d00da1d7bbea1e8d731b84f.camel@mediatek.com>
Subject: Re: [RESEND PATCH] soc: mediatek: cmdq: Use mailbox rx_callback
 instead of cmdq_task_cb
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <roy-cw.yeh@mediatek.com>, <moudy.ho@mediatek.com>,
        <nancy.lin@medaitek.com>, <singo.chang@mediatek.com>
Date:   Wed, 20 Apr 2022 16:02:23 +0800
In-Reply-To: <1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org>
References: <1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Reviewed-by: jason-jh.lin <jason-jh.lin@mediatek.com>
and
Tested-by: jason-jh.lin <jason-jh.lin@mediatek.com>


Hi Roy, Moudy,

Please aware of this modification for MDP on-going patch.

You can refer to this patch on DRM:

https://patchwork.kernel.org/project/linux-mediatek/patch/20211028101912.4624-2-jason-jh.lin@mediatek.com/


Thanks.

Regard,
Jason-JH.Lin

On Sat, 2022-04-16 at 17:54 +0800, Chun-Kuang Hu wrote:
> rx_callback is a standard mailbox callback mechanism and could cover
> the
> function of proprietary cmdq_task_cb, so use the standard one instead
> of
> the proprietary one. Client has changed to use the standard callback
> machanism and sync dma buffer in client driver, so remove the
> proprietary
> callback in cmdq helper.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +-----------------------
> -
>  include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
>  2 files changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c
> b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 3c8e421..c1837a4 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_finalize);
>  
> -static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> -{
> -	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
> -	struct cmdq_task_cb *cb = &pkt->cb;
> -	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> -
> -	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> -				pkt->cmd_buf_size, DMA_TO_DEVICE);
> -	if (cb->cb) {
> -		data.data = cb->data;
> -		cb->cb(data);
> -	}
> -}
> -
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb
> cb,
> -			 void *data)
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
>  {
>  	int err;
>  	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>  
> -	pkt->cb.cb = cb;
> -	pkt->cb.data = data;
> -	pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
> -	pkt->async_cb.data = pkt;
> -
> -	dma_sync_single_for_device(client->chan->mbox->dev, pkt-
> >pa_base,
> -				   pkt->cmd_buf_size, DMA_TO_DEVICE);
> -
>  	err = mbox_send_message(client->chan, pkt);
>  	if (err < 0)
>  		return err;
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h
> b/include/linux/soc/mediatek/mtk-cmdq.h
> index ac6b5f3..2b498f4 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute
> the CMDQ
>   *                          packet and call back at the end of done
> packet
>   * @pkt:	the CMDQ packet
> - * @cb:		called at the end of done packet
> - * @data:	this data will pass back to cb
>   *
>   * Return: 0 for success; else the error code is returned
>   *
> @@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>   * at the end of done packet. Note that this is an ASYNC function.
> When the
>   * function returned, it may or may not be finished.
>   */
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb
> cb,
> -			 void *data);
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
>  
>  #endif	/* __MTK_CMDQ_H__ */
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

