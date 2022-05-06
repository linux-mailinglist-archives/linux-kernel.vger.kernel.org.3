Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05FF51CE12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388032AbiEFBof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387988AbiEFBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:44:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB595B896;
        Thu,  5 May 2022 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801245; x=1683337245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZlj+pyzsQyLjBG0xs1qSodzYo2BytHa+1pwIeQdYQI=;
  b=I3GG9TWN/kK1bIxVhb9Cox1KBVgB3NUbDn6Zw50klp+5IxCN+yfCHvqX
   oRlT01CEcyQ9uxy/szTpSRCL0vP3zVz2Y+VRytLL/Jncht3sSUrPTnem6
   ZD6plVMy9V+szYJdr3qGswScIth2Ffo4jEo7OhtX+jTRnpiJenl3JUo4Y
   VWa2dt1DEriw1mo8qTtz3rsDFa5rcN6F/v683i8Vk37B7DGVhUNMKzLoe
   WTO7TWZMGnLlxYKT8I4YpVqhEeWaxWaBHtXGY4lacj0G2CRLVozF5xGy0
   /7OQT0aQQSgvTSTE8yeP2RSmsuFdXQZa5me736mUa5S7zB+GPLuxdsooW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519425"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645018"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:44 -0700
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
Subject: [PATCH v6 02/11] x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
Date:   Thu,  5 May 2022 18:40:26 -0700
Message-Id: <20220506014035.1173578-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506014035.1173578-1-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

