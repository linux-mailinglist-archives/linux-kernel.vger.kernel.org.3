Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954B49866E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbiAXRUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:20:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:58855 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244321AbiAXRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044828; x=1674580828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gDQSUskimsF+BvPq9Sv63P2zlzyWFSa/xN8KMVRN7Z4=;
  b=fsqK1u14VR/IvEwTXzV+ZUYVeOIO9w5GqP9psy+4Gmlerk+3snU6GfUI
   IcQmKO04COQCzuNknVvnQ1UYYI7IruBm3HFyb+Qk4UQn9J14UzGPMV+Ho
   IZAzNWn+WN5/tOLGf0/qQlvW31Lx8CN1UqJkRhM3elnv1LCWJyEbvTZxH
   rLXJotScuYBDNLTPxHikaOwpocr3o6yh4W7YM7K4aCSpDKLcBbii0mPcN
   PIBDuQ9YvFfESF8E00XLns50IMtVeiLSbWlwy28XZR6gSc2cxN4osIby+
   cabA2IA65x104JpkCcSEf1OhJyuY0i2cFzptLDwtmA2UOK0m76ASVvtAn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246316985"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246316985"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617320047"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 09:20:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97045178; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 1/6] math.h: Introduce data types for fractional numbers
Date:   Mon, 24 Jan 2022 19:20:27 +0200
Message-Id: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a macro to produce data types like

	struct TYPE_fract {
		__TYPE numerator;
		__TYPE denominator;
	};

to be used in the code wherever it's needed.

In the following changes convert some users to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

May be pulled via IIO tree.

v3: no changes
v2: no changes

 include/linux/math.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 53674a327e39..439b8f0b9ebd 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MATH_H
 #define _LINUX_MATH_H
 
+#include <linux/types.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
 
@@ -106,6 +107,17 @@
 }							\
 )
 
+#define __STRUCT_FRACT(type)				\
+struct type##_fract {					\
+	__##type numerator;				\
+	__##type denominator;				\
+};
+__STRUCT_FRACT(s16)
+__STRUCT_FRACT(u16)
+__STRUCT_FRACT(s32)
+__STRUCT_FRACT(u32)
+#undef __STRUCT_FRACT
+
 /*
  * Multiplies an integer by a fraction, while avoiding unnecessary
  * overflow or loss of precision.
-- 
2.34.1

