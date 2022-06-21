Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2823552A07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbiFUDtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFUDtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:49:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA418E19;
        Mon, 20 Jun 2022 20:49:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VH.K7.0_1655783380;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VH.K7.0_1655783380)
          by smtp.aliyun-inc.com;
          Tue, 21 Jun 2022 11:49:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm: Fix warning comparing pointer to 0
Date:   Tue, 21 Jun 2022 11:49:39 +0800
Message-Id: <20220621034939.111812-1-yang.lee@linux.alibaba.com>
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

Fix the following coccicheck warning:
./arch/alpha/mm/fault.c:197:52-53: WARNING comparing pointer to 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/alpha/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index ef427a6bdd1a..bb3fe2949313 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -194,7 +194,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 
  no_context:
 	/* Are we prepared to handle this fault as an exception?  */
-	if ((fixup = search_exception_tables(regs->pc)) != 0) {
+	fixup = search_exception_tables(regs->pc);
+	if (fixup) {
 		unsigned long newpc;
 		newpc = fixup_exception(dpf_reg, fixup, regs->pc);
 		regs->pc = newpc;
-- 
2.20.1.7.g153144c

