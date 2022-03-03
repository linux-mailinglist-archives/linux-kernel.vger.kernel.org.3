Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7B4CB740
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCCGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiCCGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:55:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D35016A5B0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:54:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso2047608wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 22:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7Ew53yfjewVk3HWOkuEB6l85pgjkhws9cTt9TXMGuQ=;
        b=pr4obOLhlupgLuaBUf/izWSxSovMzmddb/AVhCbU1PC44nH9PWqUXwu8rDkLwLZIXP
         Hpv0x6QzeksAZz+t+A0zu6b+mz92zDKCVYWYzQanxeRZmhNNeKx7GUzvfydev3437j0D
         4T8f2bmg98LO+FNmHGDYk15C1NR6OT2nhz/y63IpmFVxfokYbfVbwcklt3vXOXQ0Bf9w
         XMaPo+6MhRfAG7kZP3m5t0tiHE6pRbVOzAup5XVsyWNmIB4BlTVYkbOGKR0qnWwo4ybS
         Dg2ZJiwnUIHIgB/qxtHsNnP8TY889ivUBbDmM+CqDBnFDslA9f4WlaxiHmwsAlrx5hkQ
         UqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7Ew53yfjewVk3HWOkuEB6l85pgjkhws9cTt9TXMGuQ=;
        b=Kja16RIoH+ESsZq393GJ1MOR3oqvkFuVo9DUAkzGXDdiI8eDxE3VB3xdvDg7XAXqA2
         odsMsr1HM7zGZ4f1TXJIFXf6IEU0Q1YMadj5e0yJZYryBccG6eZ0ofFYQpBT2NH0u52X
         mOQF4KWRxiZnkUK0bnB+kjYXRHYUbmxj+E7+VgVPd0M1U/gQZDLRVB2WR7+YgHHi6Zhx
         c1d/52foxQE/xxRaRiu8dZ4mxWD1O6LiGSJIuHOL7IAxVklHoOvFynnqDfdVGogzOCpc
         Buv67jmgsIT7XtirL0QC3UC/c6BQ2EDKBF+GiSHTtQAxqMQtGngguzUN0AAiQgSPtizm
         tZ+w==
X-Gm-Message-State: AOAM532reET/80odZrx04fm+ocKD06cpq3UWTWMOcggigF2ehzK8AhDA
        XVGN5SFz6KuP1VO0hPmNFzU=
X-Google-Smtp-Source: ABdhPJw2uoUZvKyDoAgLWCGMAPCvsVIrIKS3kIRjPO3oQNH/HYS0Lx97JwAnRf5+oAkQEdfKN6xMYg==
X-Received: by 2002:a7b:c14c:0:b0:381:32fb:a128 with SMTP id z12-20020a7bc14c000000b0038132fba128mr2571355wmi.116.1646290483686;
        Wed, 02 Mar 2022 22:54:43 -0800 (PST)
Received: from localhost.localdomain ([185.239.71.98])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm1079902wrw.49.2022.03.02.22.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 22:54:43 -0800 (PST)
From:   Xiaolong Huang <butterflyhuangxx@gmail.com>
To:     fei1.li@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>
Subject: [RESEND PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Date:   Thu,  3 Mar 2022 14:54:00 +0800
Message-Id: <20220303065401.259202-1-butterflyhuangxx@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The vm_param and cpu_regs need to be freed via kfree()
before return -EINVAL error.

Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
---
 drivers/virt/acrn/hsm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5419794fccf1..423ea888d79a 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -136,8 +136,10 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 		if (IS_ERR(vm_param))
 			return PTR_ERR(vm_param);
 
-		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
+		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
+			kfree(vm_param);
 			return -EINVAL;
+		}
 
 		vm = acrn_vm_create(vm, vm_param);
 		if (!vm) {
@@ -182,21 +184,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(cpu_regs);
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
-			if (cpu_regs->reserved[i])
+			if (cpu_regs->reserved[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
-			if (cpu_regs->vcpu_regs.reserved_32[i])
+			if (cpu_regs->vcpu_regs.reserved_32[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
-			if (cpu_regs->vcpu_regs.reserved_64[i])
+			if (cpu_regs->vcpu_regs.reserved_64[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
 			if (cpu_regs->vcpu_regs.gdt.reserved[i] |
-			    cpu_regs->vcpu_regs.idt.reserved[i])
+			    cpu_regs->vcpu_regs.idt.reserved[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
 		if (ret < 0)

base-commit: 5859a2b1991101d6b978f3feb5325dad39421f29
-- 
2.25.1

