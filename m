Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692DA4AE860
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347063AbiBIEJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346402AbiBID1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:27:44 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEADC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:27:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x2Il0JhrH5EsFOuJtqhIRhFIoWPTf3W77jR9wKs31rI=;
        b=MIeHlyZMMutX70dqI+O6N/jG+BC92D2SkQNXDJlIW739n5beUj/tcgyAadqp9ZvWKgY8aP
        8tSl4OFpUmeR69s9H84qSRY6fVpyNKAG83N3HBbOR6rYMKyffEllbw81HWjx0CHyRh1916
        q5ekMfe8dl/bpBhb+yNNq0FGazgzV3M=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Baker <len.baker@gmx.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: video: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:27:13 +0800
Message-Id: <20220209032715.38437-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/staging/most/video/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index b7858e47145f..ffa97ef21ea5 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -52,7 +52,7 @@ struct comp_fh {
 	u32 offs;
 };
 
-static struct list_head video_devices = LIST_HEAD_INIT(video_devices);
+static LIST_HEAD(video_devices);
 static DEFINE_SPINLOCK(list_lock);
 
 static inline bool data_ready(struct most_video_dev *mdev)
-- 
2.25.1

