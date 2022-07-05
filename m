Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1A56612A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGEC0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGEC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:26:02 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F94E5F;
        Mon,  4 Jul 2022 19:26:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VIPhdNS_1656987958;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIPhdNS_1656987958)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 10:25:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] powercap: arm_scmi: Fix an ignored error return from num_domains_get()
Date:   Tue,  5 Jul 2022 10:25:57 +0800
Message-Id: <20220705022557.19747-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On line 428 pr->num_zones = powercap_ops->num_domains_get(), the return
of num_domains_get() is int, it can be a negative error code, however
this is being assigned to an unsigned int variable, so make the num_zones
to int to solve this problem without affecting other functions.

Eliminate the following coccicheck warning:
./drivers/powercap/arm_scmi_powercap.c:429:5-18: WARNING: Unsigned expression compared with zero: pr -> num_zones < 0

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/powercap/arm_scmi_powercap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 36f6dc211fbb..11018e63bb8b 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -29,7 +29,7 @@ struct scmi_powercap_zone {
 };
 
 struct scmi_powercap_root {
-	unsigned int num_zones;
+	int num_zones;
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 };
-- 
2.20.1.7.g153144c

