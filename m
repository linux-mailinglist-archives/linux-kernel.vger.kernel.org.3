Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277884D133C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbiCHJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:21:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AE3D1E2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:20:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qt6so37717390ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqtUPtymwD8nodVgRYs1OukKwm9TtrOarLaAI55BY/g=;
        b=HmAOr0EgeUBHvPZHmCKG4kogtaNj9ER/XOL2oeYxikeFqrOP+56VRcOO2TyJxjPGsS
         DqtrePggGOxJ0XNuBL/a98xyBbGPCP/T0URdliudkm0YcBtU5XD7doKAr0Em17dlVaf5
         +gCdPZQv7q9vlasDvLyIZiF8n8vaHt6TMEngErSG6+j7U7ii/UKf8jEXY/DWlyqCdz0k
         Bo5hklneevWe1eQd/I5cXfHrPD9R6opXOjvPtCy6uxor/m+ABNeysfeOTY6YlbZb8xU+
         J+aJE59tSdewBb+IQc1BGIYSWkVFP0ablcyRpqpXnWJZ5qaYUsv65yeRiagVXQ2S7Rh+
         9kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqtUPtymwD8nodVgRYs1OukKwm9TtrOarLaAI55BY/g=;
        b=muHhOFixcVsOji44JsxvlhUiEX/89AvGJJ+Ea3amGJ/9CzrNFdIwk97PMhlIAJqYC5
         fSonftkR4ZX4TeGWOC+zYKYdjap7KSF6UUn26+KgsBMcFH5qZ7qxgP10z+OQ6wLlNqTo
         7DoZDNReZKnY7UxzmOalQyDgQ2rzkrjCc4SQph0HDBIwzyD2QYvfgFkPeR4STJtIyyiE
         TeSnIVFUxdiC1WWcTRLclGzn3QnLQqlJbRePAvFD2MzV5sCi1CddesCRLmB1V9ZAnkTp
         ooD0KJizMQdcPjwdU7rRNL/3k0EM5TLPS11E00KprB/McIU1e9p6LnC48xEezTibXcGF
         loNw==
X-Gm-Message-State: AOAM533NnifKJR/dPmbxePyP5HdpDuKaR3TspP0+pTNGC9HhseKMwJlo
        bgSC0xnj5eYFAraf+LCjJ1k=
X-Google-Smtp-Source: ABdhPJzFRBpvTX/II9tuHgaB5BDWG4wldJf92kFKUtz1rpjJ8XSwyFROqu6361kWne0pIk9Jh64J9A==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr12581079ejs.105.1646731257375;
        Tue, 08 Mar 2022 01:20:57 -0800 (PST)
Received: from localhost.localdomain ([185.239.71.98])
        by smtp.gmail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm7410951edk.13.2022.03.08.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:20:56 -0800 (PST)
From:   Xiaolong Huang <butterflyhuangxx@gmail.com>
To:     gregkh@linuxfoundation.org, fei1.li@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>
Subject: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Date:   Tue,  8 Mar 2022 17:20:47 +0800
Message-Id: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
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
Signed-off-by: Fei Li <fei1.li@intel.com>
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

