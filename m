Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF44DB6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353485AbiCPQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiCPQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:54:56 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A931341;
        Wed, 16 Mar 2022 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647449622; x=1678985622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=67HJ5xsUQCH77LSjNv9g0hLBWeBJ7D0jAoL2UnUtLbY=;
  b=RYXF41fW6Lv87cYDIdZS6gM/d4eBWGuBE/wt1/Oik+I0MJXv/VUrTExc
   xW8/n5y5hQuECkFGYHBAOSIgB3kcv6Hr302EzvGOY/WVAtt8PXLnqXO0P
   3qkVt5RI9Rq65csYsDEBAqdKnFX9B1TF441nrFp/dP45hHjK/t4ENHS2X
   iYsFmRZmvKa40m/j8Z3GJNJjHAHENyf/oZ71Gs/NRmWnDBV/kfAzJpGwt
   WgdHM8aJUq0GwFyYfpiIqDo5bYRSwGqplaUHzPqdnM/DfGDP9Z4O0cs33
   1uUSGVvDKB9Meo1VAXJkyO5V/PVyHBX4EDitc9E1xhNpV0hrCIxDqiHNl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317381330"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317381330"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513107709"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2022 09:53:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D8E3192; Wed, 16 Mar 2022 18:53:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] staging: fbtft: Consider type of init sequence values in fbtft_init_display()
Date:   Wed, 16 Mar 2022 18:53:51 +0200
Message-Id: <20220316165351.58107-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316165351.58107-1-andriy.shevchenko@linux.intel.com>
References: <20220316165351.58107-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
v2: no changes, just based on prerequisite
 drivers/staging/fbtft/fbtft-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 6dc77895a87c..3b182115bd6e 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1034,10 +1034,9 @@ int fbtft_init_display(struct fbtft_par *par)
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
2.35.1

