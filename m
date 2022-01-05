Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55DC485B49
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiAEWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbiAEWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B3C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 8so363497pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8fcTIqomurbLX0G16Zj/Ofhh/zSXr/FCVjYSHLreys=;
        b=G6FqP/fkwAlE20UuL3U3VahbfkjR74+m0nS4DlHNVCnxpnbNxtLIjUixlSgWNxmUq9
         fSu7w3umRO6f9FFDTRS+n6LlFl0cg5zj25zAa39nzoclem9490pzuYy9opzhcTcek5Xi
         Zg8KpmzzSXQfEFGG3W8Rs3qhVrJYZMVDDAdoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8fcTIqomurbLX0G16Zj/Ofhh/zSXr/FCVjYSHLreys=;
        b=FnYe2DaGB3QzNOMMnljuJoSOy81t6BYc4DpkQxplxE/74xNapGYhIlH3Ri12s4FwzK
         T2ZfzF4wBX1V/389HPlSIMkbxhrgIDX6vZPEdWB5I1I9/OHhz4yD3LEbjFPisjLg5DHb
         BFQDvi0fJSGd0LUeCt/O5zpdj9EyWzP5YpzQf5jc57oi/FUmyVGWM+psMGRbcl3G6AP0
         F5Ue72uLTMBYIPjVRjQrVkZLs/wyr3ociyk7BkcmI6BWduXB7toz5dKb+LVjE4litk7w
         CIpUu+pRif8R8UwU8p1cF1zCMkp2UHweXpAvDbFuKiApE0l+MTQCMp6uWg0JFlIBdyKk
         LOdA==
X-Gm-Message-State: AOAM532GzXeoABxPYa/pdaw+8hwQCk4gwPjFFtdd7JXVhNo9LPAqC7Jj
        r6MsCYa3qXkNdMAkSRC+18WAlw==
X-Google-Smtp-Source: ABdhPJzvxhORQ8mkniQK6+0wPa195RkTMqnQzf5P4/VW6aZ4n1rU+pwKGJW2EJbDpHTdGH/liQtuKg==
X-Received: by 2002:a63:ba47:: with SMTP id l7mr50954788pgu.75.1641420424713;
        Wed, 05 Jan 2022 14:07:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id b11sm105207pfv.39.2022.01.05.14.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:04 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 01/17] plaform: chrome: Add PL_CHROMEOS export symbol namespace
Date:   Wed,  5 Jan 2022 14:06:37 -0800
Message-Id: <20220105220653.122451-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PL_CHROMEOS to hold functions exposed by the platform chromeos
subsystem:

for i in EXPORT_SYMBOL_GPL EXPORT_SYMBOL; do
  sed -i "s/$i(\([^)]*\)/$i_NS(\1, PL_CHROMEOS/"
    $(grep -lr $i drivers/platform/chrome/)
done

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c        | 18 +++++++++---------
 .../platform/chrome/cros_ec_sensorhub_ring.c   |  4 ++--
 drivers/platform/chrome/cros_usbpd_notify.c    |  4 ++--
 drivers/platform/chrome/wilco_ec/mailbox.c     |  2 +-
 drivers/platform/chrome/wilco_ec/properties.c  |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index c4caf2e2de825f..2cfd7d97f6d737 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -189,7 +189,7 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 
 	return EC_MSG_TX_PROTO_BYTES + msg->outsize;
 }
-EXPORT_SYMBOL(cros_ec_prepare_tx);
+EXPORT_SYMBOL_NS(cros_ec_prepare_tx, PL_CHROMEOS);
 
 /**
  * cros_ec_check_result() - Check ec_msg->result.
@@ -217,7 +217,7 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
 		return 0;
 	}
 }
-EXPORT_SYMBOL(cros_ec_check_result);
+EXPORT_SYMBOL_NS(cros_ec_check_result, PL_CHROMEOS);
 
 /*
  * cros_ec_get_host_event_wake_mask
@@ -557,7 +557,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	kfree(proto_msg);
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_query_all);
+EXPORT_SYMBOL_NS(cros_ec_query_all, PL_CHROMEOS);
 
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
@@ -625,7 +625,7 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
+EXPORT_SYMBOL_NS(cros_ec_cmd_xfer_status, PL_CHROMEOS);
 
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
@@ -767,7 +767,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_get_next_event);
+EXPORT_SYMBOL_NS(cros_ec_get_next_event, PL_CHROMEOS);
 
 /**
  * cros_ec_get_host_event() - Return a mask of event set by the ChromeOS EC.
@@ -797,7 +797,7 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 
 	return host_event;
 }
-EXPORT_SYMBOL(cros_ec_get_host_event);
+EXPORT_SYMBOL_NS(cros_ec_get_host_event, PL_CHROMEOS);
 
 /**
  * cros_ec_check_features() - Test for the presence of EC features
@@ -830,7 +830,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 
 	return !!(features->flags[feature / 32] & EC_FEATURE_MASK_0(feature));
 }
-EXPORT_SYMBOL_GPL(cros_ec_check_features);
+EXPORT_SYMBOL_NS_GPL(cros_ec_check_features, PL_CHROMEOS);
 
 /**
  * cros_ec_get_sensor_count() - Return the number of MEMS sensors supported.
@@ -896,7 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
 	}
 	return sensor_count;
 }
-EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
+EXPORT_SYMBOL_NS_GPL(cros_ec_get_sensor_count, PL_CHROMEOS);
 
 /**
  * cros_ec_command - Send a command to the EC.
@@ -944,4 +944,4 @@ int cros_ec_command(struct cros_ec_device *ec_dev,
 	kfree(msg);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cros_ec_command);
+EXPORT_SYMBOL_NS_GPL(cros_ec_command, PL_CHROMEOS);
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 98e37080f76091..fa6292e49a93e4 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -86,7 +86,7 @@ int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cros_ec_sensorhub_register_push_data);
+EXPORT_SYMBOL_NS_GPL(cros_ec_sensorhub_register_push_data, PL_CHROMEOS);
 
 void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
 					    u8 sensor_num)
@@ -94,7 +94,7 @@ void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
 	sensorhub->push_data[sensor_num].indio_dev = NULL;
 	sensorhub->push_data[sensor_num].push_data_cb = NULL;
 }
-EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
+EXPORT_SYMBOL_NS_GPL(cros_ec_sensorhub_unregister_push_data, PL_CHROMEOS);
 
 /**
  * cros_ec_sensorhub_ring_fifo_enable() - Enable or disable interrupt generation
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 91ce6be91aac16..3a5a14b8175347 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -38,7 +38,7 @@ int cros_usbpd_register_notify(struct notifier_block *nb)
 	return blocking_notifier_chain_register(&cros_usbpd_notifier_list,
 						nb);
 }
-EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
+EXPORT_SYMBOL_NS_GPL(cros_usbpd_register_notify, PL_CHROMEOS);
 
 /**
  * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
@@ -51,7 +51,7 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
 {
 	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
 }
-EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
+EXPORT_SYMBOL_NS_GPL(cros_usbpd_unregister_notify, PL_CHROMEOS);
 
 static void cros_usbpd_get_event_and_notify(struct device  *dev,
 					    struct cros_ec_device *ec_dev)
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index 0f98358ea824c6..edbe90a68d53c7 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -212,4 +212,4 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
 	return ret;
 
 }
-EXPORT_SYMBOL_GPL(wilco_ec_mailbox);
+EXPORT_SYMBOL_NS_GPL(wilco_ec_mailbox, PL_CHROMEOS);
diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
index c2bf4c95c5d2c9..011daac4de2f66 100644
--- a/drivers/platform/chrome/wilco_ec/properties.c
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -76,7 +76,7 @@ int wilco_ec_get_property(struct wilco_ec_device *ec,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wilco_ec_get_property);
+EXPORT_SYMBOL_NS_GPL(wilco_ec_get_property, PL_CHROMEOS);
 
 int wilco_ec_set_property(struct wilco_ec_device *ec,
 			  struct wilco_ec_property_msg *prop_msg)
@@ -99,7 +99,7 @@ int wilco_ec_set_property(struct wilco_ec_device *ec,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wilco_ec_set_property);
+EXPORT_SYMBOL_NS_GPL(wilco_ec_set_property, PL_CHROMEOS);
 
 int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
 			       u8 *val)
@@ -119,7 +119,7 @@ int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wilco_ec_get_byte_property);
+EXPORT_SYMBOL_NS_GPL(wilco_ec_get_byte_property, PL_CHROMEOS);
 
 int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
 			       u8 val)
@@ -132,4 +132,4 @@ int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
 
 	return wilco_ec_set_property(ec, &msg);
 }
-EXPORT_SYMBOL_GPL(wilco_ec_set_byte_property);
+EXPORT_SYMBOL_NS_GPL(wilco_ec_set_byte_property, PL_CHROMEOS);
-- 
2.34.1.448.ga2b2bfdf31-goog

