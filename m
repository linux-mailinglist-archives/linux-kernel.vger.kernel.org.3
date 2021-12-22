Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D1747D5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbhLVRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhLVRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640193943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/NeXxN2n8+g1U9GWtGeRI9IfjR6ngRoHtmD5AubDq8I=;
        b=gnG/8RvdVeB6yzSFlXSQ4vXfhodhPwuI/e6u6VkB49eLkAiXCdsZMG7HbP3hLGwAXp1cG8
        NoQRDJJjd4LWeCOwf55Gzoqf7Q/pXSMZ8piPMdwJTirSfbMYoxrp1qDEBraWEHRXOsCTJU
        FxPUljLv4LgPFSuQhWFu8Y4Y0QHAK6E=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-2zF8YGKaN7qEB_C1SHMH2g-1; Wed, 22 Dec 2021 12:25:42 -0500
X-MC-Unique: 2zF8YGKaN7qEB_C1SHMH2g-1
Received: by mail-oo1-f72.google.com with SMTP id w25-20020a4a6d59000000b002daaed72624so1264002oof.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NeXxN2n8+g1U9GWtGeRI9IfjR6ngRoHtmD5AubDq8I=;
        b=qVrGRZZydz+oaH7JLsoBrQyFjZHE6b3CzfPUg9hENesGfPS/aE8hkhANuSnc57IfV9
         5HVvDEnDMwGVL9ax/enoLHvitWk4M5I0La4AUvkiskptDfa+M6i7COFg3jp2Don2lXtg
         XbexOP91Yy+iyFhsSc6gvXhly7SMVEJVJ+5dqaf/Swm8kIXXrzCdZBYjw8zT9Jc3vHU1
         DoBsxQx41ZL4W3VBzvbmf21ofcyln8s5/DQmROf776n/DnbvpnxNwNgI5lMhMx+mCeHx
         dwZH3cgKMk33xK0bJHzNIzWDZCuEajWi18Y9n5FyuUEZUkcqGEON2DBqnhgo2A8Eo41X
         1KlA==
X-Gm-Message-State: AOAM5339UIqjfumb+Dut+cxj4fthhirBtLD6/i476aJcbIxmpY2ZcR9S
        qn67PWkinDiMm78evv2b3c4ttLcEUqeczvQy9r/tuPmE8tryZCbPDjMqv2JbTFSc3bat3azOtTk
        xgjTtEHfOH00t7TioKbhFbhWW
X-Received: by 2002:a05:6830:1df4:: with SMTP id b20mr814169otj.32.1640193941855;
        Wed, 22 Dec 2021 09:25:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFObxFmLR75vlPPpw9nVz+jLYoKDYAc9NjNPMcmdyD4rkx4NCkyf1iYZtbGszFb0pG7UTHoQ==
X-Received: by 2002:a05:6830:1df4:: with SMTP id b20mr814158otj.32.1640193941660;
        Wed, 22 Dec 2021 09:25:41 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w29sm476036ooe.25.2021.12.22.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:25:41 -0800 (PST)
From:   trix@redhat.com
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] firmware: arm_scmi: replace resevered identifiers in macros
Date:   Wed, 22 Dec 2021 09:25:19 -0800
Message-Id: <20211222172519.3209478-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Identifiers starting with __ are resevered.  Replace __X with X.

The arguments to these macros are pointers.  The macros only reads
values.  There is no need to make copies of the pointers, use them
directly.

Fixes: a287126c31ab ("firmware: arm_scmi: Add configurable polling mode for transports")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/firmware/arm_scmi/driver.c | 31 ++++++++----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b4bbfe89368df..d2fcfa9da931c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -36,29 +36,14 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
-#define IS_POLLING_REQUIRED(__c, __i)					\
-	((__c)->no_completion_irq || (__i)->desc->force_polling)	\
-
-#define IS_TRANSPORT_POLLING_CAPABLE(__i)				\
-({									\
-	bool __ret;							\
-	typeof(__i) i_ = __i;						\
-									\
-	__ret = ((i_)->desc->ops->poll_done ||				\
-			(i_)->desc->sync_cmds_completed_on_ret);	\
-	__ret;								\
-})
-
-#define IS_POLLING_ENABLED(__c, __i)					\
-({									\
-	bool __ret;							\
-	typeof(__c) c_ = __c;						\
-	typeof(__i) i_ = __i;						\
-									\
-	__ret = (IS_POLLING_REQUIRED(c_, i_) &&				\
-			IS_TRANSPORT_POLLING_CAPABLE(i_));		\
-	__ret;								\
-})
+#define IS_POLLING_REQUIRED(c, i)					\
+	((c)->no_completion_irq || (i)->desc->force_polling)
+
+#define IS_TRANSPORT_POLLING_CAPABLE(i)					\
+	((i)->desc->ops->poll_done || (i)->desc->sync_cmds_completed_on_ret)
+
+#define IS_POLLING_ENABLED(c, i)					\
+	(IS_POLLING_REQUIRED(c, i) && IS_TRANSPORT_POLLING_CAPABLE(i))
 
 enum scmi_error_codes {
 	SCMI_SUCCESS = 0,	/* Success */
-- 
2.26.3

