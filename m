Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB21562AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGAExc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGAExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:53:30 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55F65D7A;
        Thu, 30 Jun 2022 21:53:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u14so2994295qvv.2;
        Thu, 30 Jun 2022 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCRTnBAux6caQ40uFlyxkDENcZIAIY4tT/Z15xVlwZs=;
        b=n4cwRNjWiYrHDnntdseMdfJJdukRAoowkS+MkJn8+imYIXAsjvZqI6PcQWaDst9co7
         TwixdYfr4kafBHhH5TELmbemJK79aG66QbudaIyAfLiiLVQtHlEX+V5m3x0FGinmktQm
         KeZ0LN1J+E2asOIXshzLXhcnvoGVex+EA6OscU1XTQoSw6mWGMq/UXWGP5RsSyFSBlVE
         8J5DA5Wq3u9nRlNSFTRgQLVo1xnNJmkKh5IzyxSPfpYeitdDJmTsI4giijmXX8JtIf8s
         eZBSahE4S/mcm6MWLoH9/vttgtvfDKkt96+FxyU+qaKo5C3TNUNzXN1aQ/dJ022TlGUg
         RRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCRTnBAux6caQ40uFlyxkDENcZIAIY4tT/Z15xVlwZs=;
        b=6QlKfjKeWbDffYAug+PgiZsyZMJhyDammUmw14lcuw36HtCTLi6dhfVScvMkQC3wb/
         iVzfZSmPk34XgpVvdCYGDZclQdl51zKSWGJ2QIjhj4yytlMuOTICpFK+kQ5BK5vMKlxw
         yI6AsJ7vFKk7DZmnaMu2DJe/fn4oaj85VRZI6vgSaTNVobIRfEWdkzpAfITuhc5+WHYM
         XVwDyUEmVKZ/K4rNPzCeFOJ9Rd6KCnKOPDfIrAuwmKD59ICrLhiHzzuV2kAigB1roSux
         kBB6UfRMXsjXdod3ZM9IbhQF1R1wfjzQ8LGy1BQD1MtVHVFw4rlUIa+0sDrFhUQjRv+N
         TlHw==
X-Gm-Message-State: AJIora88vozedk8VwgPqrGQMjEzRRk0+s5Ll+Zv14ZKmmWiYHtsnqRih
        Sht4r390UeFJXB4wSHQlhAWyXFMafwveYA==
X-Google-Smtp-Source: AGRyM1sW4RlGOVt+jzTxJzrAAPBqPkB2B8fVVtEY3bIwtuPAzfreXypswkGDLv8VCJdCQRKzbmgGzw==
X-Received: by 2002:a05:622a:8c:b0:31b:f355:4d6e with SMTP id o12-20020a05622a008c00b0031bf3554d6emr10661613qtw.50.1656651204404;
        Thu, 30 Jun 2022 21:53:24 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm18459756qko.127.2022.06.30.21.53.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 21:53:23 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] PM / devfreq: Strengthen the handling of governor null pointer
Date:   Fri,  1 Jul 2022 12:53:15 +0800
Message-Id: <20220701045315.61456-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When new governor start failed & the old governor start failed too,
or the governor is removed, the devfreq->governor will be NULL, but
we still access it's member from devfreq->governor->name, which will
be a crash.

To fix it, change the position of Null pointer judgment before usage.

Another, If the governor is NULL, we try to assign a new governor to
it.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/devfreq/devfreq.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 01474daf4548..30d7f8c128a6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1270,7 +1270,13 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor->name, governor->name,
+		/*
+		 * When new governor start failed & the old governor start
+		 * failed too. devfreq->governor will be NULL.
+		 * Try to assign the new governor to this devfreq device.
+		 */
+		if (!devfreq->governor ||
+			!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
 			if (devfreq->governor) {
@@ -1358,15 +1364,15 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
+		/* we should have a devfreq governor! */
+		if (!devfreq->governor) {
+			dev_warn(dev, "%s: Governor %s NOT present\n",
+				__func__, governor->name);
+			continue;
+		}
+
 		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
-			/* we should have a devfreq governor! */
-			if (!devfreq->governor) {
-				dev_warn(dev, "%s: Governor %s NOT present\n",
-					 __func__, governor->name);
-				continue;
-				/* Fall through */
-			}
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
 			if (ret) {
-- 
2.29.0

