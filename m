Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A04C9538
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiCAT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiCAT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25266CA4F;
        Tue,  1 Mar 2022 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164555; x=1677700555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uC5rspVyubKHGiV6BlR4gnoUFKw65v33QJn3OEQqbkU=;
  b=IOoZOGRRikwdpzSswMurQR0EKwqWDL8VJRRQVBZmjCtGZvHeIS6JJ9li
   3J8ccSQa+qQHiQ+z19v1Yli5khrRcKZFRcSUa3H8jOSxVVN55u4IaIiZs
   inYT3mO2y0f3wMiLcvUBstwn+I3gv3tiZQeQd1spvKJtvw8ZleDyMi5EH
   XII0u7Bu6wd3ui9aoWCtY3KVfRGNLzI+Jb4VAfgg8gD/oS0wVngxYo8ep
   ZICGZsmUtrsPP20ch2g/57T4CWWtPQM1b5d+ZbGd7ZhZ0oCXlrZjuqKq3
   1UosNvEabEX2Bkn2mwEQfAGiAwMqtBo1NEzIP1U1XvvYHjmta2ky4RRww
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194894"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194894"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133167"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 05/10] platform/x86/intel/ifs: Check IFS Image sanity
Date:   Tue,  1 Mar 2022 11:54:52 -0800
Message-Id: <20220301195457.21152-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS image is designed specifically for a given family, model and
stepping of the processor. Like Intel microcode header, the IFS image
has the Processor Signature, Checksum and Processor Flags that must be
matched with the information returned by the CPUID.

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 1a5e906c51af..b40f70258f8e 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -6,6 +6,7 @@
 
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <asm/microcode_intel.h>
 
 #include "ifs.h"
 static const char *ifs_path = "intel/ifs/";
@@ -27,6 +28,67 @@ struct ifs_header {
 #define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
 static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
+static int ifs_sanity_check(void *mc)
+{
+	struct microcode_header_intel *mc_header = mc;
+	unsigned long total_size, data_size;
+	u32 sum, i;
+
+	total_size = get_totalsize(mc_header);
+	data_size = get_datasize(mc_header);
+
+	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
+		pr_err("bad ifs data file size.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+		pr_err("invalid/unknown ifs update format.\n");
+		return -EINVAL;
+	}
+
+	sum = 0;
+	i = total_size / sizeof(u32);
+	while (i--)
+		sum += ((u32 *)mc)[i];
+
+	if (sum) {
+		pr_err("bad ifs data checksum, aborting.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool find_ifs_matching_signature(struct ucode_cpu_info *uci, void *mc)
+{
+	struct microcode_header_intel *shdr;
+	unsigned int mc_size;
+
+	shdr = (struct microcode_header_intel *)mc;
+	mc_size = get_totalsize(shdr);
+
+	if (!mc_size || ifs_sanity_check(shdr) < 0) {
+		pr_err("ifs sanity check failure\n");
+		return false;
+	}
+
+	if (!cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->sig, shdr->pf)) {
+		pr_err("ifs signature, pf not matching\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool ifs_image_sanity_check(void *data)
+{
+	struct ucode_cpu_info uci;
+
+	collect_cpu_info_early(&uci);
+
+	return find_ifs_matching_signature(&uci, data);
+}
 
 static const struct firmware *load_binary(const char *path)
 {
@@ -45,6 +107,11 @@ static const struct firmware *load_binary(const char *path)
 		goto out;
 	}
 
+	if (!ifs_image_sanity_check((void *)fw->data)) {
+		pr_err("ifs header sanity check failed\n");
+		release_firmware(fw);
+		fw = NULL;
+	}
 out:
 	platform_device_unregister(ifs_pdev);
 
-- 
2.17.1

