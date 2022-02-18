Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EEC4BBECA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiBRRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:55:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiBRRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:55:19 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F843EDC;
        Fri, 18 Feb 2022 09:55:02 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IFhPYG007416;
        Fri, 18 Feb 2022 17:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=BDCWoVxZhWp+yRyjutXwaRP+sENqxLUBzem2qgF/z9M=;
 b=VWBscN6jMC2Mn2Xikuyg7QOIxwnp2oXBj167aCrF4dmTAlid1IvYzBscJjRDDT/T6kjv
 BRWPoBXr5rzoXyfgzgvp4myAbc+BU9d+tU7F9B1DjNgm+g9g/wRXdbIxOGdgwuIXCm09
 HcrqCNto5mt0KDSLGYli+PugpAyq9VNeyyDy6nyRGg8tdBVowgprLLhsAxhMlZzmZIi5
 2tw3y1Xzp/MB5ghvMWVMqTMizimNw/lh9/kmtVWewH95NmcjEkmVtAH8Q8D28h9xXBZs
 5g8Dxqa1sp8SpHlmM8roNJiP32U9VUYxi2vuqZHaaySjAPT0xGOQUcNeBvnikc5LZ9yZ qQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eaafdu5ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 17:54:21 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 00A3454;
        Fri, 18 Feb 2022 17:54:20 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 7BB7848;
        Fri, 18 Feb 2022 17:54:19 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id F0C03302F479A; Fri, 18 Feb 2022 11:54:18 -0600 (CST)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Liang, Kan" <kan.liang@intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Make uncore_discovery clean for 64 bit addresses
Date:   Fri, 18 Feb 2022 11:54:18 -0600
Message-Id: <20220218175418.421268-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2UpB5lcVBq5cN9LvENogUWC_9oqLFg1F
X-Proofpoint-ORIG-GUID: 2UpB5lcVBq5cN9LvENogUWC_9oqLFg1F
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_07,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180111
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support 64-bit BAR size for discovery, and do not truncate return from
generic_uncore_mmio_box_ctl() to 32 bits.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/events/intel/uncore_discovery.c | 16 +++++++++++-----
 arch/x86/events/intel/uncore_discovery.h |  2 --
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 3049c646fa20..141a540e7403 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -210,15 +210,21 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	void __iomem *io_addr;
 	resource_size_t addr;
 	unsigned long size;
-	u32 val;
+	u32 val, val2;
 	int i;
 
 	pci_read_config_dword(dev, bar_offset, &val);
 
-	if (val & UNCORE_DISCOVERY_MASK)
+	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
 		return -EINVAL;
 
-	addr = (resource_size_t)(val & ~UNCORE_DISCOVERY_MASK);
+	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		pci_read_config_dword(dev, bar_offset + 4, &val2);
+		addr |= ((resource_size_t)val2) << 32;
+	}
+#endif
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
@@ -444,7 +450,7 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 
 #define UNCORE_GENERIC_MMIO_SIZE		0x4000
 
-static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
+static u64 generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 {
 	struct intel_uncore_type *type = box->pmu->type;
 
@@ -456,7 +462,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 
 void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
-	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
+	u64 box_ctl = generic_uncore_mmio_box_ctl(box);
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 6d735611c281..22d40e7afbf1 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -18,8 +18,6 @@
 #define UNCORE_DISCOVERY_BIR_BASE		0x10
 /* Discovery table BAR step */
 #define UNCORE_DISCOVERY_BIR_STEP		0x4
-/* Mask of the discovery table offset */
-#define UNCORE_DISCOVERY_MASK			0xf
 /* Global discovery table size */
 #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
 
-- 
2.26.2

