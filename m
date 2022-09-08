Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48CC5B1FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiIHN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIHN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:57:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9118F8268;
        Thu,  8 Sep 2022 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645420; x=1694181420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCRdi2DaTdmSASZqdRQlPRT8IpkU0kzoXNk1axIiyWg=;
  b=O3TFkUrUM2q7X7QD8nQarIUsvU/Ow+89Hlm23DtRL7PMNlatQrcbzieZ
   6dvNj7cl3x6KSZn7qOH5WKwpFCAK0dqFJxvHhPmp467ef9plB6WlOJBh1
   a7oKsxzqE7DD4EHEQVui1+4qHn3T5KLZj1+mhI9UxIXOQtPeNh4hcEIyI
   aXumS7sOKxdQ/6s4MuxfVLWkRMR/8DWMojvPZWxXLC4qG3rw2b+ybMiz6
   ydwqrfiSDWX7sg2rMqs7fSjX+4DlhgIIV7l7yn7YlnGRbl6z+Lna5yADe
   iQeQhAtXbxjQsnzJ+3PPXR4XzK+YeUSF2aneIzYgdYaGxAC7DhQokTqU2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297174057"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297174057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="614895494"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2022 06:56:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86C6D363; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 4/9] pwm: lpss: Include headers we are direct user of
Date:   Thu,  8 Sep 2022 16:56:53 +0300
Message-Id: <20220908135658.64463-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of integrity, include headers we are direct user of.

While at it, replace device.h with a forward declaration and add
missed struct pwm_lpss_boardinfo one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index c344921b2cab..839622964b2a 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -10,11 +10,15 @@
 #ifndef __PWM_LPSS_H
 #define __PWM_LPSS_H
 
-#include <linux/device.h>
 #include <linux/pwm.h>
+#include <linux/types.h>
 
 #define MAX_PWMS			4
 
+struct device;
+
+struct pwm_lpss_boardinfo;
+
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-- 
2.35.1

