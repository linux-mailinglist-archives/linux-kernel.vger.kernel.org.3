Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E972649203A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiARH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiARH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6CC061574;
        Mon, 17 Jan 2022 23:26:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i8so13122039pgt.13;
        Mon, 17 Jan 2022 23:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEq+uVvJXtHzn7krujbcpKdPooiYBjQ4fGtzjepCNoY=;
        b=h3hElGWedXHRNZmBkfSL2+dM3RO48nMzzFDgCJYEg7NTuJVG4OJXQtcG1RtaVNTbj1
         ycunQUqmVXHGYHJSrALdpc7tgacS4eYMgh9wq10OOMAdBFp3TdHwOlXaYeZAQMjx0mLH
         GcZS7lBITYjQV5WI45cKrK4MASniwrpVvkwVJZxPpDu3IwDSTrDSwKqyiR3nk22BDgY9
         /PNAC1BGUS4seqaGBflgYdJEIdek49IwFtWs0/88qMNC6QMgDhLVaNxTQn9TrSfpolfZ
         OjJgprIBs4mrRKyYI4tWFhx0NdxtaI+advqx6um8FPa4FqcNEvCtNBYqYwPcBY/Bf3y+
         DPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEq+uVvJXtHzn7krujbcpKdPooiYBjQ4fGtzjepCNoY=;
        b=xV7a/TqSak2J5lGzb+hO1+jTAICf8W70W8G3c4hzalkJLby1/2TV0laNki0kkDClDc
         yKWb/W87eC09ilh8onLDGrkzu50f2DkfxTVVXYdYCWENfXseiDbCo7HLViRleZhaxXZh
         7rdtwcs6C+LjMzPt5y948fqGyXygKaSH+Xnwxt4BJ9S0hRhbSaFMeq4XfxvjKaMXZJtu
         PD850q9xA0PIT9siaAnuswnq3f2dj1/BN9IYB9NuKiwHCfo0meBaNqw0PnuvcdVkITzj
         xsiibR+82FyJHadZ6TKbiF143u/TSdQd/kvaTM2Ich1z/5HrLPSOOfQCGXg9sgrxFsZM
         6JTA==
X-Gm-Message-State: AOAM532d22M/E+k9xv0y0gv9sPJ7yXiIYfI4uh8Hf4RTPNieCE2FThbm
        eJ1I+RqFh3FtNxZtbn2Iims=
X-Google-Smtp-Source: ABdhPJy/ZJB70obNRENGozEl97E+pIF3JSy47LHY2WfQUJ0IQycmV7lHEXlKdCrekcjj/VqT+17zaA==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr22245025pgj.331.1642490794970;
        Mon, 17 Jan 2022 23:26:34 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:34 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports
Date:   Mon, 17 Jan 2022 23:26:18 -0800
Message-Id: <20220118072628.1617172-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internally kernel prepends all report buffers, for both numbered and
unnumbered reports, with report ID, therefore to properly handle unnumbered
reports we should

For the same reason we should skip the first byte of the buffer when
calling i2c_hid_set_or_send_report() which then will take care of properly
formatting the transfer buffer based on its separate report ID argument
along with report payload.

Fixes: 9b5a9ae88573 ("HID: i2c-hid: implement ll_driver transport-layer callbacks")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 32 ++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index bd7b0eeca3ea..b383003ff676 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -611,6 +611,17 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	if (report_type == HID_OUTPUT_REPORT)
 		return -EINVAL;
 
+	/*
+	 * In case of unnumbered reports the response from the device will
+	 * not have the report ID that the upper layers expect, so we need
+	 * to stash it the buffer ourselves and adjust the data size.
+	 */
+	if (!report_number) {
+		buf[0] = 0;
+		buf++;
+		count--;
+	}
+
 	/* +2 bytes to include the size of the reply in the query buffer */
 	ask_count = min(count + 2, (size_t)ihid->bufsize);
 
@@ -632,6 +643,9 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	count = min(count, ret_count - 2);
 	memcpy(buf, ihid->rawbuf + 2, count);
 
+	if (!report_number)
+		count++;
+
 	return count;
 }
 
@@ -648,17 +662,19 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 
 	mutex_lock(&ihid->reset_lock);
 
-	if (report_id) {
-		buf++;
-		count--;
-	}
-
+	/*
+	 * Note that both numbered and unnumbered reports passed here
+	 * are supposed to have report ID stored in the 1st byte of the
+	 * buffer, so we strip it off unconditionally before passing payload
+	 * to i2c_hid_set_or_send_report which takes care of encoding
+	 * everything properly.
+	 */
 	ret = i2c_hid_set_or_send_report(client,
 				report_type == HID_FEATURE_REPORT ? 0x03 : 0x02,
-				report_id, buf, count, use_data);
+				report_id, buf + 1, count - 1, use_data);
 
-	if (report_id && ret >= 0)
-		ret++; /* add report_id to the number of transfered bytes */
+	if (ret >= 0)
+		ret++; /* add report_id to the number of transferred bytes */
 
 	mutex_unlock(&ihid->reset_lock);
 
-- 
2.34.1.703.g22d0c6ccf7-goog

