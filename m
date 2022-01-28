Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8C49FC17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiA1Osq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349471AbiA1Oso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:48:44 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC13C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:48:43 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q127so9376090ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HCpaiU1xR9hpEUEboSIlwhSyVbNQdTFeA1BZG+767g=;
        b=DG1UGMscrDekHrN6HJL8rOrhmtcGw+77JZhsDbceVqysuInS4xGnZX1F6cqYqVMbqM
         tvJ/b7LQuPOz1xkKcnjAn0BWjE02ZX9Mc9dwYNypywFv59dEZfOEUrY6EJQnGp85bqoH
         pQeDwngPv4McGGwbts90IdWw1IQBIbBSDQ0MQq9v4NwdwQzw2hBrwcO1kMB9zcQYfHm9
         7pQ1kdMYqtCn7htpcIVKhIDLAHXvznYSk578nAXFU/l2rOzQfLGD2yJulPHWPP6tkpX4
         VVQEwqKoJ+zVUZ7DDECQ6P4bRkkUs4Q84CKPa5VHU5cIO3FDq52Ha3xfPnToaDYQFm+b
         abyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HCpaiU1xR9hpEUEboSIlwhSyVbNQdTFeA1BZG+767g=;
        b=xjj78cr3nO7O6QR3LYKPAv5u/igXOL/iEGLyN6NpQ5mUNKqGft2t2ZLjE0wodjbMIb
         vsR1kFIsXGYa5bJ/p49nLKbpoHLN47C5Wbjnn5AGY0w5x7Wv4vxPPwRyS3wBBscx24+J
         eBX9cNWkUEX8HOgF31rBwXSNHHOWxKhdMol6lRJFc5HFu8Uss/olleElUnLnzJQztiv8
         sTJevzsQT03PpOAJZP3w3Mc50/lUY+PdpLGrBsgyP84GzeDeU6UVS0dCmmkmA3O2gG0/
         H0lAJFlI+x8g4rAOyHfrVXg5C/3jX0s4YiSUVrwdj72xHgv8R66T8jJ7+CEXn16ykBpW
         2Fvg==
X-Gm-Message-State: AOAM531SsTF8i5b+RsfHYwPBlyRRKVKw2HBhXo+No2b+ENcY2SzFJkLV
        mRm3EOQyZjF03LCQVqvod3tX54vxltMh7cT4
X-Google-Smtp-Source: ABdhPJyd2faHom9r1M2zWF0vHMP9Sj4gFAsvDh8KgkCBu4S4mWHFuIsjiansIpg8rbVi5VkK+RrV8g==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr6161357lji.166.1643381322359;
        Fri, 28 Jan 2022 06:48:42 -0800 (PST)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id q7sm1706520lfp.63.2022.01.28.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:48:41 -0800 (PST)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, adriy.shevchenko@linux.intel.com
Cc:     mika.westerberg@linux.intel.com, hdegoede@redhat.com,
        wsa@kernel.org, rrangel@chromium.org, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com, thomas.lendacky@amd.com,
        alexander.deucher@amd.com, Nimesh.Easow@amd.com,
        mario.limonciello@amd.com, jsd@semihalf.com
Subject: [PATCH v2 1/2] i2c: designware: Add missing locks
Date:   Fri, 28 Jan 2022 15:48:10 +0100
Message-Id: <20220128144811.783279-2-jsd@semihalf.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220128144811.783279-1-jsd@semihalf.com>
References: <20220120001621.705352-2-jsd@semihalf.com>
 <20220128144811.783279-1-jsd@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All accesses to controller's registers should be protected on
probe, disable and xfer paths. This is needed for i2c bus controllers
that are shared with but not controller by kernel.

Signed-off-by: Jan Dabros <jsd@semihalf.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 12 ++++++++++++
 drivers/i2c/busses/i2c-designware-master.c |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index bf2a4920638a..9f8574320eb2 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -578,7 +578,12 @@ int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec.
 	 */
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
+	i2c_dw_release_lock(dev);
 	if (ret)
 		return ret;
 
@@ -607,6 +612,11 @@ u32 i2c_dw_func(struct i2c_adapter *adap)
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
 	u32 dummy;
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return;
 
 	/* Disable controller */
 	__i2c_dw_disable(dev);
@@ -614,6 +624,8 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 	/* Disable all interrupts */
 	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
 	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+
+	i2c_dw_release_lock(dev);
 }
 
 void i2c_dw_disable_int(struct dw_i2c_dev *dev)
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 9177463c2cbb..1a4b23556db3 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -905,7 +905,13 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 		irq_flags = IRQF_SHARED | IRQF_COND_SUSPEND;
 	}
 
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
 	i2c_dw_disable_int(dev);
+	i2c_dw_release_lock(dev);
+
 	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
 			       dev_name(dev->dev), dev);
 	if (ret) {
-- 
2.35.0.rc0.227.g00780c9af4-goog

