Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC558C7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiHHLvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiHHLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:51:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E196ABB4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:50:49 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278BnmJd008729;
        Mon, 8 Aug 2022 11:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y6OKjXvCN2j5uqrhqCnpVhl3aQ8AeUfPU34WmsHcx6k=;
 b=tOHpTf9i04c3xhuq9lhlKMKaywuAFYTXEAWIxcliXrQbYJIJQkfPBuzpOD64FvFTRucf
 17VZFF7mKqb3nZmD+i2xY/OWgQHv+PbN6WWoONCy0gP7UN6b7KboZ6rkJl3G4L3SQswC
 Z6eNISlPJSkEkMpmCyD8NUMIu07EdSLgh1xQpw2Yq9EdTUrp19o9zWvlHEGXW+MQvVZU
 PUGsO/K/GLZuTTXdbYJQwVYTx3U+au4nSjW7jRr9iO4YluAH44ovAVWZzsLz9zIyDjJg
 YhfPHVyPTeCQmniDrN6dwvgK4o+16eMHLEmiv7LwBvoUbKw2Ssh2VsSf91KznYgCIEZm Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1y680px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:33 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278BoW8B010766;
        Mon, 8 Aug 2022 11:50:32 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1y680p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:32 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278BbCKi012576;
        Mon, 8 Aug 2022 11:50:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3hsfx8skaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278BoRhQ21889468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 11:50:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D107511C04A;
        Mon,  8 Aug 2022 11:50:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B48F111C04C;
        Mon,  8 Aug 2022 11:50:23 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.59.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 11:50:23 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH 13/16] objtool: Use macros to define arch specific reloc types
Date:   Mon,  8 Aug 2022 17:19:05 +0530
Message-Id: <20220808114908.240813-14-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220808114908.240813-1-sv@linux.ibm.com>
References: <20220808114908.240813-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _xAGpdB1Y8WjVIFVf6hLX8_ZE3f9WlGi
X-Proofpoint-ORIG-GUID: pjZJJqHkWQdu-hUvtAaj6t9KGuu5mOQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=721
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
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
index 36f367da4752..2f1da8dbfce9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -883,7 +883,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		memset(loc, 0, addrsize);
 
 		if (elf_add_reloc_to_insn(file->elf, sec, idx,
-					  R_X86_64_64,
+					  addrsize == sizeof(u64) ? R_ABS64 : R_ABS32,
 					  insn->sec, insn->offset))
 			return -1;
 
-- 
2.31.1

