Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081634B29C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiBKQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:10:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbiBKQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02098188
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644595843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wv4wDMknRhoRv5J/R0DKZOmWjk7EJX8SY/gPCW59QMU=;
        b=gZFzHcxLzRH9Ji7nI8vbGX1vK/rzACcQVcDJGEheEzL+WtGL9ZjuWaNfqTLl2ntIp0DxyF
        3RQzqWg/7VDOIROxJer4k/F+c6mpK9f03A4Eati4EtDAnrY7MyG0ILPFe2ILzA0q2iI5Z7
        wIu6lk2nCxgHTZkCnoOH18c+1zCzeyM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-sZ9GpNCjMMmUZNLqwwbTmg-1; Fri, 11 Feb 2022 11:10:42 -0500
X-MC-Unique: sZ9GpNCjMMmUZNLqwwbTmg-1
Received: by mail-oi1-f200.google.com with SMTP id bx17-20020a0568081b1100b002d2e2df9e60so2407118oib.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wv4wDMknRhoRv5J/R0DKZOmWjk7EJX8SY/gPCW59QMU=;
        b=pdEHVgcpsZ9G9HshRbztP5jCc+XetlxxeBGTtYf6Jgu7xYzK1elYPejNrNZTEb1ZhJ
         GnYb1W8F1ZCAU50KNp2zblw+M72x5Yp2JCsls/dTtDEG7gTNZHIAhiCpfag1hQed/tXb
         Z6zadDs/rQcBwgOGcLm2YvVLve/7pMusUCeSibrXvxjYmR4CcBuvXQRxJ8M9ymowsxGa
         vnck0ey4V/EvpQDhGkvxLDADzUHmUFOKFumdtzbj/lm8xC6V7/q5mQxh4tKIwS5PveSw
         Y4feL647P8P3r686h/cSicAjiyKdXHdneyUYzTcekge7Yp10Yly2B02Lk3erVw+0EJwv
         AY+w==
X-Gm-Message-State: AOAM531uncBlqSzuXqBMG2EFLhzADuMcp8sqQ5GNc59lA3nhL/6JQw99
        unoz7Z2b9OwhzPVLrBVBakzch3JwpzmTs9DUcNj6V72g6QRPRzPnIpCj7LsWi2nRb88jQUYcBdl
        MIFCy+yC4Xf3F0T+c3UnRQv2C
X-Received: by 2002:a9d:6086:: with SMTP id m6mr854392otj.284.1644595840855;
        Fri, 11 Feb 2022 08:10:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu+zFXmT2uhpj6XQra+rL5A6s/OVXMaLY1RwA874o6rssX56oeYMdm1pSJ+FREMEUciMTQng==
X-Received: by 2002:a9d:6086:: with SMTP id m6mr854384otj.284.1644595840684;
        Fri, 11 Feb 2022 08:10:40 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d14sm9532779ooh.44.2022.02.11.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:10:40 -0800 (PST)
From:   trix@redhat.com
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PM: cleanup comments
Date:   Fri, 11 Feb 2022 08:10:27 -0800
Message-Id: <20220211161027.2516447-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'the'.
Replace the second 'of' with 'the'.
Replace 'couter' with 'counter'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/base/power/wakeirq.c | 2 +-
 drivers/base/power/wakeup.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 0004db4a9d3b..d487a6bac630 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
  *
  * Enables wakeirq conditionally. We need to enable wake-up interrupt
  * lazily on the first rpm_suspend(). This is needed as the consumer device
- * starts in RPM_SUSPENDED state, and the the first pm_runtime_get() would
+ * starts in RPM_SUSPENDED state, and the first pm_runtime_get() would
  * otherwise try to disable already disabled wakeirq. The wake-up interrupt
  * starts disabled with IRQ_NOAUTOEN set.
  *
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 8666590201c9..a57d469676ca 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -587,7 +587,7 @@ static bool wakeup_source_not_registered(struct wakeup_source *ws)
  * @ws: Wakeup source to handle.
  *
  * Update the @ws' statistics and, if @ws has just been activated, notify the PM
- * core of the event by incrementing the counter of of wakeup events being
+ * core of the event by incrementing the counter of the wakeup events being
  * processed.
  */
 static void wakeup_source_activate(struct wakeup_source *ws)
@@ -733,7 +733,7 @@ static void wakeup_source_deactivate(struct wakeup_source *ws)
 
 	/*
 	 * Increment the counter of registered wakeup events and decrement the
-	 * couter of wakeup events in progress simultaneously.
+	 * counter of wakeup events in progress simultaneously.
 	 */
 	cec = atomic_add_return(MAX_IN_PROGRESS, &combined_event_count);
 	trace_wakeup_source_deactivate(ws->name, cec);
-- 
2.26.3

