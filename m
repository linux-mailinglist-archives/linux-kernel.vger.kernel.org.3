Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA55A5AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiH3Emq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3Emo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:42:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D295AA4F8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:42:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U4Km3m010039;
        Tue, 30 Aug 2022 04:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=cHcAyJQxcN5coWhjTOmFLDC9BLXPhcUenvryaCOl6DQ=;
 b=qJ5DPNX1FGK2JZTrttbMnRkNVAGWsH6wF7d9mOL/JspiVVTKz/BnfCYMmQqXTLp0wDbd
 JXo1dan0Zd/JDLLc0jTuc2hUrAnaFQB1GqIgSbr5ETkty67bm13meebI+Zd6eKpUSBQ2
 6nbiOvIjuFNfBDaGbizm0WS43+k0aqZNndtW02jIaN8nTlU+FpDbAlJZs8c+qdYN2HdE
 bfCDy+7PHiXVJV9ej/TIBZM8Uev3kpgQjhE/31GxeqylfeAi+6uvbhTHnlgDIS72hE2z
 xVt2blRUPJKih8UE5JU+LN4q45CG8tNqx5aN7xT0uyONBUg5gQX06zs+5p9XO2pcXd4J jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9ben0tes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 04:42:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27U4Mq82024987;
        Tue, 30 Aug 2022 04:42:21 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9ben0tdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 04:42:21 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U4ZfZr012657;
        Tue, 30 Aug 2022 04:42:20 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3j7aw99f2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 04:42:20 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U4gJ5r64225778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 04:42:19 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36685AC060;
        Tue, 30 Aug 2022 04:42:19 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E211AC059;
        Tue, 30 Aug 2022 04:42:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.77.247])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 04:42:13 +0000 (GMT)
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
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH mm-unstable] mm/demotion: Fix build error with CONFIG_MIGRATION disabled
Date:   Tue, 30 Aug 2022 10:12:10 +0530
Message-Id: <20220830044210.17546-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ms_3wKFoDG7SuOiU16agbwBvt1PyFDV7
X-Proofpoint-GUID: GhD6_EsfBXZGg-d9TgHR1S6yDgGilRXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/memory-tiers.c: In function ‘toptier_nodes_show’:
mm/memory-tiers.c:647:49: error: ‘top_tier_adistance’ undeclared (first use in this function); did you mean ‘iov_iter_advance’?
  647 |                 if (memtier->adistance_start >= top_tier_adistance)
      |                                                 ^~~~~~~~~~~~~~~~~~
      |                                                 iov_iter_advance
mm/memory-tiers.c:647:49: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [scripts/Makefile.build:249: mm/memory-tiers.o] Error 1

Fixes: mm/demotion: Expose memory tier details via sysfs
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index d4648d4e4d54..b6c7e5987829 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -635,6 +635,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 	return notifier_from_errno(0);
 }
 
+#ifdef CONFIG_MIGRATION
 static ssize_t toptier_nodes_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -654,6 +655,15 @@ static ssize_t toptier_nodes_show(struct device *dev,
 	mutex_unlock(&memory_tier_lock);
 	return ret;
 }
+#else
+static ssize_t toptier_nodes_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	nodemask_t top_tier_mask = node_states[N_MEMORY];
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&top_tier_mask));
+}
+#endif
 static DEVICE_ATTR_RO(toptier_nodes);
 
 static struct attribute *memtier_subsys_attrs[] = {
-- 
2.37.2

