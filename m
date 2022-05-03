Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F451846C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiECMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiECMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:41:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CE37ABC;
        Tue,  3 May 2022 05:37:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2979D1F43170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651581460;
        bh=gkpWSmq24BqLq0ZoHGy5upa/fdOzSaEOqF5ZfViHAhc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gcD5AZTNVVRHoiMYbP/G1FZjWnwQhhc6nLBrqFS7Bf7y3MbiBRoAtV3lsk3AWbUFk
         7OYfwUpyYE7/9gTlo8W/Hh2imHGzvA+mkPjYcWqUx93bYrUrLwOzjXwsenQ4v+A6eY
         Nb0NZUhnK+b0SfS4o3slZo4NzHxkiaUvIiVNa4Jpfpnsy64CgbVc24OlejBaMnpZG4
         Y49ZNjspDj2EBh2xcVYEDegFbecRDRx/putCncrHfsab0MajeRh8ys4IVXhpKuVbtS
         bh/FDAh8164B9N4zq3lYnzxsUUMZdO7vxMVWrvl1uYIK9xL/h+rgViViS4XBhY7CoT
         OoUcBIzi3bp/g==
Message-ID: <c3f96188-7e17-d332-6789-175fd0a84411@collabora.com>
Date:   Tue, 3 May 2022 14:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 08/16] clk: mediatek: reset: Support inuput argument
 index mode
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
 <20220503093856.22250-9-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503093856.22250-9-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 11:38, Rex-BC Chen ha scritto:
> There is a large number of mediatek infra reset bits, but we do not use
> all of them. In addition, the proper input argement of reset controller
> soulde be index.
> Therefore, to be compatible with previous drivers and usage, we add
> description variables to store the ids which can mapping to index.
> 
> To use this mode, we need to put the id in rst_idx_map to map from
> index to ids. For example, if we want to input index 1 (this index
> is used to set bank 1 bit 14) for svs, we need to declare the reset
> controller like this:
> 
> In drivers:
> static u16 rst_ofs[] = {
>          0x120, 0x130, 0x140, 0x150, 0x730,
> };
> 
> static u16 rst_idx_map[] = {
>          0 * 32 + 0,
>          1 * 32 + 14,
>          ....
> };
> 
> static const struct mtk_clk_rst_desc clk_rst_desc = {
>          .version = MTK_RST_SET_CLR,
>          .rst_bank_ofs = rst_ofs,
>          .rst_bank_nr = ARRAY_SIZE(rst_ofs),
>          .rst_idx_map = rst_idx_map,
>          .rst_idx_map_nr = ARRAY_SIZE(rst_idx_map),
> };
> 
> In dts:
> svs: {
>          ...
>          resets = <&infra 1>;
>          ...
> };
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

