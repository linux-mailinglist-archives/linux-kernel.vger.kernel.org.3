Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812A4BA615
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbiBQQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:35:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiBQQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:35:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D5F2B2C69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:34:47 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HFkkua014009;
        Thu, 17 Feb 2022 16:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=xuEL5PQSIwZ8ZHqhbHa5ioaU/uO1OmJIiPq42ozg+Vk=;
 b=mv+RSvdisCRNqsGVYPXJrzw59Gs0Z5lDHscKtscj7Z42eyQtw8RQk5RkgUuOy43f2Xt5
 yjQMb/tG/ACVYms+tM41t7wWtrQA4UkPW77ZYRmc9xH+ILhfhWEsu4rVl+mdtX3sFrS+
 FDIeyjP4NTGfl9s7VTa9ooidECT9qAwOT4oaWsLELw4iImtvQZza+RO7ZIXc9Yb+Yb12
 ovhpsyYsBASpu64XpTyZ9brhDwyt5a4SrRb1sV9u7ObfE1i4Y3fvCOJkR3e/xClHj7Qt
 l1I2mW1U+sh/F+HisQRUicm3Tu4cyD5MoX9tZfEWkZlAkVhJIunZQgoZSwhGjCl4EFHR Eg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9sa91ccy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HGHTQd031877;
        Thu, 17 Feb 2022 16:34:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64hamce0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HGYQdR37290476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 16:34:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95C5A52051;
        Thu, 17 Feb 2022 16:34:26 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.54.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A18E52063;
        Thu, 17 Feb 2022 16:34:21 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Cc:     santosh@fossix.org, maddy@linux.ibm.com, rnsastry@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v6 1/4] drivers/nvdimm: Add nvdimm pmu structure
Date:   Thu, 17 Feb 2022 22:03:54 +0530
Message-Id: <20220217163357.276036-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217163357.276036-1-kjain@linux.ibm.com>
References: <20220217163357.276036-1-kjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K932WkG9nHt-X6dotSvurjcZNjISkOvy
X-Proofpoint-GUID: K932WkG9nHt-X6dotSvurjcZNjISkOvy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=906
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A structure is added called nvdimm_pmu, for performance
stats reporting support of nvdimm devices. It can be used to add
device pmu data such as pmu data structure for performance
stats, nvdimm device pointer along with cpumask attributes.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
Changelog:
Resend v5 -> v6
- No logic change, just a rebase to latest upstream and
  tested the patch.

- Link to the patchset Resend v5: https://lkml.org/lkml/2021/11/15/3979

 include/linux/nd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/nd.h b/include/linux/nd.h
index 8a8c63edb1b2..ad186e828263 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -8,6 +8,7 @@
 #include <linux/ndctl.h>
 #include <linux/device.h>
 #include <linux/badblocks.h>
+#include <linux/perf_event.h>
 
 enum nvdimm_event {
 	NVDIMM_REVALIDATE_POISON,
@@ -23,6 +24,25 @@ enum nvdimm_claim_class {
 	NVDIMM_CCLASS_UNKNOWN,
 };
 
+/**
+ * struct nvdimm_pmu - data structure for nvdimm perf driver
+ * @pmu: pmu data structure for nvdimm performance stats.
+ * @dev: nvdimm device pointer.
+ * @cpu: designated cpu for counter access.
+ * @node: node for cpu hotplug notifier link.
+ * @cpuhp_state: state for cpu hotplug notification.
+ * @arch_cpumask: cpumask to get designated cpu for counter access.
+ */
+struct nvdimm_pmu {
+	struct pmu pmu;
+	struct device *dev;
+	int cpu;
+	struct hlist_node node;
+	enum cpuhp_state cpuhp_state;
+	/* cpumask provided by arch/platform specific code */
+	struct cpumask arch_cpumask;
+};
+
 struct nd_device_driver {
 	struct device_driver drv;
 	unsigned long type;
-- 
2.31.1

