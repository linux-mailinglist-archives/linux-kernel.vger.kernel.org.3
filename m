Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C560353CDC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbiFCRHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiFCRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:07:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED114BC8D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654276032; x=1685812032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xpOexUYLWNWmda+V5P62AASnYjvdSRQGlPJg1HsZW8A=;
  b=FyKo7Wyw94FTPMup+wRFKwqOnn2BGUJitbT4k+yKR1Yi/y3AsNqFDrIp
   SdnxfgYfaipgzk68ntqj/TDRJoc9uAqGmy+nTBr7o8n9ak/9QrcCwTysx
   G/qCf0n7QDKJrvmosx5p2XztLG5ITLOpTiHaldc0u33nbqa8Bn9nrbtYi
   /m5GupRPwAvAe4IZ6r31R6ZMs4Kxifu2AAMvNWNUL5FtmJAulHDNknxhA
   X2c5cGVpxT5Qf9L2IsKZ9EiDJ2NOEZO3barPAezbhI6mvsy6WRnY4Cktb
   sftAIK2AcT2UdiGOLQCgZI3DcTsx4WfLgVFYdy1kcyvZXx0U3FZmE49cx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="256777443"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="256777443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="578109804"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2022 10:07:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D79C5F8; Fri,  3 Jun 2022 20:07:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
Date:   Fri,  3 Jun 2022 20:07:07 +0300
Message-Id: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
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

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/madera-pdata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/madera-pdata.h b/include/sound/madera-pdata.h
index e3060f48f108..58398d80c3de 100644
--- a/include/sound/madera-pdata.h
+++ b/include/sound/madera-pdata.h
@@ -9,7 +9,7 @@
 #ifndef MADERA_CODEC_PDATA_H
 #define MADERA_CODEC_PDATA_H
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #define MADERA_MAX_INPUT		6
 #define MADERA_MAX_MUXED_CHANNELS	4
-- 
2.35.1

