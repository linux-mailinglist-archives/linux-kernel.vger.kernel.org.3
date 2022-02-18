Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF24BB6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiBRK1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:27:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBRK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:27:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBF512770
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:27:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id qe15so8159404pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+T3KpWhNKa0tR65ONmcJl30b/m+LmztZvFh+zw/KtCk=;
        b=CSBsjQACvcRO/sFAdwgQWs3JH/MmMWvyiVBNhla3nPtD9bgbk93JwZ2ntMsBUKq32T
         UIB8q3Ud3Aljxzwv3VHVhqrkqAdydQhA7KNG3IKuxZjpV67WfFmat9sN/omK6iuwGB4C
         IPB1CVoscYCyZtSboNE8VGsLqW3UjP5cZIHcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+T3KpWhNKa0tR65ONmcJl30b/m+LmztZvFh+zw/KtCk=;
        b=0mYEE1d/lv7N1YeGSh2XxEFg3u5DVfgl0HUrf9XfFm41ycCVpnKrWJ+BBIdeFEFZ3c
         727MlMY+/am8GUwyAEqrYvzlzILlrWSCBaDCRgGUOFtpGopcB1FPv1UV6Qaz/KoJpoQp
         9ni5HMSFBMl57l9cu5WkI8t6rJ7xe6naVo2RLLFZ4vrHpHe0in1NI51OCIKuR+UJ7eoT
         P7oKFOu7YgC41kUUKbCNyieYTgoRurT/onF09YFFBazGuzcNomy9cl0erCOfsNqSE00h
         IM4B0PeUgICPRMo/orfSC4XQW9av/akHmKtQ+iAVpW9sOje6mlhEVfoKZ43n4Vkihwch
         msyw==
X-Gm-Message-State: AOAM533c8iMcRYQh+7u78rkoictne6eSaPx/QDj7RzfChziMl/xHiwAs
        /Wl7NIMRwANMlZFrx8gNdZ5NVQ==
X-Google-Smtp-Source: ABdhPJwmd0fVZO0Edt92aYqkcns0NPA3othJELbRqEVsjcuckc3gLs6OopDmtExBFLlQwLVPribCdw==
X-Received: by 2002:a17:90b:38ce:b0:1b9:e0dd:50ec with SMTP id nn14-20020a17090b38ce00b001b9e0dd50ecmr11885292pjb.163.1645180021147;
        Fri, 18 Feb 2022 02:27:01 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id k13sm2767696pfc.176.2022.02.18.02.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:27:00 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     akpm@linux-foundation.org
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/3] mm/damon/core: Add damon_start_one()
Date:   Fri, 18 Feb 2022 19:26:10 +0900
Message-Id: <20220218102611.31895-3-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-1-tome01@ajou.ac.kr>
References: <20220218102611.31895-1-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_start() function is designed to start multiple damon monitoring
contexts. But, sometimes we need to start monitoring one context.
Although __damon_start() could be considered to start for one monitoring
context, it seems reasonable to adopt a new function that does not need
to handle 'damon_lock' from the caller.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c0adf1566603..069577477662 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -511,6 +511,7 @@ int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_start_one(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 #endif	/* CONFIG_DAMON */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 290c9c0535ee..e43f138a3489 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -466,6 +466,31 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
+/**
+ * damon_start_one() - Starts the monitorings for one context.
+ * @ctx:	monitoring context
+ *
+ * This function starts one monitoring thread for only one monitoring context
+ * handling damon_lock.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_start_one(struct damon_ctx *ctx)
+{
+	int err = 0;
+
+	mutex_lock(&damon_lock);
+	err = __damon_start(ctx);
+	if (err) {
+		mutex_unlock(&damon_lock);
+		return err;
+	}
+	nr_running_ctxs++;
+	mutex_unlock(&damon_lock);
+
+	return err;
+}
+
 /*
  * __damon_stop() - Stops monitoring of given context.
  * @ctx:	monitoring context
-- 
2.17.1

