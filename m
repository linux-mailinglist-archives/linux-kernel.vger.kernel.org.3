Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A8488C69
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiAIVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiAIVFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:05:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB18C06173F;
        Sun,  9 Jan 2022 13:05:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 18-20020a05600c22d200b00347d3a13c7cso3605268wmg.0;
        Sun, 09 Jan 2022 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg6Z6UgqVNey0NkbSjhi6a7Fl2EqTAOtDFR5jta0Uxw=;
        b=n2F52I6+jgGSp26KEemyZHGHVnd/id+3quqJx5k8PvjLiMNjQ66OXBosizoYkpS1fR
         /Pvzft+ozDgK4IpgGa49UPKLYKe4GqYsV+kYA0W3vq4WlkEIGvI9wDQM5sJsKGopje9d
         rAGe81UYMHedBJMXRhZ1z3+0Zvr+cAPr9Cb8Cloq2GcJT323usF/W+6GuRerDXR9goah
         kNRSyeSeWKsYfpK+FG2nY2zxuufEIaIaoNByJZdqPQohQ2RUei1SNznFCM5qpRXOKOAM
         2KLy4mTdcCqP845QunRpioWdo88HJ1m479AxRnq2BGuo77cZLgGxwvNUKM+5zbZQj8dj
         LmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg6Z6UgqVNey0NkbSjhi6a7Fl2EqTAOtDFR5jta0Uxw=;
        b=3QF/8hdldhXTdRoRFE/0elOYGnuKrUx+1RuywPvx7M+C0y73i9Ze5T+AnkYKEjlWB/
         EiG36t4ZKT1K/7/BHqPZouJvf02Ydw41v+A/KOee9WOIW4zUz0R9yebn2JXl18t6RGQa
         B3vmiDCFDFoDo0/q81lhS0z0seLgmOSEmahHooa9Q8gpEXDitQyprl4TrB/NwF7b2C72
         8nZ7zogFkmHBMCRH7C1C8u2YYD2a9fhjQ5+VDBaIvjbq7byFHK/Z3FxbFdCm/DmOzHcg
         2KbMJEWdDczKskMPyFkgTyB3V04hiMYDhZP4elYRqmNE2moSZmssmNUDPdzrxAiNGcPq
         UDEQ==
X-Gm-Message-State: AOAM532D+fu/NAYdwfYoJmfjEdTqJ2wlnpeuq85v3Atdi0lW8nc6odRy
        EwVXCrYIlV/SoNv3mjR1Mhk=
X-Google-Smtp-Source: ABdhPJz1XLecsWUsrbpLxT7lkU5S/VJCREJzYyIe/ggiWOViEzrmEO+VeJxOPO+IL63OC77wh1YVHw==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr19790018wmj.20.1641762303179;
        Sun, 09 Jan 2022 13:05:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u11sm5152562wmq.2.2022.01.09.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:05:02 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: v4l2-ctrls: make array range static
Date:   Sun,  9 Jan 2022 21:05:02 +0000
Message-Id: <20220109210502.53438-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array range on the stack but
instead it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 54abe5245dcc..85c2d3f39d96 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -382,7 +382,7 @@ validate_vp9_seg_params(struct v4l2_vp9_segmentation *seg)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(seg->feature_data); i++) {
-		const int range[] = { 255, 63, 3, 0 };
+		static const int range[] = { 255, 63, 3, 0 };
 
 		for (j = 0; j < ARRAY_SIZE(seg->feature_data[j]); j++) {
 			if (seg->feature_data[i][j] < -range[j] ||
-- 
2.32.0

