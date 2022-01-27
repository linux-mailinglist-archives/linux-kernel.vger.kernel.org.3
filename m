Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E473249E973
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiA0R4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:65458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244799AbiA0Rzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306131; x=1674842131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kpcQgxJ7fszxV7l5EYVD/+VKUecWGueqOZwFpwV6EQ=;
  b=ENM+2H1v+0DQtzBLi6mY3dwgFraZIgyi2HLHlaZ6JVbffvBH+Eg1Qv0D
   oUbdb86CFew6Pe63rYrxBAmjljsD8vdq4ZR2AEPCeAQLayikWcA0SUhNv
   xKjfuYcusVKkZ1MZ0hs/8J0idDXq9A+6xb/3p0DXSQNDSzmnPMtUZ9/nS
   VDitRuJIPWWtER+AfB1lYKm0b/8HPpBhmLk6iVuQruUM4ZyGr7MkJm6eY
   BsaRwgiKn02I0bWYk2IA6KYnQ09FhXQIU6Kgs+/aXJOXt9QVTPTspscVM
   3Q5RfTWrVmqSOa5LB6V7fnrAnU1HOwbhwJBKkq73qLyBc/KkyvIRsTT1b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899137"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796185"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 37/44] memremap_pages: Set PKS PKey in PTEs if PGMAP_PROTECTIONS is requested
Date:   Thu, 27 Jan 2022 09:54:58 -0800
Message-Id: <20220127175505.851391-38-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When the user requests protections the dev_pagemap mappings need to have
a PKEY set.

Define devmap_protection_adjust_pgprot() to add the PKey to the page
protections.  Call it when PGMAP_PROTECTIONS is requested when remapping
pages.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/memremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index a74d985a1908..d3e6f328a711 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -83,6 +83,14 @@ static void devmap_protection_enable(void)
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
@@ -99,6 +107,10 @@ EXPORT_SYMBOL_GPL(pgmap_protection_available);
 static void devmap_protection_enable(void) { }
 static void devmap_protection_disable(void) { }
 
+static pgprot_t devmap_protection_adjust_pgprot(pgprot_t prot)
+{
+	return prot;
+}
 #endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
 
 static void pgmap_array_delete(struct range *range)
@@ -353,6 +365,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		if (!pgmap_protection_available())
 			return ERR_PTR(-EINVAL);
 		devmap_protection_enable();
+		params.pgprot = devmap_protection_adjust_pgprot(params.pgprot);
 	}
 
 	switch (pgmap->type) {
-- 
2.31.1

