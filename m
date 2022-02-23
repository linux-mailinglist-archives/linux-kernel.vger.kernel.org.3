Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCE4C17A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiBWPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiBWPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:47:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC07522EE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645631228; x=1677167228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mSZ1AwQC1ZfGoULXm+icAsVOCG3GXxEWDmHN8O+6HiE=;
  b=eDlIR+2/Me0suhKaeFdMz4q6mPNGiF1ONh0C0S7C9n0hDIv3op1nTIuN
   xi6zyfMXxvhMqcZRqgnmEyBwd9htbRDpqi8vydRy4RD/VPvsON18/6MHQ
   51u2tHS/HDdxAwx4bd4S+n7tslxXSvNgpBJgCnAYbHM3ac5qApTXlF2Ve
   sFn2CbNL6px799PoBnzjlWkph2R7erhtlHA/nUA9fsLfY1xWvKZE9gbAf
   AK2SZ48EhlfhKqnsiQ+lFYu4Y3XCjL8w0PhoWCVNP8ft33hufQD2PstOM
   JG1MjrRGVAmVDvtAp7cufiwDr2zLJcr8zCLUA/7eIaLgfMUsstHUs7N03
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312708675"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312708675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="548302368"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 07:47:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB8DC94; Wed, 23 Feb 2022 17:47:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
Date:   Wed, 23 Feb 2022 17:47:16 +0200
Message-Id: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

It seems that the lcd2s_redefine_char() has never been properly
tested. The buffer is filled by DEF_CUSTOM_CHAR command followed
by the character number (from 0 to 7), but immediately after that
these bytes are got rewritten by the decoded hex stream.

Fix the index to fill the buffer after the command and number.

Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
Cc: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 38ba08628ccb..ea9d75ad4f16 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -238,7 +238,7 @@ static int lcd2s_redefine_char(struct charlcd *lcd, char *esc)
 	if (buf[1] > 7)
 		return 1;
 
-	i = 0;
+	i = 2;
 	shift = 0;
 	value = 0;
 	while (*esc && i < LCD2S_CHARACTER_SIZE + 2) {
-- 
2.34.1

