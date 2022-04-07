Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA84F87DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiDGTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiDGTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D023F3CD;
        Thu,  7 Apr 2022 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358867; x=1680894867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+eR5D0XLFb0F39D069TY7O/BYuSHP4xfr5BdPVb8HQk=;
  b=IP7m5+ICybaADfbzgEpvP557CtdkqRcTRtp/1LbCLBCW52TMA4/i0Guk
   636vMY49tLK3VNGrT90L5ibsytOi17iyPCX3Da0+6aKo2bPSCyn2KoAe0
   +n4TV8hV6b17AvAMJJ0M02EP5ItX/35XlPjuVGaSuDkbfTdbAdGo/19ob
   Ym/lQoE4Tgoz1nzUqDf50TC81IYwKa+FTqmgpMYbqfnciGyXJ8V1yOjjg
   EBWUdrJZEVD3KmUFppn6rlgY04BDp4iFXqPT0C+1R/+7XseN5Ctah+1KI
   awZACfjnekpPG46g3BkqA/6MFcEE4WImIqiPkHrD5sI3pTLX7unJuKRGn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255381"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193717"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:17 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 05/10] platform/x86/intel/ifs: Check IFS Image sanity
Date:   Thu,  7 Apr 2022 12:13:42 -0700
Message-Id: <20220407191347.9681-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS image is designed specifically for a given family, model and
stepping of the processor. Like Intel microcode header, the IFS image
has the Processor Signature, Checksum and Processor Flags that must be
matched with the information returned by the CPUID.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index a1be4d6558a1..8f2735775f5b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,6 +3,7 @@
 
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <asm/microcode_intel.h>
 
 #include "ifs.h"
 static const char *ifs_path = "intel/ifs/";
@@ -24,6 +25,67 @@ struct ifs_header {
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
+		dev_err(&ifs_pdev->dev, "bad ifs data file size.\n");
+		return -EINVAL;
+	}
+
+	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+		dev_err(&ifs_pdev->dev, "invalid/unknown ifs update format.\n");
+		return -EINVAL;
+	}
+
+	sum = 0;
+	i = total_size / sizeof(u32);
+	while (i--)
+		sum += ((u32 *)mc)[i];
+
+	if (sum) {
+		dev_err(&ifs_pdev->dev, "bad ifs data checksum, aborting.\n");
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
+		dev_err(&ifs_pdev->dev, "ifs sanity check failure\n");
+		return false;
+	}
+
+	if (!cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->sig, shdr->pf)) {
+		dev_err(&ifs_pdev->dev, "ifs signature, pf not matching\n");
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
+	cpu_collect_info_early(&uci);
+
+	return find_ifs_matching_signature(&uci, data);
+}
 
 static const struct firmware *load_binary(const char *path)
 {
@@ -36,6 +98,11 @@ static const struct firmware *load_binary(const char *path)
 		goto out;
 	}
 
+	if (!ifs_image_sanity_check((void *)fw->data)) {
+		dev_err(&ifs_pdev->dev, "ifs header sanity check failed\n");
+		release_firmware(fw);
+		fw = NULL;
+	}
 out:
 
 	return fw;
-- 
2.17.1

