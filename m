Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A15397EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbiEaUY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbiEaUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:24:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5F54692
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654028663; x=1685564663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMvhiu9RwOfwRcd3j1Wm5yOfM0CPUW06P8hcny6gDfY=;
  b=Xj0JBtwHTkGGs4Bqyh9LP8MXb5aBM8e6EesPcUjB9pVb3377Va/fzNsG
   vQiIbonXv0dV1Df5dwzzLsTWJyBjCM0cBngWYrYy0ETGbccqdsOP/x4IM
   GfApFFR7ej96QJQ5vmLM4oyp0ge4hTf3I4vp/JNom4kUUZmDmTw4kAN04
   kWtdSS6FfjGalKlzx3c8YdHGrEDxAP9TNblI6opy0dwZJLF19EzkumTw3
   ig1lPhgjruvrC4+IA7jYH8PubLgS+80UlTsW05ydyyfs0bte+Q8ncu8QU
   pVpTkdS2DPXuN/JHRy8zP2vb9Zo6vMH+Ve9GJEt8J21JIMv9nrlOuYJxR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361750611"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361750611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="605869275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2022 13:24:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D965F18B; Tue, 31 May 2022 23:24:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] syscon: Use %pa to format the variable of resource_size_t type
Date:   Tue, 31 May 2022 23:24:04 +0300
Message-Id: <20220531202404.70282-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of explicit casting, use %pa specifier to format
the variable of resource_size_t type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/syscon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 191fdb87c424..bdb2ce7ff03b 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -101,8 +101,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		}
 	}
 
-	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
-				       (u64)res.start);
+	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
-- 
2.35.1

