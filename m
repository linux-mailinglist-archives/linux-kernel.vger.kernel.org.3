Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF54EBBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiC3HpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbiC3Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:44:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5B4B1DF;
        Wed, 30 Mar 2022 00:42:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9D4621F44389;
        Wed, 30 Mar 2022 08:42:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648626174;
        bh=pIoevYhcg4lXfHAB+gBSklOntW3daq2OPWaaIDxIW6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iq4UZjhSaV+ZYTcSkGHAm9xbaJifda92sZT/0xu0mlaErqEDx8q3PQxXGnLazpxux
         cYxJ0F5vFVwS0NTOWzswdqbTz5Xcg0uUJTgsI1CLRwaXKZ567UbHDi9cVdgKM375nf
         0LkAlezqhGvsdXF+y6a6XwurlLaHoBzC+bADyP00qoc4ba6ZNP4O9S0ctMldo/tEeS
         TDodJrL12LoM5I1OFg4jb3a/mVQ5a9MbM4EBID2itedr3abZRzrpiaVDkeGqGUD3dO
         Z9xhsyqcA0f+fvtn+L2xGODoKGBsgMpFJFhWgnDvM76lUM06dyCOEtxJw4BS4sGmvO
         Pz4S9HYRbGMpw==
Date:   Wed, 30 Mar 2022 09:42:50 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 21/24] media: hantro: Stop using H.264 parameter
 pic_num
Message-ID: <20220330074250.jqyljbr53fgeci6q@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-22-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220328195936.82552-22-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

The term pic_num is now only present in the following files:
```
❯ rg 'pic_num'
staging/media/rkvdec/rkvdec-h264.c
766:	 * Assign an invalid pic_num if DPB entry at that position is inactive.
768:	 * reference picture with pic_num 0, triggering output picture

media/platform/amphion/vpu_windsor.c
485:	u32 pic_num;

media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
97:	unsigned short pic_num;
346:		dst_entry->pic_num = src_entry->pic_num;

media/v4l2-core/v4l2-h264.c
143:	 * but with frame_num (wrapped). As for frame the pic_num and frame_num
306:		/* this is pic_num for frame and frame_num (wrapped) for field,
307:		 * but for frame pic_num is equal to frame_num (wrapped).
```

In v4l2-h264 and rkvdec-h264 it is only present as comment and the term
is not part of the specification.
In vpu_windsor it is actually never used.
And for the mediatek driver the same might apply.
It might be worth it to get rid of that term all together while you are
at it.

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>The hardware expects FrameNumWrap or long_term_frame_idx. Picture
>numbers are per field, and are mostly used during the memory
>management process, which is done in userland. This fixes two
>ITU conformance tests:
>
>  - MR6_BT_B
>  - MR8_BT_B
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian
>---
> drivers/staging/media/hantro/hantro_h264.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
>index 0b4d2491be3b..228629fb3cdf 100644
>--- a/drivers/staging/media/hantro/hantro_h264.c
>+++ b/drivers/staging/media/hantro/hantro_h264.c
>@@ -354,8 +354,6 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
>
> 	if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> 		return 0;
>-	if (dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
>-		return dpb->pic_num;
> 	return dpb->frame_num;
> }
>
>-- 
>2.34.1
>
