Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6350735C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354844AbiDSQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354755AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888E115FDA;
        Tue, 19 Apr 2022 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386349; x=1681922349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ARNz7nUBZvuZ8VHGg0IyjYjwy19s9Gc7GZ5lMCyM5s=;
  b=hHP4jWtDw1/QWNjiMPmahAsC40ILAdW51GkK4Fm1S8Rdn7EUCJ4IWTeT
   M1v90nI0obTT205cs7t/7Vk/p6+LOMxWcy0vgqUwHy2Eu2DuEpPrcdqA4
   FzorkLDZcDNcvV4KQNGvj44h1M0QnDbfOk/nvn+cXoY7sZSBL9glomS8M
   IPruTXWZFchaD+UnJOjfB7eNtsTzr/XkxMGfRlaVZCELKMZw0Uw65B+s/
   6DnJ+i23TanvcbOVFesZtjcBAnhHfelE23Po2rmwjW7iEALSc9MitpN/1
   8qUcNO8VqqP5j8PSdGfoojINcCyDBgFeKkleBx3gSaO3kZcuGkUqem+6B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702537"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702537"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802150"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:08 -0700
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
Subject: [PATCH v3 06/11] platform/x86/intel/ifs: Check IFS Image sanity
Date:   Tue, 19 Apr 2022 09:38:54 -0700
Message-Id: <20220419163859.2228874-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/platform/x86/intel/ifs/load.c | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index fa6c64707a73..b05d9055c391 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,9 +3,73 @@
 
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <asm/cpu.h>
+#include <asm/microcode_intel.h>
 
 static const char *ifs_path = "intel/ifs/";
 
+static int ifs_sanity_check(struct device *dev, void *mc)
+{
+	struct microcode_header_intel *mc_header = mc;
+	unsigned long total_size, data_size;
+	u32 sum, i;
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
+	sum = 0;
+	i = total_size / sizeof(u32);
+	while (i--)
+		sum += ((u32 *)mc)[i];
+
+	if (sum) {
+		dev_err(dev, "bad ifs data checksum, aborting.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool find_ifs_matching_signature(struct device *dev, struct ucode_cpu_info *uci, void *mc)
+{
+	struct microcode_header_intel *shdr;
+	unsigned int mc_size;
+
+	shdr = (struct microcode_header_intel *)mc;
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
+static bool ifs_image_sanity_check(struct device *dev, void *data)
+{
+	struct ucode_cpu_info uci;
+
+	intel_cpu_collect_info_early(&uci);
+
+	return find_ifs_matching_signature(dev, &uci, data);
+}
+
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
  * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
@@ -25,6 +89,11 @@ int load_ifs_binary(struct device *dev)
 		return ret;
 	}
 
+	if (!ifs_image_sanity_check(dev, (void *)fw->data)) {
+		dev_err(dev, "ifs header sanity check failed\n");
+		ret = -ENOENT;
+	}
+
 	release_firmware(fw);
 
 	return ret;
-- 
2.35.1

