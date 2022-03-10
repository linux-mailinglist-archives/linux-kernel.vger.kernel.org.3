Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A04D5037
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiCJRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245038AbiCJRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3976219D618
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932911; x=1678468911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fm86wwCN9yDs6lCc+3TkC/46REj4XEfoqrbmWncxwxA=;
  b=dibV38wsv++5If3Dt+fbxnIysBq+rRy3RL5aK5IK+E0bD46y2VwWvsoi
   KSrc141XWgC2zzkq+B/cw66NRTD+iYItOR+sPpzHjZjY2jSLi4tLY+nOD
   zr9+KX/jp3FfvU6i8f2Ko1mrUjeB5IW84eVs4Xta7vHnEIet6SEivKpIX
   bx5zQhPQKoEgidbHj+QrfDYn/dJFrw8mDzjwW6Vjwi0uCc+IkqjvOd4dj
   Larenb/8NTG2F6oc10/6eiEfwxuHrTu5BFF53kezK2lh7g1Zm1UpKgTgi
   mT/n5r0MmoqdqXXAq84ou1eUMAs8KnvL6Z39/APZAyst6ZV8bADOvgi+9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255260189"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255260189"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:50 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="781532458"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:50 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 38/45] memremap_pages: Reserve a PKS pkey for eventual use by PMEM
Date:   Thu, 10 Mar 2022 09:20:12 -0800
Message-Id: <20220310172019.850939-39-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes for V9
	Adjust for new key allocation
	From Dave Hansen
		use pkey
---
 include/linux/pks-keys.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index f7e82e462659..32075ac54964 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -61,7 +61,9 @@
 /* PKS_KEY_DEFAULT must be 0 */
 #define PKS_KEY_DEFAULT		0
 #define PKS_KEY_TEST		PKS_NEW_KEY(PKS_KEY_DEFAULT, CONFIG_PKS_TEST)
-#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_TEST, 1)
+#define PKS_KEY_PGMAP_PROTECTION \
+		PKS_NEW_KEY(PKS_KEY_TEST, CONFIG_DEVMAP_ACCESS_PROTECTION)
+#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_PGMAP_PROTECTION, 1)
 
 #ifdef CONFIG_PKS_TEST_ALL_KEYS
 #undef PKS_KEY_MAX
@@ -72,6 +74,8 @@
 #define PKS_KEY_DEFAULT_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
 #define PKS_KEY_TEST_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_TEST, AD, \
 							CONFIG_PKS_TEST)
+#define PKS_KEY_PGMAP_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_PGMAP_PROTECTION, \
+					AD, CONFIG_DEVMAP_ACCESS_PROTECTION)
 
 #define PKS_ALL_AD_MASK \
 	GENMASK(PKS_NUM_PKEYS * PKR_BITS_PER_PKEY, \
@@ -79,7 +83,8 @@
 
 #define PKS_INIT_VALUE ((PKS_ALL_AD & PKS_ALL_AD_MASK) | \
 			PKS_KEY_DEFAULT_INIT | \
-			PKS_KEY_TEST_INIT \
+			PKS_KEY_TEST_INIT | \
+			PKS_KEY_PGMAP_INIT \
 			)
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.35.1

