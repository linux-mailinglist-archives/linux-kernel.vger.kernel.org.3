Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0594D5059
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiCJRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiCJRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF67199E00
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932925; x=1678468925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWzVVihtrzaKMh9/jDZar+4C30ohWv7mGzMK4BGPHdc=;
  b=jZbY161V5QlXPjyR9dEiA7euU8cAWuWEWJWNIus07BKHNMx91XpLbb15
   JHSlsswUngqOf4Hms1QVwo4zmHp/RiQicjl9hXA3JoZIQJH+vrHkSMR9G
   RQhT+g4smETHBfHv1M/nKsb+/r+yghZgUsMG01p8KRdl8RQn1gcsNQZqa
   dhP2zgWrI58R+RqpoitnW205mFf9ivDUqN/aXTcniRIqKldC6bFSytRHv
   2EGKPXCb7dgYb7B47c5lfyOhcV5xHggOsWSZ673ty9l9/7EzXgkSC+vKE
   j9xpbrH5fFAGIuGlbGy9X6D2IdkJE0tBVJ64rrnRoMvTprJDjcYCdDNFj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252879600"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252879600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:22:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="815940932"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:22:04 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 45/45] devdax: Enable stray access protection
Date:   Thu, 10 Mar 2022 09:20:19 -0800
Message-Id: <20220310172019.850939-46-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device dax is primarily accessed through user space and kernel access is
controlled through the kmap interfaces.

Now that all valid kernel initiated access to dax devices have been
accounted for, turn on PGMAP_PKEYS_PROTECT for device dax.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Add Review tag

Changes for V8
	Rebase to 5.17-rc1
	Use pgmap_protection_available()
	s/PGMAP_PKEYS_PROTECT/PGMAP_PROTECTION/
---
 drivers/dax/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index d33a0613ed0c..cee375ef2cac 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -452,6 +452,8 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	if (dev_dax->align > PAGE_SIZE)
 		pgmap->vmemmap_shift =
 			order_base_2(dev_dax->align >> PAGE_SHIFT);
+	if (pgmap_protection_available())
+		pgmap->flags |= PGMAP_PROTECTION;
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.35.1

