Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123EC52EB19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbiETLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiETLrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:47:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31611132A2E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:47:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l14so7851695pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/sZxdnlDlYYTV9I65vLamfPMEuqzTJFo0qUtU3MH/c=;
        b=Ak6cHzelvck3fSEyxeTHG5Jn3zz9ZaGrQC/USvoekhOuDgPCrYAgFhALlMqmcVVAXe
         sJGu1ikvS+uAecJU2q58i2Mtb6TQXVBmEawybAp05td9dqE5yeYYuejS9xunzKSyGMw+
         WQjTVDfBmGC29I/xS5BtbvIjQr4pxxDX8+DDwG9eKYPa1nxUWD5UkhCbwDKAatN1cYkz
         oaVJ0a8SFJIYS3xsQf8NU0OhPDEDcExRn+XRJlYs0RA51ay6z/CjgqZe8YWq7JdXyKzc
         fns6YHIiqZ/TUTyAYyVDiWvGnDuGC2BmSaROqqUceoUJUwrOOEaSpUcHc4x7vRLh5Rx0
         e2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/sZxdnlDlYYTV9I65vLamfPMEuqzTJFo0qUtU3MH/c=;
        b=o0kYD5YjaizIlygFGigv8LFxI0cWkK3JaTvgP7CO6YszmHpDW5nzw44hRhcFf5lIhv
         uvMXgPcLTHcfipIvMjO70aImH/1xx9UAP/C7X0a4Rag8Zui4qvNU9BmwY/LkKkpcnQ7F
         LL/EJp3f5DqiMWd4hFmeCXKSm42OC1k4nKt1anguzZmaKXjiaRGaR2l8gu+Vs2Z9+VNg
         Yq4CTkVJQS4lvf7NxK2a0zn8Ld7OjKGnTmttcQLfk0Xgmk2LM4RvTghF5qyDxayzKg5a
         kukgcZVh/qH71EitFT0EY/ztMDbWKQIBhm5zCbHxrDoLPPBCf5sf2Ls7wbZmrWoq1zsv
         XS6w==
X-Gm-Message-State: AOAM530lWu5jE3y2yDViTJj8q0grgLCxH3V2GSTTBN/rsIpCriemlV0s
        AaexLKHbGvJcmmHidKtqq4Q=
X-Google-Smtp-Source: ABdhPJxDuNBZiI9/qoZrI2gREPKiHIGSoxLQth0Rnod3iVc3jAyG4J00agAeqE268h5vP42z4fSCPw==
X-Received: by 2002:a17:90a:62cb:b0:1dd:2ddd:ba8c with SMTP id k11-20020a17090a62cb00b001dd2dddba8cmr10591633pjs.226.1653047241684;
        Fri, 20 May 2022 04:47:21 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id v22-20020aa78096000000b0050dc76281d0sm1623934pff.170.2022.05.20.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:47:21 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v1] x86/vmware: use unsigned integer for shifting
Date:   Fri, 20 May 2022 17:17:12 +0530
Message-Id: <20220520114712.595583-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is implementation-defined
behaviour. Using unsigned is better option for this.

Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..7f44ea073436 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/bits.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
-	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
+	return (eax & BIT(VMWARE_CMD_VCPU_RESERVED)) == 0 &&
+	       (eax & BIT(VMWARE_CMD_LEGACY_X2APIC)) != 0;
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.36.1

