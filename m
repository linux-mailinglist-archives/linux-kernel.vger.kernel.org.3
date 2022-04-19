Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3972750760F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355526AbiDSRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355357AbiDSRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F555FF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388013; x=1681924013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kg96elYopHb8G+ADzcmCb8Kh5ugzUamsq/2aa+YD4w=;
  b=ZVSM1sGmAxhpfn5iglGqwXYe/CCOwcVrab2Q0ZRjLKo1W4BoeMsc09mr
   DvqS3ffSnJHCzl6Vq7hvKoa6h7kPtH7LtF0uoJAdZlndYN1bVNLrqggBp
   BrpRmQE4+nHitsqakA6Qm2GX1k4W69uDAZYJXY9MMeqH5Yu6wKKizaCSy
   1H72YFRFufuRZJd6rH0Bxd90kn0S4JGbfiFFF73ke5wgwTWaDWjz58J/H
   TAV6S/oisr6CvW+F9OIpNbySVYvaiDcpn0TQA22m46z4cNfaCqO3RWrlW
   bal1GWWUdbZ6zjcUpjea0Ug9NrMS/+dVqYEhsqAv6G8tZ2b/MiMSlkekz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267538"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267538"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727145490"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:51 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 01/44] Documentation/protection-keys: Clean up documentation for User Space pkeys
Date:   Tue, 19 Apr 2022 10:06:06 -0700
Message-Id: <20220419170649.1022246-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The documentation for user space pkeys was a bit dated including things
such as Amazon and distribution testing information which is irrelevant
now.

Update the documentation.  This also streamlines adding the Supervisor
pkey documentation later on.

Cc: "Moger, Babu" <Babu.Moger@amd.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9:
	use pkey
	Change information on which CPU's have PKU
---
 Documentation/core-api/protection-keys.rst | 44 +++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e72d0b2..bf28ac0401f3 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,31 +4,29 @@
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
+Pkeys Userspace (PKU) is a feature which can be found on:
+        * Intel server CPUs, Skylake and later
+        * Intel client CPUs, Tiger Lake (11th Gen Core) and later
+        * Future AMD CPUs
+
+Pkeys work by dedicating 4 previously Reserved bits in each page table entry to
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
2.35.1

