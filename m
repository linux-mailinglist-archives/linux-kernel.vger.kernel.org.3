Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A277B5A80AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHaOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:53:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27652C9EA2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957638; x=1693493638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0+EbL1RhBfmVcoK0Ut4bdChM3MUYimh+4W3tL0nGLCY=;
  b=fY/YNL6BG1mIOzj51muxLeArec6Mpf5bKcZzVpTfgrRaBSxNc5LTT1rq
   fcg2BZuE2NHPIkqD7TgE6ATS3LiFRBmgrFJTdLDP9CEmKCVE0a2WBC2qf
   Io6tJrF2PSnK6EdhNnNbV4tBqLxgkZAfOC2VmDHNGmYU5T+33yWHbE991
   XCzC2QqVQV5pTuPy3/MEf2e3QUXxGbTEv9Z/m7ySG95X9nIsj/5+NcBw0
   MZlKgfuVsn4sMR5H7QsDK5A1JWaCiF4yfj1TV9Ze4qqfz1yDfpruhjS2L
   ZTiGFE+fgXlqV6wsYalt8STD2YX2Y3LPs1KS+AFLBF/VvNvCzDLqbyLW2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357181894"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="357181894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="608203872"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2022 07:53:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB99B174; Wed, 31 Aug 2022 17:54:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/3] swab: Add array operations
Date:   Wed, 31 Aug 2022 17:54:05 +0300
Message-Id: <20220831145407.78166-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, some simple array operations to swab.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/swab.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/swab.h b/include/linux/swab.h
index bcff5149861a..9b804dbb0d79 100644
--- a/include/linux/swab.h
+++ b/include/linux/swab.h
@@ -20,4 +20,29 @@
 # define swab64s __swab64s
 # define swahw32s __swahw32s
 # define swahb32s __swahb32s
+
+static inline void swab16_array(u16 *buf, unsigned int words)
+{
+	while (words--) {
+		swab16s(buf);
+		buf++;
+	}
+}
+
+static inline void swab32_array(u32 *buf, unsigned int words)
+{
+	while (words--) {
+		swab32s(buf);
+		buf++;
+	}
+}
+
+static inline void swab64_array(u64 *buf, unsigned int words)
+{
+	while (words--) {
+		swab64s(buf);
+		buf++;
+	}
+}
+
 #endif /* _LINUX_SWAB_H */
-- 
2.35.1

