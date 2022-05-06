Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53B51E25B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442324AbiEFW6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444590AbiEFW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:58:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4CAFF4;
        Fri,  6 May 2022 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651877660; x=1683413660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j8Pu8lD/llak8O7ELIsdTVSd0MJLc866Awr81ZvC1iY=;
  b=gLibcW4E46RBhP90Nr8hWROBGQIW8lfVLv6A7i/eqLTNcSK/XfV1kaed
   XNxaoj7CCXAz9OE1Avsmn0oGSUXeDvX7LQlPE5rvETxftfydizXOIZUy3
   RSMwFI755n/c5tBV3+7BmEZCXqHVAdIvAS1MlJ2l7TW+jRZgSIxCovUic
   iWmH7jwqQvViq1e8SLKNnHm6yWoYkAk0o29+fclA+0+h75bzM3FYCZUlU
   Pf+lqzfR1zwxaHm2dtc/ezJm5Knd4d8PLNUrVC1mmKreikPZWVzROj97k
   kgIJC3/na6MvXszucGHrqD4V8h7qE7PDCkgMMNqrmKrBk280D28goZu7g
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256080797"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="256080797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695383633"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v7 06/12] platform/x86/intel/ifs: Check IFS Image sanity
Date:   Fri,  6 May 2022 15:54:04 -0700
Message-Id: <20220506225410.1652287-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506225410.1652287-1-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

IFS image is designed specifically for a given family, model and
stepping of the processor. Like Intel microcode header, the IFS image
has the Processor Signature, Checksum and Processor Flags that must be
matched with the information returned by the CPUID.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/ifs/load.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 9fb71d38c819..cfbf62494c89 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -2,9 +2,72 @@
 /* Copyright(c) 2022 Intel Corporation. */
 
 #include <linux/firmware.h>
+#include <asm/cpu.h>
+#include <asm/microcode_intel.h>
 
 #include "ifs.h"
 
+static int ifs_sanity_check(struct device *dev,
+			    const struct microcode_header_intel *mc_header)
+{
+	unsigned long total_size, data_size;
+	u32 sum, *mc;
+
+	total_size = get_totalsize(mc_header);
+	data_size = get_datasize(mc_header);
+
+	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
+		dev_err(dev, "bad ifs data file size.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+		dev_err(dev, "invalid/unknown ifs update format.\n");
+		return -EINVAL;
+	}
+
+	mc = (u32 *)mc_header;
+	sum = 0;
+	for (int i = 0; i < total_size / sizeof(u32); i++)
+		sum += mc[i];
+
+	if (sum) {
+		dev_err(dev, "bad ifs data checksum, aborting.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool find_ifs_matching_signature(struct device *dev, struct ucode_cpu_info *uci,
+					const struct microcode_header_intel *shdr)
+{
+	unsigned int mc_size;
+
+	mc_size = get_totalsize(shdr);
+
+	if (!mc_size || ifs_sanity_check(dev, shdr) < 0) {
+		dev_err(dev, "ifs sanity check failure\n");
+		return false;
+	}
+
+	if (!intel_cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->sig, shdr->pf)) {
+		dev_err(dev, "ifs signature, pf not matching\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool ifs_image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
+{
+	struct ucode_cpu_info uci;
+
+	intel_cpu_collect_info(&uci);
+
+	return find_ifs_matching_signature(dev, &uci, data);
+}
+
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
  * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
@@ -24,5 +87,8 @@ void ifs_load_firmware(struct device *dev)
 		return;
 	}
 
+	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data))
+		dev_err(dev, "ifs header sanity check failed\n");
+
 	release_firmware(fw);
 }
-- 
2.35.1

