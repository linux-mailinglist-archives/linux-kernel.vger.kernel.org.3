Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C64A6009
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiBAP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:25040 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240286AbiBAP2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729285; x=1675265285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MbIG2Haqo+sMYAR0yJQlYgFVluGDFXvkSBl9zNZtNi0=;
  b=FjoFEoioeBvcULzIfid8aYQii/siehOyFSBI2UaKv6GQ9kciEOJlJua1
   pdU5R3neVUdhJebaHUPVIqqS40CGB4C7SN6GIUgzLiuZkknvvH5IsnfEn
   s3s1rMeh2W8ncmlAMiEGxKhX7RzrfHoENrrRif+2JMltEvTwSB6BREfuY
   g5b22fyhRQCXQd4g9R40o/uKBzfvHVhvZzX7Fy9LgF97VSBhA1NlJ1rAf
   nWm+TyeTuB2Pt/xhDpHY2DqETUg/Ogo+5KhusVnE8+GBx18TClkfMRIQk
   HgzKjTepByGZh1LpS8NSxRyp3/vqn3+3CxaL9haK1dMt9qwdv9qmcB/cX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246545712"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="246545712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619821086"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E8554411; Tue,  1 Feb 2022 17:28:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 3/4] gpiolib: Use short form of ternary operator in gpiod_get_index()
Date:   Tue,  1 Feb 2022 17:27:57 +0200
Message-Id: <20220201152758.40391-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of repeating first argument for true branch, use short
form of the ternary operator, i.e. ?:.

While at it, fix a typo in the comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e3702bc1b533..daedf8207173 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3931,19 +3931,18 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	 * If a connection label was passed use that, else attempt to use
 	 * the device name as label
 	 */
-	ret = gpiod_request(desc, con_id ? con_id : devname);
+	ret = gpiod_request(desc, con_id ?: devname);
 	if (ret) {
 		if (ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
 			/*
 			 * This happens when there are several consumers for
 			 * the same GPIO line: we just return here without
-			 * further initialization. It is a bit if a hack.
+			 * further initialization. It is a bit of a hack.
 			 * This is necessary to support fixed regulators.
 			 *
 			 * FIXME: Make this more sane and safe.
 			 */
-			dev_info(dev, "nonexclusive access to GPIO for %s\n",
-				 con_id ? con_id : devname);
+			dev_info(dev, "nonexclusive access to GPIO for %s\n", con_id ?: devname);
 			return desc;
 		} else {
 			return ERR_PTR(ret);
-- 
2.34.1

