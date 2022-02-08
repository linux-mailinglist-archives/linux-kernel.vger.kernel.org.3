Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5221B4ADAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377421AbiBHOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351016AbiBHOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:12:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD812C03FED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:12:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a28so33490767lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VE0MB5TApOFhOvDoB5Sj1RVM5bQ12TfgYgo1XLf+VJQ=;
        b=5Scz24gknPUC230Z2O62vR17u2+XRfZpDNn+1L1ufk1yhg8n6RfJCbSXrbAXQrC7wY
         SqJLuCgRKjoXB/Hvgt9syd8c0ORJYUhbXcDLzyhWWM3nBCR3q2FPDx9t1HhYaGSINS5S
         ldsoR8H/Nk0ja1w1FcY7Jwt6St9JzvWEm/Dyd4f0ggXt8DJxu5Jobw7/ftJTDcsUh3x/
         L2absdEgQ9nmS/WJ1weou3wP1Yw60GtaeIfck8sk67rKZ52y51DE/tHzy5UQ7F9jbNdK
         SdjTKTG2kD06JGZtSpK+JaaI31/xrwA4JtCGzUtQaANYtK2iMxZiTxI9x366zBwp0LSU
         lQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VE0MB5TApOFhOvDoB5Sj1RVM5bQ12TfgYgo1XLf+VJQ=;
        b=BjqsC0UuMHl56LcS3O05TliKPRiv/SaT5e7HVj+w14mi/WcFeHektoYO5u1AYEhS4s
         q3pdTcXqxHv8hhbgx95XRmQKrqRt4PBGB5zWiiABjTQ0wD0bFvsRwEujq4vXPUbiwqX2
         qSMuk08lY8MIDHlgLTM5T6g8ZQsjU9qDlBkatk7iWffofjQOt4HLFbyZtn5fawmb+j4J
         iUxvI5qRGQhgYq4qssrj2SNIw3PYFsb5y/vBAUrd7+JsPmL9LJV+HRmHuN9GIi6nIjfJ
         0L4NeME6nBb9Atys9RBTs3rxfDLN4WGRcAJ4IAhHZtQnAuGxQcQ2KsHpFoF/3RBMCi+U
         SqpQ==
X-Gm-Message-State: AOAM531p9F5HXR6NBtrSCR+4rHcmMVQIbHNP8x8NJ3462c4IStV5L5vA
        qz5BP7q9NNzn0V3PbB+jVCPr79Lbva4XwxuL
X-Google-Smtp-Source: ABdhPJzXkglmKfzZfaqj30t8G/6W3ESB/gsroFF7Y637vXVKSyUDkt06UPoGppOV37K1bGlze0m8xw==
X-Received: by 2002:a05:6512:2215:: with SMTP id h21mr3104903lfu.549.1644329555989;
        Tue, 08 Feb 2022 06:12:35 -0800 (PST)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id u1sm1935973lff.199.2022.02.08.06.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 06:12:35 -0800 (PST)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     mika.westerberg@linux.intel.com, hdegoede@redhat.com,
        wsa@kernel.org, rrangel@chromium.org, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com, thomas.lendacky@amd.com,
        alexander.deucher@amd.com, Nimesh.Easow@amd.com,
        mario.limonciello@amd.com, jsd@semihalf.com
Subject: [PATCH v4 1/2] i2c: designware: Add missing locks
Date:   Tue,  8 Feb 2022 15:12:17 +0100
Message-Id: <20220208141218.2049591-2-jsd@semihalf.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208141218.2049591-1-jsd@semihalf.com>
References: <20220208141218.2049591-1-jsd@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.0.263.gb82422642f-goog

