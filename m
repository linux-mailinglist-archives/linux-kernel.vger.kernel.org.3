Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7594D1B61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiCHPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347757AbiCHPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:12:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18C38D9D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646752266; x=1678288266;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yHcVks0rZ5KbEhC3PatYkdzXGhiO+H+bN06X78E65lg=;
  b=FuDepTZxLNb6XLqIeJcBrZ7Yunx4ZVD+CdbG96/qKoRD1/y3PVI13F9/
   10QKF0jYUGG7SH7KWNuK3mamYo+akVfANUuTDSM0TVbD+jIgOwDQEGZuC
   8CWMqldt/P/8EcmcDPZ+GLV+T4fdNuvUonvMyN6s3WrTzh3le9pIgZHan
   XAs7nO+t7noDirxwuq/We/4CmK5fzdgZ2lDEzxnbNfBu0GnzsRcVGEy0S
   uwqPmSckZINmSopyjCZ8RyvOoCuHmv0uJDOZGMaKhY1B/rDR9kC1EEUsz
   5JCoo+xswO/Wz+/mH3XXC+PRIjev/5kYmSkcZoL2cA76DcVx+LxQotIR5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242144420"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242144420"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="632256871"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 07:11:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E07F411; Tue,  8 Mar 2022 17:11:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy()
Date:   Tue,  8 Mar 2022 17:11:19 +0200
Message-Id: <20220308151119.48412-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the reading of the onstack array is confusing since two
out of three members are of different types. Let it be more clear
by explicitly set the array size, so everybody will understand that
parameters are cast to the type of the array.

While at it, add a missed space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index a4503765a95d..86103cecdd3e 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -106,7 +106,7 @@ static int lcd2s_print(struct charlcd *lcd, int c)
 static int lcd2s_gotoxy(struct charlcd *lcd, unsigned int x, unsigned int y)
 {
 	struct lcd2s_data *lcd2s = lcd->drvdata;
-	u8 buf[] = { LCD2S_CMD_CUR_POS, y + 1, x + 1};
+	u8 buf[3] = { LCD2S_CMD_CUR_POS, y + 1, x + 1 };
 
 	lcd2s_i2c_master_send(lcd2s->i2c, buf, sizeof(buf));
 
-- 
2.34.1

