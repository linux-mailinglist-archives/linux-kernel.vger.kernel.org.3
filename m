Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916F4E8BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiC1COn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiC1COl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:14:41 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C250457
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:12:57 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 10:12:57 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 10:12:54 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] x86/mm: Directly return instead of using local ret variable
Date:   Mon, 28 Mar 2022 10:12:53 +0800
Message-ID: <1648433573-25735-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes coccinelle warning:
./arch/x86/mm/pf_in.c:133:18-20: Unneeded variable: "rv". Return "OTHERS" on line 144

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/x86/mm/pf_in.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pf_in.c b/arch/x86/mm/pf_in.c
index 3f83e31..4eff3ee 100644
--- a/arch/x86/mm/pf_in.c
+++ b/arch/x86/mm/pf_in.c
@@ -130,7 +130,6 @@ enum reason_type get_ins_type(unsigned long ins_addr)
 	unsigned char *p;
 	struct prefix_bits prf;
 	int i;
-	enum reason_type rv = OTHERS;
 
 	p = (unsigned char *)ins_addr;
 	p += skip_prefix(p, &prf);
@@ -141,7 +140,7 @@ enum reason_type get_ins_type(unsigned long ins_addr)
 	CHECK_OP_TYPE(opcode, imm_wop, IMM_WRITE);
 
 exit:
-	return rv;
+	return OTHERS;
 }
 #undef CHECK_OP_TYPE
 
-- 
2.7.4

