Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716F505DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347284AbiDRSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347271AbiDRSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:02:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48135256
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:42 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so8182025plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuHwr81n4dn+L1ihy6nXq1mfk2kBOn+r4UOaqo83GJw=;
        b=WRyWkwOGvkFKChN2vgQQTDI30Vye1r69Q1pThCHeIJpyD1i91ALknX+71pzv9EAflH
         MXHKgUAmlMSunHfOMflHjEJP4Q9bFO/WxloegYnyhF9KUhEIA5IloGjWHaDHbqmIrNrs
         Nn+TY1pjdvcmQo7NFCwWHqxEMU4HBPYUBe50fGO0+Ci8VqfUQao8UNfHsuL+2clN2P5w
         RNoGxMQwmQLJDtyQnqiKO03w23iW+xvmLbzJuuon9WOpt1fq+cpu4CzaKSPovrk19UOo
         hl3UkHpJvyyQ3tOcq3xVd4JuHS9AsKic2Qsixby8XopB4Z7p6EAWnlql13Y3uZJ0db8X
         xRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuHwr81n4dn+L1ihy6nXq1mfk2kBOn+r4UOaqo83GJw=;
        b=Xq4Tfp9sJ0NqzG9VRpWrTtGhVSc8QSHPdth4N+FDpA1g6hh1dmTigTo6Bh9r+tbSPf
         ugIa+HtPjJ55F8cWs2Wj0+nVNeMrKe7s6MT66/OmC0o80TchBgi/q07yYWTwWCk03tJv
         8vslsdcyM8RLx+eFBmerbQ4HH0A5y8ggFO7WyjWotTsOmqD69bCUoH8S/H82iZdWNOcc
         MJmiwj9Js112BS1yYXf3yW7DlcAyv9WZdrWBtHsdRNT57X3CcD9tm+iNPB4XHVREoOBH
         ybxXdiKctd6khWSdhdAYjxmlvcqnN5vERlS8av2SIdkSx/5sFSLmKtxGoHSbHFvrneiL
         srcA==
X-Gm-Message-State: AOAM532j0VWFA4y9azSp0hnLCk5t6chRc7r6Rl2D7H+svv+/kNkA8Zlj
        4Juj6ElvQ/FZTTITRaS3OVJ0HwTha2p0Lw==
X-Google-Smtp-Source: ABdhPJzL1dRg1wEpGUGbWcfKGlCFOXV46fORxkmcdIfqO9xFmmLfOn9Nde9V9NafXduX8OgKQz7OtswxQngdOA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:690b:b0:159:65c:9044 with SMTP id
 j11-20020a170902690b00b00159065c9044mr3825600plk.47.1650304781783; Mon, 18
 Apr 2022 10:59:41 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:59:32 +0000
In-Reply-To: <20220418175932.1809770-1-wonchung@google.com>
Message-Id: <20220418175932.1809770-3-wonchung@google.com>
Mime-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 2/2] thunderbolt: Link USB4 ports to their USB Type-C connectors
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Creating a symlink pointing to the correct USB Type-C
connector for the on-board USB4 ports when they are created.
The link will be created only if the firmware is able to
describe the connection between the port and its connector.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         | 10 +++++
 drivers/thunderbolt/usb4_port.c               | 38 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index b7e87f6c7d47..f7570c240ce8 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -293,6 +293,16 @@ Contact:	thunderbolt-software@lists.01.org
 Description:	This contains XDomain service specific settings as
 		bitmask. Format: %x
 
+What:		/sys/bus/thunderbolt/devices/usb4_portX/connector
+Date:		April 2022
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Symlink to the USB Type-C connector. This link is only
+		created when USB Type-C Connector Class is enabled,
+		and only if the system firmware is capable of
+		describing the connection between a port and its
+		connector.
+
 What:		/sys/bus/thunderbolt/devices/usb4_portX/link
 Date:		Sep 2021
 KernelVersion:	v5.14
diff --git a/drivers/thunderbolt/usb4_port.c b/drivers/thunderbolt/usb4_port.c
index 29e2a4f9c9f5..6b02945624ee 100644
--- a/drivers/thunderbolt/usb4_port.c
+++ b/drivers/thunderbolt/usb4_port.c
@@ -7,9 +7,37 @@
  */
 
 #include <linux/pm_runtime.h>
+#include <linux/component.h>
+#include <linux/property.h>
 
 #include "tb.h"
 
+static int connector_bind(struct device *dev, struct device *connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &connector->kobj, "connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&connector->kobj, &dev->kobj, dev_name(dev));
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "connector");
+
+	return ret;
+}
+
+static void connector_unbind(struct device *dev, struct device *connector, void *data)
+{
+	sysfs_remove_link(&connector->kobj, dev_name(dev));
+	sysfs_remove_link(&dev->kobj, "connector");
+}
+
+static const struct component_ops connector_ops = {
+	.bind = connector_bind,
+	.unbind = connector_unbind,
+};
+
 static ssize_t link_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -246,6 +274,14 @@ struct usb4_port *usb4_port_device_add(struct tb_port *port)
 		return ERR_PTR(ret);
 	}
 
+	if (dev_fwnode(&usb4->dev)) {
+		ret = component_add(&usb4->dev, &connector_ops);
+		if (ret) {
+			dev_err(&usb4->dev, "failed to add component\n");
+			device_unregister(&usb4->dev);
+		}
+	}
+
 	pm_runtime_no_callbacks(&usb4->dev);
 	pm_runtime_set_active(&usb4->dev);
 	pm_runtime_enable(&usb4->dev);
@@ -265,6 +301,8 @@ struct usb4_port *usb4_port_device_add(struct tb_port *port)
  */
 void usb4_port_device_remove(struct usb4_port *usb4)
 {
+	if (dev_fwnode(&usb4->dev))
+		component_del(&usb4->dev, &connector_ops);
 	device_unregister(&usb4->dev);
 }
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

