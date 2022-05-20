Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39652E9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbiETKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiETKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:13:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037F67D12;
        Fri, 20 May 2022 03:13:01 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K9t1f5015088;
        Fri, 20 May 2022 10:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=03W+KVCf05ryBpIQznhubjGjNBUYpOjO41ZnD0L+yZY=;
 b=khAPDsHcfXx79sQeQGGf7zJirqbTPDlZM9P91zN9C81f5yokRd7+zqTQ6sooGALl7EF+
 ttCRLzUidUzYPckYx56Mwwb/ES+P99/tzw5WDkFVvfYmEdapuiK+ov5gx9WvppRDpa9g
 v9z0eV9Bk/l+QZnOQPUROnMqIZLKHU88mOFDgaDUls2mDOzib8YLXLzZCqXs+xl4Okyg
 c442eTLoeUX/ReoxVQivB04p2YXzICFZ3Op0IgIU/qPXp37dQa7p+zDzULKgkSjUfasZ
 XTzoaUA8kaL9en7NBWBgjtk8wblfMNP1eB8UijleJEnWuINopeQ0geqnXGFI/mXB43sT AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g65m5m1x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:12:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K9e0pQ029598;
        Fri, 20 May 2022 10:12:49 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g65m5m1wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:12:49 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KA7FcG022448;
        Fri, 20 May 2022 10:12:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3g4j3gk86v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:12:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K9wlGd40042866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 09:58:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D6A4C046;
        Fri, 20 May 2022 10:12:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB10F4C040;
        Fri, 20 May 2022 10:12:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.163.31.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 10:12:37 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, irogers@google.com
Subject: [PATCH V3] tools/perf/test: Fix perf all PMU test to skip hv_24x7/hv_gpci tests on powerpc
Date:   Fri, 20 May 2022 15:42:36 +0530
Message-Id: <20220520101236.17249-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P3t1m_5cJo1TKPkjLQPk1RLXiH_V5YKx
X-Proofpoint-ORIG-GUID: XZmE3eOwJARec2zzlTf2ubhndWCst_8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205200073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"perf all PMU test" picks the input events from
"perf list --raw-dump pmu" list and runs "perf stat -e"
for each of the event in the list. In case of powerpc, the
PowerVM environment supports events from hv_24x7 and hv_gpci
PMU which is of example format like below:
- hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
- hv_gpci/event,partition_id=?/

The value for "?" needs to be filled in depending on
system and respective event. CPM_ADJUNCT_INST needs have
core value and domain value. hv_gpci event needs partition_id.
Similarly, there are other events for hv_24x7 and hv_gpci
having "?" in event format. Hence skip these events on powerpc
platform since values like partition_id, domain is specific
to system and event.

Fixes: 3d5ac9effcc6 ("perf test: Workload test of all PMUs")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 v2 -> v3:
 Fixed patition/partition/ as pointed out by Ian Rogers.

 v1 -> v2:
 Instead of checking for platform, used the pmu name
 ie, hv_24x7 and hv_gpci to skip the test since this
 pmu name is specific to powerpc as suggested by
 Michael Ellerman.

 tools/perf/tests/shell/stat_all_pmu.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index b30dba455f36..7d046bb8a7b9 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -5,6 +5,16 @@
 set -e
 
 for p in $(perf list --raw-dump pmu); do
+  # In powerpc, skip the events for hv_24x7 and hv_gpci.
+  # These events needs input values to be filled in for
+  # core, chip, partition id based on system.
+  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
+  # hv_gpci/event,partition_id=?/
+  # Hence skip these events for ppc.
+  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
+    echo "Skipping: Event '$p' in powerpc"
+    continue
+  fi
   echo "Testing $p"
   result=$(perf stat -e "$p" true 2>&1)
   if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
-- 
2.35.1

