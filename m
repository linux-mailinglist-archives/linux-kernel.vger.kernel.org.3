Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E85AF541
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIFUDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIFUCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:02:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4165B6;
        Tue,  6 Sep 2022 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494308; x=1694030308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhatPtkdB5nt/+6uaBTUEZJ3XFSsa5xrXYQXGVisJug=;
  b=iF3j8kuwXnkQRb8uctvisYyE72av8DloyBjEkRuimGWA106iBX2yKyQ7
   XH22QUgWz0CA7PCK6loN+ZMuxjhDbSVaPnq0C5WpQjo9/ELsOrE//UXJa
   ErIxK8RtfHr5X5iClaFhy6gceqTS8Quw7jbtG0AsjoMwc8XsSyXIpQ//s
   01TaclyIQqPUofx6cH3WYQtQ6wVrRHQL0H9DspkQG06qrXaB68SUCcR5I
   xK9e3NEZjBrDTyQyD9t1VeGKC2epoRW/WZcrLKlVJXC85T+yyTQbNl+Po
   K4hAXHp+i1P2bP+ORrEZ+wPj8g44yfZA0Fy6+O30wJslWIDor4rdt6IN0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297475675"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297475675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591398908"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 12:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 440F05E4; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 8/9] pwm: lpss: Add a comment to the bypass field
Date:   Tue,  6 Sep 2022 22:57:34 +0300
Message-Id: <20220906195735.87361-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to the bypass field based on the commit b997e3edca4f
("pwm: lpss: Set enable-bit before waiting for update-bit
to go low").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 832cb86996d7..35e570067fc6 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -29,6 +29,11 @@ struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
 	unsigned long base_unit_bits;
+	/*
+	 * Some versions of the IP may stuck in the state machine if enable
+	 * bit is not set, and hence update bit will show busy status till
+	 * the reset. For the rest it may be otherwise.
+	 */
 	bool bypass;
 	/*
 	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
-- 
2.35.1

