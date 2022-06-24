Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED355A0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFXSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFXSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:34:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966C81272
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:34:12 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHudQk026614;
        Fri, 24 Jun 2022 18:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sTxAmaGGVt8kjnrd5wCZdRVcwparabBnXdu0NPdSbvQ=;
 b=J6FbynVY+70k0C/qusfjRxn8Hjhr+hwNTv2vmH4Md2axxg427Fgy/w0d7a3YwsZUGw3p
 DjcW4HwfYANLTXdW9M2pef27WZxDb7HPWcwnyl9hnoKBaMEpetTlWJQqaXu5tB/J8b6C
 uo2BAL3sgLeMBXkb2wUbR+bCZZ2vNs82pbCXdbrie6oRP7V1RaWx3EC46JjMvbtddsvF
 ia6WIH+7wtBDzTX6nhUlGElY0bzzyxRM4XK8qK1pGbcSPx1F4V7B3DKZuXtd3bE60cL/
 IRE8dLsYSKkf5M/W6QDqxCCVoJRyOIqgWo9fMRe3MW0ECiJyHDlX6Ml+llDha0IVJMOR dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwj458ybe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:49 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25OHvTIT028645;
        Fri, 24 Jun 2022 18:33:48 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwj458yaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OIKgf9017792;
        Fri, 24 Jun 2022 18:33:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gv9r7395c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:33:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OIXhhF22807014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:33:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FE245204F;
        Fri, 24 Jun 2022 18:33:43 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.0.85])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C86D45204E;
        Fri, 24 Jun 2022 18:33:39 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, mingo@redhat.com, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com, mbenes@suse.cz,
        benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH v3 07/12] objtool: Use macros to define arch specific reloc types
Date:   Sat, 25 Jun 2022 00:02:33 +0530
Message-Id: <20220624183238.388144-8-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220624183238.388144-1-sv@linux.ibm.com>
References: <20220624183238.388144-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1labSrJZGiUpCD4CwyEkuPQ8fDGRqgAq
X-Proofpoint-GUID: FrxwgWt2onpDdoZRmUD4sPMEJlO9nEXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_08,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=588
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make relocation types architecture specific.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/arch/x86/include/arch/elf.h | 2 ++
 tools/objtool/check.c                     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index 69cc4264b28a..ac14987cf687 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -2,5 +2,7 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_X86_64_NONE
+#define R_ABS64 R_X86_64_64
+#define R_ABS32 R_X86_64_32
 
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 98e869721bc4..88f68269860e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -834,7 +834,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		memset(loc, 0, size);
 
 		if (elf_add_reloc_to_insn(file->elf, sec, idx,
-					  R_X86_64_64,
+					  size == sizeof(u64) ? R_ABS64 : R_ABS32,
 					  insn->sec, insn->offset))
 			return -1;
 
-- 
2.25.1

