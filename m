Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAAA4D5039
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiCJRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbiCJRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25619D623
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932913; x=1678468913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABzxJ4X/LqsCox3ux29jcZ+e1wu+SuSOC6C/nuOr2N4=;
  b=alZi0IzhZZqLAaksMBo4jbrJqH+hWBQEIeV1PN0YKAwnHjHkyoCwMK0l
   M1zhEN8xm6mpIwiaWC7uJ2Ji7VXtYEESQggdiRUj54h9/Y1NUCcvyaYnJ
   /c2rLg98s+TLXOgbpM0RV331abqQ3hG028yQobsb0gZJBDqkSWtFJHYUc
   dehYe18cJfvfJ4JnGjwG8FE5Vdu/L0Nwg1mCqlIylmCEe8Yf6kGDsnrG/
   pfh0ZhULoq+WyZ/JqQpoiv3j23+3d2HCtg1VqoCTFFHustX44gI4noVuJ
   0sp0dLvXrYuFWHXUTbgHnQgGkdFamKrzS87vS4d++4slynI9BPbeSSL2G
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255049381"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255049381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688732615"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:52 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 39/45] memremap_pages: Set PKS pkey in PTEs if requested
Date:   Thu, 10 Mar 2022 09:20:13 -0800
Message-Id: <20220310172019.850939-40-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When a devmap caller requests protections, the dev_pagemap PTE's need to
have a PKEY set.

When PGMAP_PROTECTIONS is requested add the pkey to the page
protections.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dave Hansen
		use pkey
---
 mm/memremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 38d321cc59c2..cefdf541bcc1 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -82,6 +82,14 @@ static void devmap_protection_enable(void)
 	static_branch_inc(&dev_pgmap_protection_static_key);
 }
 
+static pgprot_t devmap_protection_adjust_pgprot(pgprot_t prot)
+{
+	pgprotval_t val;
+
+	val = pgprot_val(prot);
+	return __pgprot(val | _PAGE_PKEY(PKS_KEY_PGMAP_PROTECTION));
+}
+
 static void devmap_protection_disable(void)
 {
 	static_branch_dec(&dev_pgmap_protection_static_key);
@@ -92,6 +100,10 @@ static void devmap_protection_disable(void)
 static void devmap_protection_enable(void) { }
 static void devmap_protection_disable(void) { }
 
+static pgprot_t devmap_protection_adjust_pgprot(pgprot_t prot)
+{
+	return prot;
+}
 #endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
 
 static void pgmap_array_delete(struct range *range)
@@ -346,6 +358,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		if (!pgmap_protection_available())
 			return ERR_PTR(-EINVAL);
 		devmap_protection_enable();
+		params.pgprot = devmap_protection_adjust_pgprot(params.pgprot);
 	}
 
 	switch (pgmap->type) {
-- 
2.35.1

