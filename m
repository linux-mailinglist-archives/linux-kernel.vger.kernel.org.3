Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175894EAEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiC2N4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiC2Nzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:55:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BF1C7C3B;
        Tue, 29 Mar 2022 06:54:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 244CD1F43F35;
        Tue, 29 Mar 2022 14:54:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648562047;
        bh=8B1qrSJI0pwevUCYKVB5QvEM9Cz4zIGrfiS9YCQ8xWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cjo6B7GBuagdrECvYXJwN4E9sG+lit31ck1eIlwF6q7cHMEtMXpmAIjQ4l7cTHAIW
         hNnpYA2UimzcJtad2wFPaNAU7lP6BehiEuQ4rXVLVGSbJ7Lp1cZJNlLC7Scq7z2SvE
         6vAsgz3twqcVWyI3QEWw0lFuoa0TSZ5cH+t146TedABssSbsUcOqLhXYl2uDUEYuJ1
         UFAaIt8TKHh4+YzbK09VT2yk5MhgVvI5XFNuS/epQuAsJKtnAH/w1WDUA95xyEwmkL
         i6Iaz01DtPOQm0OIEStaWw7JvMwmwaHXgj8shvu3wPHe/dr5+bVV3jmt9OwDVGq1Xv
         pqTOsw8zpHbMg==
Date:   Tue, 29 Mar 2022 15:54:03 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/24] media: v4l2: Reorder field reflist
Message-ID: <20220329135403.37dqfaw5ctxoj3wx@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-9-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-9-nicolas.dufresne@collabora.com>
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
>As per spec, the field refslist requires interleaving top and bottom

In other patches you call it always field reflist, so I'd say let's
stick to that:
s/field refslist/field reflist/

>field in a specific way that does not fit inside the sort operation.
>Reorder in-place the references so that their parity sart with the same
>parity as the current picture and do that for both short and longterm
>references separately.

I find that sentence hard to understand, is this maybe better:

"""
Rearrange the references in place so that their parity matches that of
the current image, and do this separately for both short- and long-term
references.
"""

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/media/v4l2-core/v4l2-h264.c | 45 +++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index c3fad382882d..2f7ee8d5479f 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -243,6 +243,43 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
> 	return poca < pocb ? -1 : 1;
> }
>
>+/*
>+ * The references need to be reorder so that reference are alternating between

s/to be reorder/to be reordered/
s/ so that reference/, so that references/

>+ * top and bottom ref starting with the current picture parity. This have to be

s/bottom ref/bottom field references/
s/This have to be/This has to be/

>+ * done for short term and long term references separately.
>+ */
>+static void reorder_field_reflist(const struct v4l2_h264_reflist_builder *b,
>+				  struct v4l2_h264_reference *reflist)
>+{
>+	struct v4l2_h264_reference tmplist[V4L2_H264_REF_LIST_LEN];
>+	u8 lt, i = 0, j = 0, k = 0;
>+
>+	memcpy(tmplist, reflist, sizeof(tmplist[0]) * b->num_valid);
>+
>+	for (lt = 0; lt <= 1; lt++) {
>+		do {
>+			for (; i < b->num_valid && b->refs[tmplist[i].index].longterm == lt; i++) {
>+				if (tmplist[i].fields == b->cur_pic_fields) {
>+					reflist[k] = tmplist[i];
>+					k++;
>+					i++;

You can just say: `reflist[k++] = tmplist[i++];`

>+					break;
>+				}
>+			}
>+
>+			for (; j < b->num_valid && b->refs[tmplist[j].index].longterm == lt; j++) {
>+				if (tmplist[j].fields != b->cur_pic_fields) {
>+					reflist[k] = tmplist[j];
>+					k++;
>+					j++;

Same here: `reflist[k++] = tmplist[j++];`

Greetings,
Sebastian

>+					break;
>+				}
>+			}
>+		} while ((i < b->num_valid && b->refs[tmplist[i].index].longterm == lt) ||
>+			 (j < b->num_valid && b->refs[tmplist[j].index].longterm == lt));
>+	}
>+}
>+
> static char ref_type_to_char (u8 ref_type)
> {
> 	switch (ref_type) {
>@@ -345,6 +382,9 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
> 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
> 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
>
>+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF)
>+		reorder_field_reflist(builder, reflist);
>+
> 	print_ref_list_p(builder, reflist);
> }
> EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
>@@ -378,6 +418,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
> 	sort_r(b1_reflist, builder->num_valid, sizeof(*b1_reflist),
> 	       v4l2_h264_b1_ref_list_cmp, NULL, builder);
>
>+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF) {
>+		reorder_field_reflist(builder, b0_reflist);
>+		reorder_field_reflist(builder, b1_reflist);
>+	}
>+
> 	if (builder->num_valid > 1 &&
> 	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
> 		swap(b1_reflist[0], b1_reflist[1]);
>-- 
>2.34.1
>
