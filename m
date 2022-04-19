Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A150763B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbiDSRLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbiDSRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B862C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388042; x=1681924042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qfkDg2QQgBb+Ae6HRu+P0c6D5UC51bq/BcKspZQJB24=;
  b=KgbzVTT0bTB2OyB7JuqCNsjqvaGVHmOJJpn5pBsiaEXKlxvW1HY3ynuS
   +fAy1dnSaEMF+irFIN1ttaIl2/L4abCuCMxncOxGlCSptjwmCw96CAwlr
   ndtRYOIkGQXHeMWX3S5b/YQKQqhtW+NOgrpcGtfKTmnWaRtDtOlDgINmC
   y0Iv8Yr0q7F+3gM9posVKSpR2n/EUtTbp4G8OkZ0TRPsfN0BmfMbtJQeR
   47PG5BdakJ/EtARBUsm4huJndl5NqoSVB8/+OrtXJP9MLhDcsLzRoJd1h
   2iWY9JJTrjr3XLvRugmp0rO1ryvubIx/wyVRce8YEtj9oNsjPGxTMIEqA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991937"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991937"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397335"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:21 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 36/44] devdax: Enable stray access protection
Date:   Tue, 19 Apr 2022 10:06:41 -0700
Message-Id: <20220419170649.1022246-37-ira.weiny@intel.com>
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
index 5494d745ced5..045854ba3855 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -451,6 +451,8 @@ int dev_dax_probe(struct dev_dax *dev_dax)
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

