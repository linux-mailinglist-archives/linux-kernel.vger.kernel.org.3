Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804E50947E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347588AbiDUBKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiDUBKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:10:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF348235
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:07:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i24so3537889pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXFcguuKOwZ36a7tzEaULLH2NlMoMwaQ0FzsNYrn/D0=;
        b=H35RrJypbqQQXKi3d6omdA5/Wjpjk71GysLP24tgF8AryaAVWYiDvhNHNrKI3BHono
         iVKB2/o910yl+++gNDw9xQZnS3/N8j27AGGViCVMcP2Vx0EhA7hMwCGbXqAX00g90v2E
         t2XcSUM7mhmqQNS+xxrkboHR6z42v8O/W3cfhlwdHlOX6Z1t2tBbALWEwxi87lSfGf7/
         p+XnfRZOL873YIkqIud139khCXixevJI7joeZdKy/KeuVYGmJ3ldRzQHrvlsYQmCVnyq
         87OfckQd4ZtJONPp2aL2hgc/KDV5LkVfmFr/cG195g+VrCTfmAFmhTXTZfl5b9CYSJWL
         ezVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXFcguuKOwZ36a7tzEaULLH2NlMoMwaQ0FzsNYrn/D0=;
        b=ehXi1uGodBGYrT/0vopqE+7tjsikmuT7XavLMkbDe/5JV6/9lFrjF0OtlR8ICcV0cy
         4xO51BwM9AwD7AjYdYc5hiY75OX8FAnetewFJBAEJc8iibjlv4x2kB25lHVh8G0tOeQ+
         sXiZKq9rxUzR401SH0qbFODI7FcoScDve7kUz6XEFdbddHT7TN0EcVGFidRSlx95iKsJ
         UgV3flduSfh4R60pyBXk5c7+DIKNkRt0DG+38jdYSOpPZc2Pd3hziGLu2kE/AO+U1BRb
         YGCm42aX+cerBQYLBnjwXRUEcb1aZgXp5QQ4M8fdOX2wDUb4ObitTb885kKVdw84A1hE
         1V5Q==
X-Gm-Message-State: AOAM532qTKmeDRsPBB1vzmsP8PTDn8Kbc9zXAxyisYpZwio1Cx8rrTnW
        BuERRrYHybTjY5AARgRJ3Q==
X-Google-Smtp-Source: ABdhPJxqpx75p1EEQuqcnM5mHC7MaRzzP+yU47HGzCScCDnCL7Qn7ZcrrjfE0InDKHgi6vQhp6qPLg==
X-Received: by 2002:a05:6a00:4399:b0:50a:db62:e4fa with SMTP id bt25-20020a056a00439900b0050adb62e4famr1041435pfb.31.1650503275199;
        Wed, 20 Apr 2022 18:07:55 -0700 (PDT)
Received: from ubuntu.lan (64.64.231.132.16clouds.com. [64.64.231.132])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a8c9400b001cd4989fec4sm404101pjo.16.2022.04.20.18.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:07:54 -0700 (PDT)
From:   Hailong Tu <tuhailong@gmail.com>
To:     tuhailong@gmail.com, akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     tuhailong@oppo.com, lichunpeng@oppo.com, aaron.qiu@oppo.com,
        fanguoze@oppo.com
Subject: [PATCH v3] mm/damon: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 09:06:41 +0800
Message-Id: <20220421010640.383365-1-tuhailong@gmail.com>
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
 mm/damon/reclaim.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e34c4d0c4d93..46505c501cd6 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -28,7 +28,6 @@
  * this.
  */
 static bool enabled __read_mostly;
-module_param(enabled, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -358,11 +357,27 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
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
+module_param_call(enabled, enabled_store, param_get_bool, &enabled, 0600);
+
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
-- 
2.25.1

