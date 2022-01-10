Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28C48A02B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiAJTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:31:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:21940 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243510AbiAJTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641843061; x=1673379061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RxYOq7hNnHUydTJret/bzJJ7FKiRggRskn0+xuXTnOE=;
  b=TBkZKP2xzBxML5bc5guYljwagQXDdA7nsuC0W5R6gLcD/huvw7gKE1KE
   rcwyBR35zogUF+PUnbAJwmkiDtLF0uA6sRLNqN8PI63UNYVY1i79HTtJC
   mP0ZzEABNqOBqheu5n2Q2bw+X+m1b11esr0OhpDT0/NAidt3MA0DgkZfB
   rqXU57TLJQpdPSFpcjZEcDx5pvDWWJpzt4wsGZz+Hef5Ez9uuj36oCO1v
   J34uu+PJAz71O0JdWdLWUQI6vJOUCthqqcptcBSu2Xaxh6cRk+2IIFT4z
   7oTfxexsHOdZJY7wsNbvlChMnTxre2xR9yDewOrwvdSHbXEkzWkYRIOrA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242118803"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242118803"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 11:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="592450674"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2022 11:30:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17955120; Mon, 10 Jan 2022 21:31:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/5] math.h: Introduce data types for fractional numbers
Date:   Mon, 10 Jan 2022 21:31:00 +0200
Message-Id: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
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

