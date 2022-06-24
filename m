Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511A55A12D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiFXSe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiFXSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:34:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76C81273
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:34:16 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OIPttW000986;
        Fri, 24 Jun 2022 18:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5n/kbbwmVtiDducCA0pI1CxpPR9FC2WdELyFBwcGRw0=;
 b=KqTs/m0++SqIbQlrxKA72kyH7wadEGXg1jRfrYMRSeIoBqOIjMitPqhNrkM8VDqSN695
 MV9H8BXsn151kIQC8G6zUghL7i4Feb02Gcx54uBhK3pP639RO6c8F3Ig+urtFlwuAfXt
 O50wdbJk7n6SiAULBWAtt1g1a14hk3nTk9eRw2oPnXnV7sm4whrdY9VlUGz6VUmkl9tH
 w79D7vjdDmEg4K9lWo+HlrHrSFQjiX/C1oP+E4mGEpcA1rNxCUzY29FuNr9Aj1JAHd9p
 j3DICmCBHJWn1MX05xsawN7NKJx6D9EGgw46wTY5KU7/4wSNx3dj6DAT6XoZqtzbRojC nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjhur5w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:54 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25OIS6B7011188;
        Fri, 24 Jun 2022 18:33:54 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjhur5uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OIJR39019226;
        Fri, 24 Jun 2022 18:33:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3gvtjp9fmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OIXm0w20775268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:33:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D688352052;
        Fri, 24 Jun 2022 18:33:48 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.0.85])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 244605204E;
        Fri, 24 Jun 2022 18:33:44 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, mingo@redhat.com, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com, mbenes@suse.cz,
        benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH v3 08/12] objtool: Add arch specific function arch_ftrace_match()
Date:   Sat, 25 Jun 2022 00:02:34 +0530
Message-Id: <20220624183238.388144-9-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220624183238.388144-1-sv@linux.ibm.com>
References: <20220624183238.388144-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4ZHAoHhxyDNA1h6_ZBIMKsPkX9DcUvkV
X-Proofpoint-GUID: e7EBk8aVeCs_-T1LeInehUFzFdR1Yf4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_08,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific function to look for
relocation records pointing to arch specific
symbols.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/arch/x86/decode.c      | 8 ++++++++
 tools/objtool/check.c                | 2 +-
 tools/objtool/include/objtool/arch.h | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 8b990a52aada..6a66b0c0dd2c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -23,6 +23,14 @@
 #include <objtool/builtin.h>
 #include <arch/elf.h>
 
+bool arch_ftrace_match(char *name)
+{
+	if (!strcmp(func->name, "__fentry__"))
+		return true;
+
+	return false;
+}
+
 static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 88f68269860e..51b6dcec8d6a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2185,7 +2185,7 @@ static int classify_symbols(struct objtool_file *file)
 			if (arch_is_retpoline(func))
 				func->retpoline_thunk = true;
 
-			if (!strcmp(func->name, "__fentry__"))
+			if (arch_ftrace_match(func->name))
 				func->fentry = true;
 
 			if (is_profiling_func(func->name))
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..99d0c8ba1b69 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -69,6 +69,8 @@ struct stack_op {
 
 struct instruction;
 
+bool arch_ftrace_match(char *name);
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
-- 
2.25.1

