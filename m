Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE25467D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbiFJN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbiFJN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:56:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD597DECFA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:55:51 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADoHxW016649;
        Fri, 10 Jun 2022 13:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a7bDqNWFTJyacCiGWS/s5MOUukAxREUpgwMRPd1dTmg=;
 b=gmx3Xm3F/q8k/GeF3AEMUEoM3pq1O0S6TerX3Vr15BOvghnr4Y+wYZIUVzp2vX6mVw5i
 6rbAVQRbhoVgtIOo1W7JEzAuLc7VEriDN+SxtYaQu/OVJV9kM6Q+5ZhFMWWw0LP3KCUi
 J2ghLkvWRClg17GMTraJpfBj77FjhCd2dS1l1X7XeyOCJtUZiKX9z9Xu4MRW6qfGKQZX
 +V4t4gN7N1c2SSaHpHS+sP9kM/oeLJ+ElKvTstwBJioDjMmEZE61gHBa8TVlJvv2bcXx
 sK1983zDNb6Pm0Hrv3vohfYQixUIfzJcSMQid9EidUH6eZzMDZMvusXKQcKhwMfcDn4I Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gkaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:55:36 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADqjab026257;
        Fri, 10 Jun 2022 13:55:35 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gk9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:55:35 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZXLr004853;
        Fri, 10 Jun 2022 13:54:49 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3gfy1a922m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:49 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADsmFT36438402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:54:48 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900806A04D;
        Fri, 10 Jun 2022 13:54:48 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 975486A051;
        Fri, 10 Jun 2022 13:54:39 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:54:39 +0000 (GMT)
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
Subject: [PATCH v6 13/13] mm/demotion: Add sysfs ABI documentation
Date:   Fri, 10 Jun 2022 19:22:29 +0530
Message-Id: <20220610135229.182859-14-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 96LtkCGvMN52ZkQucdAutDgdVy8ShBGH
X-Proofpoint-GUID: Togfug4tun8xnidrVKBf_HDl7swp2yS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
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
 .../ABI/testing/sysfs-kernel-mm-memory-tiers  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
new file mode 100644
index 000000000000..b41d2977b0a5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -0,0 +1,87 @@
+What:		/sys/devices/system/memtier/
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		This is the directory containing the information about memory tiers.
+
+		Each memory tier has its own subdirectory.
+
+		The order of memory tiers is determined by their rank values, not by
+		their memtier device names.  A higher rank value means a higher tier.
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
+Description:	Maximum number of memory tiers supported
+
+		The max memory tier device ID we can create. Users can create memory
+		tiers in range [0 - max_tier)
+
+What:		/sys/devices/system/memtier/create_tier_from_rank
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface to create memory tiers from userspace
+
+		Writing to this file with a rank value results in creation of
+		a new memory tier with the specified rank value. This is used
+		by userspace to create new memory tiers.
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
+		special meaning, i.e. memtier device ID numbers do not determine the
+		order of memory tiers.
+
+What:		/sys/devices/system/memtier/memtierN/rank
+Date:		June 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Memory tier rank value
+
+
+		When read, list the "rank" value associated with memtierN.
+
+		"Rank" is an opaque value. Its absolute value doesn't have any
+		special meaning. But the rank values of different memtiers can be
+		compared with each other to determine the memory tier order.
+
+		For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
+		their rank values are 100, 10, 50, then the memory tier order is:
+		memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
+		and memtier1 is the lowest tier.
+
+		The rank value of each memtier should be unique.
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

