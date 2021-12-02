Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFE465D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355588AbhLBErK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:24220 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355576AbhLBEq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640183"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788579"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:17 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/7] Documentation/auxiliary_bus: Clarify __auxiliary_driver_register
Date:   Wed,  1 Dec 2021 20:43:02 -0800
Message-Id: <20211202044305.4006853-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

__auxiliary_driver_register is not intended to be called directly unless
a custom name is required.  Add documentation for this fact.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/base/auxiliary.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 70a8dbcd31b7..7192f7d03a05 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -225,6 +225,11 @@ EXPORT_SYMBOL_GPL(auxiliary_find_device);
  * @auxdrv: auxiliary_driver structure
  * @owner: owning module/driver
  * @modname: KBUILD_MODNAME for parent driver
+ *
+ * The expectation is that users will call the "auxiliary_driver_register"
+ * macro so that the caller's KBUILD_MODNAME is automatically inserted for the
+ * modname parameter.  Only if a user requires a custom name would this version
+ * be called directly.
  */
 int __auxiliary_driver_register(struct auxiliary_driver *auxdrv,
 				struct module *owner, const char *modname)
-- 
2.31.1

