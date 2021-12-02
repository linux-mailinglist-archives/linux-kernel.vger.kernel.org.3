Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABA465D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbhLBErQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:24208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355567AbhLBErD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:47:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640186"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640186"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788587"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:18 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/7] Documentation/auxiliary_bus: Clarify the release of devices from find device
Date:   Wed,  1 Dec 2021 20:43:04 -0800
Message-Id: <20211202044305.4006853-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

auxiliary_find_device() takes a proper get_device() reference on the
device before returning the matched device.

Users of this call should be informed that they need to properly release
this reference with put_device().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/base/auxiliary.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 7192f7d03a05..ab5315681a42 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -202,6 +202,8 @@ EXPORT_SYMBOL_GPL(__auxiliary_device_add);
  * This function returns a reference to a device that is 'found'
  * for later use, as determined by the @match callback.
  *
+ * The reference returned should be released with put_device().
+ *
  * The callback should return 0 if the device doesn't match and non-zero
  * if it does.  If the callback returns non-zero, this function will
  * return to the caller and not iterate over any more devices.
-- 
2.31.1

