Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B00562CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiGAHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:35:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C56D559
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:35:46 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2617SUSF018572;
        Fri, 1 Jul 2022 07:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=gLsIGt5mcqLwa6DnbQZyQAdiTpRMEIZyAyathQipuig=;
 b=M75U/GR6ZmabZ+1tSIC/sttID+YgqPI7saYFMIPW5tJDg6mTOsnc1WVvP882nqzLf8Fx
 g6ru0fQ2Otwjs8ve9zEzyrJWwhG3Pqtz02MsSva6T0etbNuVyEB8OYzQnwDKxGrnU/UT
 QxSwH+Gx2RITDbO+HeMBqsec4p4sTAytkZKpadZeVxAQLuDQBbStDbvrSnFjmMtRMmMA
 W0yGbQ2IllIBZVIIz87ChVHSsQTadMpiPQtZt/Eah/xgGPO2e63gRx8/l7jUnpiEQaqi
 qt2cg6iV4xWj+ISXeEnZn2SR8ZM2FQzuPt086rrylG/L17lmxpr7VwQrVWnhBQ6rsyi5 dQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1vjpg751-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 07:35:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2617SSia010563;
        Fri, 1 Jul 2022 07:35:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3gwt08y09u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 07:35:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2617Za3h22020394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 07:35:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BEA14C04A;
        Fri,  1 Jul 2022 07:35:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D29334C046;
        Fri,  1 Jul 2022 07:35:34 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.100.5])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 07:35:34 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 0/2] kexec: Drop __weak attributes from functions
Date:   Fri,  1 Jul 2022 13:04:03 +0530
Message-Id: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LBOsbtN09GJJq3kw3KNFbeGzH4JSd4IT
X-Proofpoint-GUID: LBOsbtN09GJJq3kw3KNFbeGzH4JSd4IT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=638 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested [1], this series converts weak functions in kexec to use 
the #ifdef approach. I have compile-tested this series on arm64, 
powerpc, s390 and x86_64.

- Naveen

[1] http://lkml.kernel.org/r/87ee0q7b92.fsf@email.froward.int.ebiederm.org


Naveen N. Rao (2):
  kexec_file: Drop weak attribute from functions
  kexec: Drop weak attribute from functions

 arch/arm64/include/asm/kexec.h   | 18 +++++++-
 arch/powerpc/include/asm/kexec.h | 14 ++++++
 arch/s390/include/asm/kexec.h    | 14 ++++++
 arch/x86/include/asm/kexec.h     | 12 +++++
 include/linux/kexec.h            | 76 +++++++++++++++++++++++++++-----
 kernel/kexec_core.c              | 27 ------------
 kernel/kexec_file.c              | 35 +--------------
 7 files changed, 124 insertions(+), 72 deletions(-)


base-commit: 13fa82df3449770de37197fa51b610ffc788f555
-- 
2.36.1

