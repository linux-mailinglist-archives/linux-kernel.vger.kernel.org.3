Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8549E959
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiA0RzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:65458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244647AbiA0RzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306114; x=1674842114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aeJ1/P1xqXGcj5TN1+2Hu9SHaU92723DTWbcaS3bA44=;
  b=MGYhsQSRCmobDyWpag5+3qHyfXR/ViAeZsHHklrNshvBwwXgaBCaHUJI
   XJvmAfvHKqOHrSbWQ+b300k+leO0zg6lti1vT/OUfYuG1c0cDptzKYtdH
   rbNPgcyrLlan8EtMo2otAqGZJtEBgXLeVMTOBkfBuLUo5AyTRrvhwCdHj
   rlJPGuscbjPqNjVYpAfn96ogcjML6eRQ9KIzKKYcKP5XQ+1k1zU7w8HG9
   aNIcXTh6105+WWeEylzi30UMpeb/SGh1thJ423OWZ5XP64nIFTQwJ51Js
   /4ooxAzU1KP+uXv16yWLgduAWWcVJs0BKpx2oMndYkp0iZi4r7JvMNQF/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899116"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796047"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 02/44] Documentation/protection-keys: Clean up documentation for User Space pkeys
Date:   Thu, 27 Jan 2022 09:54:23 -0800
Message-Id: <20220127175505.851391-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The documentation for user space pkeys was a bit dated including things
such as Amazon and distribution testing information which is irrelevant
now.

Update the documentation.  This also streamlines adding the Supervisor
Pkey documentation later on.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/protection-keys.rst | 43 ++++++++++------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e72d0b2..12331db474aa 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,31 +4,28 @@
 Memory Protection Keys
 ======================
 
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake (and later) "Scalable Processor"
-Server CPUs. It will be available in future non-server Intel parts
-and future AMD processors.
-
-For anyone wishing to test or use this feature, it is available in
-Amazon's EC2 C5 instances and is known to work there using an Ubuntu
-17.04 image.
-
-Memory Protection Keys provides a mechanism for enforcing page-based
-protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
-
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
+Memory Protection Keys provide a mechanism for enforcing page-based
+protections, but without requiring modification of the page tables when an
+application changes protection domains.
+
+PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
+Processor" Server CPUs and later.  And it will be available in future
+non-server Intel parts and future AMD processors.
+
+pkeys work by dedicating 4 previously Reserved bits in each page table entry to
+a "protection key", giving 16 possible keys.
+
+Protections for each key are defined with a per-CPU user-accessible register
+(PKRU).  Each of these is a 32-bit register storing two bits (Access Disable
+and Write Disable) for each of 16 keys.
+
+Being a CPU register, PKRU is inherently thread-local, potentially giving each
 thread a different set of protections from every other thread.
 
-There are two new instructions (RDPKRU/WRPKRU) for reading and writing
-to the new register.  The feature is only available in 64-bit mode,
-even though there is theoretically space in the PAE PTEs.  These
-permissions are enforced on data access only and have no effect on
-instruction fetches.
+There are two instructions (RDPKRU/WRPKRU) for reading and writing to the
+register.  The feature is only available in 64-bit mode, even though there is
+theoretically space in the PAE PTEs.  These permissions are enforced on data
+access only and have no effect on instruction fetches.
 
 Syscalls
 ========
-- 
2.31.1

