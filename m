Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0E53AA81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355859AbiFAPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352032AbiFAPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:53:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C33744766
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:53:39 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251FC8pp030213;
        Wed, 1 Jun 2022 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MRgMY47LU6wCqbjlqxb5jdwNFxFSB8A52fHgX01565w=;
 b=Qhv5Ff0ETa+nwsz+9gG5JhttJrM9NIM3SuXZnhK0SAomUDPWpzHE2rTl4/fMWawbJlCR
 lkNUsbwZDz2Rge2M5TnVL13GXsGQPoMtgkLdJb68xzICtEcbNUvz8AOzlHhjn+Eu4Pxf
 jetcGUqmadNdHYfCsnOYb6ldi6q/RglEwv1mJpPelRwqavsw8drizv9h+JzH75o/oQWi
 Xv026KjeFKsCzJp6f7iyJj8Ke30Ssx23RWLvezSvyNSWG1+qB+PRWXfliakTv/E5oboX
 47WWTQ2R86vBSwi6PSrfPr/cZ8s6nja0IThXaLeOuHbx5jAAeIPxtrwZxFeoxxVmIT4u Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geahu8vvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:23 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 251FkZRQ009083;
        Wed, 1 Jun 2022 15:53:23 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geahu8vve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:23 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 251FdVq6028254;
        Wed, 1 Jun 2022 15:53:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3gbcakmdwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251FrHst49283484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 15:53:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47BC04203F;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D308C42041;
        Wed,  1 Jun 2022 15:53:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.172.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jun 2022 15:53:16 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Disabling NMI watchdog during LPM's memory transfer
Date:   Wed,  1 Jun 2022 17:53:13 +0200
Message-Id: <20220601155315.35109-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gJ0EAOCenuno_Jn4XAe5BO1P4ZIEZZzb
X-Proofpoint-ORIG-GUID: GUvyGmwzfG_6074J50lKXAKG7KoRev8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=941 adultscore=0
 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206010072
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

Given how often hard lockups are detected when transferring large
partitions, it seems best to disable the watchdog NMI until the memory
transfer from the start node is complete.

The first patch in this series waits for the memory transfer to complete,
the second disables the watchdog NMI just before stopping the CPUs and
reactivates it when the memory transfer is complete.

Laurent Dufour (2):
  powerpc/mobility: Wait for memory transfer to complete
  powerpc/mobility: disabling hard lockup watchdog during LPM

 arch/powerpc/platforms/pseries/mobility.c | 40 +++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.36.1

