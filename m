Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A550C138
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiDVVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiDVVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C934179C3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:12 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MIwSSP017070;
        Fri, 22 Apr 2022 19:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4X2QURIlgZAv9adJmpQNjH+Rxhc/IoUAl9LWBytqM5A=;
 b=cSsN4Bqg5QdTDSh5z+pM1k1bytAuEMcbVQuYYoPu5OCWQCZcvZoKTcisFl1GZbwDsGeN
 bpLy/NaXp5b5b5kroh3liym+anJCX5hedx3AEArxuU5yox2LensXy2ysXFI+XBUyiHhj
 sY8n1e5XVNheuYeX11hnCK3xDE4IXGLas9qTIX7WiK9XHzI93HdUPzt2zZ1Pm76Y0e1q
 jS+zK/dBOGq9Q2bZ6pKcJnxKHPXezw6xr7WRgHUFYHeyjkXDWMBD+3HaMfC2JqeKfGYA
 Rxhlvp+4axlRQqJ8tPUIaTc4W9YQXgyjNILslmJJLc2U0pUYKzcB712dEqj9HQGNhaza GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jyxr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:49 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJogII012415;
        Fri, 22 Apr 2022 19:55:49 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jyxqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:48 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJiZqd005844;
        Fri, 22 Apr 2022 19:55:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne97td3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJgoKO35127788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:42:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5580711C04A;
        Fri, 22 Apr 2022 19:55:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E17311C04C;
        Fri, 22 Apr 2022 19:55:40 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:39 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 4/7] device-dax/kmem: Set node state as N_DEMOTION_TARGETS
Date:   Sat, 23 Apr 2022 01:25:13 +0530
Message-Id: <20220422195516.10769-5-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WYHc5m7ZLWuDYh8gE8WUbhlGSGAIMlTY
X-Proofpoint-ORIG-GUID: bZ4xj7Y8DyommoyUhUEXDMw8rSd5AuDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set dax-device node as N_DEMOTION_TARGETS so that it
can be used as demotion target.

In future, support should be added to distinguish the
dax-devices which are not preferred as demotion target
e.g. HBM, for such devices, node shouldn't be set to
N_DEMOTION_TARGETS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 drivers/dax/kmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..f42ab9d04bdf 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -147,6 +147,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
+	node_set_state(numa_node, N_DEMOTION_TARGETS);
+
 	return 0;
 
 err_request_mem:
-- 
2.35.1

