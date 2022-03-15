Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C94D9BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiCONOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbiCONOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:14:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D661BEA6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647349980; x=1678885980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2ZXiyrkgfMQGJXiIcEHYdmmm67CQ4j0HsfR1bK6GiY=;
  b=CYEeNRCBNJOCVGSBoHbYj77CV00V089zZhErqL1S7AJPeJNhTVVe1oq1
   RojnwG0eQzrjfsjD3/5ux56E+hp1xXXt+gz/PmxUxqziSJ5p1ataJ9UCF
   Zl/M4wgBCkapt0C6KviT4dTvVsDvqYMLQUVkgicriBznYtPGYc/jULA+L
   k3NBKRPig8FkwEuOI3i9koCcvQiilgktxdVx7SdAmMQuVo9w/XJXqKNrS
   WuiBCnGkJlqWEVXojXVFCmKpBHvamhPSr4cs35mtOeodPnre+IpJpbz5V
   4OjFPk7r0ma2PO62EaZXpC3lAjunx7DPoK+EPYhOyiEr9EIQIUzf9FgKn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253853055"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253853055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="556920081"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:56 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/5] mei: gsc: add runtime pm handlers
Date:   Tue, 15 Mar 2022 15:11:56 +0200
Message-Id: <20220315131157.3972238-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315131157.3972238-1-alexander.usyskin@intel.com>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
V5: Rebase
V6: Rebase
V7: add Greg KH Reviewed-by
V8: Rebase
V9: Rebase
V11: Rebase
---
 drivers/misc/mei/gsc-me.c | 67 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 58e39c00f150..32ea75f5e7aa 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -159,7 +159,72 @@ static int __maybe_unused mei_gsc_pm_resume(struct device *device)
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

