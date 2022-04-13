Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED4C4FF361
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiDMJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiDMJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:24:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17552E5B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:22:33 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D8fnt5015860;
        Wed, 13 Apr 2022 09:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DC90fePYOoCr+3ib3Y1j/qpFHxLAIQ/hvFvZPCUiPLM=;
 b=LZztJFQkhVDpUpW5WhYo/PC/SZs0ezbBUQQ4L5P8kSgsLTvWr0jsPtOw+f4JyR8vUMYx
 zcwVW3Un8o0NJv1v+0KYZ0hRfAMbLtmDg6Z3+2tIJphU//m7FKFFtZIieYCikslHuEUy
 MeKQGdaMKTx9jxAj99iqM6rP0vO3X3U5ua1fqry8XBcvvCfkPumT7ALSLJKTrKTlWgpI
 HyYemXs1l0Y5ZmSGC1TK83lw+nqJ2R9PiT49b6tcICJf0FbAgRQXkqKkJb76JIojAosH
 1a3SgU46B93cradmujMKhHD/4sCkJ6EveF1tWsv0cLnuHSjPhMd7TwlR12FzqAe6M1DG WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdu7sry95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:29 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23D9MTPh017708;
        Wed, 13 Apr 2022 09:22:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdu7sry8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D9KGRa030806;
        Wed, 13 Apr 2022 09:22:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fb1dj6fm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D9MOCX33620248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 09:22:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FEA4C046;
        Wed, 13 Apr 2022 09:22:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 901474C044;
        Wed, 13 Apr 2022 09:22:21 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.51.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 09:22:21 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 3/5] mm: demotion: Add support to set targets from userspace
Date:   Wed, 13 Apr 2022 14:52:04 +0530
Message-Id: <20220413092206.73974-4-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hdHHjqQxSQNPifr7Z18VkAsJBt2ofxx1
X-Proofpoint-ORIG-GUID: Hw1mFgL-SDpAqea-jpyTjfCTiBnzxBM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_01,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add support to set node_states[N_DEMOTION_TARGETS] from
user space to override the default demotion targets.

Restrict demotion targets to memory only numa nodes
while setting them from user space.

Demotion targets can be set from userspace using command,
echo <nodelist> > /sys/kernel/mm/numa/demotion_target

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 12 +++++++
 mm/migrate.c                                  | 35 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d4ed80..10e9e643845c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -22,3 +22,15 @@ Description:	Enable/disable demoting pages during reclaim
 		the guarantees of cpusets.  This should not be enabled
 		on systems which need strict cpuset location
 		guarantees.
+
+What:		/sys/kernel/mm/numa/demotion_target
+Date:		April 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configure demotion target nodes
+
+		Page migration during reclaim is intended for systems
+		with tiered memory configurations. Preferred migration target
+		nodes can be configured in a system using this interface, based
+		on which demotion table is prepared in kernel. If demotion is
+		enabled then pages will be migrated to set demotion targets
+		during reclaim.
diff --git a/mm/migrate.c b/mm/migrate.c
index 516f4e1348c1..4d3d80ca0a7f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2564,12 +2564,47 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
 	return count;
 }
 
+
+static ssize_t numa_demotion_target_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&node_states[N_DEMOTION_TARGETS]));
+}
+
+static ssize_t numa_demotion_target_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *nodelist, size_t count)
+{
+	nodemask_t nodes;
+
+	if (nodelist_parse(nodelist, nodes))
+		return -EINVAL;
+
+	if (!nodes_subset(nodes, node_states[N_MEMORY]))
+		return -EINVAL;
+
+	if (nodes_intersects(nodes, node_states[N_CPU]))
+		return -EINVAL;
+
+	node_states[N_DEMOTION_TARGETS] = nodes;
+
+	set_migration_target_nodes();
+
+	return count;
+}
+
 static struct kobj_attribute numa_demotion_enabled_attr =
 	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
 	       numa_demotion_enabled_store);
 
+static struct kobj_attribute numa_demotion_target_attr =
+	__ATTR(demotion_target, 0644, numa_demotion_target_show,
+	       numa_demotion_target_store);
+
 static struct attribute *numa_attrs[] = {
 	&numa_demotion_enabled_attr.attr,
+	&numa_demotion_target_attr.attr,
 	NULL,
 };
 
-- 
2.35.1

