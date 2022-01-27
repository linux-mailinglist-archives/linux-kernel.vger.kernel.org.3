Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B449E0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiA0LVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:21:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:52776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240201AbiA0LVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643282508; x=1674818508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLKsXPAoEZizmeUJjRmRi4B9UCYAOzaKJRGepYNsFXg=;
  b=fS69lraXsIYuKkQZEJ+c/S9jS5Kx8tdCMJTtlXWXan4l4ahp2ScKREeJ
   aQnDbdDHMbfEvv3XEunj9kC5vq5zJsPuOvawHVLY87JUou3IXAcMw1gv2
   pDfYKWzrXHDNUBhh1/Tism3us9KwMMCrMFrAQ5Rv/Og54B6BUwAo7etvF
   G0aLZlgbjrEFIJ9IgZh1Xizohd70L/krmcIL6CNbx7laAB272WcGtSD5V
   GFW0RWrSiwZkSsO5sgROLC0nGPJrkz4tCyUydMzpKPDZXfIbS5JcsE5a9
   RvYHnOUSYhqGImletA/iWihy/jTT3P+HrMLTRBsLO9IjAR7F6G63Sf+zZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="247042439"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="247042439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:21:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="480253268"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:21:45 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] mei: gsc: add runtime pm handlers
Date:   Thu, 27 Jan 2022 13:21:02 +0200
Message-Id: <20220127112103.2336871-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127112103.2336871-1-alexander.usyskin@intel.com>
References: <20220127112103.2336871-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

Implement runtime handlers for mei-gsc, to track
idle state of the device properly.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
V4: drop debug prints
---
 drivers/misc/mei/gsc-me.c | 67 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index cf427f6fdec9..dac482ddab51 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -152,7 +152,72 @@ static int __maybe_unused mei_gsc_pm_resume(struct device *device)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend, mei_gsc_pm_resume);
+static int __maybe_unused mei_gsc_pm_runtime_idle(struct device *device)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+
+	if (!dev)
+		return -ENODEV;
+	if (mei_write_is_idle(dev))
+		pm_runtime_autosuspend(device);
+
+	return -EBUSY;
+}
+
+static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	struct mei_me_hw *hw;
+	int ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&dev->device_lock);
+
+	if (mei_write_is_idle(dev)) {
+		hw = to_me_hw(dev);
+		hw->pg_state = MEI_PG_ON;
+		ret = 0;
+	} else {
+		ret = -EAGAIN;
+	}
+
+	mutex_unlock(&dev->device_lock);
+
+	return ret;
+}
+
+static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	struct mei_me_hw *hw;
+	irqreturn_t irq_ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&dev->device_lock);
+
+	hw = to_me_hw(dev);
+	hw->pg_state = MEI_PG_OFF;
+
+	mutex_unlock(&dev->device_lock);
+
+	irq_ret = mei_me_irq_thread_handler(1, dev);
+	if (irq_ret != IRQ_HANDLED)
+		dev_err(dev->dev, "thread handler fail %d\n", irq_ret);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mei_gsc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mei_gsc_pm_suspend,
+				mei_gsc_pm_resume)
+	SET_RUNTIME_PM_OPS(mei_gsc_pm_runtime_suspend,
+			   mei_gsc_pm_runtime_resume,
+			   mei_gsc_pm_runtime_idle)
+};
 
 static const struct auxiliary_device_id mei_gsc_id_table[] = {
 	{
-- 
2.32.0

