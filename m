Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847D5509323
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382980AbiDTWtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382964AbiDTWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:49:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC127CDC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:46:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 12so3099790pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J00nUig6FU1iS+CYuX/r/SUYB9GfMxq2KFZFBX82bIQ=;
        b=JYATQizpk3AS+5NjkeucdAb78Lea6qbioEnGkOVtu39RXhVxgOYlNTizUCvj3ftF5R
         YUhkh1+4pwPk9pLyGa+a8cUWGK2+cISrbPmPSXNfviog8XocUAXFp0mtXbAUVTZGz0JV
         Yck0peX5E8YyY4cu14o3fiokS2g8Y4qIAkMQYxTiQjKL3gHF+UC25l3cio2cy5rIvlt8
         VdSDL+uoMgfWPrpD8SJVBFGGeobwdjG3lNk9ht5eyxv0IZH8+VJumEuqKlA7gUFpYWsI
         94MfC13oHdX+H+yqWIvboXHKDWe9okP68OvzBzKhbEvCGCi6PnXScTqSxR7grz2zPA9O
         skLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J00nUig6FU1iS+CYuX/r/SUYB9GfMxq2KFZFBX82bIQ=;
        b=qncUdwPJo7n+ZH9ogczVC0gq7GXIjNDGDwyjmPOoSTPG6n0OGxtcOJ049eJXeoRH3+
         drev8R2upwSkYRU2d/KWb5VsW1NNarh6rbeNCa+tOkB0SCbDepg8Hd+1FvCmRfbg7QLh
         Tr5WS4vhW54+ITsoDgebRcZ+Ifr7Zi6aHhiYWmwjrcRItRuwRrZ+MY0iKVbNItsQ+xhk
         FZc7tWxIC/vKenKM2PIyoLWSPeWztf+GQfgn8Zazv4cynFVShc2ySkf8xRVLg6+CWoZ7
         5iOD98/eB090jeL5lEuclaS92zQJ+3Y22oMFw7f9cEDiUMxe7Aq2WpTFhJpvzUTpBGNi
         iSrw==
X-Gm-Message-State: AOAM53395lBM3MnHhvFD76y7Ag/CIj+6tXLS/2swXuDSwV5DBbBCBxES
        +R3N+dFTRZG4k5Ej8tO45g==
X-Google-Smtp-Source: ABdhPJxQaqGbYOaxZ0SIUndDSFLyttMAYvQLvpF0D+y02HTgrdiAE4d5UdCT0XCv7cyVJEOkTqEH+Q==
X-Received: by 2002:a17:902:ee13:b0:158:a3ca:3def with SMTP id z19-20020a170902ee1300b00158a3ca3defmr22870694plb.97.1650494790692;
        Wed, 20 Apr 2022 15:46:30 -0700 (PDT)
Received: from ubuntu.lan (64.64.231.132.16clouds.com. [64.64.231.132])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm23130088pfj.152.2022.04.20.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 15:46:30 -0700 (PDT)
From:   Hailong Tu <tuhailong@gmail.com>
To:     tuhailong@gmail.com, akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tuhailong@oppo.com, lichunpeng@oppo.com
Subject: [PATCH v2] mm/damon: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 06:43:57 +0800
Message-Id: <20220420224356.322697-1-tuhailong@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer stays active even if the reclaim mechanism is never enabled.
It is unnecessary overhead can be completely avoided by using module_param_call() for enabled flag.

Signed-off-by: Hailong Tu <tuhailong@gmail.com>
---
 mm/damon/reclaim.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e34c4d0c4d93..389c4be4f62b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -28,7 +28,6 @@
  * this.
  */
 static bool enabled __read_mostly;
-module_param(enabled, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -358,11 +357,32 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 			enabled = last_enabled;
 	}
 
-	schedule_delayed_work(&damon_reclaim_timer,
+	if (enabled)
+		schedule_delayed_work(&damon_reclaim_timer,
 			msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
+static int enabled_show(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", enabled ? 'Y' : 'N');
+}
+
+static int enabled_store(const char *val,
+		const struct kernel_param *kp)
+{
+	int rc = param_set_bool(val, kp);
+
+	if (rc < 0)
+		return rc;
+
+	if (enabled)
+		schedule_delayed_work(&damon_reclaim_timer, 0);
+
+	return 0;
+}
+module_param_call(enabled, enabled_store, enabled_show, &enabled, 0600);
+
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
-- 
2.25.1

