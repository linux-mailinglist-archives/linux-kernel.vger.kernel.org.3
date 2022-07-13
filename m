Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37DE57375F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGMN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGMN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:28:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019511C2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:28:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w185so10248520pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oS8l0DP9XOP7IcptwyyBF7p0o//V8/X4Uva/tnzgH+I=;
        b=oli3pkWVLTc5myDwYPzIiLZfFnOebiBXTjssvr0eGGu9PTd+yVQ44s6tUWfe4KgE7U
         8/uMxcr0/YMQZ8X9kTuj1FoR5P9WWia6Hl7C1j6HHb118NS8fAP54XhgyFMtj5S8DmC0
         Flj2TlXVrAG6u7xd3cTmQjFlNT0Yl+fDhlEPVf6wNaICiSGweNBCwCaJSmXbqYA7a/q0
         zf0nKN20vQLcoZ69uGScPMsgzXkyM9CmlUdfj3XsqxqgB5kfgqH4FekE385EI5IKvdo9
         HB91dkQ9gJEnCqVQFSWfxgocFKDpB+DXrh7bdf/Kgg60JGQaJU7/+f+7ju/IMUc29QGs
         xTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oS8l0DP9XOP7IcptwyyBF7p0o//V8/X4Uva/tnzgH+I=;
        b=hXtpieKF0zw91PjXPkFast/pPy2K3yINdzT2LouFWKvYJsRIxj1Usz1hNJIENdYhnx
         3XDN0KdYhhxtNXiue+RumhgESYUb7uJX+fR+vh6Luvya6IqLCn9vNq1YCwkmMqgHbtov
         rMncO08RhaXp/rIpQAdn+idDb8awhvsJyVHl161mxVIdKO1swmru6McqQ1/xHtgDIvlT
         wx6tPUFpGixtHb4AXMcBE4rvvQiNVMvwKoBKBmlMG92i5qMFGwiHxkQQ3JpKOfP10iRj
         K6rG/CSrTO6yG3PLvUwb1agYa/rugASCUQBv2FstC+0pFpBegZJ5UI37XEHrUKQlcqCP
         HGjA==
X-Gm-Message-State: AJIora+KWvHnp5SVzCHdXW53N9xsghTLrnLN0sv0PJWNshsTqI/mZF7z
        OPXTOaxC/uNRnjguE96tWh5g2WlxgV0ObA==
X-Google-Smtp-Source: AGRyM1ultb8zQEZlRq+nP410/QqzMmsDWQrnfoxi8ex5F23hOd6xjPtNRkRlwEmIa8il/m8/ojpeWg==
X-Received: by 2002:a05:6a00:124b:b0:52a:c7de:c76 with SMTP id u11-20020a056a00124b00b0052ac7de0c76mr3348008pfi.5.1657718935475;
        Wed, 13 Jul 2022 06:28:55 -0700 (PDT)
Received: from alvinzhan-virtual-machine.localdomain (1-164-121-236.dynamic-ip.hinet.net. [1.164.121.236])
        by smtp.gmail.com with ESMTPSA id kk18-20020a17090b4a1200b001ec9dce6f10sm1622316pjb.38.2022.07.13.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:28:54 -0700 (PDT)
From:   alvinzhan1234@gmail.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alvin Zhan <alvinzhan1234@gmail.com>
Subject: [PATCH 1/1] arm64: Prevent offline CPU handling IRQs.
Date:   Wed, 13 Jul 2022 21:28:43 +0800
Message-Id: <20220713132843.49693-1-alvinzhan1234@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Alvin Zhan <alvinzhan1234@gmail.com>

Migrate all of the IRQs on this CPU after setting it offline may still cause the IRQs to be dispatched to this CPU.
To prevent offline CPU handling IRQs, we should migrate the IRQs away from this CPU before it is powered off.

Signed-off-by: Alvin Zhan <alvinzhan1234@gmail.com>
---
 arch/arm64/kernel/smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 62ed361a4..c4c3c5ed5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -302,6 +302,11 @@ int __cpu_disable(void)
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 
+	/*
+	 * Migrate IRQs away from this CPU first.
+	 */
+	irq_migrate_all_off_this_cpu();
+
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
 	 * and we must not schedule until we're ready to give up the cpu.
@@ -309,11 +314,6 @@ int __cpu_disable(void)
 	set_cpu_online(cpu, false);
 	ipi_teardown(cpu);
 
-	/*
-	 * OK - migrate IRQs away from this CPU
-	 */
-	irq_migrate_all_off_this_cpu();
-
 	return 0;
 }
 
-- 
2.34.1

