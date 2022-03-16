Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A74DAE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbiCPK6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiCPK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:58:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4044615D;
        Wed, 16 Mar 2022 03:57:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B85311F4454D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647428259;
        bh=+B786kmjh9bVhF2dKutVQcJCHSHyfhNNrMNo6Cs2QQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Htic6mUCNGozdobaaT2ZH9DnFUpA3VUjw9aytlaQcKQMsh4mDtjvQ4L8arnYmHveS
         k/QlQjTJS2giW6WpcAi7/mYPOlnQl+BuSG+HnUJVisxaGeicYRfoUmgiMX4yOZ1M1Z
         f1Rag2nzFgD4tLZAjkIY3y0g8VlBZoXLMiX7t2LGQakwVVhZCO4ZHUpqVpKJlnwriN
         rX+trRcxFmD/Q3n3ZQEzHKl/R0xNCbfEKKuYQr5MGGBKH20ULZ4nT5TD353J503tS9
         Iguqwt8793ig+QEiV9BPHBt42E7Q3gscBku2eokd3b9o/61M/IpQbVDT0mYmW+uM9k
         3TfRWAKlbtb4A==
Message-ID: <a06003ae-2dcc-f5a4-3b5c-62db99d18950@collabora.com>
Date:   Wed, 16 Mar 2022 11:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 0/5] MediaTek pinctrl drivers cleanups
Content-Language: en-US
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, wenst@chromium.org
References: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/02/22 12:11, AngeloGioacchino Del Regno ha scritto:
> Hello!
> This series performs some cleanups to the MediaTek pinctrl drivers
> by commonizing some functions (reducing code duplication) hence also
> simplifying the probe mechanism by removing unnecessary per-driver
> probe functions.
> 
> This code was tested against multiple platforms.
> 
> Changes in v2:
> - Patch 2/5: Changed -ENOENT to -ENODEV as per Chen-Yu's suggestion
> - Patch 4/5: Removed unnoticed wrong comment change (Chen-Yu)
> 
> AngeloGioacchino Del Regno (5):
>    pinctrl: mediatek: paris: Unify probe function by using OF match data
>    pinctrl: mediatek: common-v1: Add common probe function
>    pinctrl: mediatek: common-v1: Use common probe function
>    pinctrl: mediatek: common-v1: Commonize spec_pupd callback
>    pinctrl: mediatek: common-v1: Commonize spec_ies_smt_set callback
> 
>   drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 40 ++++--------
>   drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 44 +++----------
>   drivers/pinctrl/mediatek/pinctrl-mt6765.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt6779.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt6797.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 39 +++---------
>   drivers/pinctrl/mediatek/pinctrl-mt8135.c     | 17 ++----
>   drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 40 +++---------
>   drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 29 +++------
>   drivers/pinctrl/mediatek/pinctrl-mt8183.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt8192.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt8195.c     |  9 +--
>   drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 40 +++---------
>   drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 40 +++---------
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 61 ++++++++++++++-----
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 33 +++++++---
>   drivers/pinctrl/mediatek/pinctrl-paris.c      |  9 ++-
>   drivers/pinctrl/mediatek/pinctrl-paris.h      |  3 +-
>   18 files changed, 164 insertions(+), 285 deletions(-)
> 


Hello maintainers,

friendly ping for this series that already got a Reviewed-by tag on all patches :)

Cheers,
Angelo
