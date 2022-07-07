Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA73D56AE13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGGWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGGWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:04:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5582B1BA;
        Thu,  7 Jul 2022 15:04:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r1so14812684plo.10;
        Thu, 07 Jul 2022 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gztFolpOjRs4gmw4YebA1BI/HHxjQgQpOSAd6qju7xs=;
        b=Z8eC2jZYCCpsvpiFBwV8ezW4pTFcWXnuy4sU831z78Xw+eF12FHvT0C2Kbz1gB1tet
         8e+3l1eOph7TsvljIRIpRFvfWLcYyNds0Ibml5x4sqsBq+kkQDZOMoKqclWaKadDDsx7
         zAqmVo3UFPHxJx9vavKR09fU255eaYmJ9atsnlO4G1nqf1wH8l47fCagot3rlMmdhrYt
         m1ktZvRXXvI+Smkfq/d3Xq4/+mH9noax2vvnKD2zfWFOQuAkn9eqnt/uAQMFccY8GVnB
         zcHRQjIbpWjVTuQCegTfdseg1FpOTSdvZcyAnFiZtPu/ZIZMgqtNQL9oKmsV3XncMFc6
         DnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gztFolpOjRs4gmw4YebA1BI/HHxjQgQpOSAd6qju7xs=;
        b=PhjErnBLeUmU22dcVL3qTW+hAknwyph+AU0BFJ4/oe/yOH//NfVn6+WmX1FLQtVD0I
         0i5AfWiePC2vgZfCbF/9d3p2IMXEh44AvPmez/pPbWBYkaSperJwKsg6SdVKW0azaSTa
         BNwN3VglyiohljZ6T8xpCp1sj8Eekxf6vGSY4hLQN4H8uayVSGiztKiyMkDz2RwzAtCI
         7AZwFfolBVBLv971LD14yRu/yYRLzcGiVg+5jd1LgC/jNniteSu//479nV1stCvTz271
         OgOfCD9rP1+RrDaG0WuuLKRWdrBMl1X2XJKrtLBCMD89Jexz5dU5DIqIbKSsE/z6fsUV
         qyvg==
X-Gm-Message-State: AJIora8Mr9Rtyii4aqHRHA7LCl5nYqxPSyRkwA5+AYNJUho5art+Xnk2
        2T1Z/T4TZIsvS5ZyUgZ7wqH7d7kWxQQ=
X-Google-Smtp-Source: AGRyM1t+qWzNHY3hylQUhEZteb+eFoihq4G6o91pFz6/yQ9b9r56kmL2IFHUDSiHcWt0pWGi9QmZYw==
X-Received: by 2002:a17:90b:2384:b0:1ef:8506:374e with SMTP id mr4-20020a17090b238400b001ef8506374emr7688335pjb.99.1657231474622;
        Thu, 07 Jul 2022 15:04:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id cu7-20020a056a00448700b00525373aac7csm27239922pfb.26.2022.07.07.15.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:04:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     fancer.lancer@gmail.com, gerg@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] MIPS: Enable ARCH_HAS_DEBUG_VIRTUAL for 64-bit
Date:   Thu,  7 Jul 2022 15:04:27 -0700
Message-Id: <20220707220428.1731083-1-f.fainelli@gmail.com>
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

Update __debug_virt_addr_valid() to check for a virtual address'
validity below CKSSEG and remove the !64BIT dependency on
ARCH_HAS_DEBUG_VIRTUAL to make DEBUG_VIRTUAL selectable.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
This requires the previous patch to be applied for this to work cleanly.

 arch/mips/Kconfig       | 2 +-
 arch/mips/mm/physaddr.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db09d45d59ec..ddb6bde8fa1f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,7 +5,7 @@ config MIPS
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
-	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
+	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
index a82f8f57a652..3076238943d3 100644
--- a/arch/mips/mm/physaddr.c
+++ b/arch/mips/mm/physaddr.c
@@ -31,7 +31,11 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
 	if (x == MAX_DMA_ADDRESS)
 		return true;
 
+#ifdef CONFIG_64BIT
+	return KSEGX(x) < CKSSEG;
+#else
 	return KSEGX(x) < KSEG2;
+#endif
 }
 
 phys_addr_t __virt_to_phys(volatile const void *x)
-- 
2.25.1

