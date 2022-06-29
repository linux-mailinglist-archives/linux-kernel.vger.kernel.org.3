Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4148560AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiF2TwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Tv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:51:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B629CB1;
        Wed, 29 Jun 2022 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656532317; x=1688068317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N/fkGCuTMr1eYUIcmeBesy9hJ2pRKXecFt00zHBxD1E=;
  b=m7hJaZaReGqdEIXNcAJ/jq9URzfK1KEw42tGWc5g8pwanIMP5UQ+wx4z
   jLeE9Gd3wemulQiflBSbpdz9zbgH2rfkI56alLQIX3hnJwTB7/Be8FPi1
   jcMDwXbS5I1MUvfmkZ48r+ac4DSQqzTGxWGlYd0vq3OX9YrbhaBPZuSY3
   FhuhZPg+bPc96m+2mvvMqsxfHWw7ykWE7sLHj3u7NkEYBG5ZdwXoxpXx0
   93SnCI/tIjzh82K4QJ2wuOOfEkng9te8E3HpB0/0HjbJoceZvG0J62Gs7
   +kR3k9lbxFYqxJ2ahvjPui4IccfgXaKOOxfiE9dltJn9qhxZ0hnj8/j34
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307644703"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="307644703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="717956836"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2022 12:48:24 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering
Date:   Wed, 29 Jun 2022 12:48:17 -0700
Message-Id: <20220629194817.2418240-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a multiple package system using Sub-NUMA clustering, there is an issue
in mapping Linux CPU number to PUNIT PCI device when manufacturer decided
to reuse the PCI bus number across packages. Bus number can be reused as
long as they are in different domain or segment. In this case some CPU
will fail to find a PCI device to issue SST requests.

When bus numbers are reused across CPU packages, we are using proximity
information by matching CPU numa node id to PUNIT PCI device numa node
id. But on a package there can be only one PUNIT PCI device, but multiple
numa nodes (one for each sub cluster). So, the numa node ID of the PUNIT
PCI device can only match with one numa node id of CPUs in a sub cluster
in the package.

Since there can be only one PUNIT PCI device per package, if we match
with numa node id of any sub cluster in that package, we can use that
mapping for any CPU in that package. So, store the match information
in a per package data structure and return the information when there
is no match.

While here, use defines for max bus number instead of hardcoding.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
- Use #define for max bus number and use

 .../intel/speed_select_if/isst_if_common.c    | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e8424e70d81d..fd102678c75f 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -277,29 +277,38 @@ static int isst_if_get_platform_info(void __user *argp)
 	return 0;
 }
 
+#define ISST_MAX_BUS_NUMBER	2
 
 struct isst_if_cpu_info {
 	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
-	int bus_info[2];
-	struct pci_dev *pci_dev[2];
+	int bus_info[ISST_MAX_BUS_NUMBER];
+	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
 	int punit_cpu_id;
 	int numa_node;
 };
 
+struct isst_if_pkg_info {
+	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
+};
+
 static struct isst_if_cpu_info *isst_cpu_info;
+static struct isst_if_pkg_info *isst_pkg_info;
+
 #define ISST_MAX_PCI_DOMAINS	8
 
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
-	int no_matches = 0;
+	int no_matches = 0, pkg_id;
 	int i, bus_number;
 
-	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
-	    cpu >= num_possible_cpus())
+	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
+	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
+	pkg_id = topology_physical_package_id(cpu);
+
 	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
 	if (bus_number < 0)
 		return NULL;
@@ -324,6 +333,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 		}
 
 		if (node == isst_cpu_info[cpu].numa_node) {
+			isst_pkg_info[pkg_id].pci_dev[bus_no] = _pci_dev;
+
 			pci_dev = _pci_dev;
 			break;
 		}
@@ -342,6 +353,10 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (!pci_dev && no_matches == 1)
 		pci_dev = matched_pci_dev;
 
+	/* Return pci_dev pointer for any matched CPU in the package */
+	if (!pci_dev)
+		pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
+
 	return pci_dev;
 }
 
@@ -361,8 +376,8 @@ struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *pci_dev;
 
-	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
-	    cpu >= num_possible_cpus())
+	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER  || cpu < 0 ||
+	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
 	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];
@@ -417,10 +432,19 @@ static int isst_if_cpu_info_init(void)
 	if (!isst_cpu_info)
 		return -ENOMEM;
 
+	isst_pkg_info = kcalloc(topology_max_packages(),
+				sizeof(*isst_pkg_info),
+				GFP_KERNEL);
+	if (!isst_pkg_info) {
+		kfree(isst_cpu_info);
+		return -ENOMEM;
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"platform/x86/isst-if:online",
 				isst_if_cpu_online, NULL);
 	if (ret < 0) {
+		kfree(isst_pkg_info);
 		kfree(isst_cpu_info);
 		return ret;
 	}
@@ -433,6 +457,7 @@ static int isst_if_cpu_info_init(void)
 static void isst_if_cpu_info_exit(void)
 {
 	cpuhp_remove_state(isst_if_online_id);
+	kfree(isst_pkg_info);
 	kfree(isst_cpu_info);
 };
 
-- 
2.31.1

