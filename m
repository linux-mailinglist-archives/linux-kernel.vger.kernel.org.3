Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353B57A8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiGSUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiGSUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:53:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4E61104;
        Tue, 19 Jul 2022 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263979; x=1689799979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HCbJLPfxlxI92iZKFv4/AkOuve50aUnNogOmoa9pIRI=;
  b=MOPXEW3efk1J96dFxnbmI6wdKKakLIdb95VVkc1BEaomoSw7CgOZcDJV
   jii27rWIIdMwfUkBvCx39Dk7kfGqVgvuAtCILexHFOvKGmiAoQl9nkWn7
   CwHPdRA3dxVQudZ5QEJV5m5QvliAkC+m3oYbiqlER7q2jVw9oZukV7Qgp
   xKq++w4LDmNQlP2b3MblpwDHrR9pIIgMEnDT5IyCnHzYczMBNlJMVSrh5
   b8ubjnRoEHRJSVn02Yg1aIWSXJ/Xsry9E/Gk6piNVo4yLzaAh5KGtm4B7
   APc+RXjeYqnfPqOg747+VoLcLVl6avzUxirBL1rLb1Dd39yT/vmXtHLo2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="348291047"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="348291047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:52:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="548063475"
Received: from kscamus-mobl1.amr.corp.intel.com (HELO localhost) ([10.255.6.221])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:52:57 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V16 2/6] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Tue, 19 Jul 2022 13:52:45 -0700
Message-Id: <20220719205249.566684-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220719205249.566684-1-ira.weiny@intel.com>
References: <20220719205249.566684-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Replace the magic value in pci_bus_crs_vendor_id() with
PCI_VENDOR_ID_PCI_SIG.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V6
	Simplify commit message
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..6280e780a48c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2312,7 +2312,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
 
 static bool pci_bus_crs_vendor_id(u32 l)
 {
-	return (l & 0xffff) == 0x0001;
+	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
 }
 
 static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
-- 
2.35.3

