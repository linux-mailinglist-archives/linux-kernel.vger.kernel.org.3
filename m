Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C74C88B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiCAKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiCAKBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:01:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E28CD85
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:01:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt27so1274638ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+FjqKF6453USE5UorZH/Z4JUOdGVGV9jUTa12s/aMk=;
        b=S4n2H8tqOrMOrc7dLZzaUxVja5uNy4JSf1sqx7VgPpEYHS1ljkPZxwlzlYOK3tweOx
         trnal6uqjgt1gxACMHfdx3g4ynpMge5cz1aWmZGqBadshPqrnKPCQ+njdSKetpAvP4NH
         Hym5gl/S4HYw5Vuo/I0b4xnUiGkXJnQ5Z0MG4hd3nQrKIBK1Rbux4KgtBJ1LRE/AAEQS
         6NS+Vm5HjHHkcP+ckz4RFnS1DZzm9wsbfx+E2Rj4nA+57ZFYIRLLGmEjWweKGpC3ZBVT
         8xjVcJnSn05gkOckvRq7H3ibAUoBkvAykaRVaQ1SQ8wBQbDiE0Efjfm1jrowEyVSzM11
         smOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+FjqKF6453USE5UorZH/Z4JUOdGVGV9jUTa12s/aMk=;
        b=ysH+NYAPEGPEAJG58jCQarcyHIQoasnQe7eRclX6YRRg6actjCj0ynKZCHXmH+viFz
         yl1fDn1ukMao4XzhQ+Z9LpNMKkON+kTEU3vuv6bf3121nyAaCA9ynGLdqqh0v2Na8ole
         hilMPwPDULRcWZADOznMU/R/obEGoo0YPOWX9DdpRyVmy3IXK6n2OmOITVN+7zxem6qT
         8mSjUImt0vCyYJOWOD7cSmU4W5OYW5jq3DOWzmF/guxj4TyQTz9AsvcqvigBVBIp3kte
         jVE/q/4l8Ypewbxox2/a8/uqb59QxuNblQNMcVgVtXIgI8Aknc+UGqbRjFxMLpaaA6RD
         D7KA==
X-Gm-Message-State: AOAM533rV6rtwis4WN7BxtRJ4H7awe7O2AGbtgYP8m9HNquKZeGd4x1E
        dQxqtLNtK6nr9Sd9i8mh4QI=
X-Google-Smtp-Source: ABdhPJxUJvqOJfF52Tpegzo4zDYXNA+3VHuXq5tBl3sLguF2B8LNdrA494EySAdnP2QS2rkHyFr9gg==
X-Received: by 2002:a17:906:26d8:b0:6d2:515:9bdb with SMTP id u24-20020a17090626d800b006d205159bdbmr18356035ejc.261.1646128869913;
        Tue, 01 Mar 2022 02:01:09 -0800 (PST)
Received: from localhost.localdomain ([185.239.71.98])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b0040f682ee13dsm6990067edv.26.2022.03.01.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:01:09 -0800 (PST)
From:   Xiaolong Huang <butterflyhuangxx@gmail.com>
To:     fei1.li@intel.com, shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>
Subject: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Date:   Tue,  1 Mar 2022 18:00:59 +0800
Message-Id: <20220301100059.1834362-1-butterflyhuangxx@gmail.com>
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

The vm_param and cpu_regs need to be freed via kfree() before return -EINVAL error.

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
-- 
2.25.1

