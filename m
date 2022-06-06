Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA553E0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiFFF3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiFFF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:28:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655CBBC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:17:07 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25611ZES023526;
        Mon, 6 Jun 2022 04:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=AK8VTiHmZxVWgxKU+PEg8p6oOO/RT8TA0ohFC90Evak=;
 b=hsROOd57sQ8HZ3p9Ln6kgn2UM2hoFhqBSyPKyLVZ75B9qrxT4AF1earP2/q1jLz3T/EY
 7PLuwF/BOdeY4A6qnA25xL7Fp0xcZ29aS0upUsvufgCk+AQhlLjP0bigQSngah0by9Vr
 1drJNWOjbf2C6GU248wI7DLlA6M/v1WB0EhY4+r7J0qLN/ju6R+kSFLcM2YvjkXbdxOL
 EvAMA/t3qIN3Rw6VNKGWjMSpU8ujYBpTBQIpVgnoaBymzrAqU6D7b14Dgi3o2vYieucu
 dt21+K0YbsdylPR0dseQwZLoKTRbL51Ndtgi+YeiP21HjV5vW//XOJAFt+YrJy0jZnrY Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gg206s6wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:54:08 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2564nroK014495;
        Mon, 6 Jun 2022 04:54:08 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gg206s6w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:54:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2564oAW5024146;
        Mon, 6 Jun 2022 04:54:07 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3gfy19b9c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:54:07 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2564s7JM25100606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 04:54:07 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE9BC124058;
        Mon,  6 Jun 2022 04:54:06 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 650C6124053;
        Mon,  6 Jun 2022 04:53:59 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.87.254])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 04:53:59 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
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
        David Rientjes <rientjes@google.com>
Subject: [PATCH] mm/demotion: Add sysfs ABI documentation
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
Date:   Mon, 06 Jun 2022 10:23:56 +0530
Message-ID: <87r1428k9n.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: APa9aTVJURlGYUqnOxoSaN0iZv8cQcAQ
X-Proofpoint-GUID: Kgl80yoV0xVh-NuSz9ALzJJ-2uXVBDmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_01,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From dd986c5aab4f6ccf41cc8d2dde5d9702a17adb6f Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 6 Jun 2022 10:14:17 +0530
Subject: [PATCH] mm/demotion: Add sysfs ABI documentation

Add sysfs ABI documentation.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../ABI/testing/sysfs-kernel-mm-memory-tiers  | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
new file mode 100644
index 000000000000..41b0d1756ddb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -0,0 +1,81 @@
+What:		/sys/devices/system/memtier/
+Date:		Jun 2022
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
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		The default memory tier to which memory would get added via hotplug
+		if the NUMA node is not part of any memory tier.
+
+What:		/sys/devices/system/memtier/max_tier
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		The max memory tier device ID we can create. Users can create memory
+		tiers in range [0 - max_tier)
+
+What:		/sys/devices/system/memtier/memtierN/
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		This is the directory containing the information about a particular
+		memory tier, memtierN, where N is the memtier device ID (e.g. 0, 1).
+
+		The memtier device ID number itself is just an identifier and has no
+		special meaning, i.e. memtier device ID numbers do not determine the
+		order of memory tiers.
+
+What:		/sys/devices/system/memtier/memtierN/rank
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
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
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+
+		When read, list the memory nodes in the specified tier.
+
+What:		/sys/devices/system/node/nodeN/memtier
+Date:		Jun 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for tiered memory
+
+		When read, list the device ID of the memory tier that the node belongs
+		to.  Its value is empty for a CPU-only NUMA node.
+
+		When written, the kernel moves the node into the specified memory
+		tier if the move is allowed. The tier assignments of all other
+		nodes are not affected.
+
+		When written with the special string "none" the specific node is removed
+		from participating in memory demotion.
-- 
2.36.1

