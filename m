Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398D4EE1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiCaTjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbiCaTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3222451D;
        Thu, 31 Mar 2022 12:37:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id A47591F47247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755459;
        bh=XWSCMrc+NrLm1p3fYYJooFLeLhu8K+wqylIt0iyj7Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ci2A27WG3nn3hVwxc9jwIR3E4CPWTQcVTJX69lc7p4gFqCHtA6JBUl2Zc403FpXq5
         LkQ1jV3EkM9Dn964TVruUiU4v9lkrRH9Fb7J0VIytyFFZtFeOIktrZzNfcxOPviNDp
         o0jMoLjQioZWZclguu1x7RvVwgXbWK1O6VGJRcseqdEWPy8sEYg/hqZUdFQ2x9J9oq
         g5RbA6c821YYmIh0tZ95dqRwo/xZCZW2B5tcxonaUAFoGB/d/vG4+jCtUYEX65iuB6
         1l7ebu99zlOQkx1eBuyjPSfSIpK3Oy/QWqai+EVzKRIlJnavqmkwAlyP/y7mQs+0mr
         IYSHXnNduxHAw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/23] media: h264: Avoid wrapping long_term_frame_idx
Date:   Thu, 31 Mar 2022 15:37:06 -0400
Message-Id: <20220331193726.289559-5-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
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

For long term references, frame_num is set to long_term_frame_idx which
does not require wrapping. This is fixed by observation, no directly
related issue have been found yet.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
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

