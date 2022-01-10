Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A662489EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiAJSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:17:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:29178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238848AbiAJSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641838626; x=1673374626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n2VU3KcLS5khnCS9/8zTHtmWmBczUON+c54f03UlPBw=;
  b=Ii9FVykU6s1pNH/x+8wQhwbOQPqWrBM+i9q+L2KLnXQwArib72EKq1oD
   6g7FSJtzBpM9uW7X5T00fKPDAAQ0YYlbYCq163YIqZ0DtKWmioAxHntnC
   Fkyrf0J2+w5ZMxZRm991C/7R+Zs2NU4xqtiqSnT9KFbB4HXPe9V1DatYz
   EeYDU79N4tGoopcmCE/IHZv4Zdj8LXwOSpQ8wks2FhwcA8veFRScoWRtr
   6nrJK08m+dzb+NC9gdt85k+24JtFO77xn1w0rkmaEJIplqqE7/vPxX058
   gPOtjIWUt7QBsOFLkJApx1GNNQa4AKuS8If2KmMvD3wR5/GCE2hGAWvnC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="329630526"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="329630526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="622759584"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 10:17:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9ED3120; Mon, 10 Jan 2022 20:17:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 1/5] math.h: Introduce data types for fractional numbers
Date:   Mon, 10 Jan 2022 20:17:07 +0200
Message-Id: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
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

