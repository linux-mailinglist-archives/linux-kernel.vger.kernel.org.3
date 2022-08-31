Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009285A8814
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiHaV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiHaV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:27:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80C6F4C88
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981253; x=1693517253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4TD5fQr4fxUJXo4Iew85XPimvRvneII2apiUFF+zuDM=;
  b=QPBJEjsU3lEv1nltU2vDYugDMnyXVow3Ll+NcpUR+qBohJxVYaIb0j6u
   ks8xHrIyv/q6WIJtItRvgo+VrbmV51BZhtiJabJrjOEeAAhuaVBKpjdux
   ZiPC34PQKj9v0QIJQ0nrqCk9M31bzH9Yd+59xAq1xN7pZMBje1Xt1Fsp6
   Lh4ctTsfNkDhUWSFu9y9tkPoioZbBmx23bvDy5/J2v0jYOPMRh1sQm8Xy
   mysOpjGR/efTQFOPZJERhCXg6daUm1KljLmuuwBdD0CQ1ExhXo6XCpxKT
   flRsYQHhF4fsHRrY5M4+zgS/5P+qB1SOeMTEnEvyPWUTSJTEIAooSKhcT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357266135"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="357266135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="754557671"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2022 14:27:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B81F174; Thu,  1 Sep 2022 00:27:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/3] swab: Add array operations
Date:   Thu,  1 Sep 2022 00:27:42 +0300
Message-Id: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
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

