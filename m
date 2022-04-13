Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818F4FF357
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiDMJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiDMJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:24:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099852E55
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:22:30 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D8oEO7015856;
        Wed, 13 Apr 2022 09:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GuT/Aag64Naw9qrAoc+yZUT4CN6KosjaU/EzDIYcFBQ=;
 b=O3wbE9iYbROYCeCbaC0BXCHr0hxaecx6K+dMduPc4k7L8DR5nrOb59XKJxcmYvn2paal
 uy/T8UxEUvHiNfXssSF5bXUP5OGaSiq39Isn02nXjw+BODp0L1HekQc7gkyyvHnnQMYw
 IL7kzFIJbiE4AT8hevR7N46/X/F2Zsweokki1895H7pcCGccbVyOtwGbQNeH1PjnQwPy
 H1JWTh9HA6xJLdolWGWgjUTCLrBuNqzD1qFF+EWPLPxg5ksPVIPoqlYK+QqK1IXQtLcx
 KFAAWTl03tllY1LWs3c+1lUzfAmJSbkia32ol/AkrhZ6G6TG0iTvgZ87YSi35pdmseF4 OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fduc0rqec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:26 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23D9LOo1013075;
        Wed, 13 Apr 2022 09:22:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fduc0rqdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D9K4mm030760;
        Wed, 13 Apr 2022 09:22:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fb1dj6fky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D9MTQj27984254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 09:22:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1514C040;
        Wed, 13 Apr 2022 09:22:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666894C05C;
        Wed, 13 Apr 2022 09:22:18 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.51.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 09:22:18 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 2/5] mm: demotion: Add new node state N_DEMOTION_TARGETS
Date:   Wed, 13 Apr 2022 14:52:03 +0530
Message-Id: <20220413092206.73974-3-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AqVLASNKy2nlze1g9vVm1zEmaqvPGGah
X-Proofpoint-GUID: _WxfuiiwnygLq1KIjNQFFPFibbAECMho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_01,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=903 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation to find the demotion targets works
based on node state N_MEMORY, however some systems may have
dram only memory numa node which are N_MEMORY but not the
right choices as demotion targets.

Add new state N_DEMOTION_TARGETS, node_states[N_DEMOTION_TARGETS]
then can be used to hold the list of nodes which can be used
as demotion targets.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 drivers/base/node.c      | 4 ++++
 include/linux/nodemask.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..cd79815b0f7a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -1038,6 +1038,9 @@ static struct node_attr node_state_attr[] = {
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
+	[N_DEMOTION_TARGETS] = _NODE_ATTR(has_demotion_targets,
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

