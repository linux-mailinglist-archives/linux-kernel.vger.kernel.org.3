Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2757ECF5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiGWJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiGWJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:17:01 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981CF592;
        Sat, 23 Jul 2022 02:16:50 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658567795ta5impsq
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:16:33 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 7YFKcddXagi7O5A/TYgY5np6eb36noUAugBV9iGqdk214wWCMtNgQExS2Kaxe
        euObBs7FyhgEwk8OIhA16igB1XFlBh7ik+2/5gSJZBwKVy1ITGLXEBaroib5Vwu6fFXo18Y
        lBeKHM3pdL7aTg5UnHdYfJWj+Pjiho51i5DlWki/xFSX1p1953PPZy+UK/DLWZJzfog63Lf
        unFZAwcFNNa+IOjY3nYdEA6PO+vXbLb8Z5DJXoWi3xQogrn51+OFe5xg7e8SMbRKoOEPr9A
        D+YtoU/tThyu1Fyh0uSZsx4i5d2FJAfIBzq1hN13hj7MVHn5EexKpuilVwHczG0qDfgY9tX
        0InCtsWOzDPM6JePO3zQannGPfL92hcYo2k5ZIXwMbIYEleb80=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sumit.saxena@broadcom.com
Cc:     kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: megaraid: Remove the static variable initialisations to 0
Date:   Sat, 23 Jul 2022 17:16:20 +0800
Message-Id: <20220723091620.5463-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise global and static variable to 0 is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 2a339d4a7e9d..157c3bdb50be 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -181,7 +181,7 @@ MODULE_PARM_DESC(cmd_per_lun,
  * This would result in non-disk devices being skipped during driver load
  * time. These can be later added though, using /proc/scsi/scsi
  */
-static unsigned int megaraid_fast_load = 0;
+static unsigned int megaraid_fast_load;
 module_param_named(fast_load, megaraid_fast_load, int, 0);
 MODULE_PARM_DESC(fast_load,
 	"Faster loading of the driver, skips physical devices! (default=0)");
-- 
2.35.1

