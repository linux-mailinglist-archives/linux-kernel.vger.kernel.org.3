Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C923A4EE1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiCaTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbiCaTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CA23FF01;
        Thu, 31 Mar 2022 12:38:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 08D9D1F4725F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755480;
        bh=HmMBg5b8YH4LzW0sBzAl4u/8f+BCfQenxWj/fruvkP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbVTEhI17KkBlxrzHM4EuGkf7QIYl4hZ/hOfcIcrzBe13cx9Xk5TLnQilPRIkCk/u
         +RAY0swuwiXIxoC7+k0vRmZm036mvACh+quaET/cKJOI1pwgQV9em1k9c0K7ymuKsf
         /Q7biHye8EnmdIsduVy61i1tLrDezx2l9quW2m4+1MKZOo/JAiSUAXxQnx3emifXBL
         8COXL3t4Q7KArtzscrvkyquK+0+O2W+4FznSZTULfF5040+lllV7hyjwDLsz/z77P2
         O3gWwpXQDdPv8zkLNX/NAufkBj5R0d8RXWFUa8vfYn7pR9ZDFaRx+fBm4Bc5cxyEGx
         fuwF0A10DIMuA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/23] media: rkvdec: h264: Fix reference frame_num wrap for second field
Date:   Thu, 31 Mar 2022 15:37:18 -0400
Message-Id: <20220331193726.289559-17-nicolas.dufresne@collabora.com>
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

From: Jonas Karlman <jonas@kwiboo.se>

When decoding the second field in a complementary field pair the second
field is sharing the same frame_num with the first field.

Currently the frame_num for the first field is wrapped when it matches the
field being decoded, this cause issues to decode the second field in a
complementary field pair.

Fix this by using inclusive comparison, less than or equal.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index a42cf19bcc6d..730f8ebf7f58 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -773,7 +773,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 			continue;
 
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
-		    dpb[i].frame_num < dec_params->frame_num) {
+		    dpb[i].frame_num <= dec_params->frame_num) {
 			p[i] = dpb[i].frame_num;
 			continue;
 		}
-- 
2.34.1

