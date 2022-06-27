Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305455C135
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiF0Nyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiF0Ny2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:54:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5156631F;
        Mon, 27 Jun 2022 06:54:27 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDN1Uh003946;
        Mon, 27 Jun 2022 13:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=GAWoFxCNJhIvlMoWt/ylWRzzaBWADkUmC7Q0ZaAXQKw=;
 b=C0ydIsLJo8x0/XnILLmB+DUZEBR5KX89h2JbxUzVNC6/KgG1neIl2vXdYCVInE2Li/c8
 nuiA2CuFmQzyvXOxgYSSZnxlPvWVr6pr2LGCrp1g2SQgwew1o7KKGlCP54NS692fwiGh
 o+Kf4WPsKd9moa4t6SCvS8V7bvScgy0N4319jWM0y2XuyczOSQyqfwssbSLHhZ11Pgms
 xZyyiaIv4pRZTvM/RN5WLB7UhuLG0M/TCOH4d3qa6bripbGyddUftQhirwg7YKsw8FZX
 Dk1q8o9yzRyQ4x8eNhyV0VAg/tJeaM2LPzNXTqxr/RWOyckxyg/ddpti8mKle1fPF+25 iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gydcv8vq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:56 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25RDaoDs024237;
        Mon, 27 Jun 2022 13:53:56 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gydcv8vn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:55 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25RDq9Bo028366;
        Mon, 27 Jun 2022 13:53:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt092age-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25RDrmtT23003544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:53:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 581B4AE051;
        Mon, 27 Jun 2022 13:53:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0F45AE045;
        Mon, 27 Jun 2022 13:53:47 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jun 2022 13:53:47 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v3 0/4] Extending NMI watchdog during LPM
Date:   Mon, 27 Jun 2022 15:53:43 +0200
Message-Id: <20220627135347.32624-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 356kCkZtDT4EdcQIcQ430xVDqLe2qI9o
X-Proofpoint-GUID: kkjhEORm_2eMvJi08KpG6Xk7BV_E4iDG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=972 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270059
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
(specific to powerpc) nmi_watchdog_factor. This value represents the
percentage added to watchdog_tresh to set the NMI watchdog timeout during a
LPM.

Changes in v3:
 - don't export watchdog_mutex
 - fix a comment in mobilty.c, wait_for_vasi_session_completed()
 - fix a build issue when !CONFIG_PPC_WATCHDOG
 - rework some printk and rename the sysctl variable.

v2:
https://lore.kernel.org/all/20220614135414.37746-1-ldufour@linux.ibm.com/

Laurent Dufour (4):
  powerpc/mobility: wait for memory transfer to complete
  watchdog: export lockup_detector_reconfigure
  powerpc/watchdog: introduce a NMI watchdog's factor
  pseries/mobility: set NMI watchdog factor during LPM

 Documentation/admin-guide/sysctl/kernel.rst | 12 +++
 arch/powerpc/include/asm/nmi.h              |  2 +
 arch/powerpc/kernel/watchdog.c              | 21 ++++-
 arch/powerpc/platforms/pseries/mobility.c   | 85 ++++++++++++++++++++-
 include/linux/nmi.h                         |  2 +
 kernel/watchdog.c                           | 21 +++--
 6 files changed, 135 insertions(+), 8 deletions(-)

-- 
2.36.1

