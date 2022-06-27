Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2D55D6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiF0Vuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiF0Vuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:50:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB92DC9;
        Mon, 27 Jun 2022 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656366643; x=1687902643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p9nbmeAUVIyt45kDOqNNIMa+DKOyaEwgkbvEn2hif7g=;
  b=j+pvSU3rjz3nijVZlN0sloKYf1bjOlSLP7EUqx9HqktqQ85Kjq93Vur8
   YeImsZoVJ8dNsHubc+INB7wbPFlgefdhWSoo9Fgjpl2FjBRjUbKnLqEga
   ozRtP0ArqbJny2KhGBop+Av6V4D3M/NOC1mvZWwka4GgJm3cEHPPyyw6I
   we2yVv989B0+mDGVJvSHPD2RMBG/UJVAV6ZK21KsECWNhEvNOfKiBzQCe
   X9WrsFBX8VFKNkzL4tH/7WXv9rnzRVoGaraHbnxAWMBZowW8XlWuIi91X
   yQPaJ4O+4ZmpcPCKPjgs1lzcWYWx75V2WFfIpftgUSRXKFpzUme25l4GT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282305334"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282305334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657862028"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 14:50:41 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering
Date:   Mon, 27 Jun 2022 14:50:31 -0700
Message-Id: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/speed_select_if/isst_if_common.c    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e8424e70d81d..f3cd1be3283a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -286,11 +286,18 @@ struct isst_if_cpu_info {
 	int numa_node;
 };
 
+struct isst_if_pkg_info {
+	struct pci_dev *pci_dev[2];
+};
+
 static struct isst_if_cpu_info *isst_cpu_info;
+static struct isst_if_pkg_info *isst_pkg_info;
+
 #define ISST_MAX_PCI_DOMAINS	8
 
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
+	int pkg_id = topology_physical_package_id(cpu);
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
 	int no_matches = 0;
@@ -324,6 +331,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 		}
 
 		if (node == isst_cpu_info[cpu].numa_node) {
+			isst_pkg_info[pkg_id].pci_dev[bus_no] = _pci_dev;
+
 			pci_dev = _pci_dev;
 			break;
 		}
@@ -342,6 +351,9 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (!pci_dev && no_matches == 1)
 		pci_dev = matched_pci_dev;
 
+	if (!pci_dev)
+		pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
+
 	return pci_dev;
 }
 
@@ -417,10 +429,19 @@ static int isst_if_cpu_info_init(void)
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
@@ -433,6 +454,7 @@ static int isst_if_cpu_info_init(void)
 static void isst_if_cpu_info_exit(void)
 {
 	cpuhp_remove_state(isst_if_online_id);
+	kfree(isst_pkg_info);
 	kfree(isst_cpu_info);
 };
 
-- 
2.31.1

