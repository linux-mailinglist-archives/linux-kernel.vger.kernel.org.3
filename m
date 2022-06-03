Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E353CAD3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiFCNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244781AbiFCNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:44:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317013A1A3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:44:13 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253AacwD001424;
        Fri, 3 Jun 2022 13:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6JnFH6Ge2DqnYCy9p4M/QpIYwkZi2m2iZlpzOFDI2qU=;
 b=bN2bC5I0eXblOAEaGNm11SXMP/VWA4sA188NRfcEFNnqyumOWRm8ARhUjOnW+gmiNrDH
 FiywIb8w/NZvE130mx//VhfTxO4itfMSXWHeZSF/CvsIBDQAFqhcwYbyRZhxYSo15G0Z
 bEUGpTDefxG230zAK80qPqtcwpCeAvwwdbgIqBKANubqK8cvIJJh5//O/XZNK0Ug3sQl
 sXOMeAbrFS+l46YlA19/EvESTF9qJti5nWCHqJ9c9XJoEU5np9SCJlWHUxly3C67DEVP
 E9vqSRAepOYpl+MyiQxBfqjq7jXEUczhObDn/fqSXgSqAaY/bm8bfesYARKVhaQ20KUA 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfeksdewt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:02 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253BZDYD031309;
        Fri, 3 Jun 2022 13:44:01 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfeksdew8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:01 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253Da8xw005528;
        Fri, 3 Jun 2022 13:44:00 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3gcxt62yjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DhxoG3801862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:43:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63A86112062;
        Fri,  3 Jun 2022 13:43:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 981C2112063;
        Fri,  3 Jun 2022 13:43:51 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:43:51 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 5/9] mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
Date:   Fri,  3 Jun 2022 19:12:33 +0530
Message-Id: <20220603134237.131362-6-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ng9BJzbA3aQjPHA8NpZ2baLKJ6Aib5bK
X-Proofpoint-ORIG-GUID: XdqiEYOM5eBOErlTnTvrzuuKbVYkljLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
is memory tier 1 which is designated for nodes with DRAM, so it
is not the right tier for dax devices.

Set dax kmem device node's tier to MEMORY_TIER_PMEM, In future,
support should be added to distinguish the dax-devices which should
not be MEMORY_TIER_PMEM and right memory tier should be set for them.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c | 4 ++++
 mm/memory-tiers.c  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..7a11c387fbbc 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory-tiers.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
+#ifdef CONFIG_TIERED_MEMORY
+	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
+#endif
 	return 0;
 
 err_request_mem:
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0d05c0bfb79b..9c82cf4c4bca 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -364,6 +364,7 @@ int node_set_memory_tier(int node, int tier)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(node_set_memory_tier);
 
 /**
  * next_demotion_node() - Get the next node in the demotion path
-- 
2.36.1

