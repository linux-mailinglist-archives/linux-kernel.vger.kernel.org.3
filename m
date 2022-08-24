Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332A059FB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiHXNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiHXNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:21:36 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318A61D4C;
        Wed, 24 Aug 2022 06:21:32 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661347288te7o964w
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:21:27 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: zT6n3Y95oi1FhNGEPFle4+77sm1pAnicPB2mzwKc78jDEmifi8bIwYnLA8jxH
        TwvUOmpYKNfl7A7YbBHy48K4eKEVmdAE+6IB1+ag0mC0r4kJNp4bxJHBJB3kAa+oASLEokV
        bBvi9McB4TIgHEavO+pMJfHkLHwn1qCeOXewrlPn6LVoRvxo8kEN4Cg9Fb5g0Wb+t0gBehM
        ZrQU26m702AkKNEljkzkn11IgBXLWpAdquVubaCfxdIEpY08mDoslyckcwRSaIK3BsixVSK
        Z33PfS1MZY3CI1s0C76URQ/1vHRP6MJIhZc43ZAq01/Ui8eYiGUuYqVhmipXz3h/no0+MvP
        IgItyBfktuVrcNu9Tvn2TdDAOci6Qa+UQcKTHdZWS8Z2fGsDzs6QWZ+jA4fKQdC+MouLotR
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     matrandg@cisco.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media/i2c: Use 'unsigned int' instead of just 'unsigned'
Date:   Wed, 24 Aug 2022 21:21:21 +0800
Message-Id: <20220824132121.57334-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/i2c/tc358743.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index e18b8947ad7e..fbffa9d6b5c0 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -292,12 +292,12 @@ static int get_audio_sampling_rate(struct v4l2_subdev *sd)
 
 /* --------------- TIMINGS --------------- */
 
-static inline unsigned fps(const struct v4l2_bt_timings *t)
+static inline unsigned int fps(const struct v4l2_bt_timings *t)
 {
 	if (!V4L2_DV_BT_FRAME_HEIGHT(t) || !V4L2_DV_BT_FRAME_WIDTH(t))
 		return 0;
 
-	return DIV_ROUND_CLOSEST((unsigned)t->pixelclock,
+	return DIV_ROUND_CLOSEST((unsigned int)t->pixelclock,
 			V4L2_DV_BT_FRAME_HEIGHT(t) * V4L2_DV_BT_FRAME_WIDTH(t));
 }
 
@@ -305,7 +305,7 @@ static int tc358743_get_detected_timings(struct v4l2_subdev *sd,
 				     struct v4l2_dv_timings *timings)
 {
 	struct v4l2_bt_timings *bt = &timings->bt;
-	unsigned width, height, frame_width, frame_height, frame_interval, fps;
+	unsigned int width, height, frame_width, frame_height, frame_interval, fps;
 
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));
 
-- 
2.36.1

