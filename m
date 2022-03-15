Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3F4DA36D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbiCOTo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350498AbiCOTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:44:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11332717E;
        Tue, 15 Mar 2022 12:43:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q194so276013qke.5;
        Tue, 15 Mar 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDraLfdvNRPxu+1H1GYdFP58AdsfLAH58eveu7tc/9Q=;
        b=Bpu++ll3hZg3OnQnB/onttugrvoTFv2mhnzJVQGdpMa4q2I2VBbw+6m/QKYMPe+EMA
         C7O+0dj0iRfK7Q/RUd8hTQ+Ybhsue6QamZIamdl/R0XNCT50MztYcFJBa9Ev872aQPHx
         HqkOf6xWCGEL26eFI9wlFu+/FNJNb4MVzFrRSgnqBNV5gpkz/K3jUoX7MuMrz7vzevcH
         KBOxYc4JTI3bJ4wOA48eAN/lWzF7XtF+a70WmqdvH1NUOGXST1HGtctgEd37gdaK90nN
         /RANaeYxMdXTFbvhNkGDF6dk/HhrjfhIYI1XKfxTDR2Ren1xz64KFxsRB+3KphpAIcPg
         9Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDraLfdvNRPxu+1H1GYdFP58AdsfLAH58eveu7tc/9Q=;
        b=KdYzGixIi2WH0yt0HxS3c8gWG/3/C3D9S7BpP8EXIaMiiDWe0+GThuARLFhkmCksfQ
         aPwGvU6Ql3Dtc3vUDBm4w6EYcMo5eAvGhNoiOILM8c/Z+TL2G8nRgTM6elviQE0QZiT5
         Z6TuI+aC8/9A5LPH2CNxUpuwSueANpYiepQtu1j2rs5R1Dn8NBvpAkAijB+ObglRqz5p
         NFDM/zW9Lr1CWViqD+ElmHHXd4GEuTHItSwL7jkKjzZd+Eod71KLnCbvTusnZPZ/4CKe
         bRNfk/AAZOJcCgxlzszYDIs20FIWkkTrTDqDAS86Awy4CoN0bFBtODlzJE/TRDf8wwkD
         v5BQ==
X-Gm-Message-State: AOAM530tKVwsnJP2ddk7spFHo71AqP5N4Dxx5qAR6RZpyso80B1V819g
        0n/vmJCAJOq8O3UTxlr7Twc9iMRorNvpmf7V
X-Google-Smtp-Source: ABdhPJzL633RxLpZMRy4YKLhwVuVyiH/0mxFw8Qhx9o4qh/Fi5lxo0EVDPlRntfQwkCh8OlOuCAH9g==
X-Received: by 2002:a37:9e43:0:b0:67b:312d:50e0 with SMTP id h64-20020a379e43000000b0067b312d50e0mr19410726qke.549.1647373390990;
        Tue, 15 Mar 2022 12:43:10 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id 1-20020a05620a078100b00648cc800c9dsm9845318qka.103.2022.03.15.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:43:10 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 1/1] counter: Stop using dev_get_drvdata() to get the counter device
Date:   Tue, 15 Mar 2022 15:43:04 -0400
Message-Id: <4a14311a3b935b62b33e665a97ecaaf2f078228a.1647373336.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373336.git.vilhelm.gray@gmail.com>
References: <cover.1647373336.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
container_of instead of drvdata to track counter_device") which wrongly
claimed there were no users of drvdata. Convert to container_of() to
fix a null pointer dereference.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to track counter_device")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/all/20220204082556.370348-1-u.kleine-koenig@pengutronix.de/
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 7cc4d1d523ea..04eac41dad33 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -19,6 +19,11 @@
 
 #include "counter-sysfs.h"
 
+static inline struct counter_device *counter_from_dev(struct device *dev)
+{
+	return container_of(dev, struct counter_device, dev);
+}
+
 /**
  * struct counter_attribute - Counter sysfs attribute
  * @dev_attr:	device attribute for sysfs
@@ -90,7 +95,7 @@ static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u8 data = 0;
 
@@ -122,7 +127,7 @@ static ssize_t counter_comp_u8_store(struct device *dev,
 				     const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	bool bool_data = 0;
 	u8 data = 0;
@@ -158,7 +163,7 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	const struct counter_available *const avail = a->comp.priv;
 	int err;
 	u32 data = 0;
@@ -221,7 +226,7 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	struct counter_count *const count = a->parent;
 	struct counter_synapse *const synapse = a->comp.priv;
 	const struct counter_available *const avail = a->comp.priv;
@@ -281,7 +286,7 @@ static ssize_t counter_comp_u64_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 
@@ -309,7 +314,7 @@ static ssize_t counter_comp_u64_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 
-- 
2.35.1

