Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD55546561
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiFJLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiFJLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:19:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653B14ACBB;
        Fri, 10 Jun 2022 04:19:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB978660168F;
        Fri, 10 Jun 2022 12:19:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654859947;
        bh=Ck+aYJKkUbyZ3UmbDm/L1PWoLd3XeECCKHIxgTNarSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XQiNd351At0P50R0TJzHHgKeVENhyQeIDbJ3qjfyPsPUESyv/aO8V4EB7q9WVCdX7
         9uxiYwada4ZenUvSAyDO74A4AZZt+he2ZKDswZBch9Z+TFWAQ0Ym232nsFalFycVwG
         IfK3a/bqGEodtFio4z1xjM8e27J5CtlRYbdBOBvb9qprurjsEVu5WCcT49b+DsZIM5
         k4XtBLlGXdMpjySf5Eb0csLDTj23HQY79jkWZa42kPdv+bL4/6WJKKmVo2UYY6h8JW
         t6o/LzNcPU1YyLqtC5aHnCEl0HHvHt8uHAxCgRbYLhfnHCnHJchMgetLB81HcQf8IJ
         NpTL8QtCXiCuA==
Message-ID: <3228e9af-02a6-5814-b76d-463214cf76e4@collabora.com>
Date:   Fri, 10 Jun 2022 13:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] pinctrl: mediatek: common: add quirk for broken
 set/clr modes
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530123425.689459-1-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220530123425.689459-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/22 14:34, Fabien Parent ha scritto:
> On MT8365, the SET/CLR of the mode is broken and some pin modes won't
> be set correctly. Add a quirk for such SoCs, so that instead of using
> the SET/CLR register use the main R/W register
> to read/update/write the modes.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 46 ++++++++++++-------
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  3 ++
>   2 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index f25b3e09386b..156627d9c552 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -330,23 +330,37 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>   		return -EINVAL;
>   	}
>   

That's not the right way of doing that, unless there are other SoCs that are
actually affected by this issue (and besides, any *new* pinctrl driver should
be using pinctrl-mtk-common-v2, which accounts for this quirk already).

Since MT8365 seems to be the only SoC that is affected by this issue, there's
a spec_pull_set() callback that you can use and you can indeed define your own
function in mt8365-pinctrl.c instead... but this, only if I got it right (and
I think I did, but please recheck!):

In this function, the call to spec_pull_set assigns 'arg' if 'enable == true',
else, MTK_PUPD_SET_R1R0_00...
...for "generic pull config", as stated in a comment in this function, 'arg' will
always be either 0 or 1, so you will get passed either:
     - 1, if pull-enable; or
     - MTK_PUPD_SET_R1R0_00 (100) if pull-disable.

Though, if I got the '1' part wrong, it's still doable because you care only about
one value in your case, so, if you get a MTK_PUPD_SET_R1R0_00, this means that you
have to do pull-disable.

The other args are passed as they are, so that's golden.

Regards,
Angelo
