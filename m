Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F85511508
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiD0Kq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiD0KqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:46:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DD394E2F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:28:44 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R73lCq025540;
        Wed, 27 Apr 2022 09:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/w+KC+YY9q0y/zt+m9HGRNZ4xIPkZ4LVCXJ5Evns0V8=;
 b=r6brKZonFr8o3yzrMC0gzmj4zpmjRLjZj/69r82JLEqprDk4mADtyW5aG3kTy/P9wPqB
 5XdPYkA9Gt5m6/hYvElyYui9zevHDE+WDKHmriiSOgkd6vELDj4F+R0N0Ztg6fYvb7Nm
 ZkbwZfpW1fWmSRl98uvDrhjCRWIgMJgn0CxHNqbTPJN3qGJb6nXdgdwlAh6g0q5NDrXc
 1JmV0ueu7JF+dC9nfsDfJpLOEizjxGxPkMJW1kX//1uqh3YZvgebnM52JlGMg7FnerQj
 U3v8U3OFQj/RF8dQ8IZGK0KmI8SbihScnO8WEG2Xf4ST46rKiE62dEjefpwCIgCkjxHq kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpsdpj1js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 09:36:29 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23R9aTth010556;
        Wed, 27 Apr 2022 09:36:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpsdpj1hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 09:36:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23R9Sr6R020336;
        Wed, 27 Apr 2022 09:36:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938wq4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 09:36:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23R9abMt10617428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 09:36:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CE64C044;
        Wed, 27 Apr 2022 09:36:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF2C4C040;
        Wed, 27 Apr 2022 09:36:22 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.116.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 09:36:21 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        llvm@lists.linux.dev
Subject: [PATCH 1/2] ftrace: Drop duplicate mcount locations
Date:   Wed, 27 Apr 2022 15:01:21 +0530
Message-Id: <9b1b816cff1f479c8de0e9baa5a6ac680b84e17e.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xOD5Je7fuvdMKVm_hwjuxnSEunGOm4QJ
X-Proofpoint-GUID: qOWJyvUDBeYDjXs0ou5OOdL3rgKWBUIA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_03,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=866
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of section symbols [1], objtool (today) and recordmcount
(with a subsequent patch) generate __mcount_loc relocation records with
weak symbols as the base. This works fine as long as those weak symbols
are not overridden, but if they are, these can result in duplicate
entries in the final vmlinux mcount location table. This will cause
ftrace to fail when trying to patch the same location twice. Fix this by
dropping duplicate locations during ftrace init.

[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/ftrace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e726341..8bc4f282bb3ff4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6496,7 +6496,7 @@ static int ftrace_process_locs(struct module *mod,
 	struct dyn_ftrace *rec;
 	unsigned long count;
 	unsigned long *p;
-	unsigned long addr;
+	unsigned long addr, prev_addr = 0;
 	unsigned long flags = 0; /* Shut up gcc */
 	int ret = -ENOMEM;
 
@@ -6550,6 +6550,16 @@ static int ftrace_process_locs(struct module *mod,
 	while (p < end) {
 		unsigned long end_offset;
 		addr = ftrace_call_adjust(*p++);
+
+		/*
+		 * Drop duplicate entries, which can happen when weak
+		 * functions are overridden, and __mcount_loc relocation
+		 * records were generated against function names due to
+		 * absence of non-weak section symbols
+		 */
+		if (addr == prev_addr)
+			addr = 0;
+
 		/*
 		 * Some architecture linkers will pad between
 		 * the different mcount_loc sections of different
@@ -6569,6 +6579,7 @@ static int ftrace_process_locs(struct module *mod,
 
 		rec = &pg->records[pg->index++];
 		rec->ip = addr;
+		prev_addr = addr;
 	}
 
 	/* We should have used all pages */
-- 
2.35.1

