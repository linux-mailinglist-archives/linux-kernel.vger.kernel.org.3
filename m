Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8122654F94A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382436AbiFQOiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFQOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:38:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7E39684
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:38:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HDU16D027696;
        Fri, 17 Jun 2022 16:38:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=MrCSWINS2GfAc4BiOcRjdRsIo2RBOjPuhfPkTDR+o4E=;
 b=kqp0tkFourtjKPnGdVNU+vmUxAaa5nd+cSC+CGQIwcUTRCJJ9xG24Mly8kCNMbbmfQhh
 viqqbu6ZxpM4Iay9Wrd7OGI0LgDHel4Yb5PUwl9vvHxHnyWjvB9wb/9hQBX9ILopR8bb
 MlwCAiQFEGgq+g7/q6q/OfVAKAEtvYg24UUbp2UCky/uMCcj60CJKqYOYmlzLqMaKiOk
 e6SWx3MiDD4IBqHhYmdPUgMLPmNSSyQzIOIm/VvYODblkbcnHddYEQRVFdLmZgzO/rv2
 GDQX1iZOSlVm+Qhu0ouOg2S2ULaFPRf60sQGhcZRoXyeqKxqEgK2oexIgBHozO9C5eDD aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gqd18763v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 16:38:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FFFF10002A;
        Fri, 17 Jun 2022 16:38:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A33CF21BF79;
        Fri, 17 Jun 2022 16:38:20 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 17 Jun
 2022 16:38:20 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] scripts/gdb: fix 'lx-dmesg' on 32 bits arch
Date:   Fri, 17 Jun 2022 16:37:58 +0200
Message-ID: <20220617143758.137307-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_10,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type atomic_long_t can have size 4 or 8 bytes, depending on
CONFIG_64BIT; it's only content, the field 'counter', is either an
int or a s64 value.

Current code incorrectly uses the fixed size utils.read_u64() to
read the field 'counter' inside atomic_long_t.

On 32 bits architectures reading the last element 'tail_id' of the
struct prb_desc_ring:
	struct prb_desc_ring {
		...
		atomic_long_t tail_id;
	};
causes the utils.read_u64() to access outside the boundary of the
struct and the gdb command 'lx-dmesg' exits with error:
	Python Exception <class 'IndexError'>: index out of range
	Error occurred in Python: index out of range

Use the existing utils.read_ulong() to read 'counter' inside the
atomic_long_t.

Fixes: e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 scripts/gdb/linux/dmesg.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index d5983cf3db7d..e2d9ab3aa836 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -89,9 +89,9 @@ class LxDmesg(gdb.Command):
 
         # read in tail and head descriptor ids
         off = prb_desc_ring_type.get_type()['tail_id'].bitpos // 8
-        tail_id = utils.read_u64(desc_ring, off + counter_off)
+        tail_id = utils.read_ulong(desc_ring, off + counter_off)
         off = prb_desc_ring_type.get_type()['head_id'].bitpos // 8
-        head_id = utils.read_u64(desc_ring, off + counter_off)
+        head_id = utils.read_ulong(desc_ring, off + counter_off)
 
         did = tail_id
         while True:
@@ -102,7 +102,7 @@ class LxDmesg(gdb.Command):
             desc = utils.read_memoryview(inf, desc_addr + desc_off, desc_sz).tobytes()
 
             # skip non-committed record
-            state = 3 & (utils.read_u64(desc, sv_off + counter_off) >> desc_flags_shift)
+            state = 3 & (utils.read_ulong(desc, sv_off + counter_off) >> desc_flags_shift)
             if state != desc_committed and state != desc_finalized:
                 if did == head_id:
                     break

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
-- 
2.36.1

