Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38B4540430
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiFGQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344320AbiFGQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:57:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EA27FE3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654621062; x=1686157062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByfqHSUyr5zD+LfMcI0HbBfFVGYb2wsqtAn5SPC4XIA=;
  b=ST4ZrW9kC14ElDA8bJ/yKxuU3LHZxz8YsKNUs1qAV3Gs3VvNimqyNEtV
   o7Ie87FQ2iU/BXVDtk25lcbUPYxVEfZtDle+jsGV+T4cEUdjko5uznxBz
   imaipei+FlR2zVKlZrOTds8ucmpQ7v6V2yFsxoAwHW/psbeIskfMC/nYN
   hAJWctwaJWV/9/MBa+qcFsfpn8WGPRNM/hO+NfB6iwtThtystsKSLh0/X
   D0H8ITQE2oOb5BmiPZJVEwDEeFuXctL4VtyT1xeiGsENs3ofrwNCZf+a8
   Y/kE15lUb4Db91T0AKzUcGO/azxfSJx02pOoXPuS5+rc3c9LyJOodHrPq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="259613232"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="259613232"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="565504289"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2022 09:49:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4D65109; Tue,  7 Jun 2022 19:49:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] nvdimm/namespace: drop nested variable in create_namespace_pmem()
Date:   Tue,  7 Jun 2022 19:49:37 +0300
Message-Id: <20220607164937.33967-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel build bot reported:

  namespace_devs.c:1991:10: warning: Local variable 'uuid' shadows outer variable [shadowVariable]

Refactor create_namespace_pmem() by dropping a nested version of
the same variable.

Fixes: d1c6e08e7503 ("libnvdimm/labels: Add uuid helpers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvdimm/namespace_devs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 0f863fda56e6..dfade66bab73 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1704,8 +1704,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	res->flags = IORESOURCE_MEM;
 
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
-		uuid_t uuid;
-
 		nsl_get_uuid(ndd, nd_label, &uuid);
 		if (has_uuid_at_pos(nd_region, &uuid, cookie, i))
 			continue;
-- 
2.35.1

