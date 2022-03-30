Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644A4EBB59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiC3HB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbiC3HAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:00:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701DE098D;
        Tue, 29 Mar 2022 23:59:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AB0641F4425E;
        Wed, 30 Mar 2022 07:59:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648623544;
        bh=OO5IhJqrvpl7EnmyLBkThDfuejEHt3zMXYjy+fGmxIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXKi0icpx0gFfmKs73t4gHpVsW/kLu6dbAK3CPpSGaI7pepzLhSOt/p9ZKm+8pnCd
         4m2wmpmbN9zqnAOlbxNn61LDIdPo2q7Gs0D2mUoI8bRlfN1VVECbfZ9kAPHppmu/W5
         UPbaJCSaZ3CPUWUnxTUZi0S3KJIN8xY4aWgeMuiXo0Fg1k+42IAJc54Z5gkOjAY2i7
         IAzbRMl0NfBqYdz1eiu7I34Ay1WwM0QHrXpQH9MN5/3uxHBAvCkI4qJmZtTIbG3+Ks
         HwyCRSka8rjUhhfPqVWsPxsYPf5Ea0JiEVTvVclqqVtXXwKCk/gl2APbGHgCqqRGE/
         ZwEtfEhF18/sA==
Date:   Wed, 30 Mar 2022 08:59:01 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 18/24] media: rkvdec: h264: Fix bit depth wrap in pps
 packet
Message-ID: <20220330065901.q6vodbqpes5hqr4y@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-19-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-19-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>From: Jonas Karlman <jonas@kwiboo.se>
>
>The luma and chroma bit depth fields in the pps packet is 3 bits wide.

s/is 3 bits wide/are 3 bits wide/

>8 is wrongly added to the bit depth value written to these 3-bit fields.

s/bit depth value/bit depth values/

(as we talk about multiple different values)

>Because only the 3 LSB is written the hardware is configured correctly.

s/Because only the 3 LSB is written the hardware is configured correctly./
   Because only the three least significant bits are written, the hardware will be configured correctly./

(original sentence is very hard to read, the sentence could also mean
something like this:
'Because only the three least significant bits, that are written to the hardware, are configured correctly.')

>
>Correct this by not adding 8 to the luma and chroma bit depth value.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/staging/media/rkvdec/rkvdec-h264.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>index 847b8957dad3..ec52b195bbd7 100644
>--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>@@ -662,8 +662,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
> 	WRITE_PPS(0xff, PROFILE_IDC);
> 	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
> 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
>-	WRITE_PPS(sps->bit_depth_luma_minus8 + 8, BIT_DEPTH_LUMA);
>-	WRITE_PPS(sps->bit_depth_chroma_minus8 + 8, BIT_DEPTH_CHROMA);
>+	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
>+	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
> 	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
> 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
> 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
>-- 
>2.34.1
>
