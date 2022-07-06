Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF74568436
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGFJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiGFJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:54:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B22248ED;
        Wed,  6 Jul 2022 02:53:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF779660199B;
        Wed,  6 Jul 2022 10:53:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657101234;
        bh=rrPM2RkTW31xk31VsC6bdTdnculyR3ZfQ48lOmZ9V5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fb+2l5vidgyAGY8OhCcNd87EdHAo2OhyjbVAH1q3Nkj+8qOMGHrmL88J2W9e7/UWx
         3v7k9SU2nBDHgrTjbmGh3A/AtStOFFSdvQf+2oIbuJSxzlcjmKypBcm6ZkVSUM0aG7
         8rq5S4IduoCoUhuLeGMgx8ruXj5ChlVcYM0wWn6RuJZKZwroLp8a46WaftVQzwJAb0
         giPupNRNKIJssSgcW9BOVRp1EbDTtCGV9TdsMFiyT+edCjtpDhK+NgmwvYOY3G/HCg
         2duK7Bia6wBC0by0Z/5nqhmM29AGsjeusHhwaNRwdQSuFNXze/sojl914FsAfFCt8H
         5Ws55Yiq2MEMQ==
Message-ID: <458c06ee-a617-0ebf-c7f6-c731e743c7fb@collabora.com>
Date:   Wed, 6 Jul 2022 11:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/6] media: mediatek: vcodec: Fix 4K decoding support
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20220706082138.2668163-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 10:21, Chen-Yu Tsai ha scritto:
> This is v2 of the mtk-vcodec 4K decoder fixes.
> 
> While testing a backport of recent mtk-vcodec developments on ChromeOS
> v5.10 kernel [1], it was found that 4K decoding support had regressed.
> The decoder was not correctly reporting 4K frame sizes when queried,
> and ChromeOS then determined that the hardware did not support it.
> 
> This turned out to be a mix of different bugs:
> 
> 1. Frame size enumeration on the output side should not depend on the
>     currently set format, or any other derived state. This is fixed in
>     patch 2.
> 
> 2. TRY_FMT on the output side was incorrectly clamping the resolution
>     based on the current maximum values. It should not. Fixed in patch
>     4.
> 
> 3. The default resolution limit was not set according to the default
>     output format determined at runtime, but hard-coded to 1080p. An
>     S_FMT call is needed to override this. The instance resolution limit
>     is rendered useless after patches 3 and 4, and dropped in patch 5.
> 
> Other patches:
> - Patch 1 makes stepwise_fhd constant.
> - Patch 3 drops redundant aligning of default resolution
> - Patch 6 moves framesize inside mtk_video_fmt, making it easier to
>    access and removes a list search that was added in patch 4.
> 
> Changes since v1:
>    - Added patch to const-ify stepwise_fhd, as Nicolas requested.
>    - Dropped old patch 2 (media: mediatek: vcodec: dec: Set default
>      max resolution based on format)
>    - Dropped old patch 4 (media: mediatek: vcodec: dec: Set maximum
>      resolution when S_FMT on output only)
>    - Made max resolution lookup for TRY_FMT return stepwise structure in
>      patch 4, which helps with the last patch that moves framesize
>      stepwise into mtk_video_fmt.
>    - Did some style cleanups in patch 4
> 
> This series is based on next-20220705.
> 
> This was only tested on the backport kernel [1] on MT8195, which is the
> only currently supported SoC that does 4K decoding. Hopefully the folks
> at Collabora can give this a test on their mainline MT8195 integration
> branch.

Cannot spot any regression after fluster tests.

For the whole series:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> 
> Regards
> ChenYu
> 
> [1] https://crrev.com/c/3713491
> 
> Chen-Yu Tsai (6):
>    media: mediatek: vcodec: decoder: Const-ify stepwise_fhd
>    media: mediatek: vcodec: decoder: Fix 4K frame size enumeration
>    media: mediatek: vcodec: decoder: Skip alignment for default
>      resolution
>    media: mediatek: vcodec: decoder: Fix resolution clamping in TRY_FMT
>    media: mediatek: vcodec: decoder: Drop max_{width,height} from
>      mtk_vcodec_ctx
>    media: mediatek: vcodec: decoder: Embed framesize inside mtk_video_fmt
> 
>   .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 54 ++++++++-----------
>   .../mediatek/vcodec/mtk_vcodec_dec_stateful.c | 29 +++-------
>   .../vcodec/mtk_vcodec_dec_stateless.c         | 30 +++++------
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 20 +------
>   4 files changed, 41 insertions(+), 92 deletions(-)
> 


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
