Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56CE4821E2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhLaDjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:39:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:50282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242613AbhLaDjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640921980; x=1672457980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zKFqxvpkXMfH8iCX8G0z9vQbSfMlLk2XMC3zy0U5Xc=;
  b=mOsSqJD9eyFIU4Vyl3SnmMKSFwI4NcPlIU14eJVJ9cNHv8dKluLtdbAu
   7NN7NW2oq0SFckiYD+2xRkzJQOe/6kdXtzyONr3xx7n+BbATV6OxKhttA
   8zKGytYzo9aNIcHwJ7gA5vWHc4VhBdmoXoa0JjYKQ3ansQt8TT4OILgpX
   /1jmc5fUSW5/f6I/bwnYyPhGjnv1eyKaDIZD7A93kLWkpDyHFsKimXSyh
   K5rixt5c8Qg1vASwmRURPdz/+sy3vTOp8OomnI6DT3rFx4k1ca8Iwg5zl
   MvmkOSVEFWXVaKfAGrhcWjVVOz7b2jmfmX8+t9ebQZSRWjO3GrsfYjjND
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328100648"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="328100648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666718311"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 19:39:39 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kay Sievers <kay.sievers@novell.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] driver core: Move driver_sysfs_remove() after driver_sysfs_add()
Date:   Fri, 31 Dec 2021 11:39:00 +0800
Message-Id: <20211231033901.2168664-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231033901.2168664-1-baolu.lu@linux.intel.com>
References: <20211231033901.2168664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver_sysfs_remove() should be called after driver_sysfs_add() in
really_probe(). The out-of-order driver_sysfs_remove() tries to remove
some nonexistent nodes under the device and driver sysfs nodes. This is
allowed, hence this change doesn't fix any problem, just a cleanup.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/base/dd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..f6fac016b811 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -577,14 +577,14 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (dev->bus->dma_configure) {
 		ret = dev->bus->dma_configure(dev);
 		if (ret)
-			goto probe_failed;
+			goto sysfs_failed;
 	}
 
 	ret = driver_sysfs_add(dev);
 	if (ret) {
 		pr_err("%s: driver_sysfs_add(%s) failed\n",
 		       __func__, dev_name(dev));
-		goto probe_failed;
+		goto sysfs_failed;
 	}
 
 	if (dev->pm_domain && dev->pm_domain->activate) {
@@ -657,6 +657,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	else if (drv->remove)
 		drv->remove(dev);
 probe_failed:
+	driver_sysfs_remove(dev);
+sysfs_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
@@ -666,7 +668,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
-	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
-- 
2.25.1

