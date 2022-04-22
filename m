Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817350C2FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiDVWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiDVWJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:09:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F6D2D8236;
        Fri, 22 Apr 2022 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660985; x=1682196985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09faArqF0ybDa7yJRCawo2WfNEh4ZJlwmYaJ5Yj+Yxg=;
  b=BdTyC90ioLpAc2WyHDgZAL0Byul7SQBSGxwsARU94bEd4vKFOYWVI4io
   xtKe/XV/tLpsaOHFp57d6fJLn5fHT5lVO4nx0cQzWYZONucQwzgzi4F34
   mDJB2NtMhBBSPbco82YK0aKMe6Ogcbm60s9bcX2NoxRlbEc/SWnvCbQ/a
   KehD6+c0+ml4bj29cm28Bp+97z00KEdGNiOICC22/KWS8ercximagjFc1
   lJbCJ+pHzAzgo3i/Uxu1f1K5u/qjz6X9bJhnJMoHLOQHJ44VWWd2RGm//
   gOefPg37L1gaXoJGYslGlYdcj5sfpb7eODgexLY3UJXLV5ndhmd3PHhRl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289897444"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289897444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511719321"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:26 -0700
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
Subject: [PATCH v4 02/10] x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
Date:   Fri, 22 Apr 2022 13:02:11 -0700
Message-Id: <20220422200219.2843823-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422200219.2843823-1-tony.luck@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTEGRITY_CAPABILITIES MSR is enumerated by bit 2 of the
CORE_CAPABILITIES MSR.

Add defines for the CORE_CAPS enumeration as well as for the integrity
MSR.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/msr-index.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ee15311b6be1..c3dc7ae32f1f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -76,6 +76,8 @@
 
 /* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
 #define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_INTEGRITY_CAPS_BIT	  2
+#define MSR_IA32_CORE_CAPS_INTEGRITY_CAPS	  BIT(MSR_IA32_CORE_CAPS_INTEGRITY_CAPS_BIT)
 #define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
 #define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
 
@@ -154,6 +156,11 @@
 #define MSR_IA32_POWER_CTL		0x000001fc
 #define MSR_IA32_POWER_CTL_BIT_EE	19
 
+/* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
+#define MSR_INTEGRITY_CAPS			0x000002d9
+#define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
+#define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
 #define MSR_LBR_CORE_FROM		0x00000040
-- 
2.35.1

