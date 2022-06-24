Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A978955A10F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiFXSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiFXSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:35:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC741116D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:34:43 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OISH3d021085;
        Fri, 24 Jun 2022 18:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N3X0d/Vv0ug7CUEFLrwoDDV1RplYg5o6x20/V3TCrSs=;
 b=SF4c/GqtI+D6/fOiywn1WYyUEFDZXwLOpoGAvugjwr+GbO9wXyr/Yv7krmDU4m7KnIAn
 J9XltYsVAZ+rjTomNYlCfV+yn20CeLhL2RShTYU38ALfXNGw5mhYfc/XafvBUVa5YETE
 /GGlAw8wTKuohZxTqFtIlv/gpVdPOF3NVBWIxYms+Yt8gBGctvgxtzWu0s5hW+TQ1JQA
 4TYFNbB2ir5tDyK0Xa6hOgH5awF7XgLHkFeQxAFaBRg9KChAGl2WHYRpcIIMPueDsrgl
 dDl13FgqUjtirqEtfRfqA6GKmc+zuorNiExvI+7tNwssODxKyzUYw33/AfvAd28azigm 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjjyg4sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:34:11 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25OIYA1Q010161;
        Fri, 24 Jun 2022 18:34:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwjjyg4rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:34:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OIKFaW028830;
        Fri, 24 Jun 2022 18:34:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b99ens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 18:34:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OIY6kc14156086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 18:34:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 770385204E;
        Fri, 24 Jun 2022 18:34:06 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.0.85])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9028652050;
        Fri, 24 Jun 2022 18:34:02 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, mingo@redhat.com, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com, mbenes@suse.cz,
        benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Date:   Sat, 25 Jun 2022 00:02:37 +0530
Message-Id: <20220624183238.388144-12-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220624183238.388144-1-sv@linux.ibm.com>
References: <20220624183238.388144-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oDpY5cvYmzfmeVcEPnR0NiehJAYh-tTg
X-Proofpoint-GUID: 5mO5xSgsRJPVx0qx4SxtCsU8BNy2rZV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_08,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=640 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool is throwing *unannotated intra-function call*
warnings with a few instructions that are marked
unreachable. Remove unreachable() from WARN_ON()
to fix these warnings, as the codegen remains same
with and without unreachable() in WARN_ON().

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/include/asm/bug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index ecbae1832de3..df6c11e008b9 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -97,7 +97,6 @@
 	__label__ __label_warn_on;				\
 								\
 	WARN_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags), __label_warn_on); \
-	unreachable();						\
 								\
 __label_warn_on:						\
 	break;							\
-- 
2.25.1

