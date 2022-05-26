Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFEE535470
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiEZUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiEZUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36D8955AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653597115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wQbOUriGCnynaLUc5Bo76/WwyN+TFwMe7tvzUPT6f20=;
        b=LteoKDlfxC31tncHiylWAvL02YT0Qg4D5pc5nNLnYQGojfafu8YY7hZbUfzFwyH3JAZ+MQ
        7iytl4wYNaoXiVTqwvgQY3PUo/OYfb+LeleW6ov0mY/xji/K3j24Ho+GxVU718KPl65xXZ
        +/tVh4AI0dXWvueHFOS1jNUb8i8ooO4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-bnyKRFf2N3mqFq1B1yJviw-1; Thu, 26 May 2022 16:31:51 -0400
X-MC-Unique: bnyKRFf2N3mqFq1B1yJviw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992A6296A60C;
        Thu, 26 May 2022 20:31:51 +0000 (UTC)
Received: from darcari.bos.com (unknown [10.22.8.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3913D2026D64;
        Thu, 26 May 2022 20:31:51 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] platform/x86/intel: Fix pmt_crashlog array reference
Date:   Thu, 26 May 2022 16:31:40 -0400
Message-Id: <20220526203140.339120-1-darcari@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function pmt_crashlog_probe() may incorrectly reference
the 'priv->entry array' as it uses 'i' to reference the array instead
of 'priv->num_entries' as it should.  This is similar to the problem
that was addressed in pmt_telemetry_probe via commit 2cdfa0c20d58
("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic").

Cc: "David E. Box" <david.e.box@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/platform/x86/intel/pmt/crashlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index 34daf9df168b..ace1239bc0a0 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -282,7 +282,7 @@ static int pmt_crashlog_probe(struct auxiliary_device *auxdev,
 	auxiliary_set_drvdata(auxdev, priv);
 
 	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
-		struct intel_pmt_entry *entry = &priv->entry[i].entry;
+		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries].entry;
 
 		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, intel_vsec_dev, i);
 		if (ret < 0)
-- 
2.27.0

