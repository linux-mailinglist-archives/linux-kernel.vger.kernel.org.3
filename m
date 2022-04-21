Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC55509C28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387374AbiDUJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387351AbiDUJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328A237CD;
        Thu, 21 Apr 2022 02:08:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 80F5D1F45276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532085;
        bh=YZVTLxKtIQxkm9Bp8TdQ6gxbzWomCWXRNzsdT8Q+x30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UI/ILTNaBWxgSMTa97JCIgzZB/HClrk0wDLVsqsfKJNMGSW/rJXknwZswnzZSxtx+
         dzb5K1mqU2HwPSgXioOOKfsXChbk1Hg18kYyn0OIX0U9hrnWca4lJPQLxWr2hzp50Q
         6+j/6gIgGxZKJWe46YEISOVOoLrlieHXpS4whcxiMv2kzpWs2ObyTElqEZC0QQD+fq
         tJhhHmwgIR9ZOopMA/aMybCPoGjwFAigKuIfycAMxrwSsU+j6DFmQOvfs88KJGypBq
         kpvy34atxSbHbtL3ES5wUPvGiAINF25ynJka6YK5i/ljjTatpEMyhARAO+zAHeAf0R
         dwXiBEu5Vm8RA==
Message-ID: <da6fed21-f661-773d-307f-0c7085e3eb9b@collabora.com>
Date:   Thu, 21 Apr 2022 11:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 02/12] clk: mediatek: reset: Use simple reset
 operations
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
 <20220420130527.23200-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-3-rex-bc.chen@mediatek.com>
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
> There are two version for clock reset register control of MediaTek SoCs.
> The reset operations before MT8183 can use simple reset to cover.
> Therefore, we replace mtk_reset_ops with reset_simple_ops.
> In addition, we also rename mtk_register_reset_controller to
> mtk_register_reset_controller_simple.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Hello Rex,
have you tested this? It won't work.

reset-simple is not using regmap, and it requires you to pass a struct
reset_simple_data through drvdata.

Besides, I like that we are using regmap, while reset_simple simply uses
readl/writel... so if you want to use that driver, which is good to reduce
duplication, you should also implement support for regmap in the form of
reset_simple_regmap_ops.

Regards,
Angelo
