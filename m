Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072324EA0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbiC1UBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbiC1UBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24163969A;
        Mon, 28 Mar 2022 12:59:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id D7E931F43853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497593;
        bh=koeYZVYa1e9V9VAWFVOsniYBHyi6nWtDcIkC0przTEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4LqLgpBupA7Vw6AD5z/wVRO3g7+he2wEA288iD6Ho4mfTQVWnM+FTZpAmFZPZDaH
         oj4IlQXm7SvqKU/H10sqMz9poEwuzZUeiG8gEE5WzvHIvwCs7WZRCcgSfye+qzqCfR
         EoHcip48VZ/+lhfc0OdQ+tsFwhTfX/RxMezGwkbxBdD6s2MPplK0ASSQ54/PjzgfCw
         avIr1tSLDsp4s9vUcNp4o92zyvncm2ExFJAxNiqgzqwdLtEvnEJO9t1et5oL61egqu
         r9mDlWWDSqwT3dXjH0VK0+X7DkXmvrAh6x4UzBbdnW5aC27R57F6deeFO515CWc3xf
         Kh5Hc7D/2cwPQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/24] media: h264: Avoid wrapping long_term_frame_idx
Date:   Mon, 28 Mar 2022 15:59:15 -0400
Message-Id: <20220328195936.82552-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For long term reference, frame_num is set to long_term_frame_idx which
does not require wrapping. This if fixed by observation, no directly
related issue have been found yet.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 8d750ee69e74..aebed1cbe05a 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -57,8 +57,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
 		 * TODO: This logic will have to be adjusted when we start
 		 * supporting interlaced content.
+		 * For long term reference, frame_num is set to
+		 * long_term_frame_idx which requires no wrapping.
 		 */
-		if (dpb[i].frame_num > cur_frame_num)
+		if (!b->refs[i].longterm && dpb[i].frame_num > cur_frame_num)
 			b->refs[i].frame_num = (int)dpb[i].frame_num -
 					       max_frame_num;
 		else
-- 
2.34.1

