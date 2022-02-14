Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1D4B5D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiBNVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:49:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiBNVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:49:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E368D194170;
        Mon, 14 Feb 2022 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644875339; x=1676411339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgCkQ2NGl6kNtBv0PJ01OQfL9X/ihdcLA+SoGtX1dco=;
  b=mGfVtYBpHKL1Or1xkO8Dqjumhw3zaH6UWJctosUH2uVoDYSbK2RWX9j2
   g0wQVosg8FoDwEToFl7y6J0wYEpbHOMcserf+EZodGM9dZhREOZWqXVag
   sfVB/ZXwM/+OzRyS4p+tL/Mb7Ydp64aT74Nhu+qG8DGoJNeSdFKavoyQu
   LQYOPhmQiPPnLCe2A/GtlLJ0VPyO/j8KXP+6OoD3fje1+kh8MntDsEYHG
   RsyJ2dQrjtQRg4QoU2kkBIaBmkIyyveLGTywHAdhu55Y37/603R+6Sq5F
   A+pTeCQQNl0F5Kh9akmYAd+5tBY9QYiwfYyz2u1rEz9UwNqck/UoafY+a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250137064"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250137064"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="587370369"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 13:33:06 -0800
Received: from debox1-desk4.intel.com (unknown [10.255.228.161])
        by linux.intel.com (Postfix) with ESMTP id 87CAF580D3A;
        Mon, 14 Feb 2022 13:33:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        mgross@linux.intel.com, rjw@rjwysocki.net,
        srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/3] platform/x86/intel: pmt: Remove bin_attribute mmap support to runtime pm
Date:   Mon, 14 Feb 2022 13:32:56 -0800
Message-Id: <20220214213258.1929462-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214213258.1929462-1-david.e.box@linux.intel.com>
References: <20220214213258.1929462-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMT devices need to support runtime D3. However, binary attributes don't
provide access to open/release methods that could be used to control
runtime pm. Therefore, remove the mmap operation. The data may still be
accessed with read() calls.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V0 comments:

I expect that this is an undesirable solution because of the ABI change.
I don't know if anyone is using this ABI outside of our Intel tools which
are willing to make this change. I'd rather find a solution to keep the
mmap support. I initially wrote a patch to simply add the missing open and
release callbacks to binary attributes but this was thought to be too heavy
handed in our internal review. I'm open to suggestions. Thanks.

David

 .../ABI/testing/sysfs-class-intel_pmt         | 24 +++++++-------
 drivers/platform/x86/intel/pmt/class.c        | 31 -------------------
 2 files changed, 12 insertions(+), 43 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-intel_pmt b/Documentation/ABI/testing/sysfs-class-intel_pmt
index ed4c886a21b1..4182f67dcef8 100644
--- a/Documentation/ABI/testing/sysfs-class-intel_pmt
+++ b/Documentation/ABI/testing/sysfs-class-intel_pmt
@@ -15,10 +15,10 @@ Description:
 		The telem<x> directory contains files describing an instance of
 		a PMT telemetry device that exposes hardware telemetry. Each
 		telem<x> directory has an associated telem file. This file
-		may be opened and mapped or read to access the telemetry space
-		of the device. The register layout of the telemetry space is
-		determined from an XML file that matches the PCI device id and
-		GUID for the device.
+		may be opened and read to access the telemetry space of the
+		device. The register layout of the telemetry space is determined
+		from an XML file that matches the PCI device id and GUID for the
+		device.
 
 What:		/sys/class/intel_pmt/telem<x>/telem
 Date:		October 2020
@@ -26,7 +26,7 @@ KernelVersion:	5.10
 Contact:	David Box <david.e.box@linux.intel.com>
 Description:
 		(RO) The telemetry data for this telemetry device. This file
-		may be mapped or read to obtain the data.
+		may be read to obtain the data.
 
 What:		/sys/class/intel_pmt/telem<x>/guid
 Date:		October 2020
@@ -43,7 +43,7 @@ KernelVersion:	5.10
 Contact:	David Box <david.e.box@linux.intel.com>
 Description:
 		(RO) The size of telemetry region in bytes that corresponds to
-		the mapping size for the telem file.
+		the size of the telem file.
 
 What:		/sys/class/intel_pmt/telem<x>/offset
 Date:		October 2020
@@ -51,7 +51,7 @@ KernelVersion:	5.10
 Contact:	David Box <david.e.box@linux.intel.com>
 Description:
 		(RO) The offset of telemetry region in bytes that corresponds to
-		the mapping for the telem file.
+		the size of the telem file.
 
 What:		/sys/class/intel_pmt/crashlog<x>
 Date:		October 2020
@@ -61,10 +61,10 @@ Description:
 		The crashlog<x> directory contains files for configuring an
 		instance of a PMT crashlog device that can perform crash data
 		recording. Each crashlog<x> device has an associated crashlog
-		file. This file can be opened and mapped or read to access the
-		resulting crashlog buffer. The register layout for the buffer
-		can be determined from an XML file of specified GUID for the
-		parent device.
+		file. This file can be opened and read to access the resulting
+		crashlog buffer. The register layout for the buffer can be
+		determined from an XML file of specified GUID for the parent
+		device.
 
 What:		/sys/class/intel_pmt/crashlog<x>/crashlog
 Date:		October 2020
@@ -72,7 +72,7 @@ KernelVersion:	5.10
 Contact:	David Box <david.e.box@linux.intel.com>
 Description:
 		(RO) The crashlog buffer for this crashlog device. This file
-		may be mapped or read to obtain the data.
+		may be read to obtain the data.
 
 What:		/sys/class/intel_pmt/crashlog<x>/guid
 Date:		October 2020
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 1c9e3f3ea41c..85fc159961c1 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -68,36 +68,6 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static int
-intel_pmt_mmap(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, struct vm_area_struct *vma)
-{
-	struct intel_pmt_entry *entry = container_of(attr,
-						     struct intel_pmt_entry,
-						     pmt_bin_attr);
-	unsigned long vsize = vma->vm_end - vma->vm_start;
-	struct device *dev = kobj_to_dev(kobj);
-	unsigned long phys = entry->base_addr;
-	unsigned long pfn = PFN_DOWN(phys);
-	unsigned long psize;
-
-	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
-		return -EROFS;
-
-	psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
-	if (vsize > psize) {
-		dev_err(dev, "Requested mmap size is too large\n");
-		return -EINVAL;
-	}
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (io_remap_pfn_range(vma, vma->vm_start, pfn,
-		vsize, vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-
 static ssize_t
 guid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -263,7 +233,6 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 	sysfs_bin_attr_init(&entry->pmt_bin_attr);
 	entry->pmt_bin_attr.attr.name = ns->name;
 	entry->pmt_bin_attr.attr.mode = 0440;
-	entry->pmt_bin_attr.mmap = intel_pmt_mmap;
 	entry->pmt_bin_attr.read = intel_pmt_read;
 	entry->pmt_bin_attr.size = entry->size;
 
-- 
2.25.1

