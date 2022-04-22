Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268550C1AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiDVWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiDVWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:01:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E6306720
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:11 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MJrAOK020809;
        Fri, 22 Apr 2022 19:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lZutXka2GOB3kc31PvIIjpZk/pQq2vS+oBixzg1Fc18=;
 b=J6TkaY7cLuuJXoqIwycNItdTnzjcfWrnbcSwG5UKNuHlyScXbFWxjtVcqno/nW3cksVB
 YDK7JlurtLztJvbObs4YmeS7Q6Rz/rUQf8/yhu0pKOcdsLeE5nYcH7wdlqs4xY2c/Jar
 IR2uWIL9VsWnhW2oMgrdLf6w4oDQk3dCPxOOdJPGdRUP41RU+k4INzAdtIYxLgeSKMs6
 wnXVEhViw9z5iuGWYYkCPV/MDsIopLGfipb/0vAr4e705I1dnItyRDxIW0C6s0FBTnaC
 sBoCbbQNmZj5NN85sGmF6amXuaf4ow/RWeLm4LDRxwxPsfhzmZjtBav+h4GCK2oJ0TBt Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkrbbwck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:57 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJtvj0017102;
        Fri, 22 Apr 2022 19:55:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkrbbwck0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJiexr005656;
        Fri, 22 Apr 2022 19:55:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2j1u45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtpwR55705928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC67211C04C;
        Fri, 22 Apr 2022 19:55:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BFDD11C04A;
        Fri, 22 Apr 2022 19:55:48 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:48 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 6/7] mm: demotion: expose per-node demotion targets via sysfs
Date:   Sat, 23 Apr 2022 01:25:15 +0530
Message-Id: <20220422195516.10769-7-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pAt2Pn13pdZaoo_rYGtyjmBx-8Mrss4r
X-Proofpoint-GUID: 0q4ved5SKwpCH7ZhFuWSXgyGuXdlaO8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel prepares per-node demotion target list based on
node_states[N_DEMOTION_TARGETS], If enabled through sysfs,
demotion kicks in during reclaim, and pages get migrated
according to demotion target list prepared by kernel.

It is helpful to know demotion target list prepared by
kernel to understand the demotion behaviour, so add
interface /sys/devices/system/node/nodeX/demotion_targets
to view per-node demotion targets via sysfs.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 drivers/base/node.c     | 10 ++++++++++
 include/linux/migrate.h |  1 +
 mm/migrate.c            | 17 +++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index e03eedbc421b..92326219aac2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -561,11 +561,21 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t demotion_targets_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	nodemask_t demotion_targets = node_get_demotion_targets(dev->id);
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&demotion_targets));
+}
+static DEVICE_ATTR_RO(demotion_targets);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_demotion_targets.attr,
 	NULL
 };
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 90e75d5a54d6..072019441a24 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -173,6 +173,7 @@ int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
 int next_demotion_node(int node);
+nodemask_t node_get_demotion_targets(int node);
 
 #else /* CONFIG_MIGRATION disabled: */
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 5b92a09fbe4a..da864831bc0c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2187,6 +2187,23 @@ struct demotion_nodes {
 
 static struct demotion_nodes *node_demotion __read_mostly;
 
+nodemask_t node_get_demotion_targets(int node)
+{
+	nodemask_t demotion_targets = NODE_MASK_NONE;
+	unsigned short target_nr;
+
+	if (!node_demotion)
+		return NODE_MASK_NONE;
+
+	rcu_read_lock();
+	target_nr = READ_ONCE(node_demotion[node].nr);
+	for (int i = 0; i < target_nr; i++)
+		node_set(READ_ONCE(node_demotion[node].nodes[i]), demotion_targets);
+	rcu_read_unlock();
+
+	return demotion_targets;
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
-- 
2.35.1

