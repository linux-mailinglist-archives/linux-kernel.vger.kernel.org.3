Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD82250C221
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiDVWJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiDVWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF62B376D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:54:14 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MJb8I3016570;
        Fri, 22 Apr 2022 19:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uY0Z6msCCH9KzE009HO1twr/mIvovXgZnjZLx+NVgAE=;
 b=nIIZJAv0fvAwuej9k4W2ANK++bg/JdZ26uocRoaEqXvKEPT47GMarA1yUxWOBgAHTf76
 YM85CYilX4g0bxafOndy2KThIvQhpRqYIoe4Kct5/ex7IATlx5vLTbnw1t0MkALatWcs
 HuLF2FTQBx3ax6GYl4tMhC1n/KVUortCxt9M4BAiAD2qvIuUkSHbIFhBmafYOQcmjcwr
 mXt6SWSZWnn0hjn4W8Um+H4u2yIsInywh58alLCso7kMCzuHfwjwH/NNqeLVTDl2Cucm
 YP2gjXd1U3CHcnl58ejez88GdcWjSxOsiGRrIo19qwwVJ260QY+7k0Sk4+CiQ03vW/Fs Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjn0ykhqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:45 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJjAEA015282;
        Fri, 22 Apr 2022 19:55:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjn0ykhq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJhTBF027247;
        Fri, 22 Apr 2022 19:55:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ffne8st22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtdkQ40305124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3855711C050;
        Fri, 22 Apr 2022 19:55:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E883311C052;
        Fri, 22 Apr 2022 19:55:35 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:35 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 3/7] drivers/base/node: Add support to write node_states[] via sysfs
Date:   Sat, 23 Apr 2022 01:25:12 +0530
Message-Id: <20220422195516.10769-4-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yOg7QkFiteOgPwyb7WJin5XJOPO6WZ_O
X-Proofpoint-ORIG-GUID: m18RbXrSxa4x2MrQV8mNB9H0Ke2nlc6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current /sys/devices/system/node/* interface doesn't support
to write node_states[], however write support is needed in case
users want to set them manually e.g. when user want to override
default N_DEMOTION_TARGETS found by the kernel.

Rename existing _NODE_ATTR to _NODE_ATTR_RO and introduce new
_NODE_ATTR_RW which can be used for node_states[] which can
be written from sysfs.

It may be necessary to validate written values and take action
based on them in a state specific way so a callback 'write' is
introduced in 'struct node_attr'.

A new function demotion_targets_write() is added to validate
the input nodes for N_DEMOTION_TARGETS which should be subset
of N_MEMORY and to build new demotion list based on new nodes.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 drivers/base/node.c | 62 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6eef22e6413e..e03eedbc421b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/migrate.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -1013,6 +1014,7 @@ void unregister_one_node(int nid)
 struct node_attr {
 	struct device_attribute attr;
 	enum node_states state;
+	int (*write)(nodemask_t nodes);
 };
 
 static ssize_t show_node_state(struct device *dev,
@@ -1024,23 +1026,57 @@ static ssize_t show_node_state(struct device *dev,
 			  nodemask_pr_args(&node_states[na->state]));
 }
 
-#define _NODE_ATTR(name, state) \
-	{ __ATTR(name, 0444, show_node_state, NULL), state }
+static ssize_t store_node_state(struct device *s,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	nodemask_t nodes;
+	struct node_attr *na = container_of(attr, struct node_attr, attr);
+
+	if (nodelist_parse(buf, nodes))
+		return -EINVAL;
+
+	if (na->write) {
+		if (na->write(nodes))
+			return -EINVAL;
+	} else {
+		node_states[na->state] = nodes;
+	}
+
+	return count;
+}
+
+static int demotion_targets_write(nodemask_t nodes)
+{
+	if (nodes_subset(nodes, node_states[N_MEMORY])) {
+		node_states[N_DEMOTION_TARGETS] = nodes;
+		set_migration_target_nodes();
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+#define _NODE_ATTR_RO(name, state) \
+	{ __ATTR(name, 0444, show_node_state, NULL), state, NULL }
+
+#define _NODE_ATTR_RW(name, state, write_fn) \
+	{ __ATTR(name, 0644, show_node_state, store_node_state), state, write_fn }
 
 static struct node_attr node_state_attr[] = {
-	[N_POSSIBLE] = _NODE_ATTR(possible, N_POSSIBLE),
-	[N_ONLINE] = _NODE_ATTR(online, N_ONLINE),
-	[N_NORMAL_MEMORY] = _NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
+	[N_POSSIBLE] = _NODE_ATTR_RO(possible, N_POSSIBLE),
+	[N_ONLINE] = _NODE_ATTR_RO(online, N_ONLINE),
+	[N_NORMAL_MEMORY] = _NODE_ATTR_RO(has_normal_memory, N_NORMAL_MEMORY),
 #ifdef CONFIG_HIGHMEM
-	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
+	[N_HIGH_MEMORY] = _NODE_ATTR_RO(has_high_memory, N_HIGH_MEMORY),
 #endif
-	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
-	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
-	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
-					   N_GENERIC_INITIATOR),
-	[N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
-					  N_DEMOTION_TARGETS),
-
+	[N_MEMORY] = _NODE_ATTR_RO(has_memory, N_MEMORY),
+	[N_CPU] = _NODE_ATTR_RO(has_cpu, N_CPU),
+	[N_GENERIC_INITIATOR] = _NODE_ATTR_RO(has_generic_initiator,
+					      N_GENERIC_INITIATOR),
+	[N_DEMOTION_TARGETS] = _NODE_ATTR_RW(demotion_targets,
+					     N_DEMOTION_TARGETS,
+					     demotion_targets_write),
 };
 
 static struct attribute *node_state_attrs[] = {
-- 
2.35.1

