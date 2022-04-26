Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8350FE06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350374AbiDZNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350325AbiDZNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8B5177D47;
        Tue, 26 Apr 2022 05:58:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 335911F43982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977885;
        bh=fNRZoSK/0DILeV16LVHwTQzonwtkLN2LiUy6JGrnOQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fkv6n+WV8+Zvr4P0dEKD5P40Rzhb7kMRK/4rDVPQKGKHqJsnpzsyEMzxwq8KktH1z
         wwQHVcadl8QyVax+00Cu2Rl+wRQfeNxeXCY8uZ8zZwNp+PmhuXG9TGmFklOLFRPe0L
         S1bhRAvjg8j1ffbRifxo9SwaQBCE1XFBT7ShUuppUVgU1SJRtsnn+hr1SNEu11jHPr
         uRcPq0ko3CuNfFIDnsmCVkt47n/126jrtqZEOgQ6vxQjJXjeIUOhESata2ickcrjKa
         TM+Fka8HxR3fe4l85obJmuvMCSIVAZloo1pncuTTiyhwuJwWK3s9c03sbYsSsvBRaH
         +UTgKxu7t5CHg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/24] media: h264: Avoid wrapping long_term_frame_idx
Date:   Tue, 26 Apr 2022 08:57:30 -0400
Message-Id: <20220426125751.108293-5-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For long term references, frame_num is set to long_term_frame_idx which
does not require wrapping. This is fixed by observation, no directly
related issue have been found yet.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/v4l2-core/v4l2-h264.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 5633a242520a..ac47519a9fbe 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -57,8 +57,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
 		 * TODO: This logic will have to be adjusted when we start
 		 * supporting interlaced content.
+		 * For long term references, frame_num is set to
+		 * long_term_frame_idx which requires no wrapping.
 		 */
-		if (dpb[i].frame_num > cur_frame_num)
+		if (!b->refs[i].longterm && dpb[i].frame_num > cur_frame_num)
 			b->refs[i].frame_num = (int)dpb[i].frame_num -
 					       max_frame_num;
 		else
-- 
2.34.1

