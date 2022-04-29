Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C46515681
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiD2VRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiD2VRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B07D3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651266868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRdwdJR3OoR56yf6TqIrpiS+NzNySH2VSMNhpjHFJH4=;
        b=ebsBpLAU7gUxxaX+4eAneVpD71f0zLNyL7dm5wNNsOewlQ+biZdqBsWG/YLDHy6wpxR4Wh
        kbvzEPdsIcfYY6vzlTsCN4lZE/jom64HFMdD/FaZ+u5GpZfyyRaCiStWXh+jMD9O8X/2Fp
        5sTydSaNBwQGpkKsxPUMziYwe0jGEuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-XVnx60pGMza8UVmti2IyWw-1; Fri, 29 Apr 2022 17:14:24 -0400
X-MC-Unique: XVnx60pGMza8UVmti2IyWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5C9E811E75;
        Fri, 29 Apr 2022 21:14:23 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.8.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52771111CD36;
        Fri, 29 Apr 2022 21:14:23 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: Don't probe 2nd fan if enabled by quirk
Date:   Fri, 29 Apr 2022 17:14:18 -0400
Message-Id: <20220429211418.4546-3-lyude@redhat.com>
In-Reply-To: <20220429211418.4546-1-lyude@redhat.com>
References: <20220429211418.4546-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we already know that the system in question has a quirk telling us that
the system has a second fan, there's no purpose in probing the second fan -
especially when probing the second fan may not work properly with systems
relying on quirks.

Also, convert all of the conditionals here into a single group of if/else
statements. This is because there's no situations where there's more then
one quirk on a device.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
Cc: Mark Pearson <markpearson@lenovo.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Mark Gross <markgross@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9067fd0a945c..677822b5d4b4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8747,26 +8747,25 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 			unsigned int speed;
 
 			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
-			if (quirks & TPACPI_FAN_Q1)
+			if (quirks & TPACPI_FAN_Q1) {
 				fan_quirk1_setup();
-			if (quirks & TPACPI_FAN_2FAN) {
+			} else if (quirks & TPACPI_FAN_2FAN) {
 				tp_features.second_fan = 1;
 				pr_info("secondary fan support enabled\n");
-			}
-			if (quirks & TPACPI_FAN_2CTL) {
+			} else if (quirks & TPACPI_FAN_2CTL) {
 				tp_features.second_fan = 1;
 				tp_features.second_fan_ctl = 1;
 				pr_info("secondary fan control enabled\n");
+			} else {
+				/* Try and probe the 2nd fan */
+				res = fan2_get_speed(&speed);
+				if (res >= 0) {
+					/* It responded - so let's assume it's there */
+					tp_features.second_fan = 1;
+					tp_features.second_fan_ctl = 1;
+					pr_info("secondary fan control detected & enabled\n");
+				}
 			}
-			/* Try and probe the 2nd fan */
-			res = fan2_get_speed(&speed);
-			if (res >= 0) {
-				/* It responded - so let's assume it's there */
-				tp_features.second_fan = 1;
-				tp_features.second_fan_ctl = 1;
-				pr_info("secondary fan control detected & enabled\n");
-			}
-
 		} else {
 			pr_err("ThinkPad ACPI EC access misbehaving, fan status and control unavailable\n");
 			return -ENODEV;
-- 
2.35.1

