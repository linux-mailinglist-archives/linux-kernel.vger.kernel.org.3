Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5694AB417
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiBGFuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiBGEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:39:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826AC043183
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:39:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a19-20020a25ca13000000b0061db44646b3so2935798ybg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 20:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZGBcS7JWV4jEm41Ieg0bh/DWDMa+jid9L2vZwRwLPsQ=;
        b=hTi2MIRuc/XCPJdsJ8EBR8xE/nfUcnqO/pcV2L0/Vx4Muy05JpQDhrmhezGgIVhPV8
         G6etzRvhkLJ/XS074ODg978oyePc62d5Hwywtt24jXa5rivawKxCYakQnlJOdTZdMWbp
         S1bO7TV0OaXcoTVKm6WBLjTfYvhKrZ3lQJMEZw1+59aZhZR8ogcuHZpwn7zAWGo0nvJj
         D1mF1Ch86HwaduTjHGN9jlHC3MYC/bkEeWtDbmwzRmpqZGCLbiAnL5xPJcFQ2qpE8ksY
         WWs2wyHZ5LKrq0VY5TefuETmU0Ui72bJJ4aoXZY/WeoF6WUFzkHYqaRQleJ7vKTeu2Q1
         x5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZGBcS7JWV4jEm41Ieg0bh/DWDMa+jid9L2vZwRwLPsQ=;
        b=OMJfb6E54Mh55fcOuCdBzGgDqLA/KEQpMk4GUhwnbuA3YJ79gKi37ENONFk9a5lCQp
         Hj9GeWECfyS//6fbFKfcZ06sRK+q+HsgrsghdLoDJTom+jb/KGI0hyaT70SWY9Npdmds
         Gwkfi2j+dy7gdycPrOPmdsm5Y9IxDqpujQDMwYn8GKiwUCShMAulum0RTsm7xhuvmqFV
         i8gUTZ2++IEP8hbvNgxxU95XFvLq3Btm51/1dPjoBR3eCD2jlAWNOktpVEUyBRaxnxJy
         E8U+2IEqjQYwbIdbho+Gh3scF9mjsHj0W/LDUgRb6KKQMMIaU9nIXXrOnrrQfuQXIjqG
         dehA==
X-Gm-Message-State: AOAM531Ca/va7Tg09+i1EJrG2XvD0K3Rj1ovaCaNmeMI6tovgBKHXaYo
        QsyMMt4UgBjNRDykVpt0EfnVQ0XRiUs=
X-Google-Smtp-Source: ABdhPJyKen1NvGRKRRF5JJSfuC0xiMhzV6FqmDa7uRHf2FY/+bd89jMaurQm8wBzbpZx9FYb+xTlwVIwGvs=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:55d1:a045:9816:1433])
 (user=badhri job=sendgmr) by 2002:a5b:bcd:: with SMTP id c13mr251353ybr.303.1644208752853;
 Sun, 06 Feb 2022 20:39:12 -0800 (PST)
Date:   Sun,  6 Feb 2022 20:39:06 -0800
Message-Id: <20220207043907.2758424-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v1 1/2] usb: typec: Introduce typec attributes for limiting
 source current
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
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

This change introduces the following two attributes to the
typec sysfs class which allows userspace to limit the power
advertised while acting as source. This is useful to mitigate
battery drain in portable devices when the battery SOC is low.

New attibutes introduced:
1. limit_src_current_active
2. limit_src_current_ma

The port while in PD contract and acting as source would
only advertise vSafe5V fixed PDO with current set through
limit_src_current_ma when limit_src_current_active is set
to 1. When limit_src_current_active is set to 0, the port
would publish the default source capabilities.
limit_src_current_ma would limit the current to the
Maximum current published by vSafe5V fixed pdo of the default
source capabilities of the port.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 Documentation/ABI/testing/sysfs-class-typec | 25 ++++++
 drivers/usb/typec/class.c                   | 99 +++++++++++++++++++++
 drivers/usb/typec/class.h                   |  5 ++
 include/linux/usb/typec.h                   |  4 +
 4 files changed, 133 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 75088ecad202..dd2240632172 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -141,6 +141,31 @@ Description:
 		- "reverse": CC2 orientation
 		- "unknown": Orientation cannot be determined.
 
+What:		/sys/class/typec/<port>/limit_src_current_active
+Date:		February 2022
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		This attribute can be used to make the port only publish
+		vSafe5V fixed pdo with Maximum current limited to the
+		current limit set by limit_src_current_ma when the port
+		is acting as source.
+		Valid values:
+		- write(2) "1" limits source capabilities to vSafe5V
+		  with max current specified by limit_src_current_ma
+		- write(2) "0" publishes the default source capabilities
+		  of the port.
+
+What:		/sys/class/typec/<port>/limit_src_current_ma
+Date:		February 2022
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		This attribute allows write(2) to set the Maximum
+		current published when limit_src_current_active is set
+		to 1. When limit_src_current_active is already set
+		to 1, if the port is already acting as source with
+		explicit contract in place, write(2) will make the port
+		renegotiate the pd contract.
+
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
 What:		/sys/class/typec/<port>-partner/accessory_mode
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45a6f0c807cb..3b3c7b080ad1 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1403,6 +1403,102 @@ port_type_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(port_type);
 
+static ssize_t
+limit_src_current_active_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			       size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	int ret;
+	u8 active;
+
+	if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
+	    !port->cap->pd_revision) {
+		dev_dbg(dev, "Limiting source current not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtou8(buf, 0, &active))
+		return -EINVAL;
+
+	if (active != 1 && active != 0)
+		return -EINVAL;
+
+	mutex_lock(&port->limit_src_current_lock);
+
+	if (port->limit_src_current_active == (bool)active) {
+		ret = size;
+		goto unlock_and_ret;
+	}
+
+	ret = port->ops->limit_src_current_set(port, port->limit_src_current_ma, active);
+	if (ret)
+		goto unlock_and_ret;
+
+	port->limit_src_current_active = active;
+	ret = size;
+
+unlock_and_ret:
+	mutex_unlock(&port->limit_src_current_lock);
+	return ret;
+}
+
+static ssize_t
+limit_src_current_active_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+
+	return sysfs_emit(buf, "%d\n", port->limit_src_current_active ? 1 : 0);
+}
+static DEVICE_ATTR_RW(limit_src_current_active);
+
+static ssize_t
+limit_src_current_ma_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			   size_t size)
+{
+	struct typec_port *port = to_typec_port(dev);
+	int ret;
+	u32 src_current_ma;
+
+	if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
+	    !port->cap->pd_revision) {
+		dev_dbg(dev, "Limiting source current not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtou32(buf, 0, &src_current_ma))
+		return -EINVAL;
+
+	mutex_lock(&port->limit_src_current_lock);
+
+	if (port->limit_src_current_ma == src_current_ma) {
+		ret = size;
+		goto unlock_and_ret;
+	}
+
+	if (port->limit_src_current_active) {
+		ret = port->ops->limit_src_current_set(port, src_current_ma,
+						       port->limit_src_current_active);
+		if (ret)
+			goto unlock_and_ret;
+	}
+
+	port->limit_src_current_ma = src_current_ma;
+	ret = size;
+
+unlock_and_ret:
+	mutex_unlock(&port->limit_src_current_lock);
+	return ret;
+}
+
+static ssize_t
+limit_src_current_ma_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct typec_port *port = to_typec_port(dev);
+
+	return sysfs_emit(buf, "%u\n", port->limit_src_current_ma);
+}
+static DEVICE_ATTR_RW(limit_src_current_ma);
+
 static const char * const typec_pwr_opmodes[] = {
 	[TYPEC_PWR_MODE_USB]	= "default",
 	[TYPEC_PWR_MODE_1_5A]	= "1.5A",
@@ -1536,6 +1632,8 @@ static struct attribute *typec_attrs[] = {
 	&dev_attr_vconn_source.attr,
 	&dev_attr_port_type.attr,
 	&dev_attr_orientation.attr,
+	&dev_attr_limit_src_current_active.attr,
+	&dev_attr_limit_src_current_ma.attr,
 	NULL,
 };
 
@@ -2039,6 +2137,7 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
+	mutex_init(&port->limit_src_current_lock);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 0f1bd6d19d67..3856bc058444 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -54,6 +54,11 @@ struct typec_port {
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
+
+	/* lock to protect limit_src_current_*_store operation */
+	struct mutex			limit_src_current_lock;
+	u32				limit_src_current_ma;
+	bool				limit_src_current_active;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 7ba45a97eeae..1b1958ae4c16 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -213,6 +213,8 @@ struct typec_partner_desc {
  * @pr_set: Set Power Role
  * @vconn_set: Source VCONN
  * @port_type_set: Set port type
+ * @limit_src_current_set: Used to limit source current advertisement while
+ *                         acting as source
  */
 struct typec_operations {
 	int (*try_role)(struct typec_port *port, int role);
@@ -221,6 +223,8 @@ struct typec_operations {
 	int (*vconn_set)(struct typec_port *port, enum typec_role role);
 	int (*port_type_set)(struct typec_port *port,
 			     enum typec_port_type type);
+	int (*limit_src_current_set)(struct typec_port *port, u32 limit_src_current_ma,
+				     bool enable);
 };
 
 enum usb_pd_svdm_ver {
-- 
2.35.0.263.gb82422642f-goog

