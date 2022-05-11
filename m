Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F5523CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbiEKSeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiEKSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:34:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337E1D5700
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:34:12 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BISVTK001212;
        Wed, 11 May 2022 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=S9smiIoCZeob67RjhpjWOL2E+f/znLADLRdFic9T0EA=;
 b=tsUhR/yHZmxSN+5arfKSuvUv0Ia0TaSE4RUHbafsDWPisRfPBnNztfR2K8/uuZT9a2VI
 Z5mTe/DhsWC/Je4ytcUBxxiSBC32xKbL1NJ+7HQCHH3kNCoZ2pTbEIKbPjFvt265v9gd
 0oQ2N/A8T0xNQy1SYAsIhvCQZX/6DZgU16xX+1bIGUQtLbvGE7MIpn8CIjb8AQhNg6aV
 O3RNk4i6DeF9gjc9F5zhIsj3F6DFK/jbBCVyGcR6G7RgpqzO190Rlod4bgNDavzVxyda
 TXYzBNb9le27A4pM4jIaIIKq5pLs8P/+S+J38Ztab7lJRewm94oe3c3F9Vu2VnMldd44 8g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0fn43ndy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 18:34:07 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BINsQJ021873;
        Wed, 11 May 2022 18:34:06 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3fwgdadjb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 18:34:06 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BIY5TK25035246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:34:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F28F6A057;
        Wed, 11 May 2022 18:34:05 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CDDF6A04D;
        Wed, 11 May 2022 18:34:05 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.61.211])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 18:34:04 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] mm: Add config option for default panic_on_oom value
Date:   Wed, 11 May 2022 13:34:00 -0500
Message-Id: <20220511183400.47940-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kEBD4Ldd6pT4_OI5UGEHbbCDwZ18-zzN
X-Proofpoint-ORIG-GUID: kEBD4Ldd6pT4_OI5UGEHbbCDwZ18-zzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=956 mlxscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the option to kconfig and set the default panic_on_value.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 mm/Kconfig    | 7 +++++++
 mm/oom_kill.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 675a6be43739..1fde865b0a63 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -825,6 +825,13 @@ config ZSMALLOC_STAT
 config GENERIC_EARLY_IOREMAP
 	bool
 
+config PANIC_ON_OOM_DEFAULT
+	int "Startup setting for panic_on_oom"
+	default 0
+	range 0 2
+	help
+	  This is the default startup value for /proc/sys/vm/panic_on_oom
+
 config STACK_MAX_DEFAULT_SIZE_MB
 	int "Default maximum user stack size for 32-bit processes (MB)"
 	default 100
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3996301450e8..a6a9cc5635f8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -52,7 +52,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/oom.h>
 
-static int sysctl_panic_on_oom;
+static int sysctl_panic_on_oom = CONFIG_PANIC_ON_OOM_DEFAULT;
 static int sysctl_oom_kill_allocating_task;
 static int sysctl_oom_dump_tasks = 1;
 
-- 
2.27.0

