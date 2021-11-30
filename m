Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D385463A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhK3P42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbhK3Pxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:53:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C4C06175D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:50:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d9so24575655wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdAKuIWGNHoXcj5qxrDRO1k6wk3YEeV2N3wFRBB2HSM=;
        b=aazx5vnOse7eotqB3rGEhhHWQGGbIsoW6LYwigU2Jzu6JyGuU/HAOhnS6eneQsMmf+
         F9BqwPpACwW7zHXMHcnmnUF8KEZhvSU9AzZw+A1OGW7gaoAgx7gMJ/J7qdSpeoylnIGq
         ZS2nerjzcDJO3793TmRYGKGSQXfOpeLIhO6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdAKuIWGNHoXcj5qxrDRO1k6wk3YEeV2N3wFRBB2HSM=;
        b=OIdxrsqdY7i+I+VJcCclHSYfA/ZDVoiWawn9XFZ7NECHTePYP6fjYH8vLT2ObNXI4b
         P/QENoLgsoP16w9wFsZXgZhUo59o9XjQokyKiU+zy5Ke8Nb8nC0NRHbxiF01z6K/trFM
         a0rPL06h/b3Uet/xOsNX51aM3SIP1yetucU+KgJbSlA0ISYBpmOLpEsh6uD4sx8Dkwy0
         p4UDnf5qZkZRPs14OeCsr24ljsCYX+8bnEMMv2WkNKpUW1tg5/VX/ksJn041kYt8MwoY
         5KhfZitfIhwnqofLpoI5wTYq4yulJKWoToFpIAc5HSKCy8hBkbnHLj+5Ou7BsJfzASG8
         AwxA==
X-Gm-Message-State: AOAM530J9TbGrHlr9oCju1tzPPYsd+AbtfFN5NulFxcAf6bwcOM9Q68w
        C9MI2vUBH/qlq8TAK4xT8hjZ6QyfXUXqsA==
X-Google-Smtp-Source: ABdhPJw6JIVKeN0h68i03hrGw2p9Pk3fp+RhWJJoGq7Ge9YNqJ9cpKKukLholnCK4mcC1hbSXDdDwQ==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr41255573wrw.628.1638287428569;
        Tue, 30 Nov 2021 07:50:28 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id b13sm13555207wrh.32.2021.11.30.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:50:28 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/2] media: uvcvideo: Avoid invalid memory access
Date:   Tue, 30 Nov 2021 15:50:25 +0000
Message-Id: <20211130155026.1082594-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mappings points to an invalid memory, we will be invalid accessing
it.
Solve it by initializing the value of the variable mapping and by
changing the order in the conditional statement (to avoid accessing
mapping->id if not needed).

Fix:
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN NOPTI

Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 30bfe9069a1fb..f7b7add3cfa59 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -852,8 +852,8 @@ static void __uvc_find_control(struct uvc_entity *entity, u32 v4l2_id,
 				return;
 			}
 
-			if ((*mapping == NULL || (*mapping)->id > map->id) &&
-			    (map->id > v4l2_id) && next) {
+			if (next && (map->id > v4l2_id) &&
+			    (*mapping == NULL || (*mapping)->id > map->id)) {
 				*control = ctrl;
 				*mapping = map;
 			}
@@ -1638,7 +1638,7 @@ static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
 				  struct v4l2_ext_controls *ctrls,
 				  struct uvc_control *uvc_control)
 {
-	struct uvc_control_mapping *mapping;
+	struct uvc_control_mapping *mapping = NULL;
 	struct uvc_control *ctrl_found;
 	unsigned int i;
 
-- 
2.34.0.384.gca35af8252-goog

