Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3558CA24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiHHOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiHHOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E62677
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659967683; x=1691503683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=leLck+dya6ABfLtLyxSoE4X46UoEgHFqOdsYIxvm5aQ=;
  b=RiU7BxLdJsnoap0EG2SgKl70gTexQrpyL4gyoudIErl8c/MK0H1SG5c3
   dsG/S4R5Ip8zEvzJQxLH5x0Wl328wSsyuC9MarTyqWHDBtLqMBijlaYWq
   w0wHSMylEZLoylmpUSr7Rue/PFRQLcGc4tfDWNg4z00TraGdb8ee7+kxr
   DeIjyBHbsr5Q3Z/vb3NHKjbYdVJnwS5G8grbH0OublgYOinADJ4Ns/np4
   HWA286dOnLhWjoXSpEjnuu9ojtPkBWEYNi0kmjl22CysS/ASqU48NWqnL
   1o+WZMit1SIgxucBBet4OvNUTyDD5+7LYRrE0/O+UxPhLpvw+vhgBSASC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291835492"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291835492"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="693771627"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2022 07:08:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADDAE1AA; Mon,  8 Aug 2022 17:08:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 1/1] mfd: syscon: Remove repetition of the regmap_get_val_endian()
Date:   Mon,  8 Aug 2022 17:08:11 +0300
Message-Id: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
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

Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
definitions from DT") regmap MMIO parses DT itsef, no need to
repeat this in the caller(s).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/syscon.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 651cc6f3fd3f..15b74dcb0744 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -66,14 +66,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		goto err_map;
 	}
 
-	/* Parse the device's DT node for an endianness specification */
-	if (of_property_read_bool(np, "big-endian"))
-		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
-	else if (of_property_read_bool(np, "little-endian"))
-		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
-	else if (of_property_read_bool(np, "native-endian"))
-		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
-
 	/*
 	 * search for reg-io-width property in DT. If it is not provided,
 	 * default to 4 bytes. regmap_init_mmio will return an error if values
-- 
2.35.1

