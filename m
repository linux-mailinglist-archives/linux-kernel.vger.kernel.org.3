Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687005AEE2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiIFOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbiIFOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D186B53;
        Tue,  6 Sep 2022 07:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7C061555;
        Tue,  6 Sep 2022 14:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D08C433C1;
        Tue,  6 Sep 2022 14:08:51 +0000 (UTC)
Message-ID: <918ec569-8dde-2b5d-b623-b35eaf9ce11c@xs4all.nl>
Date:   Tue, 6 Sep 2022 16:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V13,0/7] Enable two hardware jpeg encoder for MT8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20220826092956.10340-1-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220826092956.10340-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

On 26/08/2022 11:29, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for multi hardware jpeg encoding, by first
> adding use of_platform_populate to manage each hardware information:
> interrupt, clock, register bases and power. Secondly add encoding
> work queue to deal with the encoding requestsof multi-hardware
> at the same time. Lastly, add output picture reorder function
> interface to eliminate the out of order images.
> 
> This series has been tested with MT8195 Gstreamer.
> Encoding worked for this chip.

When building this I get a sparse warning and a number of kerneldoc
warnings:

sparse: WARNINGS
SPARSE:drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c:401:24: warning: symbol 'mtk_jpegenc_hw_driver' was not declared. Should it be static?

kerneldoc: WARNINGS
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:111: warning: Function parameter or member 'clks' not described in 'mtk_jpegenc_clk'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:111: warning: Function parameter or member 'clk_num' not described in 'mtk_jpegenc_clk'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:173: warning: Function parameter or member 'reg_encbase' not described in 'mtk_jpeg_dev'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:173: warning: Function parameter or member 'enc_hw_dev' not described in 'mtk_jpeg_dev'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:173: warning: Function parameter or member 'is_jpgenc_multihw' not described in 'mtk_jpeg_dev'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:173: warning: Function parameter or member 'enc_hw_wq' not described in 'mtk_jpeg_dev'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:173: warning: Function parameter or member 'enchw_rdy' not described in 'mtk_jpeg_dev'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:238: warning: Function parameter or member 'jpeg_work' not described in 'mtk_jpeg_ctx'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:238: warning: Function parameter or member 'total_frame_num' not described in 'mtk_jpeg_ctx'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:238: warning: Function parameter or member 'dst_done_queue' not described in 'mtk_jpeg_ctx'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:238: warning: Function parameter or member 'done_queue_lock' not described in 'mtk_jpeg_ctx'
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h:238: warning: Function parameter or member 'last_done_frame_num' not described in 'mtk_jpeg_ctx'

Can you fix this in a v14?

Thank you!

	Hans

> 
> Patches 1 Adds jpeg encoder dt-bindings for mt8195
> 
> Patches 2 jpeg encoder builds two module for using Multi-HW,
> export some functions to make them visible by other modules.
> 
> Patches 3 use devm_of_platform_populate to manage multi-hardware.
> 
> Patch 4 add jpeg encoding timeout function to judge hardware timeout.
> 
> Patch 5 add encoding work queue to deal with multi-hardware encoding
> at the same time.
> 
> Patch 6 add output picture reorder function to order images.
> 
> Patch 7 add stop cmd function to deal with EOS operation.
> ---
> This series patches dependent on:
> media_stage tree:
> [1]
> https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4
> 
> patch1 new jpegenc dt-bindings included files
> [2] MM IOMMU binding:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/
> 
> [3] MT8195 power domain:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579
> 
> Changes compared with v12:
> - some modifications for patch v12's review comments.
> 
> Changes compared with v11:
> - some modifications for patch v11's review comments.
> - fix yaml file check errors.
> 
> Changes compared with v10:
> - some modifications for patch v10's review comments.
> - fix Gstreamer test errors.
> 
> Changes compared with v9:
> - some modifications for patch v9's review comments.
> 
> Changes compared with v8:
> - some modifications for patch v8's review comments.
> - add stop cmd function.
> 
> Changes compared with v7:
> - some modifications for patch v6's review comments.
> 
> Changes compared with v6:
> - new yaml file for mt8195 jpeg encoder.
> - some modifications for patch v5's review comments.
> 
> Changes compared with v5:
> - use of_platform_populate to replace component framework to
>   manage multi-hardware in patch 2.
> 
> Changes compared with v4:
> - No change compaered with v4
> 
> Changes compared with v3:
> - Structure patches for consistency, non-backward
>   compatible and do not break any existing functionality
> 
> Changes compared with v2:
> - Split the last two patches into several patches
>   to enhance readability
> - Correct some syntax errors
> - Explain why the component framework is used
> 
> Changes compared with v1:
> - Add jpeg encoder dt-bindings for MT8195
> - Use component framework to manage jpegenc HW
> - Add jpegenc output pic reorder function interface
> 
> kyrie wu (7):
>   dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
>   mtk-jpegenc: export jpeg encoder functions
>   mtk-jpegenc: support jpegenc multi-hardware
>   mtk-jpegenc: add jpegenc timeout func interface
>   mtk-jpegenc: add jpeg encode worker interface
>   mtk-jpegenc: add output pic reorder interface
>   mtk-jpegenc: add stop cmd interface for jpgenc
> 
>  .../media/mediatek,mt8195-jpegenc.yaml        | 147 ++++++++++
>  drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 255 ++++++++++++++---
>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  81 +++++-
>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |   1 +
>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 258 ++++++++++++++++++
>  7 files changed, 715 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 

