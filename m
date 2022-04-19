Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21BE507624
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356117AbiDSRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355332AbiDSRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A438BEA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388035; x=1681924035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48r55Tzhghkqvh16jlfpDIA8KBy3fgH76RnR2W3gPbY=;
  b=h/Kz8sEE4stBXkFvIGnLmJ0X7y3X76SxHpp6xzgJn3XQGlJCL6ZWlP0u
   aqBaui2QNP8W3XVbdiQNTG/2lDqhw7eGpdOgHELvKNmKIMMXiHn0UxgC9
   Tz8ibEgv1WPAjNqzryv3aSIyuuu5PEsbYQbX/XBzhZt5E4qniZtvUrb0b
   LQ8tDnF2LuGSrsD1T0FYBCZFOTTq7MQnxMAWo41XX3a/0e5G9qOLN5hTj
   8KUuvb6n0K9LA5RZjcW1FIc/FP8mmjwriWsbF8JKjbZHStijp24VmjfZh
   0Se9w13mI2DFgBgFLIFnLdHUQfgvWcAStyl9sr0Ahs9F0pdRs6b//e5HJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420847"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420847"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625733419"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:14 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 29/44] memremap_pages: Reserve a PKS pkey for eventual use by PMEM
Date:   Tue, 19 Apr 2022 10:06:34 -0700
Message-Id: <20220419170649.1022246-30-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Reserve a pkey for use by the memmap facility and set the default
protections to Access Disabled.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	This patch now reserves a key before the PKS testing does.  So
	adjust for this being the only key at this point in the series.

Changes for V9
	Adjust for new key allocation
	From Dave Hansen
		use pkey
---
 include/linux/pks-keys.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index c914afecb2d3..4e63c8061e55 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -60,17 +60,22 @@
 
 /* PKS_KEY_DEFAULT must be 0 */
 #define PKS_KEY_DEFAULT		0
-#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_DEFAULT, 1)
+#define PKS_KEY_PGMAP_PROTECTION \
+		PKS_NEW_KEY(PKS_KEY_DEFAULT, CONFIG_DEVMAP_ACCESS_PROTECTION)
+#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_PGMAP_PROTECTION, 1)
 
 /* PKS_KEY_DEFAULT_INIT must be RW */
 #define PKS_KEY_DEFAULT_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
+#define PKS_KEY_PGMAP_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_PGMAP_PROTECTION, \
+					AD, CONFIG_DEVMAP_ACCESS_PROTECTION)
 
 #define PKS_ALL_AD_MASK \
 	GENMASK(PKS_NUM_PKEYS * PKR_BITS_PER_PKEY, \
 		PKS_KEY_MAX * PKR_BITS_PER_PKEY)
 
 #define PKS_INIT_VALUE ((PKS_ALL_AD & PKS_ALL_AD_MASK) | \
-			PKS_KEY_DEFAULT_INIT \
+			PKS_KEY_DEFAULT_INIT | \
+			PKS_KEY_PGMAP_INIT \
 			)
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.35.1

