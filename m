Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A84DBD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358476AbiCQC6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiCQC6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:58:21 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0D20F4F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:57:05 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 10:57:06 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 10:57:03 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <benh@kernel.crashing.org>, <masahiroy@kernel.org>,
        <adobriyan@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] macintosh: windfarm_pm121: Fix warning comparing pointer to 0
Date:   Thu, 17 Mar 2022 10:57:02 +0800
Message-ID: <1647485822-16717-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/macintosh/windfarm_pm121.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index ba1ec6f..f0aa263 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -650,7 +650,7 @@ static void pm121_create_cpu_fans(void)
 
 	/* First, locate the PID params in SMU SBD */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
-	if (hdr == 0) {
+	if (!hdr) {
 		printk(KERN_WARNING "pm121: CPU PID fan config not found.\n");
 		goto fail;
 	}
@@ -969,7 +969,7 @@ static int pm121_init_pm(void)
 	const struct smu_sdbp_header *hdr;
 
 	hdr = smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
-	if (hdr != 0) {
+	if (hdr) {
 		struct smu_sdbp_sensortree *st =
 			(struct smu_sdbp_sensortree *)&hdr[1];
 		pm121_mach_model = st->model_id;
-- 
2.7.4

