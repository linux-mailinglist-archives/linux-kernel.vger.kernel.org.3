Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD852F767
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353306AbiEUBx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiEUBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:53:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED997195BE5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:53:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l14so9433885pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9WAfYeuw2rM/x9RDm1gVc1LuP/yWR8j3Z6vMIFpmHE=;
        b=AEP0hwK7eENdujB43s0AppydtVZW8WoJ97TELyc6SbvsrUEE3OMviBxGDctnbSTa7m
         Vqj6z2y2mJjyte/ZWcrTBkuHCO3TMas5gqAPbhRMaBSNa8mUi597dM6ulffqHUTDELci
         1UM3CtQZM+O06orSWrLuGbUYnCIH9ePZWrDvfbI+IF2dIKp7uYARvvZG/pli2wFQsJu4
         k2DDVfr6KU7HdDE47gzawF4gsyVKVicIC+L1zCMqOj1Hv0BF2LZRZSVsOwa9vyucfa6j
         frXtEM+oi/dVPAUFVZ1LwHsglkv0o4QYnpR+AF+H+ZuP8x2tpEa+Jq/bKvrZho/8ZWhj
         MIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9WAfYeuw2rM/x9RDm1gVc1LuP/yWR8j3Z6vMIFpmHE=;
        b=ZWj7kAAQeaWT2AtK51vTHfKIMBfSs6pw1999s1hyRNSWF6OPUQNKv8stz0H+CpoMNA
         LucMnAtd4MA/toE4DPGg5r4aPCNPQpNjhVCz8UjVRm+bN/NZV49BMJlICRO1C5PROA2S
         lQdZ0udB1gH2tdCeKRBhyz/v9tRlQ1LU+7F9bK2RHr7rt0aG7459gfQsDOb6C1/5EXgd
         xRDBA48htkbXSSHKyrmdB0ckQ+rHHd1fRXdMRCQG5AUzgC2a2MYZy/uDjE6660lKjwYx
         8uK8pEuipMceN1s/lD6tixUcD6dJzN5d8uUaCkmFXRwO6UvaDh2lhHoSSDuJH6dlx9B5
         Q3Cw==
X-Gm-Message-State: AOAM531XyKTNO6mqpKvluhyXNVBLux/xSYKLaKxGJD8+xFPqRryBEQAb
        4DUTt5VlHXfiY7oqEoh8YeF6cqg/ytY=
X-Google-Smtp-Source: ABdhPJwYl1UI4zWLTkjd6jq9LfcEw83cmeNVHfA1KrzsYl8aFhrN6XVsEkKFo9Dxncisbmtie5hU5A==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id h1-20020a170902b94100b0014daf723f23mr12589600pls.6.1653098029956;
        Fri, 20 May 2022 18:53:49 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f78d00b0015e8d4eb242sm363598pln.140.2022.05.20.18.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 18:53:49 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Kees Cook <keescook@chromium.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] openrisc: Allow power off handler overriding
Date:   Sat, 21 May 2022 10:53:21 +0900
Message-Id: <20220521015322.188707-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
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

The OpenRISC platform always defines a default pm_power_off hanlder
which is only useful for simulators.  Having this set also means power
management drivers like syscon-power are not able to wire in their own
pm_power_off handlers.

Fix this by not setting the pm_power_off handler by default and fallback
to the simulator power off handler if no handler is set.

This has been tested with a new OpenRISC virt platform I am working on
for QEMU.

  https://github.com/stffrdhrn/qemu/commits/or1k-virt

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..1cca89a3b0c8 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -60,6 +60,16 @@ void machine_restart(char *cmd)
 	while (1);
 }
 
+/*
+ * This is used if pm_power_off has not been set by a power management
+ * driver, in this case we can assume we are on a simulator.  On
+ * OpenRISC simulators l.nop 1 will trigger the simulator exit.
+ */
+static void default_power_off(void)
+{
+	__asm__("l.nop 1");
+}
+
 /*
  * Similar to machine_power_off, but don't shut off power.  Add code
  * here to freeze the system for e.g. post-mortem debug purpose when
@@ -75,7 +85,10 @@ void machine_halt(void)
 void machine_power_off(void)
 {
 	printk(KERN_INFO "*** MACHINE POWER OFF ***\n");
-	__asm__("l.nop 1");
+	if (pm_power_off != NULL)
+		pm_power_off();
+	else
+		default_power_off();
 }
 
 /*
@@ -89,7 +102,7 @@ void arch_cpu_idle(void)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
 
-void (*pm_power_off) (void) = machine_power_off;
+void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
 /*
-- 
2.31.1

