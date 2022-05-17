Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBC5296BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiEQBbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiEQBbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:31:09 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C83F2BC4;
        Mon, 16 May 2022 18:31:05 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 17 May
 2022 09:31:04 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 17 May
 2022 09:31:02 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal: intel: hfi: remove null check after call container_of()
Date:   Tue, 17 May 2022 09:31:01 +0800
Message-ID: <1652751061-23045-1-git-send-email-baihaowen@meizu.com>
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

container_of() will never return NULL, so remove useless code.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/thermal/intel/intel_hfi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 730fd121df6e..a0640f762dc5 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -243,8 +243,6 @@ static void hfi_update_work_fn(struct work_struct *work)
 
 	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
 				    update_work);
-	if (!hfi_instance)
-		return;
 
 	update_capabilities(hfi_instance);
 }
-- 
2.7.4

