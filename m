Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280C507638
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356050AbiDSRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355630AbiDSRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF920C53
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388035; x=1681924035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5Ntw+w2U3i3omwgQwquKdMbUX1Ci6rQ18tEbpDLUm8=;
  b=VynZDKZWKTulXHtL7z3D1oiKls6GJCaVWAkVxFnRKvwLNqVNd/KPIZKH
   AMH7gqBQtn+U44WiPXfSn/lSw2Y1ap35LrSTzuj3dml+eau+VCHSCHaHl
   UHSTT9NiIGjVz73dXQsCZISPtc7NSOn8gzh3xBnr1/J3ZduhuipZuq4Xt
   MZzLb+KbpaN5uJiZQ5iocpDCBcVbxxwDeUMoPsyELhQ5QR+a0nU/vSrRA
   nciF+cwkDL4s8tw6wSxlbe0pQZ+quhyf9etha9xoxxLFUN4xO9tWFiTiE
   KhiUizCKQAFzdALmcoEeRnBsgRPemmCQl1mnPVvMb7DJ1WfpZkxyiZjdX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991888"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397291"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:15 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 30/44] memremap_pages: Set PKS pkey in PTEs if requested
Date:   Tue, 19 Apr 2022 10:06:35 -0700
Message-Id: <20220419170649.1022246-31-ira.weiny@intel.com>
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
index 4dfb3025cee3..215ab9c51917 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -81,6 +81,14 @@ static void devmap_protection_enable(void)
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
@@ -91,6 +99,10 @@ static void devmap_protection_disable(void)
 static void devmap_protection_enable(void) { }
 static void devmap_protection_disable(void) { }
 
+static pgprot_t devmap_protection_adjust_pgprot(pgprot_t prot)
+{
+	return prot;
+}
 #endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
 
 static void pgmap_array_delete(struct range *range)
@@ -333,6 +345,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		if (!pgmap_protection_available())
 			return ERR_PTR(-EINVAL);
 		devmap_protection_enable();
+		params.pgprot = devmap_protection_adjust_pgprot(params.pgprot);
 	}
 
 	switch (pgmap->type) {
-- 
2.35.1

