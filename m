Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBC4969EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiAVDzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiAVDy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:54:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D1BC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w190so4424579pfw.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYdDKM03pUu8N31R+N2Sqs9jO4GAOic0QVQiqI/HaA0=;
        b=AL2qCcPoqTFgjUzcFRRvL/VvqnFeTVVqoh4+z1cDdox9JJR+seu/JofKDmnNLqorsm
         lKQZA5LxkK+eEjxZgNTLx6uT2x2yQYek1gmIgOohxsef9l/nMjwN37YUi+EbZYX1XkrN
         N/POapTPbDWDWF2o7bdFQS0bDx0H8xsIs0fJs+mUnMIjY40M535YCAKh+cgcTxWldvMw
         e8u/Rr3NakeU8KYtuBAwmGWOjeTv16t1rquUOPETA4WpswWl3rbb0gDzCnVs2DGT8ge9
         MwdY6QO0rFMdLKJ3PFp6DgxnhUE7qP8NtL5GLTRQKtkbnHgFCEFUvAd9ISk3o8T0epqU
         oLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYdDKM03pUu8N31R+N2Sqs9jO4GAOic0QVQiqI/HaA0=;
        b=Yf4S3eKjRd00n77b4aPjOE6hrGGuTyuCiFiKovkp9OpFx/lywAhTaZZWi9oNamV4k8
         toRD7YG0VneOx/DMj2yMnCrRSazH43gghCOK3YNwBO6W1SrM62xpm2G9uTOz+HB2Inx5
         bJ24i8kyQMmogVwYUY7qyz+Yd/zHKCGu3NlYodhQ2ITnM+jz5agNOf7tUqT1fV+ct9IY
         isflVv2TBcUoc8ZIZRXmMPs8nUwnB1J/ZIrhSZrvOtMyPaQ4seIox3mSNwJLZJsAlnAr
         +sRz2fwGfVFlDK1AsckDhJsAXPH9mh9B3Y77CuT5bCGt8KFseOTy5z2/M9vZx92YpBvM
         sdGg==
X-Gm-Message-State: AOAM533D7Ju+w2ec7YXLMM0MgoYsusrQ6U74xzDpAu2bzx9vK3oj7MIC
        lgPK1HPGsueZ61zfz6AYg1c=
X-Google-Smtp-Source: ABdhPJw070FOByJBVA42p0u7yayirhUO5FRDBBLKlCn0n55ddqhnL/gfrRUE2tQjo3x9yiLZseeJRA==
X-Received: by 2002:a05:6a00:810:b0:4c1:e21d:a900 with SMTP id m16-20020a056a00081000b004c1e21da900mr6325088pfk.6.1642823697311;
        Fri, 21 Jan 2022 19:54:57 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm667255pjm.1.2022.01.21.19.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:54:56 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] firmware: psci: Export a couple of suspend symbols
Date:   Fri, 21 Jan 2022 19:54:18 -0800
Message-Id: <20220122035421.4086618-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export psci_system_suspend_enter() and psci_cpu_suspend_enter() for
the Broadcom STB PSCI extension to be usable and built as a loadable
module.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/psci/psci.c | 9 ++++++++-
 include/linux/psci.h         | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..9a60e340c248 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -355,7 +355,13 @@ int psci_cpu_suspend_enter(u32 state)
 
 	return ret;
 }
+#else
+int psci_cpu_suspend_enter(u32 state)
+{
+	return -EOPNOTSUPP;
+}
 #endif
+EXPORT_SYMBOL_GPL(psci_cpu_suspend_enter);
 
 static int psci_system_suspend(unsigned long unused)
 {
@@ -365,10 +371,11 @@ static int psci_system_suspend(unsigned long unused)
 			      pa_cpu_resume, 0, 0);
 }
 
-static int psci_system_suspend_enter(suspend_state_t state)
+int psci_system_suspend_enter(suspend_state_t state)
 {
 	return cpu_suspend(0, psci_system_suspend);
 }
+EXPORT_SYMBOL_GPL(psci_system_suspend_enter);
 
 static const struct platform_suspend_ops psci_suspend_ops = {
 	.valid          = suspend_valid_only_mem,
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc4..ffeba6b08e10 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -9,6 +9,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
 #include <linux/types.h>
 
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
@@ -17,6 +18,7 @@
 bool psci_tos_resident_on(int cpu);
 
 int psci_cpu_suspend_enter(u32 state);
+int psci_system_suspend_enter(suspend_state_t state);
 bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
-- 
2.25.1

