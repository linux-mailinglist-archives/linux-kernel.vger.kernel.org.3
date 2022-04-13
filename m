Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EA4FF35A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiDMJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiDMJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BB532F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:23:23 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D8pcOH019860;
        Wed, 13 Apr 2022 09:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U2cjrNuEcn2sQ89XEkzD3fEZ1fdJ85MFrRiqEkOU6i8=;
 b=dc+ULpzUa915obWL7+MMSH0pAVjVlATboUURzP/tqbYd/5aV83JZrjRCWjFDqrh/azEV
 RxIXbtVagr9LPAqUtAJVbwybzB0hMXe0QuT7YT4Jkxf4XosOYQJJzaqMGGJpYNgann4B
 LeLyJHFylNW1gArcU+bXEPdxnlHiCXB6X1/fl3HdT1gjg/CX+AEq993QzrsE/Zcv9g88
 lOSKkwJgtmN343vGo/dP1/ROwJrM27eW7plYGHCVreWCrN8N48XiP30HJr61SLCEbPNW
 /t9szx+GsnZAD/1IYgdJfICrBSUS9iISI+PEWMHhPN4sjJ9H4VoxeSR7D7SYNX9c1KwN Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fduck0pf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:19 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23D9BMSs025437;
        Wed, 13 Apr 2022 09:22:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fduck0pem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D9M6aL007614;
        Wed, 13 Apr 2022 09:22:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s8xf98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D9MM1f34275822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 09:22:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0928C4C058;
        Wed, 13 Apr 2022 09:22:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF6E4C046;
        Wed, 13 Apr 2022 09:22:10 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.51.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 09:22:10 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
Date:   Wed, 13 Apr 2022 14:52:01 +0530
Message-Id: <20220413092206.73974-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NQnp9Eledtwufypjbo5oPKvlY-ioKyb0
X-Proofpoint-ORIG-GUID: 3Hgn8aM6zXUnUs3PEbVJ-UXd9JWt3qyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_08,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=816 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation to find the demotion targets works
based on node state N_MEMORY, however some systems may have
dram only memory numa node which are N_MEMORY but not the
right choices as demotion targets.

This patch series introduces the new node state
N_DEMOTION_TARGETS, which is used to distinguish the nodes which
can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
is used to hold the list of nodes which can be used as demotion
targets, support is also added to set the demotion target
list from user space so that default behavior can be overridden.

node state N_DEMOTION_TARGETS is also set from the dax kmem
driver, certain type of memory which registers through dax kmem
(e.g. HBM) may not be the right choices for demotion so in future
they should be distinguished based on certain attributes and dax
kmem driver should avoid setting them as N_DEMOTION_TARGETS,
however current implementation also doesn't distinguish any 
such memory and it considers all N_MEMORY as demotion targets
so this patch series doesn't modify the current behavior.

Current code which sets migration targets is modified in
this patch series to avoid some of the limitations on the demotion
target sharing and to use N_DEMOTION_TARGETS only nodes while
finding demotion targets.

Changelog
----------

v2:
In v1, only 1st patch of this patch series was sent, which was
implemented to avoid some of the limitations on the demotion
target sharing, however for certain numa topology, the demotion
targets found by that patch was not most optimal, so 1st patch
in this series is modified according to suggestions from Huang
and Baolin. Different examples of demotion list comparasion
between existing implementation and changed implementation can
be found in the commit message of 1st patch.

Jagdish Gediya (5):
  mm: demotion: Set demotion list differently
  mm: demotion: Add new node state N_DEMOTION_TARGETS
  mm: demotion: Add support to set targets from userspace
  device-dax/kmem: Set node state as N_DEMOTION_TARGETS
  mm: demotion: Build demotion list based on N_DEMOTION_TARGETS

 .../ABI/testing/sysfs-kernel-mm-numa          | 12 ++++
 drivers/base/node.c                           |  4 ++
 drivers/dax/kmem.c                            |  2 +
 include/linux/nodemask.h                      |  1 +
 mm/migrate.c                                  | 67 +++++++++++++++----
 5 files changed, 72 insertions(+), 14 deletions(-)

-- 
2.35.1

