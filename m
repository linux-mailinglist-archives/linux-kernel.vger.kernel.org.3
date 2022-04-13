Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6104FF1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiDMI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiDMI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:29:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84859344DE;
        Wed, 13 Apr 2022 01:27:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A44341F44F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649838441;
        bh=1AfnyPhY9aZhl5MD9PjUjLmG1rmk6J0oAYjA4S+AzeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F3QNXS64YUZpcdCUUIACB3y05+PSICtvWt5z3iXD+vnZ61arDN1ZoTHsaPMJf7WhC
         Enlp0rde9tmn/BTIf3m6Wz10iWUZyGW9Kd+ncw8o0cNS/azixzp7kxg7/2E0TWkQJ5
         3sJV7qO5bRbPXqG1G3Z378kJqCWk1wjoIpuFo4GeKFRMPtEL6/Ue+0PgaH2AHgc2u0
         8MQcpAFB+xpYYm/yNZwyII6HxIFXtRoXpvqNTOCukooSqxlrHKbBUw4D6oRYkHtqwt
         7vSVAIORhb2r0LjG0zPU0pfgOvf877M7pY4OIjY6Cuj/awBPtySiKEEQEEllU2B9EO
         N+I4LehjFqd/w==
Message-ID: <0193f6b6-0019-3080-2615-02225eb4bf3b@collabora.com>
Date:   Wed, 13 Apr 2022 10:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v14 1/6] soc: mediatek: mutex: add common interface to
 accommodate multiple modules operationg MUTEX
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220411072403.24016-1-moudy.ho@mediatek.com>
 <20220411072403.24016-2-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220411072403.24016-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/04/22 09:23, Moudy Ho ha scritto:
> In order to allow multiple modules to operate MUTEX hardware through
> a common interfrace, a flexible index "mtk_mutex_table_index" needs to
> be added to replace original component ID so that like DDP and MDP
> can add their own MUTEX table settings independently.
> 
> In addition, 4 generic interface "mtk_mutex_set_mod", "mtk_mutex_set_sof",
> "mtk_mutex_clear_mod" and "mtk_mutex_clear_sof" have been added, which is
> expected to replace the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp"
> pair originally dedicated to DDP in the future.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Change-Id: I6a2ab74fccf36248165ce4a6b268d82a1177afc9
> ---
>   drivers/soc/mediatek/mtk-mutex.c       | 89 ++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-mutex.h | 21 ++++++
>   2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index aaf8fc1abb43..48a04dce50d5 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -156,6 +156,8 @@ struct mtk_mutex_data {
>   	const unsigned int *mutex_sof;
>   	const unsigned int mutex_mod_reg;
>   	const unsigned int mutex_sof_reg;
> +	const unsigned int *mutex_table_mod;
> +	const unsigned int *mutex_table_sof;
>   	const bool no_clk;
>   };
>   
> @@ -445,6 +447,54 @@ void mtk_mutex_add_comp(struct mtk_mutex *mutex,
>   }
>   EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
>   

Hello Moudy,

Some critical things, and one cleanup.

First of all, the commit title is very long, and it also contains a typo.
I would go for something like
"soc: mediatek: mutex: Add common interface for modules setting".

Also, please remove your internal "Change-Id" tag, this is meaningless on
upstream, hence not applicable here.

Now for the cleanup: I have an idea to make this a bit shorter (and please
feel free to change function names with something more appropriate, if needed):

static int mtk_mutex_write_mod(struct mtk_mutex *mutex,
				enum mtk_mutex_table_index idx,
				bool clear)
{


> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +	unsigned int reg;
> +	unsigned int offset;
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	if (idx < MUTEX_TABLE_IDX_MDP_RDMA0 ||
> +	    idx >= MUTEX_TABLE_IDX_MAX) {
> +		dev_err(mtx->dev, "Not supported MOD table index : %d", idx);
> +		return;

		return -EINVAL;

> +	}
> +
> +	offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
> +				    mutex->id);
> +
> +	reg = readl_relaxed(mtx->regs + offset);

if (clear)
	reg &= ~BIT(mtx->data->mutex_table_mod[idx])
else
	reg |= BIT(mtx->data->mutex_table_mod[idx])

> +	reg |= 1 << mtx->data->mutex_table_mod[idx];
> +	writel_relaxed(reg, mtx->regs + offset);
> +}

int mtk_mutex_set_mod(struct mtk_mutex *mutex,
		      enum mtk_mutex_table_index idx)
{
	return mtk_mutex_write_mod(mutex, idx, false);
}

int mtk_mutex_clear_mod(struct mtk_mutex *mutex,
			enum mtk_mutex_table_index idx)
{
	return mtk_mutex_clear_mod(mutex, idx, true);
}

> +EXPORT_SYMBOL_GPL(mtk_mutex_set_mod);
> +
> +void mtk_mutex_set_sof(struct mtk_mutex *mutex,
> +		       enum mtk_mutex_table_index idx)
> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +	unsigned int sof_id;
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	if (idx < MUTEX_TABLE_IDX_MDP_RDMA0 ||
> +	    idx >= MUTEX_TABLE_IDX_MAX) {
> +		dev_err(mtx->dev, "Not supported SOF table index : %d", idx);
> +		return;
> +	}
> +
> +	sof_id = mtx->data->mutex_table_sof[idx];

... same changes here, except we'd have something like

if (clear)
	val = MUTEX_SOF_SINGLE_MODE;
else
	val = mtx->data->mutex_sof[sof_id];

	writel_relaxed(val, ...etc)

but feel free to give me valid reasons to not use this approach.

In any case, the code looks ok to me.


Regards,
Angelo
