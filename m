Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8B4FE60A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbiDLQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiDLQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:43:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4054831E;
        Tue, 12 Apr 2022 09:41:25 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CGDZsV029887;
        Tue, 12 Apr 2022 16:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LE535E2ZSsCYjUm2u5nT2c7n/KI2GcedAR+J8mt26M0=;
 b=QWuD9R47mwcgpx7HgSp4Iy8/LMqHGvVm/tLCofzn9ZB/hIxQ148oV38PbuIrT3FicgFT
 qcIIfLnUHP97n9hwZKku1OWew8fktqjaAb3Kv5vQomunudKAn6rUeNXZqUX97TXPCPP4
 BFB4b5t1SHQweyMdOHBNo/5hA1g0iLvYgww/HogHjKwvd7I2TErOwosb8T/lGWUE2Jr+
 fIc89Oletd9gJTiOtJKiCgknXJ3KS2lCZTTn6PqEz5sYF6Ew141/tFtqn/MOKroZEtLK
 0uaM1EeS62WLAU7zmD9fXdT7S29Mp9aO+4Wc8vJyO0zpJkUKhRFbKWG2rCNhAntYHG55 nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdcrjrjc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:41:14 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CGZ3Fl031289;
        Tue, 12 Apr 2022 16:41:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdcrjrjbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:41:13 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CGY5Ji009516;
        Tue, 12 Apr 2022 16:41:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3fb1s8m8ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:41:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CGf86O40567142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 16:41:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A22D8AE051;
        Tue, 12 Apr 2022 16:41:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D72DAAE04D;
        Tue, 12 Apr 2022 16:41:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.163.3.143])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 16:41:02 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        irogers@google.com
Subject: [PATCH V3 0/2] Fix perf bench numa to work with machines having #CPUs > 1K
Date:   Tue, 12 Apr 2022 22:10:57 +0530
Message-Id: <20220412164059.42654-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: isgCRUbZeKHNqvogx-vg97hrxlBbI9Is
X-Proofpoint-ORIG-GUID: AkCToOTRQ7TrovAZmyLbaRPvbxiY0LVD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204120079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf benchmark for collections: numa hits failure in system
configuration with CPU's more than 1024. These benchmarks uses
"sched_getaffinity" and "sched_setaffinity" in the code to
work with affinity.

Example snippet from numa benchmark:
<<>>
perf: bench/numa.c:302: bind_to_node: Assertion `!(ret)' failed.
Aborted (core dumped)
<<>>

bind_to_node function uses "sched_getaffinity" to save the cpumask.
This fails with EINVAL because the default mask size in glibc is 1024

To overcome this 1024 CPUs mask size limitation of cpu_set_t,
change the mask size using the CPU_*_S macros ie, use CPU_ALLOC to
allocate cpumask, CPU_ALLOC_SIZE for size, CPU_SET_S to set mask bit.

Fix all the relevant places in the code to use mask size which is large
enough to represent number of possible CPU's in the system.

This patchset also address a fix for parse_setup_cpu_list function in
numa bench to check if input CPU is online before binding task to
that CPU. This is to fix failures where, though CPU number is within
max CPU, it could happen that CPU is offline. Here, sched_setaffinity
will result in failure when using cpumask having that cpu bit set
in the mask.

Patch 1 address fix for parse_setup_cpu_list to check if CPU used to bind
task is online. Patch 2 has fix for bench numa to work with machines
having #CPUs > 1K

Athira Rajeev (2):
  tools/perf: Fix perf bench numa testcase to check if CPU used to bind
    task is online
  perf bench: Fix numa bench to fix usage of affinity for machines with
    #CPUs > 1K

Changelog:
v2 -> v3
Link to the v2 version :
https://lore.kernel.org/all/20220406175113.87881-1-atrajeev@linux.vnet.ibm.com/
 - From the v2 version, patch 1 and patch 2 are now part of upstream.
 - This v3 version separates patch 3 and patch 4 to address review
   comments from arnaldo which includes using sysfs__read_str for reading
   sysfs file and fixing the compilation issues observed in debian

 tools/perf/bench/numa.c  | 136 +++++++++++++++++++++++++++++----------
 tools/perf/util/header.c |  51 +++++++++++++++
 tools/perf/util/header.h |   1 +
 3 files changed, 153 insertions(+), 35 deletions(-)

-- 
2.35.1

