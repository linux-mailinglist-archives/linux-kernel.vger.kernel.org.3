Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BB53A5AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353129AbiFANLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiFANLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:11:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB26325
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:11:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w3so1732316plp.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5AH1U5SHVaxYK5U6wHZI+Uf8T98VsEerOgnBwZfGkY=;
        b=EpxDjcS2RtaVPEIL1O7MH8Fxfp1XUV05k/MHV3xIY/cvhJPTlS11OnBx6jymbxzO5q
         7+B1tF07vGxCCrKoyNw0Zz67BWtpT+SLqzm+gzCmTVZ8F9iLgwgmgqGo9qgdVqTwKeOH
         F5o9kx/dsC+k8w+dwSgWYUSUHYrIMCA2SDNiatPRim9X/0u8HlsrCchloeiTZREAy9cs
         Mg4R2gdSjJxVmZL27P92S26ncG4XgWJ3Fimq6YJUJPZoPV7O5vg3wSjT1gSOWAtr92iB
         4ILlyGZCMyy/sSgaXAreCLGheGep9d4s68G9Y4tadj28m1irbmyTVBHSIz+ByXTj4ocg
         /Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5AH1U5SHVaxYK5U6wHZI+Uf8T98VsEerOgnBwZfGkY=;
        b=60N7pByuvo4Jp6hTWMo4V9EQLoK/5SCPd/m4jERAMFoPQoSjsFyCgZoPPc8mqnPo9q
         KXDeAvnFsFkD7S4u2KGRtahcCDUxZdZ7G1JqZckpXV8E2We632oYmTqf02Cd82NJQTbd
         q8dmPFMhf+X6BYSg2CfWz2A+eb2xlpekEmFvMILSTs5Ywyr9cxED88G16xFou79gbbdX
         ipdwCd94dXl1r1xlorq+jQXRWftzTbGIhgbn/GKkOMI9jpClSqh/49bQBL2YGoDWMvZB
         +aqQCWdKQvGIGgdkwk60pQuYHnGsSEef5yYYfgo0B90OCT1dnqeHwUzdmBYPKacRGDAk
         9Plg==
X-Gm-Message-State: AOAM53180XYnyFN1vck1Ax7L1VE/qab1o8VSuQcxvp/YyWeOw58rsUx+
        HjIpcucWkZXOL7yUDxPAp6o=
X-Google-Smtp-Source: ABdhPJynog34wOL325DVkpBKhAu32exXyCxMUiCFCtcQ7QP9ZOrSBHoR6U9gj57/QtV+cI3GseFmAQ==
X-Received: by 2002:a17:902:c2d2:b0:166:303b:56ec with SMTP id c18-20020a170902c2d200b00166303b56ecmr1710581pla.83.1654089076345;
        Wed, 01 Jun 2022 06:11:16 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id gd20-20020a17090b0fd400b001d954837197sm3862654pjb.22.2022.06.01.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:11:15 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] psci: Fix refcount leak in psci_dt_init
Date:   Wed,  1 Jun 2022 17:11:07 +0400
Message-Id: <20220601131107.18743-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
When of_device_is_available() fails, call of_node_put() to release the
refcount. And of_node_put() will checks NULL pointer.

Fixes: d09a0011ec0d ("drivers: psci: Allow PSCI node to be disabled")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/psci/psci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..ec888aba57ff 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -619,8 +619,10 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	init_fn = (psci_initcall_t)matched_np->data;
 	ret = init_fn(np);
-- 
2.25.1

