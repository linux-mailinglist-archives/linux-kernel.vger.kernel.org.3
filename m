Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01750A02E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiDUNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiDUNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:02:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17EF326DC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:59:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so4780454plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/mm3H1SPdbVSVF5q8GMmt5AG1eAPVhbbMFtPZ5gmF0=;
        b=f/4x3TRQbfLQYK2wf2fI4LiXJLA/xuTn2/zuQ5h4FNcIqPebKzIj3Mu+LZD9qSGt3q
         7r3NWBvQ0GlSbO1MJWJB9MkQkyw2UXZqJ4l2C4jkBt7w7KK1TYqgqw0guhAXjRI20eMD
         ZYMnaXTbzk67K2Dy0P29lfOwP8oq3zsGUfdkItqlN1u1gJvudUETpeuRKsdfCgUmHwW9
         flD6ujjRByHR6sELi9LpJ4ndC1Fa97xpoyPVa1R00ucChSOwggTMCj9zpsb5ZhOZgTdz
         d/8mekOhurg2SxfWsrsKQ8nYGwJEH13AA74mM5WFRdMQ+Cpg8OMgf4ENDRyC0WW/w4Y3
         9QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/mm3H1SPdbVSVF5q8GMmt5AG1eAPVhbbMFtPZ5gmF0=;
        b=lpYHNsSJpg8CFmiEJtgpWKMgixLYjPfu7ono3VsCCC4XLLasUA/Krt9Bfhfpbsqahn
         cVOfxF7vuGjtyp7Q5gFOFR/l08Dwz11RlkC1TbJaJsp5IS0tMNNjruSrx7J+tSYC/P+8
         EK7jnbR9owIn6ASYlHy1kyA1EwwIkCyihU4QpQ9AzQ3eiGbMvfDPLQh7T5PV/FWqoS98
         wSxUvhnpMaLb28Qb6NXXPu/DYwZU5LuE0sZCTALxb88/+d9/uVdRqsv19DQvH8gGOZR2
         abvmMXzUOwyzIL01PkFxQEQj6+yKl1yDsI9hcAcPQ5ZXPCX1foHfyhAz+y1SydCppDCc
         9aPw==
X-Gm-Message-State: AOAM530Y38208/cojD17BlaGoK+441t+U3FadtLrzL3AAWt+ieaypC0V
        umoGZUq4n7JZkRTDIZMLjD6ROjnaqiM+vVo=
X-Google-Smtp-Source: ABdhPJyg/0dPj0nmGckOC1lt/WKBz3sspU7E/M3G9Z71+qC8IE96p18QYTgZP9D2A1PqZACZoT5nJQ==
X-Received: by 2002:a17:90b:1809:b0:1d2:6345:b000 with SMTP id lw9-20020a17090b180900b001d26345b000mr10513099pjb.98.1650545986181;
        Thu, 21 Apr 2022 05:59:46 -0700 (PDT)
Received: from ubuntu.lan (64.64.231.132.16clouds.com. [64.64.231.132])
        by smtp.gmail.com with ESMTPSA id ck14-20020a056a00328e00b0050a3c5f415csm21458351pfb.23.2022.04.21.05.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:59:45 -0700 (PDT)
From:   Hailong Tu <tuhailong@gmail.com>
To:     tuhailong@gmail.com, akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tuhailong@oppo.com, lichunpeng@oppo.com, aaron.qiu@oppo.com,
        fanguoze@oppo.com, wangdesuo@oppo.com, lizhihua@oppo.com
Subject: [PATCH v5] mm/damon/reclaim: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 20:59:11 +0800
Message-Id: <20220421125910.1052459-1-tuhailong@gmail.com>
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
 mm/damon/reclaim.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e34c4d0c4d93..75cfd96a6060 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -28,7 +28,6 @@
  * this.
  */
 static bool enabled __read_mostly;
-module_param(enabled, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -358,11 +357,35 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
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
+MODULE_PARM_DESC(enabled,
+	"Enable or disable DAMON_RECLAIM (default: disabled)");
+
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
-- 
2.25.1

