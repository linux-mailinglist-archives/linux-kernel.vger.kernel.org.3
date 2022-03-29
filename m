Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269614EA925
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiC2I1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiC2I1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:27:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440651877CE;
        Tue, 29 Mar 2022 01:25:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD2381F43940;
        Tue, 29 Mar 2022 09:25:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648542328;
        bh=f1D9zZ5QeEl1SNAS+500xZ0sHqyx/I137Xd4Cdi9UwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjRvs4SHnf8vYHOIcgthNvi7ssgTzAe2Y8menEXMXNm3aJfdeJctChd2AMqWelPeu
         7h04Ecsj1yqzvdpIoxXpVUDJa0wZ2ZLtUDfj6XMX1xzeEKbOFw06Do9h+/+iSCWMgj
         rEJISRZMa/1czJKIy9sB+7OSamF40GkC/qTW8ChlDQloiBuJg2e//OpfYpltFo/bJU
         /FjwiR0LKxB094KxXozCe0PzdsJFlCqt8l9/bdZvm8knhtLVRVbEoYEMV2AvFBG/du
         YIZQMUZIT7/fQ+U2PvNvHRq6iGHvVv6k5ruS4ibK966DOuwTgS3hyHZhtsXiun0xkJ
         4KAkyC0fTZ0Zg==
Date:   Tue, 29 Mar 2022 10:25:26 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 01/24] media: h264: Increase reference lists size to 32
Message-ID: <20220329082526.v64tlnmzjlheuxgu@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-2-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-2-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

As mentioned in patch 24 as well:
The patch series doesn't seem to apply on the latest media tree master
branch. Looking at your tree I can see that you have commit: ba2c670a
"media: nxp: Restrict VIDEO_IMX_MIPI_CSIS to ARCH_MXC or COMPILE_TEST
Laurent Pinchart authored 1 week ago "

But the current head of the media tree is: 71e6d0608e4d
"media: platform: Remove unnecessary print function dev_err()
Yang Li authored 13 days ago"

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>This is to accommodate support for field decoding, which splits the top
>and the bottom reference into the reference list.

s/and the bottom reference/and the bottom references/

I think it would be helpful to describe with a bit more detail why field
decoding requires the 32 entry array instead of the 16 entry array.

How about:
"""
In field decoding mode a slice is a sequence of macroblock pairs, where
each pair contains a top and a bottom macroblock. To accommodate for
this mode the reference list must be able contain references for both
top and bottom macroblocks. Double the size of the reference list array
accordingly.
"""

I got the info from the specification at 6.3.

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>---
> drivers/media/v4l2-core/v4l2-h264.c        | 6 +++---
> drivers/staging/media/hantro/hantro_hw.h   | 6 +++---
> drivers/staging/media/rkvdec/rkvdec-h264.c | 6 +++---
> include/media/v4l2-h264.h                  | 8 ++++----
> 4 files changed, 13 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index 0618c6f52214..8d750ee69e74 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -210,7 +210,7 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
>  * v4l2_h264_build_p_ref_list() - Build the P reference list
>  *
>  * @builder: reference list builder context
>- * @reflist: 16 sized array used to store the P reference list. Each entry
>+ * @reflist: 32 sized array used to store the P reference list. Each entry
>  *	     is a v4l2_h264_reference structure
>  *
>  * This functions builds the P reference lists. This procedure is describe in

Oh unrelated to the patch but there is a typo: s/describe/described/

Greetings,
Sebastian

>@@ -233,9 +233,9 @@ EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
>  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
>  *
>  * @builder: reference list builder context
>- * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
>+ * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
>  *		is a v4l2_h264_reference structure
>- * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
>+ * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
>  *		is a v4l2_h264_reference structure
>  *
>  * This functions builds the B0/B1 reference lists. This procedure is described
>diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
>index 2bc6b8f088f5..292aaaabaf24 100644
>--- a/drivers/staging/media/hantro/hantro_hw.h
>+++ b/drivers/staging/media/hantro/hantro_hw.h
>@@ -69,9 +69,9 @@ struct hantro_h264_dec_ctrls {
>  * @b1:		B1 reflist
>  */
> struct hantro_h264_dec_reflists {
>-	struct v4l2_h264_reference p[HANTRO_H264_DPB_SIZE];
>-	struct v4l2_h264_reference b0[HANTRO_H264_DPB_SIZE];
>-	struct v4l2_h264_reference b1[HANTRO_H264_DPB_SIZE];
>+	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
>+	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
>+	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
> };
>
> /**
>diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>index 3c7f3d87fab4..dff89732ddd0 100644
>--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>@@ -100,9 +100,9 @@ struct rkvdec_h264_priv_tbl {
> #define RKVDEC_H264_DPB_SIZE 16
>
> struct rkvdec_h264_reflists {
>-	struct v4l2_h264_reference p[RKVDEC_H264_DPB_SIZE];
>-	struct v4l2_h264_reference b0[RKVDEC_H264_DPB_SIZE];
>-	struct v4l2_h264_reference b1[RKVDEC_H264_DPB_SIZE];
>+	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
>+	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
>+	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
> 	u8 num_valid;
> };
>
>diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
>index ef9a894e3c32..e282fb16ac58 100644
>--- a/include/media/v4l2-h264.h
>+++ b/include/media/v4l2-h264.h
>@@ -37,7 +37,7 @@ struct v4l2_h264_reflist_builder {
> 		u16 longterm : 1;
> 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
> 	s32 cur_pic_order_count;
>-	struct v4l2_h264_reference unordered_reflist[V4L2_H264_NUM_DPB_ENTRIES];
>+	struct v4l2_h264_reference unordered_reflist[V4L2_H264_REF_LIST_LEN];
> 	u8 num_valid;
> };
>
>@@ -51,9 +51,9 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
>  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
>  *
>  * @builder: reference list builder context
>- * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
>+ * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
>  *		is a v4l2_h264_reference structure
>- * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
>+ * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
>  *		is a v4l2_h264_reference structure
>  *
>  * This functions builds the B0/B1 reference lists. This procedure is described
>@@ -70,7 +70,7 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
>  * v4l2_h264_build_p_ref_list() - Build the P reference list
>  *
>  * @builder: reference list builder context
>- * @reflist: 16 sized array used to store the P reference list. Each entry
>+ * @reflist: 32 sized array used to store the P reference list. Each entry
>  *	     is a v4l2_h264_reference structure
>  *
>  * This functions builds the P reference lists. This procedure is describe in
>-- 
>2.34.1
>
