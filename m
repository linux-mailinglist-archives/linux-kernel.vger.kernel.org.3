Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4554E686A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352528AbiCXSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347805AbiCXSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:14:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5DB6E5E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:12:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so3047880plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVas7rSAou2utAAYyG+KdmDyPsGts9SfpHbo6bgzccc=;
        b=fg0CQFG+ey99c3Kw8AMhUXok74QqW5Uri8wM4K8vYFBngy7cnH2EGVVvS1MwVRJDh8
         FJqDB/YbdfxfDGw1AU/fqYF19SMpg4wkOrlQtNpN6zeSBgOGX33dQxj/2Wtm9O/IdlNJ
         cKgTDTSyusZTq6+NV5sLmiX7qRTEtP/2avXv2Pju+TbbT7Hr4QLKEWykL9GZ4KQ7AALp
         D7VEDHxTqJT3v4rz99vpvkQz/dNYHCPZh3QZeqgjZ0GgFyGF7SHV7vNnPMkecFo8pN5L
         lXSyUMHD7NWagG0/OpCAxofnnlP47gDraXCq5QpR8whR8xYz95E+8xNrRLpnGKRYSzck
         rWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVas7rSAou2utAAYyG+KdmDyPsGts9SfpHbo6bgzccc=;
        b=YsAW/s1S2Cx2UtZXedzzlpMVItpAcZCCPDa7xMzpF8enj8HKAMnLjCd3aE0t2hg2Ae
         oyJMjpyP+pMDrbO6RoJi23mvXB8hO2HlpB+eo+pgNqYOnY8kcqunPGiS1zQ9o91LeX9D
         atV08MJlaRSrkmjG1igm94Xo+6hREcRoi/ZPa45ip+kI2VdXh3ocv9W1KbprlGFqtBX5
         2nPvJjotk8232VOibQAzCjMHQIxsIZ9ByGftgH3vtopukBKtzQVjxwohNdmVWNnBSf8H
         7ZyvaqltcpQzwptqGEriUBJlfZNo+YRvyzWpZOZWC0ZJJyGbKNzCyoPqByLb3TAumxke
         nZ+A==
X-Gm-Message-State: AOAM533KKXBabUA62qwdg3cYNkojOQ6QJwq3QllxmeOOQJKfqllM6dyf
        16cLCoPifTR/jvk34qD2s1sy
X-Google-Smtp-Source: ABdhPJwZHFFgB0y5nweFFiqApmDXuKr5fZr1/oRbmXVFv0+V0BJHSHh3uwGMsw3KFY4ENUbmQbgzhg==
X-Received: by 2002:a17:902:b68c:b0:153:bd06:85ad with SMTP id c12-20020a170902b68c00b00153bd0685admr7133646pls.99.1648145551272;
        Thu, 24 Mar 2022 11:12:31 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id j20-20020a62e914000000b004fa3bd9bef0sm3816013pfh.110.2022.03.24.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:12:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] remoteproc: Don't bother checking the return value of debugfs_create*
Date:   Thu, 24 Mar 2022 23:42:24 +0530
Message-Id: <20220324181224.21542-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DebugFS APIs are designed to return only the error pointers and not NULL
in the case of failure. So these return pointers are safe to be passed on
to the successive debugfs_create* APIs.

Therefore, let's just get rid of the checks.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b5a1e3b697d9..2e2c4a31c154 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -386,16 +386,8 @@ void rproc_remove_trace_file(struct dentry *tfile)
 struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 				       struct rproc_debug_trace *trace)
 {
-	struct dentry *tfile;
-
-	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
+	return debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
 				    &trace_rproc_ops);
-	if (!tfile) {
-		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
-		return NULL;
-	}
-
-	return tfile;
 }
 
 void rproc_delete_debug_dir(struct rproc *rproc)
@@ -411,8 +403,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
 		return;
 
 	rproc->dbg_dir = debugfs_create_dir(dev_name(dev), rproc_dbg);
-	if (!rproc->dbg_dir)
-		return;
 
 	debugfs_create_file("name", 0400, rproc->dbg_dir,
 			    rproc, &rproc_name_ops);
@@ -430,11 +420,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
 
 void __init rproc_init_debugfs(void)
 {
-	if (debugfs_initialized()) {
+	if (debugfs_initialized())
 		rproc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
-		if (!rproc_dbg)
-			pr_err("can't create debugfs dir\n");
-	}
 }
 
 void __exit rproc_exit_debugfs(void)
-- 
2.25.1

