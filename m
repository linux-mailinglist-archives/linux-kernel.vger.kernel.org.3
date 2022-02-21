Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAC4BD66B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbiBUG4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:56:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiBUG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:56:05 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A15FC7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:55:41 -0800 (PST)
X-QQ-mid: bizesmtp89t1645426532tkwhdq7x
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 14:55:26 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: XwMLFaztUQjhkiiuaJsef5Cm/q6HS4HdYRPGwY/yYJmHM8mNIjyPoqlroTkWH
        dU5IsXirHH7tS71PLBjkT0pEqN92+O9NIEbTqBduOfepbqjl5+URvJg3/cLnSLazLNcyfXK
        OC2oTa4aiQv6CszZc+/5992H1c2ePcsMcpCOxCU75HzTe5JeAaggM2XrlLeq94GHPDs3mUJ
        gEnN0xCMGy+LfeCOH7PNVOAn/18IQRH/TSJ989XwMMMS01RAJtQ4GZyWmWF05/T8L9JROq5
        1CIX5FV95IqEU/TktCeWY9AmM3pGUgQK3naRsiXXrqSWYttB0J2m3iNmCOnuNk4IbICwViR
        E1XPqKVU4EaN5+L4exbyzKtDEH4A+lMN6kEesBFTrdHB/NOUfg=
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] mm/kfence: remove unnecessary CONFIG_KFENCE option
Date:   Mon, 21 Feb 2022 14:55:25 +0800
Message-Id: <20220221065525.21344-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mm/Makefile has:
obj-$(CONFIG_KFENCE) += kfence/

So that we don't need 'obj-$(CONFIG_KFENCE) :=' in mm/kfence/Makefile,
delete it from mm/kfence/Makefile.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 mm/kfence/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/Makefile b/mm/kfence/Makefile
index 6872cd5e5390..0bb95728a784 100644
--- a/mm/kfence/Makefile
+++ b/mm/kfence/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_KFENCE) := core.o report.o
+obj-y := core.o report.o
 
 CFLAGS_kfence_test.o := -g -fno-omit-frame-pointer -fno-optimize-sibling-calls
 obj-$(CONFIG_KFENCE_KUNIT_TEST) += kfence_test.o
-- 
2.20.1



