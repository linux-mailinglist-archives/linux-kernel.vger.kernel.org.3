Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B004B4CDEBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiCDUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiCDUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4D28672B;
        Fri,  4 Mar 2022 11:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646423770; x=1677959770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=prSCg+P2w+6rp7GYMZxEjueC6DVV7pXYvo+J6n3NE1o=;
  b=nqcHg7fGLSY0xU3LY+NObE5mSzK23pAD2CGM4Qa+niRKLaR/Acn3B8eH
   QILVK8fJQ1dB1pb5hQEMO0zsnaoNg1je14TmD2tVIa/ArZG2NiAXGyMpO
   aSTNsMUxviyokjDgbFpQOWOBZ3SUCgVUtR/HGrc8iGfhntQtDXUJhdzey
   zNq6UjmnCw3vJxPwA1kJ1YCyQdG6P4lGRPThAxnHPm+fNT2Hi1+HUDWQ1
   BRgzTZKggryXKbXQTGLNYCLKxiKP30uv+/QECiNzPz5tMnOLCk729mKcq
   NEvwWqWUK5XvtqpmGc/nNykSK3XjJFJoH/RqzA02vOkyOadqL9SR+K6z+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340477231"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="340477231"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="511959167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2022 11:33:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AD81A7; Fri,  4 Mar 2022 21:34:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence values in fbtft_init_display()
Date:   Fri,  4 Mar 2022 21:34:14 +0200
Message-Id: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the fbtft_init_display() the init sequence is printed for
the debug purposes. Unfortunately the current code doesn't take
into account that values in the buffer are of the s16 type.

Consider that and replace the printing code with fbtft_par_dbg_hex()
call.

Fixes: b888897014a9 ("staging/fbtft: Remove all strcpy() uses")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4a35347b3020..b28a059ad3b4 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1035,10 +1035,9 @@ int fbtft_init_display(struct fbtft_par *par)
 			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++)
 				;
 
-			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: write(0x%02X) %*ph\n",
-				      par->init_sequence[i], j,
-				      &par->init_sequence[i + 1]);
+			fbtft_par_dbg_hex(DEBUG_INIT_DISPLAY, par, par->info->device,
+					  s16, &par->init_sequence[i + 1], j,
+					  "init: write(0x%02X)", par->init_sequence[i]);
 
 			/* Write */
 			j = 0;
-- 
2.34.1

