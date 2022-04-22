Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD250C35C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiDVW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiDVWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:25:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECC11F96D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:17:40 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MGXP4U010796;
        Fri, 22 Apr 2022 19:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lm2njEXu/VlZ5DeJu6voRE/R0+J9++pgff3IHSCKCDM=;
 b=c927QxCgv7cDkZ+YGo6jErhsk+SgqBQKN3DRra+el/MSSZulsjqqrl00WlLBXSB8WR+g
 W8XnLt8S2EEiZzJSuU/tZ8oXu2odLp5g0xRiOmaGrlNYYATtov5uUCB9rQx26u+FF+RK
 5NXiY4j2pr55yHjFPheNA+gabyYE5yuFTjqnH5WD3rtHow0s066VDkZSPaSWDPNoSeYS
 tVRagGXmbvOrx/y2aPLcBbCZbspkf/eJfdQkk99uBiRWmzp43MCTJ7hRGcsS4Q2SO/ch
 sg+RJLJbi0OrZqNWyIFLeCfoE+fdzcRq2DQTkJ8PxHwrjOZxTpWGfbA6smB5ujIBL7eA 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjswfqu9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:40 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJr1ZS032250;
        Fri, 22 Apr 2022 19:55:40 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjswfqu8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:40 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJisxq029302;
        Fri, 22 Apr 2022 19:55:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3ffn2hyt11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtZtb49152346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E157411C052;
        Fri, 22 Apr 2022 19:55:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4CBA11C050;
        Fri, 22 Apr 2022 19:55:31 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:31 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 2/7] mm: demotion: Add new node state N_DEMOTION_TARGETS
Date:   Sat, 23 Apr 2022 01:25:11 +0530
Message-Id: <20220422195516.10769-3-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aRlckp_abbNY4VUdskj5kbYr-iDtmzuD
X-Proofpoint-GUID: IKNXG7uKtK-7dawYm7TAlnVKvtqeozOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=780 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems(e.g. PowerVM) have DRAM(fast memory) only NUMA node
which are N_MEMORY as well as slow memory(persistent memory) only
NUMA node which are also N_MEMORY. As the current demotion target
finding algorithm works based on N_MEMORY and best distance, it can
choose DRAM only NUMA node as demotion target instead of persistent
memory node on such systems. If DRAM only NUMA node is filled with
demoted pages then at some point new allocations can start falling
to persistent memory, so basically cold pages are in fast memory
(due to demotion) and new pages are in slow memory, this is why
persistent memory nodes should be utilized for demotion and dram node
should be avoided for demotion so that they can be used for new
allocations.

Add new state N_DEMOTION_TARGETS, node_states[N_DEMOTION_TARGETS]
then can be used to hold the list of nodes which can be used
as demotion targets, later patches in the series builds demotion
targets based on nodes available in node_states[N_DEMOTION_TARGETS].

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 drivers/base/node.c      | 4 ++++
 include/linux/nodemask.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..6eef22e6413e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -1038,6 +1038,9 @@ static struct node_attr node_state_attr[] = {
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
+	[N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
+					  N_DEMOTION_TARGETS),
+
 };
 
 static struct attribute *node_state_attrs[] = {
@@ -1050,6 +1053,7 @@ static struct attribute *node_state_attrs[] = {
 	&node_state_attr[N_MEMORY].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
+	&node_state_attr[N_DEMOTION_TARGETS].attr.attr,
 	NULL
 };
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..17844300fd57 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -400,6 +400,7 @@ enum node_states {
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
 	N_CPU,		/* The node has one or more cpus */
 	N_GENERIC_INITIATOR,	/* The node has one or more Generic Initiators */
+	N_DEMOTION_TARGETS,	/* Nodes that should be considered as demotion targets */
 	NR_NODE_STATES
 };
 
-- 
2.35.1

