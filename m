Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C494E8BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiC1BsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiC1Br6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:47:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62C4FC4D;
        Sun, 27 Mar 2022 18:46:14 -0700 (PDT)
X-UUID: cc02df59dc6545e4b2e68572709dce71-20220328
X-UUID: cc02df59dc6545e4b2e68572709dce71-20220328
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1747605447; Mon, 28 Mar 2022 09:46:08 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Mar 2022 09:46:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Mar
 2022 09:46:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 09:46:06 +0800
Message-ID: <d5f8ec6f4b35f7db71b0261c9ddbbae9ccce90d4.camel@mediatek.com>
Subject: Re: [PATCH v9 21/22] drm/mediatek: change the aux retries times
 when receiving AUX_DEFER
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>, <airlied@linux.ie>,
        <angelogioacchino.delregno@collabora.com>,
        <chunfeng.yun@mediatek.com>, <chunkuang.hu@kernel.org>,
        <ck.hu@mediatek.com>, <daniel@ffwll.ch>, <deller@gmx.de>,
        <jitao.shi@mediatek.com>, <kishon@ti.com>, <krzk+dt@kernel.org>,
        <maarten.lankhorst@linux.intel.com>, <matthias.bgg@gmail.com>,
        <mripard@kernel.org>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <tzimmermann@suse.de>, <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <markyacoub@google.com>
Date:   Mon, 28 Mar 2022 09:46:06 +0800
In-Reply-To: <20220327223927.20848-22-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
         <20220327223927.20848-22-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 00:39 +0200, Guillaume Ranquet wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> DP 1.4a Section 2.8.7.1.5.6.1:
> A DP Source device shall retry at least seven times upon receiving
> AUX_DEFER before giving up the AUX transaction.
> 
> Aux should retry to send msg whether how many bytes.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
> b/drivers/gpu/drm/mediatek/mtk_dp.c
> index e099491cc6a4..7a197c4a7143 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2016,7 +2016,7 @@ static ssize_t mtk_dp_aux_transfer(struct
> drm_dp_aux *mtk_aux,
>  	bool is_read;
>  	u8 request;
>  	size_t accessed_bytes = 0;
> -	int retry = 3, ret = 0;
> +	int retry, ret = 0;
>  
>  	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
>  
> @@ -2050,14 +2050,21 @@ static ssize_t mtk_dp_aux_transfer(struct
> drm_dp_aux *mtk_aux,
>  	}
>  
>  	if (msg->size == 0) {
> -		ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
> -					     msg->address +
> accessed_bytes,
> -					     msg->buffer +
> accessed_bytes, 0);
> +		retry = 32;
> +		while (retry--) {
> +			ret = mtk_dp_aux_do_transfer(mtk_dp, is_read,
> request,
> +						     msg->address +
> accessed_bytes,
> +						     msg->buffer +
> accessed_bytes, 0);
> +			if (ret == 0)
> +				break;
> +			usleep_range(500, 600);
> +		}
>  	} else {
>  		while (accessed_bytes < msg->size) {
>  			size_t to_access =
>  				min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
>  				      msg->size - accessed_bytes);
> +			retry = 32;
>  			while (retry--) {
>  				ret = mtk_dp_aux_do_transfer(mtk_dp,
>  							     is_read,
> request,
> @@ -2066,7 +2073,7 @@ static ssize_t mtk_dp_aux_transfer(struct
> drm_dp_aux *mtk_aux,
>  							     to_access)
> ;
>  				if (ret == 0)
>  					break;
> -				usleep_range(50, 100);
> +				usleep_range(500, 600);
>  			}
>  			if (!retry || ret) {
>  				drm_info(mtk_dp->drm_dev,

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

