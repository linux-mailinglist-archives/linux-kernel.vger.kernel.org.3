Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647154B293
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbiFNNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiFNNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:54:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007F39158
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:54:41 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDBm50007127;
        Tue, 14 Jun 2022 13:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=91KbsJhgd5Z7wAIVHBdXOXopYNH6NERzRpoqR9TzenU=;
 b=iRDBBJ/SeO1gfxcZsOj2Q9g72nU6Vyz7FYirToCjfcas91dLRAOnsXlKvTtEG0ql+EfF
 +2NPRoWXdWOcjLyddrYp7nz123GpQ8VL6ec7pc26oXnAm6Ncj8PRAi4lbCB298CSkcR9
 cNkuu5nHHDQHgVtVL8MUDg3mEjAeDwfbqsWcyy/ksX+jB4rzpQObJ74niR+YX0WOQTs0
 vVmkY6INV0kjEOH48Z6ZtxJ27LBPUBgJvw1+5jFqP7EU7GztU8XW9/LuAnPD4FKaG6sF
 ZfMUf7uKRTO8UxQF8z0JSQwU9MvyaU43XHrsv4cZAlS7l3NYJ7U21R182FIA1xUmwVea hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbr1kkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EDsLuf027193;
        Tue, 14 Jun 2022 13:54:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbr1kg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EDpP1v007434;
        Tue, 14 Jun 2022 13:54:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gmjp94dju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EDsKwY20381972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 13:54:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB7CAE053;
        Tue, 14 Jun 2022 13:54:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A6CAE04D;
        Tue, 14 Jun 2022 13:54:16 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 13:54:16 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Extending NMI watchdog during LPM
Date:   Tue, 14 Jun 2022 15:54:10 +0200
Message-Id: <20220614135414.37746-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aUtiuafk094ucdMJIB0556ynfm-IMZI4
X-Proofpoint-ORIG-GUID: VsppHNCKw4X-KboyXicfKRuxFlHtOfXo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_04,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=947
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206140054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a partition is transferred, once it arrives at the destination node,
the partition is active but much of its memory must be transferred from the
start node.

It depends on the activity in the partition, but the more CPU the partition
has, the more memory to be transferred is likely to be. This causes latency
when accessing pages that need to be transferred, and often, for large
partitions, it triggers the NMI watchdog.

The NMI watchdog causes the CPU stack to dump where it appears to be
stuck. In this case, it does not bring much information since it can happen
during any memory access of the kernel.

In addition, the NMI interrupt mechanism is not secure and can generate a
dump system in the event that the interruption is taken while MSR[RI]=0.

Depending on the LPAR size and load, it may be interesting to extend the
NMI watchdog timer during the LPM.

That's configurable through sysctl with the new introduced variable
(specific to powerpc) lpm_nmi_watchdog_factor. This value represents the
percentage added to watchdog_tresh to set the NMI watchdog timeout during a
LPM.

Changes in v2:
 - introduce a timer factor.

v1:
[PATCH 0/2] Disabling NMI watchdog during LPM's memory transfer
https://lore.kernel.org/linuxppc-dev/20220601155315.35109-1-ldufour@linux.ibm.com/#r

Laurent Dufour (4):
  powerpc/mobility: Wait for memory transfer to complete
  watchdog: export watchdog_mutex and lockup_detector_reconfigure
  powerpc/watchdog: introduce a LPM factor
  pseries/mobility: Set NMI watchdog factor during LPM

 Documentation/admin-guide/sysctl/kernel.rst | 12 +++
 arch/powerpc/include/asm/nmi.h              |  2 +
 arch/powerpc/kernel/watchdog.c              | 22 ++++-
 arch/powerpc/platforms/pseries/mobility.c   | 90 ++++++++++++++++++++-
 include/linux/nmi.h                         |  3 +
 kernel/watchdog.c                           |  6 +-
 6 files changed, 129 insertions(+), 6 deletions(-)

-- 
2.36.1

