Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F335519750
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiEDG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiEDG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:27:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA01928D;
        Tue,  3 May 2022 23:24:13 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2445nJeO026304;
        Wed, 4 May 2022 06:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=60XPg4SBnXYPfzTpealH51rl5pQQhf9mls8O/HK4pm4=;
 b=XB48DZIpB4fnD8VS3PBcOgIM50lhNZWEnPP4DqqoTsFUorH/QH9Sl0t+S3RcfZTvvpb8
 TNjHDvXmbrkWx3TX0CpWYApSOWu3SQYeTtya2WquqNMUl/w1wqN951MmLzCbla31+a+H
 ZVjgCPMyShozKiBoNnWE2tjPTtaPkKw+5f7APbY5/L8CtnMsCTn2xL+RbtrbePLgtcTf
 B5DW82PGfIwjjc8SezDi6MRJu7SwOhSUTQU9GmgaBn7x7Ws/UXQ979yXIhpDTMxzEA8X
 +BHiWPZkfdVRPHTS7EWBq45fBZr29TuQfjyA3KZuQlGHKLMbVfSsuqfkR38IlqKhyuyD /w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fukp2rhhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2446HZuF024636;
        Wed, 4 May 2022 06:24:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fsyxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2446AlxX41353608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 06:10:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39791AE051;
        Wed,  4 May 2022 06:24:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13EDCAE056;
        Wed,  4 May 2022 06:24:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 06:24:07 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/2] s390/pai: Add support for Processor Activity Instrumentation
Date:   Wed,  4 May 2022 08:23:49 +0200
Message-Id: <20220504062351.2954280-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: avkEjKwQgmWNip6jT_Us1dNMr2w_44Bp
X-Proofpoint-ORIG-GUID: avkEjKwQgmWNip6jT_Us1dNMr2w_44Bp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_01,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=578 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Processor Activity Instrumentation
(PAI) for cryptography instructions. A new Performance Measurement
Unit (PMU) is introduced. It reads memory mapped counter values
incremented when a CPU executes certain instructions.
To differentiate between user space and kernel space counter
increments, the memory mapping is changed on system call
entry/exit and IRQ entry/exit. Patch 1 prepares that transition,
patch 2 introduces the new PMU and kernel vs user space
memory mappings.

Sven Schnelle (1):
  entry: Rename arch_check_user_regs() to arch_enter_from_user_mode()

Thomas Richter (1):
  s390/pai: Add support for cryptography counters

 arch/s390/include/asm/ctl_reg.h      |   4 +-
 arch/s390/include/asm/entry-common.h |  14 +-
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/nmi.h          |   2 +-
 arch/s390/include/asm/pai.h          |  74 +++
 arch/s390/kernel/Makefile            |   1 +
 arch/s390/kernel/entry.S             |   1 +
 arch/s390/kernel/nmi.c               |   6 +-
 arch/s390/kernel/perf_pai_crypto.c   | 688 +++++++++++++++++++++++++++
 arch/x86/include/asm/entry-common.h  |   4 +-
 include/linux/entry-common.h         |   8 +-
 kernel/entry/common.c                |   2 +-
 12 files changed, 793 insertions(+), 16 deletions(-)
 create mode 100644 arch/s390/include/asm/pai.h
 create mode 100644 arch/s390/kernel/perf_pai_crypto.c

-- 
2.32.0

