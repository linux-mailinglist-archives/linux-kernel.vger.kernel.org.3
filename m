Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C294EA972
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiC2Ihi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiC2Ihg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:37:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE423F9F8;
        Tue, 29 Mar 2022 01:35:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BBC981F439F4;
        Tue, 29 Mar 2022 09:35:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648542953;
        bh=LigN/8jbiy3pWxU4jFC/9jxwj/ZqFSV+E2hk9aahP3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCjO5cNC88D0kOhYyttzw3jLJZR7/eOfgu6FVBelA7gDBdDPeuwv+OFCqWuMJT95F
         8zW791ZB21le46YJp0EFLr4gj5adhAy/6I3XURIQaXEb8KS/qzNGgGQt+g5H/YYDcH
         h4CR4EPjV2xwXbH1R8raU4h3Db8H/Ap9NB7sxl0bQ8E/SmoaSOHfGQVC+QKNkeu6Cy
         /hln0i03sUIU0URGHWyWGAVhrfxDmdBwjTQKBWy3kjkRfUrMnfVKrsO9ldt5NmMPOY
         5Im+wh0nLTsnyDXb02GQWGXMJnQ6KwzL/odPwGf6socLdjm0BmAiIicPmfgG2FfVgJ
         ehJfV4EAzUxBQ==
Date:   Tue, 29 Mar 2022 10:35:49 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/24] media: h264: Avoid wrapping long_term_frame_idx
Message-ID: <20220329083549.2msls7obppsspvgk@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-4-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-4-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>For long term reference, frame_num is set to long_term_frame_idx which

s/reference/references/

>does not require wrapping. This if fixed by observation, no directly

s/This if/This is/

>related issue have been found yet.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/media/v4l2-core/v4l2-h264.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index 8d750ee69e74..aebed1cbe05a 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -57,8 +57,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
> 		 * TODO: This logic will have to be adjusted when we start
> 		 * supporting interlaced content.

As you change the logic can't you remove the TODO comment now?

>+		 * For long term reference, frame_num is set to

s/reference/references/

Greetings,
Sebastian

>+		 * long_term_frame_idx which requires no wrapping.
> 		 */
>-		if (dpb[i].frame_num > cur_frame_num)
>+		if (!b->refs[i].longterm && dpb[i].frame_num > cur_frame_num)
> 			b->refs[i].frame_num = (int)dpb[i].frame_num -
> 					       max_frame_num;
> 		else
>-- 
>2.34.1
>
