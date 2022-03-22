Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9E4E46D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiCVTkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiCVTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:40:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CF117F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:38:37 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MHln0d028926;
        Tue, 22 Mar 2022 19:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U5sDEkN7/ajTT0RkuVblmkXX0gg8BTa9VfgXgds6LSY=;
 b=cCeDHwpxjFi8Z/GmUd+eHqTQVKq/bhZXFRt2xpedOtInM8dZHP6PSaFJWJg2djzmT/AE
 OpwgG18ci6/8PFze1dEp/JFJU4ElHxHe9NNxnKjvfKDWhkA6wc1kS4SumNt0SX7iwgNU
 dlj2GYv5rMu/vn0tEYNLkGf/gU1WkF5WPziYk0RETQoeP2ADONj5pXoQY2n8kNniBVea
 ckvZ44YeqgWXkMMeVBrt8D1UO3tWSMrQPgCmak/srXwpIYEmkgS5rdkuFNArikhqPnwD
 AgT57Y9SUk7gWxMICfefAtgzJ3hconBXyKV7HmiZWrRMBKnXVWU7kHbn8s0nwT7qKom7 gQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyk2yth0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 19:38:25 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22MJXeS0024748;
        Tue, 22 Mar 2022 19:38:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3ew6t9e9ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 19:38:23 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22MJcMqX37618016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 19:38:22 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF03124058;
        Tue, 22 Mar 2022 19:38:22 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6134412405E;
        Tue, 22 Mar 2022 19:38:21 +0000 (GMT)
Received: from li-37e927cc-2b02-11b2-a85c-931637a79255.ibm.com.com (unknown [9.160.85.177])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 22 Mar 2022 19:38:21 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     stefani@seibold.net, torvlds@linux-foundation.org,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] kfifo: fix kfifo_init comment about power of 2 rounding
Date:   Tue, 22 Mar 2022 12:38:13 -0700
Message-Id: <20220322193813.677697-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FnUaEB7BVr-PzIMK3lc4c4L_clpgbZkG
X-Proofpoint-ORIG-GUID: FnUaEB7BVr-PzIMK3lc4c4L_clpgbZkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=854
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since, Commit ab9bb6318b09 ("Partially revert "kfifo: fix kfifo_alloc()
and kfifo_init()"") kfifo_init() rounds the preallocated buffer size
down to a power of 2 to determine the number of kfifo elements. The
documentation around the kfifo_init() macro was not updated to reflect
this change from the previous behavior that rounded up to a power of 2.

Fixes: ab9bb6318b09 ("Partially revert "kfifo: fix kfifo_alloc() and kfifo_init()"")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 include/linux/kfifo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 86249476b57f..123fa759bba9 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -378,7 +378,7 @@ __kfifo_int_must_check_helper( \
  *
  * This macro initializes a fifo using a preallocated buffer.
  *
- * The number of elements will be rounded-up to a power of 2.
+ * The number of elements will be rounded-down to a power of 2.
  * Return 0 if no error, otherwise an error code.
  */
 #define kfifo_init(fifo, buffer, size) \
-- 
2.35.1

