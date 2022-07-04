Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE8564E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiGDHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiGDHJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D69FE2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:09:19 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2644I0xR009812;
        Mon, 4 Jul 2022 07:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnJ02dPkWpDDGkvE7OaMnTSRCUZ/AidjIhYP6T2x91c=;
 b=Ub27WP/HbjQ2s5MNDk6ivID0OQCgPdwfNzhnoiWHNkVZhpTef02vxe5ikNHRcxeXHoCw
 /D51QIvUyQL/n1jhRQ7oWEqVH8BLj+uFkIq3gcu8eTAZ12Vq4/1TPhiiN2S0c71vHtF/
 CGcGz83+4/f0oXFfFycGalt8t2bhnCKshkn9evXvIvq1Cy1kKqmGBVIxXxor4iHdWnsf
 Bd9d+YJPVxSoHakq7UcqXD8fLI84XWkonRdLYV//5MBj7N0Flyy41JhLSOwSc4cftcHd
 m2s0D590InLVEcy+27xA6Xt7W0hLkdWgs6HqVauqVdzVgf9G/UwnmergcNi7C+PBMwnC ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyjk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:09:07 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646CbEr016057;
        Mon, 4 Jul 2022 07:09:07 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyjj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:09:06 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26475QEA030701;
        Mon, 4 Jul 2022 07:09:05 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3h2dn9b4m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:09:05 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 264795bK29688228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:09:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD1B124053;
        Mon,  4 Jul 2022 07:09:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9A89124052;
        Mon,  4 Jul 2022 07:08:58 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:08:58 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v8 12/12] mm/demotion: Add sysfs ABI documentation
Date:   Mon,  4 Jul 2022 12:36:12 +0530
Message-Id: <20220704070612.299585-13-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gFkjoQ9kYnarDPTZN74KzO8drIqPM-Au
X-Proofpoint-ORIG-GUID: 2qHVjEUxP0p1ktcTGHzKnDujegealXIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040030
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

