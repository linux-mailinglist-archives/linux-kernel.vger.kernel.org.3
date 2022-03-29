Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D574EAFED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiC2PKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiC2PJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F11EC62B;
        Tue, 29 Mar 2022 08:08:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 21DAC1F440C1;
        Tue, 29 Mar 2022 16:08:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648566483;
        bh=C6t3ZinGAFBOT9ORWc/HRpzQcPD7wWIHP5FykwdIt7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXC2rrIJW+aom9t1Juphld1TuKPK1diMvGZvn5F2iONYT+4InqEOI4k4mEDOCaYbL
         /Gj6zyIsX4GK0+avYdTCfxd0csR9jCaiozukIHHAHuzdbLnUUYFt3pbutam2bR+q/b
         w2uoVlynxtVFwFkgH7Wks6yKEQYw/4Jj5vhdJi9G/pCAQRpCcrawi7LE7HtZY9giaV
         Qh2BojzVa8gRaTe6DOfnb1ntTQZahK9a76Vk5zUAsfrpWDrR5GM9tkF+/Kspcg/a26
         U2A3Y963K0knxPCeizLYFpe/MHScBw+3XP2C4wbFCYWbek4nxSG9BHBKZaX7do6MO5
         cjpals4Wwk+wA==
Date:   Tue, 29 Mar 2022 17:08:00 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/24] media: v4l2: Trace calculated p/b0/b1 initial
 reflist
Message-ID: <20220329150800.siu2yaaolesf6dgs@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-7-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-7-nicolas.dufresne@collabora.com>
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
>This is crucial in verifying that the ordering is right, specially with
>more complex sorting needed for field decoding.

How about:

"""
Add debug print statements to print the content of P & B reference
lists, to verify that the ordering of the generated reference lists is
correct. This is escpecially important for the field decoding mode,
where sorting is more complex.
"""

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/media/v4l2-core/v4l2-h264.c | 86 +++++++++++++++++++++++++++++
> 1 file changed, 86 insertions(+)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index d5698c981973..c9e18fd51d78 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -241,6 +241,87 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
> 	return poca < pocb ? -1 : 1;
> }
>
>+static char ref_type_to_char (u8 ref_type)
>+{
>+	switch (ref_type) {
>+	case V4L2_H264_FRAME_REF:
>+		return 'f';
>+	case V4L2_H264_TOP_FIELD_REF:
>+		return 't';
>+	case V4L2_H264_BOTTOM_FIELD_REF:
>+		return 'b';
>+	}
>+
>+	return '?';
>+}
>+
>+static const char *format_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
>+				     struct v4l2_h264_reference *reflist,
>+				     char *out_str, const int len)
>+{
>+	int n = 0, i;
>+
>+	n += snprintf(out_str + n, len - n, "|");
>+
>+	for (i = 0; i < builder->num_valid; i++) {
>+		/* this is pic_num for frame and frame_num (wrapped) for field,
>+		 * but for frame pic_num is equal to frame_num (wrapped).
>+		 */
>+		int frame_num = builder->refs[reflist[i].index].frame_num;
>+		bool longterm = builder->refs[reflist[i].index].longterm;
>+
>+		n += scnprintf(out_str + n, len - n, "%i%c%c|",
>+			       frame_num, longterm ? 'l' : 's',
>+			       ref_type_to_char (reflist[i].fields));
>+	}
>+
>+	return out_str;
>+}
>+
>+static void print_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
>+			     struct v4l2_h264_reference *reflist)
>+{
>+	char buf[1024];
>+
>+	pr_debug("ref_pic_list_p (cur_poc %u%c) %s\n",
>+		 builder->cur_pic_order_count,
>+		 ref_type_to_char(builder->cur_pic_fields),
>+		 format_ref_list_p(builder, reflist, buf, sizeof(buf)));
>+}
>+
>+static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
>+				     struct v4l2_h264_reference *reflist,
>+				     char *out_str, const int len)
>+{
>+	int n = 0, i;
>+
>+	n += snprintf(out_str + n, len - n, "|");
>+
>+	for (i = 0; i < builder->num_valid; i++) {
>+		int frame_num = builder->refs[reflist[i].index].frame_num;
>+		u32 poc = v4l2_h264_get_poc(builder, reflist + i);
>+		bool longterm = builder->refs[reflist[i].index].longterm;
>+
>+		n += scnprintf(out_str + n, len - n, "%i%c%c|",
>+			       longterm ? frame_num : poc,
>+			       longterm ? 'l' : 's',
>+			       ref_type_to_char(reflist[i].fields));
>+	}
>+
>+	return out_str;
>+}
>+
>+static void print_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
>+			     struct v4l2_h264_reference *reflist, u8 list_num)
>+{
>+	char buf[1024];
>+
>+	pr_debug("ref_pic_list_b%u (cur_poc %u%c) %s",
>+		 list_num, builder->cur_pic_order_count,
>+		 ref_type_to_char (builder->cur_pic_fields),
>+		 format_ref_list_b(builder, reflist, buf, sizeof(buf)));
>+}
>+
> /**
>  * v4l2_h264_build_p_ref_list() - Build the P reference list
>  *
>@@ -261,6 +342,8 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
> 	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
> 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
> 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
>+
>+	print_ref_list_p(builder, reflist);
> }
> EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
>
>@@ -296,6 +379,9 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
> 	if (builder->num_valid > 1 &&
> 	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
> 		swap(b1_reflist[0], b1_reflist[1]);
>+
>+	print_ref_list_b(builder, b0_reflist, 0);
>+	print_ref_list_b(builder, b1_reflist, 1);
> }
> EXPORT_SYMBOL_GPL(v4l2_h264_build_b_ref_lists);
>
>-- 
>2.34.1
>
