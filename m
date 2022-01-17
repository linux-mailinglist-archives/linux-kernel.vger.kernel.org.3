Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF20D4904D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiAQJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiAQJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:28:06 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:28:06 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so1809226otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiJzkYiS8JHxjNK1yY8Lz1eEhjg/JRuoOm5z9rJq0+8=;
        b=GDNvN5rWNly2LPMsurHXtjpNJzi151UlIEbV+dJT1XG3AGQceVAA93aouVa0V+8GjX
         I3aPw+ScHrpJN6y5b4IH9f+OaXrhQD//q1+iSLBk6mK2dTmfIq8qNYiast+NzWL0LUPj
         F5szCyPPceZkA5/nIknl+LWwCLznPhnY1Au6No+5JheWlcYdTn+z4LWjsKWY6stmKu8U
         XZnqzATGvLGSLaOZlujPTsP/yffdFw68D26zO2LTBmYlmFAuujjlPQnywxINHhXIKSeN
         mvlhetY59vm8pFfmIUihyQ98bFGZkvmq9xFgXEAXStD1wh5HIHkc7InbpllqdecEgIbK
         X6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiJzkYiS8JHxjNK1yY8Lz1eEhjg/JRuoOm5z9rJq0+8=;
        b=a4PZPftV7fYFpifa+Nvl6zj+FD4TPHwNwAf4YbndQOQl9O90ZLKGEKL4LEBZ71Lid/
         iN/1jEzbX4F6Xe1qp0d0HmoBOtG6mMya2jJ+Pao6cC3Zpw8PiXwf0V+3QW0I5ctmLAdM
         mH0X2B4MPvVNkOIW1eLX4jZCYfYJVjVV2wEYdvPDpQZ8RJKWhCvG/GzfvvaMJwzPP+Y5
         VM8pXgY7Ro1qr71f5dno1gv4wF77mmcmoDBuyYW/yEnciihnFgio/AYHRZb501YkwSBs
         ZSqvSR+EwoWG30wUHScq1PaseCHbcKBBnaNUV9hDpjjSTRFrGnfIyIGqIAQJWVjJYma8
         76gg==
X-Gm-Message-State: AOAM530Ubt7Q/zxlE3pbJ9QsSnT+D7csFSIyhF/RmUfh0kWCaGScfs63
        +QnLrzIeFx39ZFq63ulpSA0=
X-Google-Smtp-Source: ABdhPJyEIx8GplQapvkHi6f0AkIX416RfX4Uj4E2J0tyK5q0ClmnV5USegDVHfCpM5u7zI0fVbkLtw==
X-Received: by 2002:a05:6830:23bc:: with SMTP id m28mr15418623ots.343.1642411685231;
        Mon, 17 Jan 2022 01:28:05 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id i7sm4943770oot.17.2022.01.17.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:28:05 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v1] genirq/msi: fix crash when handling Multi-MSI
Date:   Mon, 17 Jan 2022 01:27:59 -0800
Message-Id: <20220117092759.1619771-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_msi_domain_check_cap() could return 1 when domain does not support
multi MSI and user request multi MSI. This positive value will be used by
__pci_enable_msi_range(). In previous refactor, this positive value is
handled as error case which will cause kernel crash.

[    1.197953] BUG: KASAN: use-after-free in __pci_enable_msi_range+0x234/0x320
[    1.198327] Freed by task 1:
[    1.198327]  kfree+0x8f/0x2b0
[    1.198327]  msi_free_msi_descs_range+0xf5/0x130
[    1.198327]  msi_domain_alloc_irqs_descs_locked+0x8d/0xa0
[    1.198327]  __pci_enable_msi_range+0x1a4/0x320
[    1.198327]  pci_alloc_irq_vectors_affinity+0x135/0x1a0
[    1.198327]  pcie_port_device_register+0x4a1/0x5c0
[    1.198327]  pcie_portdrv_probe+0x50/0x100

Fixes: 0f62d941acf9 ("genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()")

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2bdfce5edafd..57b1447a3bf1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -935,7 +935,7 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device
 		return ret;
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (ret)
+	if (ret < 0)
 		msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
-- 
2.25.1

