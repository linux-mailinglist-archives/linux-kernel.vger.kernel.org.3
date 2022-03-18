Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D64DD925
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiCRLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiCRLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:44:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A22405B1;
        Fri, 18 Mar 2022 04:42:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22I8Gk00009380;
        Fri, 18 Mar 2022 11:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=etN1PDHz/2z4Sz/gbJNqm+0duzQA2/2HC6BdCXipIGM=;
 b=iouByIowKClLcp2sjbCcOAcBjOO09vWASv4XNIygZl6tPKex/48hDjtZIyewM4OetgH8
 jozKoPv2GuUaahjAd3XMRd1AzvaKAhonOmlUX4qn255AEQsSGjQkdyMYXFhFNZKyKdtZ
 QJGOasYedz/cMSfNxBB9LPFIEEQruV/838rTsUYEtjO0K4Z7yaTE35kAimzCKB4yH3lJ
 IYgzdlhmI8J28hWXlNKL7rZTQtV49DMh2SCs2VJW0mgrZq/KyU7NekGU7iUwbFWJRGcF
 j+dy7s1LarmGc1oZqppYVMYgd4coTfYEBN0jMK+8a4ddoU/6H5ioM5KTwdKfTQ5ox070 jg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ev10dc9d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 11:41:59 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22IBXO8O030585;
        Fri, 18 Mar 2022 11:41:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3erk58ue5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 11:41:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22IBfsOI49349100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 11:41:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A6D95204F;
        Fri, 18 Mar 2022 11:41:54 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.108.37])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E234C5204E;
        Fri, 18 Mar 2022 11:41:48 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, peterz@infradead.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, sfr@canb.auug.org.au
Cc:     santosh@fossix.org, maddy@linux.ibm.com, rnsastry@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de, kjain@linux.ibm.com,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] drivers/nvdimm: Fix build failure when CONFIG_PERF_EVENTS is not set
Date:   Fri, 18 Mar 2022 17:11:32 +0530
Message-Id: <20220318114133.113627-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v-BlhMt60iwjTiL1t2iLUciFcC3xcbsO
X-Proofpoint-GUID: v-BlhMt60iwjTiL1t2iLUciFcC3xcbsO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_08,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build failure occures when CONFIG_PERF_EVENTS is not set
as generic pmu functions are not visible in that scenario.

|-- s390-randconfig-r044-20220313
|   |-- nd_perf.c:(.text):undefined-reference-to-perf_pmu_migrate_context
|   |-- nd_perf.c:(.text):undefined-reference-to-perf_pmu_register
|   `-- nd_perf.c:(.text):undefined-reference-to-perf_pmu_unregister

Similar build failure in nds32 architecture:
nd_perf.c:(.text+0x21e): undefined reference to `perf_pmu_migrate_context'
nd_perf.c:(.text+0x434): undefined reference to `perf_pmu_register'
nd_perf.c:(.text+0x57c): undefined reference to `perf_pmu_unregister'

Fix this issue by adding check for CONFIG_PERF_EVENTS config option
and disabling the nvdimm perf interface incase this config is not set.

Also removed function declaration of perf_pmu_migrate_context,
perf_pmu_register, perf_pmu_unregister functions from nd.h as these are
common pmu functions which are part of perf_event.h and since we
are disabling nvdimm perf interface incase CONFIG_PERF_EVENTS option
is not set, we not need to declare them in nd.h

Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose
nvdimm performance stats") (Commit id based on linux-next tree)
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Link: https://lore.kernel.org/all/62317124.YBQFU33+s%2FwdvWGj%25lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/nvdimm/Makefile | 2 +-
 include/linux/nd.h      | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

---
- This fix patch changes are added and tested on top of linux-next tree
  on the 'next-20220315' branch.
---
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 3fb806748716..ba0296dca9db 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -15,7 +15,7 @@ nd_e820-y := e820.o
 libnvdimm-y := core.o
 libnvdimm-y += bus.o
 libnvdimm-y += dimm_devs.o
-libnvdimm-y += nd_perf.o
+libnvdimm-$(CONFIG_PERF_EVENTS) += nd_perf.o
 libnvdimm-y += dimm.o
 libnvdimm-y += region_devs.o
 libnvdimm-y += region.o
diff --git a/include/linux/nd.h b/include/linux/nd.h
index 7b2ccbdc1cbc..a4265eaf5ae8 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -8,8 +8,10 @@
 #include <linux/ndctl.h>
 #include <linux/device.h>
 #include <linux/badblocks.h>
+#ifdef CONFIG_PERF_EVENTS
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#endif
 
 enum nvdimm_event {
 	NVDIMM_REVALIDATE_POISON,
@@ -25,6 +27,7 @@ enum nvdimm_claim_class {
 	NVDIMM_CCLASS_UNKNOWN,
 };
 
+#ifdef CONFIG_PERF_EVENTS
 #define NVDIMM_EVENT_VAR(_id)  event_attr_##_id
 #define NVDIMM_EVENT_PTR(_id)  (&event_attr_##_id.attr.attr)
 
@@ -63,9 +66,7 @@ extern ssize_t nvdimm_events_sysfs_show(struct device *dev,
 
 int register_nvdimm_pmu(struct nvdimm_pmu *nvdimm, struct platform_device *pdev);
 void unregister_nvdimm_pmu(struct nvdimm_pmu *nd_pmu);
-void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu);
-int perf_pmu_register(struct pmu *pmu, const char *name, int type);
-void perf_pmu_unregister(struct pmu *pmu);
+#endif
 
 struct nd_device_driver {
 	struct device_driver drv;
-- 
2.31.1

