Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD72485343
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiAENKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiAENK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:10:28 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B45C061761;
        Wed,  5 Jan 2022 05:10:28 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so1895556plg.12;
        Wed, 05 Jan 2022 05:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d2egkRY01NWNRsscTta78rBEuG5eAcdTMhitWQtSkQ4=;
        b=H2rZTCMeYOJtVdngmkGhAlQXdYXyH5QMNtHxIvoz3tRXpIngYyLDFycJkfNcqujpZ6
         PYKFviYHAawE/hBrx6i/h3opSNcQK0ml84vruHZOqNbKBVmGwFi2vvlJfQDjSToV3PBG
         mrM7+AucG0PxMFmcWfipOTcCqO1kwFVQ+LRBtsLAGt16rBhr+fZf+6V94ECLiy2zDpEE
         nlR7W6G9LVJxToJThVeSFTVnYCbVg0df/lX61SqhN/RTS7LZf7sxZC+/GBZ43WvUeW8s
         MyLJ5C+hvCVHJTwc3Ruit/YXxswoKnZe0vLzuukTIoEX5N6pYbMTJcU+oswtliebLR4W
         yR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d2egkRY01NWNRsscTta78rBEuG5eAcdTMhitWQtSkQ4=;
        b=T5vgbcvYgs2JHHNCgUvE54hZOoSMRIvvJi44rx76sGxW+YBJXtao47qE0htugmOTxo
         Avo27TBPIcX4q0MrHEbzBTHqus5ayYxYMn5gIdA/ZIOA8UZd+xThdj+37IQctlcEvqj0
         wZVCt+jQxYhCVuc0nUjc1t8LgL+QqQ0y9kH+4yYNlhl+RMriZe0YarxJHo81KY6I9mwD
         8e7t/RmQQ6PcU2I7smOtLzrB1buJotLsNoBpcKeYckT9C6svFEKp+Ptow+Ne72GAn4e0
         iUcM/J/BTlRIs3AFCvdjD4GwTff7n6FkrOWBrWMMY2z4hXbAsv/mW3cU4EO8c3An7Zwy
         QJgQ==
X-Gm-Message-State: AOAM533iWNpAiFLyNrQVw69JHhwHOsHY7m77/DT7kIp/p9RB8nZ/sn4H
        N5uveMs/eHIL7MgH4215bN4=
X-Google-Smtp-Source: ABdhPJzR9Hew1vrhcl2hpMz6yb7JreFwp0MByzjZMYOPIkz5bwfpItx/91jO+J2xZIwWp12moVuIhg==
X-Received: by 2002:a17:90a:ad94:: with SMTP id s20mr3132535pjq.222.1641388227638;
        Wed, 05 Jan 2022 05:10:27 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id u11sm45219165pfi.10.2022.01.05.05.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:10:27 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     linmq006@gmail.com
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        ohad@wizery.com
Subject: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in rproc_create_trace_file
Date:   Wed,  5 Jan 2022 13:10:22 +0000
Message-Id: <20220105131022.25247-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220105064201.3907-1-linmq006@gmail.com>
References: <20220105064201.3907-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() function doesn't return NULL.
It returns error pointers. Fix check in rproc_create_trace_file
and make it returns return error pointers.
Fix check in rproc_handle_trace to propagate the error code.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- return PTR_ERR(tfile) in rproc_create_trace_file
- fix check in rproc_handle_trace()
Changes in v3:
- return tfile to fix incorrect return type in v2
---
 drivers/remoteproc/remoteproc_core.c    | 6 ++++--
 drivers/remoteproc/remoteproc_debugfs.c | 4 +---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 775df165eb45..5608408f8eac 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
 	struct rproc_debug_trace *trace;
 	struct device *dev = &rproc->dev;
 	char name[15];
+	int ret;
 
 	if (sizeof(*rsc) > avail) {
 		dev_err(dev, "trace rsc is truncated\n");
@@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
 
 	/* create the debugfs entry */
 	trace->tfile = rproc_create_trace_file(name, rproc, trace);
-	if (!trace->tfile) {
+	if (IS_ERR(trace->tfile)) {
+		ret = PTR_ERR(trace->tfile);
 		kfree(trace);
-		return -EINVAL;
+		return ret;
 	}
 
 	list_add_tail(&trace->node, &rproc->traces);
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b5a1e3b697d9..2ae59a365b7e 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 
 	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
 				    &trace_rproc_ops);
-	if (!tfile) {
+	if (IS_ERR(tfile))
 		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
-		return NULL;
-	}
 
 	return tfile;
 }
-- 
2.17.1

