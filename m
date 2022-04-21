Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780EB509D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388113AbiDUKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388128AbiDUKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B81A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h5so4243381pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsdE3ejlrgq1gDQ/exxKmXLe6JQt0xGeT5bhgKhF+Wo=;
        b=Dw1BxuIDSLskVbXwsGslurN3tXVPmH1OXW1lcLmxPUQI0PNwe2NHqxMckr/ZtpfcfE
         OPRVgaYNc7Y9Y3OX6LdBrVCj3gG1aDSDD1MYdP9s1ni0Pm9Fqop/XVU4FpwMaH3GS+AM
         mJJ2HkS6cNGFtzjJKP+7nmdpXKW4lZxCxHXExu1pc/vM082CXc/Z6fQD735LZapm/qez
         RZ3YNuwWRVYBRDYztl5r3Uyx6wnlQ2IBmfFrC8tbXQcGkPPjW/12OCFVHeh9kIrKTi5W
         vmXQGg8LM8dtQdX+cnbjNXQsySXnVGfs6R3jxr6sdclPTs2TnPVLaYgTme9JpNK+hUeg
         6FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsdE3ejlrgq1gDQ/exxKmXLe6JQt0xGeT5bhgKhF+Wo=;
        b=zNGHlmPN8/+4XwGImFPPQl3XA9Pl6EdUHNhlUbCZNjtw810rE7XybBw5DF9mu5chFW
         0OeQlbtB35rfgPTh8MobO1lVDRD5Pg/W0QoevujI7F+aT01LUM1jT+E03Jz5ZsSIf+bf
         3evxnwXHHkIJu/WigXOatZNzHCuC+uxcaBpNqVN8sw/0Pn970zppxYvtzAh+Y52Wu4tX
         cxMJCG2VbV6275RBWU7ENQ0qPdmCJc9wpn1JSTiA2VaPfWAbTxSz9lwZWbtUtpkwSACI
         4V6Q7wod5aXlwKpVWp7AXJGT6qtKNpxN9F15oUFA9nJLxpN9Gco4TpZQmaE6ALBrJzfV
         mKkw==
X-Gm-Message-State: AOAM530Ge7r88N0F2r9jw2MNGLzoosHixJSZL0oCNOGZ3ayKzeb4EtO5
        AEGZ1kLMVTMraUByuN8iFg==
X-Google-Smtp-Source: ABdhPJydwklhWWEEbdkJJYD7raDQpJT5lYQoY0Ft/exZlzpzE/98Wq0WNzQRNtzNuYZnhoWB1JtQGg==
X-Received: by 2002:a63:eb0d:0:b0:3a2:ced0:31ef with SMTP id t13-20020a63eb0d000000b003a2ced031efmr23497370pgh.594.1650535845314;
        Thu, 21 Apr 2022 03:10:45 -0700 (PDT)
Received: from ubuntu.lan (64.64.231.132.16clouds.com. [64.64.231.132])
        by smtp.gmail.com with ESMTPSA id h128-20020a628386000000b0050ade849861sm1906384pfe.2.2022.04.21.03.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:44 -0700 (PDT)
From:   Hailong Tu <tuhailong@gmail.com>
To:     tuhailong@gmail.com, akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tuhailong@oppo.com, lichunpeng@oppo.com, aaron.qiu@oppo.com,
        fanguoze@oppo.com, wangdesuo@oppo.com, lizhihua@oppo.com
Subject: [PATCH V4] mm/damon/reclaim: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 18:05:24 +0800
Message-Id: <20220421100523.689294-1-tuhailong@gmail.com>
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
It is unnecessary overhead can be completely avoided by using module_param_cb() for enabled flag.

Signed-off-by: Hailong Tu <tuhailong@gmail.com>
---
 mm/damon/reclaim.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e34c4d0c4d93..e573e3f50064 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -28,7 +28,6 @@
  * this.
  */
 static bool enabled __read_mostly;
-module_param(enabled, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -358,11 +357,34 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 			enabled = last_enabled;
 	}
 
-	schedule_delayed_work(&damon_reclaim_timer,
+	if (enabled)
+		schedule_delayed_work(&damon_reclaim_timer,
 			msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
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
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = enabled_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_RECLAIM (default: disabled)");
+
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
-- 
2.25.1

