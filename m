Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F85A42A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiH2FxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2FxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:53:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826547B9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:53:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T53X5H017215;
        Mon, 29 Aug 2022 05:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=1ZXWckPvHVTWcRblvIxNj1/s2qlvE+vB+hypd1mpVgA=;
 b=Oi+2Q/7A1RCHCSMxKRycbVsPbZbZVxrjz/1TgNsqq7nUzOeQWlLEOETgSg9Yua88X9zM
 T/QoKKVX0mnXIglbO2iXYRR1t/PZ3KzpjdYGfVYNpulbMDv1zItQBq3yFSzyLEBHyrbj
 0fU9JivKfcsAH6jRtkBhmJDC5jTyWBUn0B4fABp/NjXfhAunRc1jzZCm5ROWkXIXN5Ap
 vFt+rLI/lIN/l1smNWIyg8OmDWxxSG7Dg4RXeIfp+wXnVrwwPBG/CwPIhWOISiYyVtSX
 O0zNUXLRRiRSqbW5W1YIAUB1KlTO5F25+SXCoPKJzrzT9cwGj35FDQ0KFaezo67bvKpW 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8pyrrykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:52:42 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T5e0YM011764;
        Mon, 29 Aug 2022 05:52:42 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8pyrryk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:52:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T5pWTM020615;
        Mon, 29 Aug 2022 05:52:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8sc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:52:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T5nQZ143123154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 05:49:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 362404C044;
        Mon, 29 Aug 2022 05:52:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F2254C040;
        Mon, 29 Aug 2022 05:52:33 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.67.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 05:52:32 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v2 01/16] powerpc: Replace unreachable() with it's builtin variant in __WARN_FLAGS()
Date:   Mon, 29 Aug 2022 11:22:08 +0530
Message-Id: <20220829055223.24767-2-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829055223.24767-1-sv@linux.ibm.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LhARys3eFUdVFaw78Un2yRKjzoD2Nguw
X-Proofpoint-ORIG-GUID: hpe2Bn-DgbsNRXNhYKelugT1cQe3iAne
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=887 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool is throwing *unannotated intra-function call* warnings in
.c files with a few instructions that are marked unreachable. The
problem comes from the annotate_unreachable() macro that is
called by unreachable(). This annotation is adding a call to a
function with size 0, and objtool does not add such symbols
to the rbtree. Due to this reason, find_call_destination() function
is not able to find the destination symbol for that call.

With the annotation (annotate_unreachable()), gcc seems to
generate a 'bl' to unreachable symbol with size 0. But with
the builtin variant of unreachable (__builtin_unreachable()),
gcc does not emit calls to such symbols and the warnings
go away. Given that the codegen remains same, and that
there are no 'bl' instructions to such symbols emitted, fix
these warnings by replacing unreachable() with it's builtin
variant in __WARN_FLAGS().

Also, add barrier_before_unreachable() before __builtin_unreachable()
to work around a gcc bug [1], for the problem reported at [2].

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106751
[2]: https://lkml.org/lkml/2022/8/25/418

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/include/asm/bug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 61a4736355c2..ef42adb44aa3 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -99,7 +99,8 @@
 	__label__ __label_warn_on;				\
 								\
 	WARN_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags), __label_warn_on); \
-	unreachable();						\
+	barrier_before_unreachable();				\
+	__builtin_unreachable();				\
 								\
 __label_warn_on:						\
 	break;							\
-- 
2.31.1

