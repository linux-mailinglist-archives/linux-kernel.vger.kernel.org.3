Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470FF5097C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384914AbiDUGlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDUGlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:41:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998DDFC7;
        Wed, 20 Apr 2022 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523141; x=1682059141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tRiylTZEyGnmok4xZrcOLzssYSLSFxbagoPYNhTAEf0=;
  b=mxCJ1lxe9kcd0nqdUx/OeRoNxhhhvF6w6AemfjmAsu4/qvsjkcFpVMkv
   rOGxCM8N+BtvOO1H0cPytPQd/WhIDBcBNhiBGLiDl4RXH1r+WHLPEDvSX
   vV7vZ368kzbdocbeLRhb8Z8uiIjogbBVtdGr3p0ypDEg2kr9Q5d2R/NMk
   AckkMjStM2QUCZ6Q9jd4GfR+ygEZ0zzE5d87Z2/bzgM5iyLhmRXEyOAZA
   S8Xv5N162XAVhkhyZEsjTDjkVQzg0zokSuHdrgmMW5BxcAYXogjjhvQ/t
   q7Oe0Hm6PFOXs95bH5ppNejCMEoTi7kbBl4XKbmZy0pENBbhdFLr90Jgm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251569452"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="251569452"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670043379"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 23:38:59 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH] tools/power turbostat: print the kernel boot commandline
Date:   Thu, 21 Apr 2022 22:38:34 +0800
Message-Id: <20220421143834.627841-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be handy to have cmdline in turbostat output. For example,
according to the turbostat output, there are no C-states requested.
In this case the user is very curious if something like
intel_idle.max_cstate=0 was used, or may be idle=none too. It is
also curious whether things like intel_pstate=nohwp were used.

Print the boot command line accordingly:
turbostat version 21.05.04 - Len Brown <lenb@kernel.org>
Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0+ root=UUID=
 b42359ed-1e05-42eb-8757-6bf2a1c19070 ro quiet splash vt.handoff=7

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bc5ae0872fed..bfcb6345510b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5976,6 +5976,29 @@ void print_version()
 	fprintf(outf, "turbostat version 21.05.04" " - Len Brown <lenb@kernel.org>\n");
 }
 
+#define COMMAND_LINE_SIZE 2048
+
+void print_bootcmd(void)
+{
+	char bootcmd[COMMAND_LINE_SIZE];
+	FILE *fp;
+	int ret;
+
+	memset(bootcmd, 0, COMMAND_LINE_SIZE);
+	fp = fopen("/proc/cmdline", "r");
+	if (!fp)
+		return;
+
+	ret = fread(bootcmd, sizeof(char), COMMAND_LINE_SIZE - 1, fp);
+	if (ret) {
+		bootcmd[ret] = '\0';
+		/* the last character is already '\n' */
+		fprintf(outf, "Kernel command line: %s", bootcmd);
+	}
+
+	fclose(fp);
+}
+
 int add_counter(unsigned int msr_num, char *path, char *name,
 		unsigned int width, enum counter_scope scope,
 		enum counter_type type, enum counter_format format, int flags)
@@ -6425,8 +6448,10 @@ int main(int argc, char **argv)
 	outf = stderr;
 	cmdline(argc, argv);
 
-	if (!quiet)
+	if (!quiet) {
 		print_version();
+		print_bootcmd();
+	}
 
 	probe_sysfs();
 
-- 
2.25.1

