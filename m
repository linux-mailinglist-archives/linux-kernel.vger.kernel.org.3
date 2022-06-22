Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A118554713
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbiFVI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351875AbiFVI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:28:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18100387AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:27:14 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M87LEK005188;
        Wed, 22 Jun 2022 08:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnJ02dPkWpDDGkvE7OaMnTSRCUZ/AidjIhYP6T2x91c=;
 b=T5SKmz6Ovz83oz+34wATVGpp8IqyAosoHxTWXIlawcsYiIePU6tL7E7h3Sq7mXw44pHb
 fISU8S1tFcTqpOlquAFCs6cYfN43FtbktspIeUfhi4vl5TCFlW3Fi8MQAx3mIQNgq5VY
 lWNNQmuilcmJqlLPB4HAtzWsePIbzDtyFUkS0u9OrZ2nQrm3eqB49is9cWMOAgjq+vFf
 KEfyTofPPYi7wjWiHu7bgs7kACFkzxQhfeUZF6Zto/cgn5kVJZ2Gj86bKbt1j0toNobQ
 SZV5m6dSbrKPe5ya4IAtHPzDGAj269ky/rvbt5laJEAE6GnRkD2VdohvVLSNKQAbrc3f xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxfs1pqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:54 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M87SOJ006310;
        Wed, 22 Jun 2022 08:26:53 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxfs1ppd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:53 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8LVvD009042;
        Wed, 22 Jun 2022 08:26:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3gs6ba9ba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:47 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8QkEW36045160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:26:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB7956E054;
        Wed, 22 Jun 2022 08:26:46 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 274356E052;
        Wed, 22 Jun 2022 08:26:41 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:26:40 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v7 12/12] mm/demotion: Add sysfs ABI documentation
Date:   Wed, 22 Jun 2022 13:55:13 +0530
Message-Id: <20220622082513.467538-13-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f2cb0cHgD9adoodXVf5M2wNXeBzkLP3V
X-Proofpoint-GUID: sad9r9NDW9OCoPdB6pdre8tsTs2SB-mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs ABI documentation.

Signed-off-by: Wei Xu <weixugc@google.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../ABI/testing/sysfs-kernel-mm-memory-tiers  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
new file mode 100644
index 000000000000..843fb59d2f3d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -0,0 +1,61 @@
+What:		/sys/devices/system/memtier/
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		This is the directory containing the information about memory tiers.
+
+		Each memory tier has its own subdirectory.
+
+		The order of memory tiers is determined by their tier ID value.
+		A higher tier ID value means a higher tier. memtier300 is higher
+		memory tier compared to memtier 100.
+
+What:		/sys/devices/system/memtier/default_tier
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Default memory tier
+
+		The default memory tier to which memory would get added via hotplug
+		if the NUMA node is not part of any memory tier
+
+What:		/sys/devices/system/memtier/max_tier
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Maximum memory tier ID supported
+
+		The max memory tier device ID we can create. Users can create memory
+		tiers in range [0 - max_tier]
+
+What:		/sys/devices/system/memtier/memtierN/
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Directory with details of a specific memory tier
+
+		This is the directory containing the information about a particular
+		memory tier, memtierN, where N is the memtier device ID (e.g. 0, 1).
+
+		The memtier device ID number itself is just an identifier and has no
+		special meaning. Its value relative to other memtiers decides the level
+		of this memtier in the tier hierarchy.
+
+
+What:		/sys/devices/system/memtier/memtierN/nodelist
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Memory tier nodelist
+
+
+		When read, list the memory nodes in the specified tier.
+
+What:		/sys/devices/system/node/nodeN/memtier
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Memory tier details for node N
+
+		When read, list the device ID of the memory tier that the node belongs
+		to.  Its value is empty for a CPU-only NUMA node.
+
+		When written, the kernel moves the node into the specified memory
+		tier if the move is allowed. The tier assignments of all other
+		nodes are not affected.
-- 
2.36.1

