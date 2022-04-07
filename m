Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F74F87E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiDGTRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbiDGTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49923F3CA;
        Thu,  7 Apr 2022 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358867; x=1680894867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fqThAvr1I3L7T9wbCSFNkzuXDhoOwY6Ol47Y2zn/xYA=;
  b=NZCwBduiR2T0XKhUFAP4LmVzIE6Lo2saDlIAtvCuOzVvIoBzqKp2bcik
   gLTQ4u/N8kO6h74V2Rszk8OmxZ1o0QRwDDqCq3CWF7649N/VIZaTj2Xl7
   jrbmrTOZhsZrn8iVlsr1XCiC87UUIDXVRsI2sVjUr5XCNTFEN8w9GFNSp
   1rxt4Ip6YcYgPbhPVsZ+4/mRQFmpjsnmWwqZ/9NFppBcOP/BrYjQV+RxP
   xM/7pnI3fcKSe9rcWCWHHgd2i9zdrK+n4HeUca0iF85rS3sZiES8gBzuG
   KM3Eogh5pFw9/gkOUlUUxWQLOW0/eeyks2tC0BFbK+FRJQn7XNIolxLuh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255389"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255389"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193732"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:18 -0700
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
Subject: [PATCH v2 09/10] platform/x86/intel/ifs: add ABI documentation for IFS
Date:   Thu,  7 Apr 2022 12:13:46 -0700
Message-Id: <20220407191347.9681-10-jithu.joseph@intel.com>
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

Add the sysfs attributes in ABI/testing for In-Field Scan.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
new file mode 100644
index 000000000000..54dc6cd75484
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -0,0 +1,54 @@
+What:		/sys/devices/platform/intel_ifs/run_test
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	echo <cpu#> to trigger ifs test for all online cores.
+		For e.g to test cpu5 do echo 5 > /sys/devices/platform/intel_ifs/run_test
+
+What:		/sys/devices/platform/intel_ifs/status
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	The status of the last test. It can be one of "pass", "fail"
+		or "untested".
+
+What:		/sys/devices/system/cpu/cpu#/ifs/details
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Additional information regarding the last test. The details file reports
+		the hex value of the SCAN_STATUS MSR. Note that the error_code field
+		may contain driver defined software code not defined in the Intel SDM.
+
+What:		/sys/devices/platform/intel_ifs/image_version
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Version of loaded IFS binary image.
+
+What:		/sys/bus/platform/drivers/intel_ifs/bind
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	echo "intel_ifs" to reload IFS image.
+
+What:		/sys/module/intel_ifs/parameters/noirq
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	IFS tunable parameter that user can modify before
+		the scan run if they wish to override default value.
+
+		When set, system interrupts are not allowed to interrupt an IFS. The
+		default state for this parameter is set.
+
+What:		/sys/module/intel_ifs/parameters/retry
+Date:		April 07, 2022
+KernelVersion:	5.19.0
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	IFS tunable parameter that user can modify before scan run
+		if they wish to override default value.
+
+		Maximum retry counter when the test is not executed due to an
+		event such as interrupt. The default value is 5, it can be set to any
+		value from 1 to 20.
-- 
2.17.1

