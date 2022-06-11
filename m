Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A74547791
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiFKUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiFKUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECAB327FEA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654980548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcR0aKofOSCGCYosAm/fDhdf+hmatzPLZ0c9B4qN7K8=;
        b=ccvC8VMMlVHktSKb6UICYmOm1SgiaH2ZrMZN42amIQ28DzBFWXvXe88fWZt7Au/MucAxpp
        XUbqn9XuyxBgofLn2UG8yQea8351FiFwW+6F0u7NXDbSuRMY5R6tgCFUfTfHh+X2AndSlM
        bYzMyFrPTI3heDtg/lf1EDTTSCTtt8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-e6fvh4ZdPaW93X5vuONVMw-1; Sat, 11 Jun 2022 16:49:06 -0400
X-MC-Unique: e6fvh4ZdPaW93X5vuONVMw-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so2531225wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcR0aKofOSCGCYosAm/fDhdf+hmatzPLZ0c9B4qN7K8=;
        b=bt0q62dWcclfI3gKsu1ICUWJz5OIBofZA4OAwa0zttWujyO8FhkJqz5nY+R0hlWs3e
         l/RIx6PlEhtyECRFF/kca9HS/BHlMupSh1L59z6xdX6nKFf9P7gSAniTAmM5Ga0/Fx04
         FRlzVtkb5ORqLjGj8WQwoCQnG3qqrDRNG3T59dZAhD35cmi8Y0Qymt8MahRx9v0tKekS
         vb/CeLN+AmHVW/tlC1Q2eG8tC0diufPsKNiGBQ4YC9jSf3wTw9UFOcZ7U93xusbP0/D5
         L0YqGYDWSaiTBqUvOUDecXnY/int63eAuyYDlwqb+yI9paS1muRPBtjW1au2gpwKb7kC
         3YFQ==
X-Gm-Message-State: AOAM5319Skaoxnh6dg6PkwviBN2xhc5awsVu7E/Fgd57zxS74RThGe5J
        C/i9f3BRwwoRYsclC4cZcrML5DIN38zBsJocYpybZrCyJ7SzhMn9kEPtPOfFp2v8401tnL11zSE
        GKhzDRZ/BMRmhZ/kG1882qM0=
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id b5-20020a05600003c500b002190d096fcemr18325871wrg.197.1654980545355;
        Sat, 11 Jun 2022 13:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybNY6Mydqdoa+x8UT/rxgTAmWTiQ9yFznUm8N5Ot/sTlJOQwm2A9g83GLDT7qk18aCHmI54Q==
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id b5-20020a05600003c500b002190d096fcemr18325860wrg.197.1654980545143;
        Sat, 11 Jun 2022 13:49:05 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600016c700b0020c7ec0fdf4sm4082355wrf.117.2022.06.11.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 13:49:04 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com
Subject: [RFC PATCH 3/3] iommu/vt-d: Show region type in arch_rmrr_sanity_check()
Date:   Sat, 11 Jun 2022 21:48:59 +0100
Message-Id: <20220611204859.234975-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611204859.234975-1-atomlin@redhat.com>
References: <20220611204859.234975-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will attempt to describe the region type in the event
that a given RMRR entry is not within a reserved region.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/x86/include/asm/iommu.h | 9 ++++++---
 arch/x86/kernel/e820.c       | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..d21366644520 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -17,12 +17,15 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
+	struct e820_entry *entry;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+	entry = __e820__mapped_all(start, end, 0);
+
+	if (entry && entry->type == E820_TYPE_RESERVED)
 		return 0;
 
-	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
-	       start, end - 1);
+	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%s: %#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
+	       e820_type_to_string(entry), start, end - 1);
 	return -EINVAL;
 }
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 95b994cf80cd..165e9a444bb9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
 
 const char *__init e820_type_to_string(struct e820_entry *entry)
 {
-	switch (entry->type) {
+	switch (entry && entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return "System RAM";
 	case E820_TYPE_ACPI:		return "ACPI Tables";
@@ -1083,8 +1083,9 @@ const char *__init e820_type_to_string(struct e820_entry *entry)
 	case E820_TYPE_PMEM:		return "Persistent Memory";
 	case E820_TYPE_RESERVED:	return "Reserved";
 	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
-	default:			return "Unknown E820 type";
+	default:			break;
 	}
+	return "Unknown E820 type";
 }
 
 static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
-- 
2.34.1

