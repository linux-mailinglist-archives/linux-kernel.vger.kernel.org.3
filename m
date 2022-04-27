Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B746D511B13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiD0Otr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiD0Oto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:49:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBE38DA1;
        Wed, 27 Apr 2022 07:46:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:0:1e3e:2277:ba57:a2c0:4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 58FD21F40898;
        Wed, 27 Apr 2022 15:46:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651070788;
        bh=uPnBJqA7/3gJZoazRFRY0NtvrjeKFWjy3algIjYxiJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb/UkQ70CysqS726R9AKoHGmM2vrUsQj4301/n25YMFbnt8gVDogsJWgBYF0P4N+S
         CtMFfmQJExEjX/w3NGl0Hk+PGJkIsit+NgRt5rKj5/GK19XRjMNpdnuI5UkuNml3m5
         4CC33j4iQ/ONoUKoQL5rkSz+BaYb2B4p5DCqaDD35NAl3lEaL/LfD5FLmLEIluG5q+
         vmpzVa6sfhojxQ55yQ6SpRnYAQNH40HC/oJspHik+EFWgywbsiSE+B4JTcUGoLlVTz
         n5HOzibcc3Rtg/ceBDKRV8PX1Xc/RaW4hDJ88TrzK+nIoPqHCm6IcWM7Arsnk2d1Z5
         kS4ILsXt1lGTw==
Date:   Wed, 27 Apr 2022 16:46:24 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com
Subject: Re: [PATCH] media: hantro: HEVC: Fix tile info buffer value
 computation
Message-ID: <20220427144624.vtbdlczmykflccut@basti-XPS-13-9310>
References: <20220427135517.381959-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220427135517.381959-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benjamin,

On 27.04.2022 15:55, Benjamin Gaignard wrote:
>Use pps->column_width_minus1[j] + 1 as value for the tile info buffer
>instead of pps->column_width_minus1[j + 1].
>The patch fix DBLK_E_VIXS_2, DBLK_F_VIXS_2, DBLK_G_VIXS_2,

s/fix/fixes/

Greetings,
Sebastian

>SAO_B_MediaTek_5, TILES_A_Cisco_2 and TILES_B_Cisco_1 tests in fluster.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>index bb512389c1a5..ffeb2fbeefd2 100644
>--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>@@ -74,7 +74,7 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
> 					no_chroma = 1;
> 				for (j = 0, tmp_w = 0; j < num_tile_cols - 1; j++) {
> 					tmp_w += pps->column_width_minus1[j] + 1;
>-					*p++ = pps->column_width_minus1[j + 1];
>+					*p++ = pps->column_width_minus1[j] + 1;
> 					*p++ = h;
> 					if (i == 0 && h == 1 && ctb_size == 16)
> 						no_chroma = 1;
>-- 
>2.32.0
>
