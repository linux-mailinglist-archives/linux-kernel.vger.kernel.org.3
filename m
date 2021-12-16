Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65C6476808
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhLPCby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:31:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:62503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232958AbhLPCbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:31:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226245777"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="226245777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 18:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="614956041"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 18:31:47 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.221])
        by linux.intel.com (Postfix) with ESMTP id 908ED580514;
        Wed, 15 Dec 2021 18:31:47 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Gross <markgross@kernel.org>
Subject: [PATCH V4 2/6] driver core: auxiliary bus: Add driver data helpers
Date:   Wed, 15 Dec 2021 18:31:42 -0800
Message-Id: <20211216023146.2361174-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216023146.2361174-1-david.e.box@linux.intel.com>
References: <20211216023146.2361174-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds get/set driver data helpers for auxiliary devices.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Mark Gross <markgross@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V4
  - No changes
V3
  - No changes
V2
  - No changes

 include/linux/auxiliary_bus.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index fc51d45f106b..a8338d456e81 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -28,6 +28,16 @@ struct auxiliary_driver {
 	const struct auxiliary_device_id *id_table;
 };
 
+static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
+{
+	return dev_get_drvdata(&auxdev->dev);
+}
+
+static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev, void *data)
+{
+	dev_set_drvdata(&auxdev->dev, data);
+}
+
 static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
 {
 	return container_of(dev, struct auxiliary_device, dev);
-- 
2.25.1

