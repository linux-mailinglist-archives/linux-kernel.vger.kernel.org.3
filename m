Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD794C28D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiBXKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiBXKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:05:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1F285AAD;
        Thu, 24 Feb 2022 02:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A66361330;
        Thu, 24 Feb 2022 10:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEC3C340E9;
        Thu, 24 Feb 2022 10:04:37 +0000 (UTC)
Message-ID: <c28641a3-4da4-af49-dcc5-ae46d1f52972@xs4all.nl>
Date:   Thu, 24 Feb 2022 11:04:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RESEND,V7,0/6] Enable two hardware jpeg encoder for MT8195
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
References: <1645693637-627-1-git-send-email-kyrie.wu@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1645693637-627-1-git-send-email-kyrie.wu@mediatek.com>
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

Hi Kyrie Wu,

I just noticed that none of your patches ever arrived at the linux-media mailinglist.
And since they never arrived there, then they also won't appear in our patchwork
instance (https://patchwork.linuxtv.org/).

That might explain why your media patches aren't picked up since I rely on patchwork
to keep track of new patches.

I've no idea why they do not arrive, I see nothing wrong with them.

Perhaps you should try to post a simple test email to the mailinglist to see if it
arrives.

Looking for mails from you at lore.kernel.org:

https://lore.kernel.org/linux-media/?q=kyrie.wu

only shows replies *to* you, and not a single email actually *from* you.

Regards,

	Hans

On 2/24/22 10:07, kyrie.wu wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for multi hardware jpeg encoding, by first
> adding use of_platform_populate to manage each hardware information:
> interrupt, clock, register bases and power. Secondly add encoding
> work queue to deal with the encoding requestsof multi-hardware
> at the same time. Lastly, add output picture reorder function
> interface to eliminate the out of order images.
> 
> This series has been tested with both MT8195.
> Encoding worked for this chip.
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
> ---
> Changes compared with v6:
> - new yaml file for mt8195 jpeg encoder.
> - some modifications for patch v5's review comments.
> 
> Changes compared with v5:
> - use of_platform_populate to replace component framework to
> manage multi-hardware in patch 2.
> 
> Changes compared with v4:
> --No change compaered with v4
> 
> Changes compared with v3:
> --Structure patches for consistency, non-backward
>   compatible and do not break any existing functionality
> 
> Changes compared with v2:
> --Split the last two patches into several patches
>   to enhance readability
> --Correct some syntax errors
> --Explain why the component framework is used
> 
> Changes compared with v1:
> --Add jpeg encoder dt-bindings for MT8195
> --Use component framework to manage jpegenc HW
> --Add jpegenc output pic reorder function interface
> 
> kyrie wu (6):
>   dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
>   media: mtk-jpegenc: export jpeg encoder functions
>   media: mtk-jpegenc: manage jpegenc multi-hardware
>   media: mtk-jpegenc: add jpegenc timeout func interface
>   media: mtk-jpegenc: add jpeg encode worker interface
>   media: mtk-jpegenc: add output pic reorder interface
> 
>  .../media/mediatek,mt8195-jpegenc.yaml        | 174 +++++++++++
>  drivers/media/platform/mtk-jpeg/Makefile      |  11 +-
>  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 292 +++++++++++++++---
>  .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  81 ++++-
>  .../media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c |   1 +
>  .../media/platform/mtk-jpeg/mtk_jpeg_dec_hw.h |   3 +-
>  .../media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 261 ++++++++++++++++
>  7 files changed, 769 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 
