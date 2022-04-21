Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81008509BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbiDUJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387326AbiDUJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5622BF6;
        Thu, 21 Apr 2022 02:07:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7D53E1F45276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532075;
        bh=in1WLxPVVCjDPJ4EL6wvt2BCn3AyEU6pduFeta4ETjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HQdr9LBA3nMNCABpEBbccneExg2Kec1Fq6tMeqJer4rYWtm4+7ehM2fqRJdKZNJ+Q
         iJuQ6pvh10ZE9sBEgNzhPJpyQ9QTDbxOUh5b93lw/dQ2WQSBKOB9JheRb4NW3js5Yx
         dTabKGMbcZeMoDMSADtmMmT0X595tYKAjLNODAdW9AJ2ZQTbcEl9J1gBeiPu5Ca+AY
         cY2yEcBahv1rmocxGyqS9CdhvKGUUD7qemBDDhw+4NWUSjuDItUrcZUYZd7Irn6n0H
         fJxUwjhwuVfxzJ2mA4j6HNs7VqTSRkjXzM676lohzitKM5lv24Bjl4Mp8DzRKOfuj9
         nPl68NFt8YcQA==
Message-ID: <801c6a22-1772-2673-1fcf-5cfed54efab1@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 06/12] clk: mediatek: reset: Revise structure to
 control reset register
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-7-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-7-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> Add mtk_clk_rst_desc to input the reset register data, and replace the
> structure "struct mtk_reset" to reset.h, and rename it as
> "mtk_clk_rst_data". We use them to store reset register data and
> store reset controller device.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt2701-eth.c |  8 +++++-
>   drivers/clk/mediatek/clk-mt2701-g3d.c |  8 +++++-
>   drivers/clk/mediatek/clk-mt2701-hif.c |  8 +++++-
>   drivers/clk/mediatek/clk-mt2701.c     | 19 ++++++++++++--
>   drivers/clk/mediatek/clk-mt2712.c     | 19 ++++++++++++--
>   drivers/clk/mediatek/clk-mt7622-eth.c |  8 +++++-
>   drivers/clk/mediatek/clk-mt7622-hif.c | 10 ++++++--
>   drivers/clk/mediatek/clk-mt7622.c     | 19 ++++++++++++--
>   drivers/clk/mediatek/clk-mt7629-eth.c |  8 +++++-
>   drivers/clk/mediatek/clk-mt7629-hif.c | 10 ++++++--
>   drivers/clk/mediatek/clk-mt8135.c     | 19 ++++++++++++--
>   drivers/clk/mediatek/clk-mt8173.c     | 19 ++++++++++++--
>   drivers/clk/mediatek/clk-mt8183.c     |  9 +++++--
>   drivers/clk/mediatek/reset.c          | 36 +++++++++++++--------------
>   drivers/clk/mediatek/reset.h          | 15 ++++++++++-
>   15 files changed, 174 insertions(+), 41 deletions(-)
> 

..snip..

> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 8e42deee80a3..d67c13958458 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -14,25 +14,19 @@
>   
>   #include "clk-mtk.h"
>   
> -struct mtk_reset {
> -	struct regmap *regmap;
> -	int regofs;
> -	struct reset_controller_dev rcdev;
> -};
> -
> -static inline struct mtk_reset *to_rst_data(struct reset_controller_dev *rcdev)
> +static inline struct mtk_clk_rst_data *to_rst_data(struct reset_controller_dev *rcdev)
>   {

to_mtk_clk_rst_data()...
by the way, it's probably better if you introduce this helper here directly,
instead of introducing it in commit 03/12 and changing it entirely in 06/12.

The rest of the code looks good to me, I'm sure that you'll get my R-b in the
next version.

