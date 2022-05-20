Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776652E9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbiETKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbiETKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:22:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7F5931B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:22:25 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de [91.0.108.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id CC385209;
        Fri, 20 May 2022 12:22:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        "D. Ziegfeld" <dzigg@posteo.de>,
        =?UTF-8?q?J=C3=B6rg-Volker=20Peetz?= <jvpeetz@web.de>
Subject: [PATCH] iommu/amd: Increase timeout waiting for GA log enablement
Date:   Fri, 20 May 2022 12:22:14 +0200
Message-Id: <20220520102214.12563-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

On some systems it can take a long time for the hardware to enable the
GA log of the AMD IOMMU. The current wait time is only 0.1ms, but
testing showed that it can take up to 14ms for the GA log to enter
running state after it has been enabled.

Sometimes the long delay happens when booting the system, sometimes
only on resume. Adjust the timeout accordingly to not print a warning
when hardware takes a longer than usual.

There has already been an attempt to fix this with commit

	9b45a7738eec ("iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()")

But that commit was based on some wrong math and did not fix the issue
in all cases.

Cc: "D. Ziegfeld" <dzigg@posteo.de>
Cc: Jörg-Volker Peetz <jvpeetz@web.de>
Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..d8060503ba51 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -84,7 +84,7 @@
 #define ACPI_DEVFLAG_LINT1              0x80
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
-#define LOOP_TIMEOUT	100000
+#define LOOP_TIMEOUT	2000000
 /*
  * ACPI table definitions
  *
-- 
2.36.1

