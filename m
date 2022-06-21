Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DA553385
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbiFUNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351706AbiFUNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:23:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC521E2B;
        Tue, 21 Jun 2022 06:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A262B817F2;
        Tue, 21 Jun 2022 13:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7579FC3411C;
        Tue, 21 Jun 2022 13:23:34 +0000 (UTC)
Message-ID: <1cce42c6-98ea-16d0-8167-3c0cf6f5f0af@xs4all.nl>
Date:   Tue, 21 Jun 2022 15:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND V3,0/8] Support multi-hardware jpeg decoder for MT8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220614121004.31616-1-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220614121004.31616-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why resend this series and the v9 series?

There is generally no reason to do so. If you want to remind people that
something has to be reviewed, then just reply to the cover letter asking
for that.

A resend is only needed if the original series didn't make it to
https://patchwork.linuxtv.org/ for some reason.

Regards,

	Hans

On 6/14/22 14:09, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for multi hardware jpeg decoding,
> by first adding use of_platform_populate to manage each hardware
> information: interrupt, clock, register bases and power.
> Secondly add decoding work queue to deal with the decoding requests
> of multi-hardware at the same time. Lastly, add output picture
> reorder function interface to eliminate the out of order images.
> 
> This series has been tested with both MT8195.
> Decoding worked for this chip.
> 
> Patch 1 Adds jpeg decoder dt-bindings for mt8195
> 
> Patches 2 jpeg decoder builds three module for using Multi-HW,
> export some functions to make them visible by other modules.
> 
> Patch 3 use of_platform_populate to manage multi-hardware.
> 
> Patch 4 add jpeg decoding timeout function to judge hardware timeout.
> 
> Patch 5 add decoding work queue to deal with multi-hardware decoding
> at the same time.
> 
> Patch 6 add output picture reorder function to order images.
> 
> Patch 7 refactor jpegdec func interface for HW working.
> 
> Patch 8 add stop cmd function to deal with EOS operation.
> 
> ---
> This series patches dependent on:
> media_stage tree:
> [1]
> https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4
> 
> patch1 new jpegdec dt-bindings included files
> [2] MM IOMMU binding:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/
> 
> [3] MT8195 power domain:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579
> 
> Changes compared with v2:
> - add stop cmd function.
> - some modifications for patch v1's review comments.
> 
> Changes compared with v1:
> - new yaml file for mt8195 jpeg decoder.
> - some modifications for patch v1's review comments.
> 
> kyrie wu (8):
>   dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
>   media: mtk-jpegdec: export jpeg decoder functions
>   media: mtk-jpegdec: manage jpegdec multi-hardware
>   media: mtk-jpegdec: add jpegdec timeout func interface
>   media: mtk-jpegdec: add jpeg decode worker interface
>   media: mtk-jpegdec: add output pic reorder interface
>   media: mtk-jpegdec: refactor jpegdec func interface
>   mtk-jpegdec: add stop cmd interface for jpgdec
> 
>  .../media/mediatek,mt8195-jpegdec.yaml        | 175 ++++++++++
>  drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 244 +++++++++++++-
>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  46 +++
>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 309 ++++++++++++++++--
>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
>  7 files changed, 751 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 
