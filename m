Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A300349CB72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiAZNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:53:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:33269 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241675AbiAZNxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643205225; x=1674741225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bMBLo3juLdl1DLRTER+VXh+0HaGKi5neF1b3QBBd5Uw=;
  b=X3DKg1UckL+ci7aQkLecA2tfQXkQMy8Dk4N3oxghZA6+vtpQQ3mg87BB
   cImUn4N8cuHnLvawFNOKUswxob+Lj7DAYItkIdLEZJ4F5PQyqlUZxgvue
   LcSdJhD20GDLCcsXbJ+ujw9kKNpRc5X5Z95wBdRGeC/EyzPgCLqINdKHm
   MmLR5nys/2hgG4EsBduwxlYljaZAEhZamGjCnrTx7kufcQhtvVOVf8r0K
   2dkD1EuZa03NiBfTs/JmqFhGKxjQhPSV3z8SBeM7czVokfm8Wa5wPqvQd
   eMeEFCigdDQDK//1yUHfmkNXc/IPvVWaKVVslzf+SRkVWKVPu8IgMerK1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244150361"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244150361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="769377043"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2022 05:53:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A6F82167; Wed, 26 Jan 2022 15:53:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 1/4] math.h: Introduce data types for fractional numbers
Date:   Wed, 26 Jan 2022 15:53:50 +0200
Message-Id: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
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

v4: no changes
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

