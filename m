Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297CA5A0C71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiHYJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbiHYJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:21:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2ABA406C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:21:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P7uCAt012328;
        Thu, 25 Aug 2022 09:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=V1ZsmE9exi3HrE4feFWGgAnfWbKxkMywvkzji4yNFSg=;
 b=hCq5aeIF5EQ/NTsEv6fK/2q4llnBjJ9ZF1VW5hJy2FtTlDD2t7xigWrpWxNHuyDVtI0m
 FNTPWvE531IVjwMlA/Dl7+BIPn5slzuYs2oJaq1jcnq+1FB3CmHSOXpzFMyRnK+MV3Rh
 ezejXxNS2YMdyn3dOZBQ572ShpTqAIYLk+LeMkScP37YTxReNE92gTZuHPQ3NMeSTf/P
 E2WqnMMeH0w6L41Ac+agkPJaClxIPr4L0CW/CUhKtTnSfQpPP7desGuLgkmB7p9EKFoD
 mHZiLcWMn+oypfMzJjXMdhjWvehADq3nBI1VsOoueB/QF3INY9P/FOoVvASApZ9mM5MQ wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j654cun4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:20:46 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27P7woaM025055;
        Thu, 25 Aug 2022 09:20:45 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j654cun3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:20:45 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27P95Nd4016969;
        Thu, 25 Aug 2022 09:20:44 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3j2q89pr61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:20:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27P9KiAR10617346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 09:20:44 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C25F06A04F;
        Thu, 25 Aug 2022 09:20:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17356A047;
        Thu, 25 Aug 2022 09:20:37 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.112.25])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 09:20:37 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] mm/demotion: Fix kernel error with memory hotplug
Date:   Thu, 25 Aug 2022 14:50:19 +0530
Message-Id: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LYRoZX7Bp77pwoZ9Vxo2iM0zsMzAVDlB
X-Proofpoint-ORIG-GUID: X5vJ9CsKnfFtGnKxP0Om01-AMOjGShi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On memory hot unplug, the kernel removes the node memory type
from the associated memory tier. Use list_del_init instead of
list del such that the same memory type can be added back
to a memory tier on hotplug.

Without this, we get the below warning and return error on
adding memory type to a new memory tier.

[   33.596095] ------------[ cut here ]------------
[   33.596099] WARNING: CPU: 3 PID: 667 at mm/memory-tiers.c:115 set_node_memory_tier+0xd6/0x2e0
[   33.596109] Modules linked in: kmem

...

[   33.596126] RIP: 0010:set_node_memory_tier+0xd6/0x2e0

....
[   33.596196]  memtier_hotplug_callback+0x48/0x68
[   33.596204]  blocking_notifier_call_chain+0x80/0xc0
[   33.596211]  online_pages+0x25e/0x280
[   33.596218]  memory_block_change_state+0x176/0x1f0
[   33.596225]  memory_subsys_online+0x37/0x40
[   33.596230]  online_store+0x9b/0x130
[   33.596236]  kernfs_fop_write_iter+0x128/0x1b0
[   33.596242]  vfs_write+0x24b/0x2c0
[   33.596249]  ksys_write+0x74/0xe0
[   33.596254]  do_syscall_64+0x43/0x90
[   33.596259]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: mm/demotion: Add hotplug callbacks to handle new numa node onlined
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a20795bb0e07..ba844fe9cc8c 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -451,7 +451,7 @@ static bool clear_node_memory_tier(int node)
 		memtype = node_memory_types[node];
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
-			list_del(&memtype->tier_sibiling);
+			list_del_init(&memtype->tier_sibiling);
 			if (list_empty(&memtier->memory_types))
 				destroy_memory_tier(memtier);
 		}
-- 
2.37.2

