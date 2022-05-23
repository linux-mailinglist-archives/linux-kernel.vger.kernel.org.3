Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AE531B76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbiEWSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiEWSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553AB82C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:57:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHSoR5011312;
        Mon, 23 May 2022 17:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hiK/gTSAe9vJ+0XObkVQlmijgj5clBKRz6adl2t2/qw=;
 b=VYAEjSu8KwzRdy9IzIXlbTSQQsay9BcrdK1+IEIEfFgUU+ZQS9cyMlrZiuy8zgIHgxeG
 BabzYCwC0dp1XWKtz3fVOlL6CWUv6+PqPWA2Qnqp+A84y0WvbevRNpEsIzOM0iczk7qn
 SvrYGOB+sRvIAavndvo+H8FOV57ZcBzDmNp6ThxP68iUS+dTNUjcvbvxPczEloqI6Q6y
 Et4fYKANHrhc1NYFFTr6q/STlwHPapPJHxOJqB3UemMEIY0m4zng1b6xZP9RcGWAz3SP
 GJAKRpJN8piFye+4ahqJh1O1NWYRKeF1Mq2ExgQfNhh8pOqUosN975QUS5P8Vd2Kr0YW qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8eq0retv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NHTNWv016791;
        Mon, 23 May 2022 17:56:09 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8eq0retd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:09 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NHiN3D032732;
        Mon, 23 May 2022 17:56:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3g6qq9anjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NHu5uO48300410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:56:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B39F5204E;
        Mon, 23 May 2022 17:56:05 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.16.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B2BEE52051;
        Mon, 23 May 2022 17:56:02 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mbenes@suse.cz, aik@ozlabs.ru,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [RFC PATCH 2/4] objtool: Enable objtool to run only on files with ftrace enabled
Date:   Mon, 23 May 2022 23:25:46 +0530
Message-Id: <20220523175548.922671-3-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220523175548.922671-1-sv@linux.ibm.com>
References: <20220523175548.922671-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zGqR_cdO5w9EzBEebYwZ_Glhya1ShdP7
X-Proofpoint-GUID: bnWaIZ7VLab2xF1nO8dP-ejF7KjP8ACq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=721 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes sure objtool runs only on the object files
that have ftrace enabled, instead of running on all the object
files.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e0c3f9c1459..06ceffd92921 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -258,8 +258,8 @@ else
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 
-$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
-	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
+$(obj)/%.o: objtool-enabled = $(and $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y),        \
+        $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),y),y)
 
 endif
 
-- 
2.25.1

