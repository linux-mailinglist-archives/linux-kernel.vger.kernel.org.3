Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516504821E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbhLaDjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:39:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:50282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242653AbhLaDjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640921982; x=1672457982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+R9IOySMQZos/tW9DfOOxxoxY5gKjgTx54+jATM0/cQ=;
  b=MiQEGEprVG6t797cu4gRvfRvgL7buDq/54rF1umlY1zuHkWY2GKiPInQ
   0LjsSHI488dJyRUXrXJqfeO4jLtgVs+Yi7gk7/X1e1wUjqlmp2mtTpBOj
   cX3t8cXKmsE+JCFIntTW/yljFnlhvHXR1szAaDOhDcvBpsQ0fkKh2lfTh
   x4m4pLO3wXGLkwJyFlZi409xyRxPHNKnXN1Vri7m2cVkj6CXMixDQ4xct
   aB/mJkJYpl90RYIX9XHGZCnZjbK7wRPXFisdfcrufHesmO3N309u4UVwP
   KRLFKDeRw3mtIMAcuAupDTPodkgchWFwJdm6DQVrAAVM/u3RU0sLWRpJd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328100653"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="328100653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666718318"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 19:39:41 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kay Sievers <kay.sievers@novell.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] driver core: Make bus notifiers in right order in really_probe()
Date:   Fri, 31 Dec 2021 11:39:01 +0800
Message-Id: <20211231033901.2168664-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231033901.2168664-1-baolu.lu@linux.intel.com>
References: <20211231033901.2168664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a driver cannot be bound to a device, the correct bus notifier order
should be:

 - BUS_NOTIFY_BIND_DRIVER: driver is about to be bound
 - BUS_NOTIFY_DRIVER_NOT_BOUND: driver failed to be bound

or no notifier if the failure happens before the actual binding.

The really_probe() notifies a BUS_NOTIFY_DRIVER_NOT_BOUND event without
a BUS_NOTIFY_BIND_DRIVER if .dma_configure() returns failure. This
change makes the notifiers in order.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6fac016b811..9eaaff2f556c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -577,7 +577,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (dev->bus->dma_configure) {
 		ret = dev->bus->dma_configure(dev);
 		if (ret)
-			goto sysfs_failed;
+			goto pinctrl_bind_failed;
 	}
 
 	ret = driver_sysfs_add(dev);
-- 
2.25.1

