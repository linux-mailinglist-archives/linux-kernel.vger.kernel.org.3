Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16CB4DB6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357581AbiCPQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356913AbiCPQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:55:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78631932;
        Wed, 16 Mar 2022 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647449626; x=1678985626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+siQ0CJV8sIl5v5e72rj8Q6p8jCbZEt28U8U4nLaIAM=;
  b=HIfLVIf2VehsnzXvxHz6j9fzhLBsJ+xrOW/4C6Z8TWAxlwYDTaAj5tzH
   aoepSs3FjIbIMrsFcoPybEUJpEmnJ2r6AwOdWhsBAQ36sYvWh53Jpul67
   zieJlLFJdLX1dwSiWQEJdIoYrREDSYsGamkKjZDgr8+WnqkU45pmLVixW
   CaP8+h2j5RkpfyUQ0Sb1jyYyigdmQIBDGy5C9fqzz18aZ3+ERtEYDT79D
   vtkqai8GYpYLcxsZKayJuZL2Gq6Tn8mMcyOHswDI6A5R1xcem2py3lKzU
   NAM9hCyvdzx+mEZKuObAXfIhnfGMXHA9j6o5Z7/8aAtgiQ+XEwFtSQrvB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256614327"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256614327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="598790953"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2022 09:53:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59E14107; Wed, 16 Mar 2022 18:53:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] staging: fbtft: Constify buf parameter in fbtft_dbg_hex()
Date:   Wed, 16 Mar 2022 18:53:50 +0200
Message-Id: <20220316165351.58107-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

It's obvious that we don't and shouldn't modify buffer that
is about to be dumped. Constify parameter in fbtft_dbg_hex()
to make it clear.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch to fix a warning (Greg)
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 drivers/staging/fbtft/fbtft.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f2684d2d6851..6dc77895a87c 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -49,7 +49,7 @@ int fbtft_write_buf_dc(struct fbtft_par *par, void *buf, size_t len, int dc)
 EXPORT_SYMBOL(fbtft_write_buf_dc);
 
 void fbtft_dbg_hex(const struct device *dev, int groupsize,
-		   void *buf, size_t len, const char *fmt, ...)
+		   const void *buf, size_t len, const char *fmt, ...)
 {
 	va_list args;
 	static char textbuf[512];
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 55677efc0138..c3d8b2aae607 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -240,7 +240,7 @@ struct fbtft_par {
 int fbtft_write_buf_dc(struct fbtft_par *par, void *buf, size_t len, int dc);
 __printf(5, 6)
 void fbtft_dbg_hex(const struct device *dev, int groupsize,
-		   void *buf, size_t len, const char *fmt, ...);
+		   const void *buf, size_t len, const char *fmt, ...);
 struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 					struct device *dev,
 					struct fbtft_platform_data *pdata);
-- 
2.35.1

