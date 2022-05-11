Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A14523297
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiEKMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbiEKMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240313CF4;
        Wed, 11 May 2022 05:05:45 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BABCho005763;
        Wed, 11 May 2022 12:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0e0BA5fY0tqkCo+olJAjBe7ceu3q7Pp02d2NsqbIJFA=;
 b=Nd1gVfmCIHqKfkSFTg2YJjeLodL8+J8wmWJMT4Po+7nGMD1RRWkCxV7xPFRMyRzf0ide
 eDbmnfxZRwIZEtKklviot483M6SM8GaTBYVw3xEtoZVXcLxyAeDpR3V+pJIk/hIRtPu7
 YR5W7e6k2oS4zFPYk/mTJdVatT+e2MNQ5WTDo1DMN8PWagftcqEKT7dDlUc4bgMdT9Dx
 0KTnTDuXIuwzaFna5tHnJG85djrSPNAlOtxOigyrHkpgp39hIIe94c8yygkxC+N/JZbr
 zVv96JOmvt+2AyuTCu2p+2Alp+YkTSE7bTu4KEadts4rl3jAyxdoWYYAshiuHySScqUL hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av72byj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:44 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BBffAW010135;
        Wed, 11 May 2022 12:05:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av72bxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC2b1F015527;
        Wed, 11 May 2022 12:05:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fwgd8v7we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5aDN43188508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC2CA4040;
        Wed, 11 May 2022 12:05:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F14DA404D;
        Wed, 11 May 2022 12:05:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:36 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 8/8] scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390
Date:   Wed, 11 May 2022 14:05:32 +0200
Message-Id: <20220511120532.2228616-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1dwEpcPfPe_Noy-98iNthQjVm_sl1Ta8
X-Proofpoint-ORIG-GUID: urio_KLe00VE71REQ9dWlP_kDh-wn0s_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=880
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before version 14.0.0 llvm's integrated assembler fails to handle some
displacement variants:

arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
 lg %r11,kernel_type-.base_crash(%r13)

Instead of working around this and given that this is already fixed
raise the minimum clang version from 13.0.0 to 14.0.0.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/min-tool-version.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 53fe64856015..f1e8358ec19a 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -24,9 +24,8 @@ icc)
 	echo 16.0.3
 	;;
 llvm)
-	# https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
 	if [ "$SRCARCH" = s390 ]; then
-		echo 13.0.0
+		echo 14.0.0
 	else
 		echo 11.0.0
 	fi
-- 
2.32.0

