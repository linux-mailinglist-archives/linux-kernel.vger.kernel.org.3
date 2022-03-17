Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A34DBD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358448AbiCQCeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358444AbiCQCeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:34:00 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C720190
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:32:43 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 10:32:42 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 10:32:40 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <benh@kernel.crashing.org>, <masahiroy@kernel.org>,
        <adobriyan@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] macintosh: windfarm_pm81: Fix warning comparing pointer to 0
Date:   Thu, 17 Mar 2022 10:32:39 +0800
Message-ID: <1647484359-12402-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/macintosh/windfarm_pm81.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 82c67a4..1dfced5 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -400,7 +400,7 @@ static void wf_smu_create_cpu_fans(void)
 
 	/* First, locate the PID params in SMU SBD */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
-	if (hdr == 0) {
+	if (!hdr) {
 		printk(KERN_WARNING "windfarm: CPU PID fan config not found "
 		       "max fan speed\n");
 		goto fail;
@@ -704,7 +704,7 @@ static int wf_init_pm(void)
 	const struct smu_sdbp_header *hdr;
 
 	hdr = smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
-	if (hdr != 0) {
+	if (hdr) {
 		struct smu_sdbp_sensortree *st =
 			(struct smu_sdbp_sensortree *)&hdr[1];
 		wf_smu_mach_model = st->model_id;
-- 
2.7.4

