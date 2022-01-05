Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622EF484E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiAEGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiAEGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:42:18 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0374C061761;
        Tue,  4 Jan 2022 22:42:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 8so34360748pfo.4;
        Tue, 04 Jan 2022 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2iN9EGLEph4xOa1rzlV6HP0Zqf6BhRdNyhQVEqdz5GI=;
        b=NKW+mIEvUmLJU0NEiIEDVziEhab0imP627Hag8mPnjIVcMS3DCZ/OuYLGPDOOoAOIk
         l3YixhtdImUY4IeD9eYH8YHoAUkpFOqMdk0TJokM2kwbJB914YpHMMTNc5GucQzlDwNL
         iZDGCyGWiR7lr7LhIzEdY4hoxGiDdiJOv4bfA4CQJvTIBBVQfNYHHqiZ4OT4XipYrstj
         uT8IkBoKzeIN4rL8+OobbNa0kgjcc4uMTIg50P/1VdibiyXoPJPdSin+cIbUAnFb1HE+
         FYpKZJ2aLtN3XibrwJgGPHPRm4CAmVQSwv+o9WMifYw2+rNE7ONrnJrQYxCeFyDN5dNv
         o6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2iN9EGLEph4xOa1rzlV6HP0Zqf6BhRdNyhQVEqdz5GI=;
        b=V3wfbcUeBFKRjY/CTONZW1cStLfKLRld+V2os+PISyTTNzvXkTQjzeLDOXeQIE2xKg
         G923XJLzlPVhjgVxoyTGUKBlsIEb/4bV6Dd0v3VPcU8i/hxH3mElxKxZaO2wO64+v96e
         goWRo+6jXlB47XabUV/gdOmOWyh1EqR41vr1mZUqYPxdQqj7sOAFjRV2QWHwXo8YvtOY
         l15sW9QrtCI6TV9LK6O+4EmWSdF2hR+NQmvSxclTSDt5TqdzNnOljCW/dFhiilFc5wO2
         nJAC1AKCWfq7AHRk0cKpd8ZcQs7QhzBSnT9AJVWgBPpdxjyrjd5vXhXRB47nrfjSeHwL
         50TA==
X-Gm-Message-State: AOAM531A4IL9YOcn65uDpDA3/0U7awhD3E/IrCdWcQgyr9RARszKmw+D
        kOnxf8nw/9tLFQM56Ee+dwE=
X-Google-Smtp-Source: ABdhPJwWUoYbMtFJirfZTUsl99jYfxQVt6E/K1jaWpkf0WlGDMgCWLERYLQGjhNeKEh7BxYOnzLZrQ==
X-Received: by 2002:a62:7ed4:0:b0:4bb:5951:aac7 with SMTP id z203-20020a627ed4000000b004bb5951aac7mr54243976pfc.31.1641364938244;
        Tue, 04 Jan 2022 22:42:18 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n34sm41687462pfv.129.2022.01.04.22.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 22:42:17 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     mathieu.poirier@linaro.org
Cc:     bjorn.andersson@linaro.org, linmq006@gmail.com,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        ohad@wizery.com
Subject: [PATCH v2] remoteproc: Fix NULL vs IS_ERR() checking in rproc_create_trace_file
Date:   Wed,  5 Jan 2022 06:42:01 +0000
Message-Id: <20220105064201.3907-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104174623.GA540353@p14s>
References: <20220104174623.GA540353@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() function doesn't return NULL.
It returns error pointers. Fix check in rproc_create_trace_file
and make it returns return error pointers.
Fix check in rproc_handle_trace propagate the error code.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- return PTR_ERR(tfile) in rproc_create_trace_file
- fix check in rproc_handle_trace()
---
 drivers/remoteproc/remoteproc_core.c    | 6 ++++--
 drivers/remoteproc/remoteproc_debugfs.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index b5a1e3b697d9..c1aa7272da1e 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -390,9 +390,9 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 
 	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
 				    &trace_rproc_ops);
-	if (!tfile) {
+	if (IS_ERR(tfile)) {
 		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
-		return NULL;
+		return PTR_ERR(tfile);
 	}
 
 	return tfile;
-- 
2.17.1

