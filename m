Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A945A500C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiH2PR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiH2PRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:17:53 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C717A51B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:17:51 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so6089331otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PRU8c/YFFHTSCg7HReScdvPI3HlKG8EkTuSOdJ0Pa/4=;
        b=k3FqbItsvPd4x+fBpWLJOtyO9uA78jeUH5iX6N+/dBajn/7tAMbkwE3d1mcq2wEip9
         dUD2PRRTGbYL7+agwLk8Z0PttFgpm3WJnTIdOY63pfN1KhR+RkQG6ApOjr2NoSLHoqd7
         95BFYBWFIvdKQuH9/tMM0VBn6mN3+FpyA9iCGXP6OSQ22t/YC9kSC5zc/1lLbpGzYocQ
         7EgfqBBt4OOFUmp1Ba5hAzJGqmVsuNGpMjGHmlgryWV5Z255T+oA9vjN7rwJ8DvtWflW
         I3tvD5shCpTUI00mamneQlTyss1I6dKutW/OFgqWwH66ZjFhD0MU4s1ry8nkynpKwTP3
         Oclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PRU8c/YFFHTSCg7HReScdvPI3HlKG8EkTuSOdJ0Pa/4=;
        b=bZ2ZOF9cExB+eaXNUde7CVKekPp8Pru454gCTeSHcGoakf4VK4R9rZzzS6vZ0UIGgs
         othO1bvGfjx7GhaDl6fdJfNxGKx/k8ZNmak3GB8rNYgUVQmVmVHA0ufXbCqijfbejWzU
         pKoU6emwLRC3QNdS5hbCNRQNQXK6PRsY825XVqvDYYyBKDToXYnUtWcMZ8VH8tVcps3f
         xC088LkuEnPWzDTnel4c4qpXUv8Lf1Eo4/BUtkNhwwQ+QE3crruMH/eBaUGUu8WRBkI5
         qzSJPfmGNqZqz9yEExK8c6i3BIICdVfarHT6jcOXXPUKHbxzT/PU8CrFaIqYvOSL06zN
         WDZA==
X-Gm-Message-State: ACgBeo3FUnfIVJ3rdClYNcYJkflEnlxko93xdlqrrM+hQqkc2TjxXUNA
        qLZVD1XZsN5F/5pWYQweeSZTaQ==
X-Google-Smtp-Source: AA6agR4ZSqUNxzZ0pX3EIsQOYE/hZXVs5BuS+4pA9yOL9JxxxkJATRPDecjcQduT1ljSc8Dq/D6iYg==
X-Received: by 2002:a05:6830:2707:b0:638:9ccc:dadb with SMTP id j7-20020a056830270700b006389cccdadbmr7176616otu.369.1661786271135;
        Mon, 29 Aug 2022 08:17:51 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z14-20020a056830128e00b006389650374dsm5771320otp.54.2022.08.29.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:17:50 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, fabien.lahoudere@collabora.com,
        gwendal@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        david@lechnology.com, robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RFC PATCH 2/2] counter: Introduce the COUNTER_COMP_ARRAY_U64 component type
Date:   Mon, 29 Aug 2022 11:17:31 -0400
Message-Id: <31a35481813ec26949018888253278a634998a92.1661785438.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661785438.git.william.gray@linaro.org>
References: <cover.1661785438.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COUNTER_COMP_ARRAY_U64 Counter component type is introduced to
enable support for Counter array components. With Counter array
components, exposure for buffers on counter devices can be defined via
new Counter array component macros. This should simplify code for driver
authors who would otherwise need to define individual Counter components
for each array element.

Three Counter array component macros are introduced::

        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _length)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _length)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _length)

Six respective callbacks are introduced as well::

        int (*device_array_u64_read)(struct counter_device *counter,
                                     size_t idx, u64 *val);
        int (*count_array_u64_read)(struct counter_device *counter,
                                    struct counter_count *count,
                                    size_t idx, u64 *val);
        int (*signal_array_u64_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u64 *val);
        int (*device_array_u64_write)(struct counter_device *counter,
                                      size_t idx, u64 val);
        int (*count_array_u64_write)(struct counter_device *counter,
                                     struct counter_count *count,
                                     size_t idx, u64 val);
        int (*signal_array_u64_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u64 val);

Driver authors can handle reads/writes for an array component by
receiving an element index via the `idx` parameter and processing the
respective value via the `val` parameter.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback `foobar_read()`::

        COUNTER_COMP_COUNT_ARRAY_U64("capture", foobar_read, NULL, 4)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_read()` callback, and thus the driver knows which
array element to handle.

Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 116 +++++++++++++++++++++++++++++++-
 include/linux/counter.h         |  78 +++++++++++++++++++++
 2 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 026ea094d68e..464bc4750787 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -341,6 +341,72 @@ static ssize_t counter_comp_u64_store(struct device *dev,
 	return len;
 }
 
+static ssize_t counter_comp_array_u64_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const size_t idx = (size_t)a->comp.priv;
+	int err;
+	u64 data = 0;
+
+	switch (a->scope) {
+	case COUNTER_SCOPE_DEVICE:
+		err = a->comp.device_array_u64_read(counter, idx, &data);
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		err = a->comp.signal_array_u64_read(counter, a->parent, idx,
+						    &data);
+		break;
+	case COUNTER_SCOPE_COUNT:
+		err = a->comp.count_array_u64_read(counter, a->parent, idx,
+						   &data);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)data);
+}
+
+static ssize_t counter_comp_array_u64_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = counter_from_dev(dev);
+	const size_t idx = (size_t)a->comp.priv;
+	int err;
+	u64 data = 0;
+
+	err = kstrtou64(buf, 0, &data);
+	if (err < 0)
+		return err;
+
+	switch (a->scope) {
+	case COUNTER_SCOPE_DEVICE:
+		err = a->comp.device_array_u64_write(counter, idx, data);
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		err = a->comp.signal_array_u64_write(counter, a->parent, idx,
+						     data);
+		break;
+	case COUNTER_SCOPE_COUNT:
+		err = a->comp.count_array_u64_write(counter, a->parent, idx,
+						    data);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return len;
+}
+
 static ssize_t enums_available_show(const u32 *const enums,
 				    const size_t num_enums,
 				    const char *const strs[], char *buf)
@@ -488,6 +554,16 @@ static int counter_attr_create(struct device *const dev,
 			dev_attr->store = counter_comp_u64_store;
 		}
 		break;
+	case COUNTER_COMP_ARRAY_U64:
+		if (comp->count_array_u64_read) {
+			dev_attr->attr.mode |= 0444;
+			dev_attr->show = counter_comp_array_u64_show;
+		}
+		if (comp->count_array_u64_write) {
+			dev_attr->attr.mode |= 0200;
+			dev_attr->store = counter_comp_array_u64_store;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -597,6 +673,38 @@ static int counter_ext_attrs_create(struct device *const dev,
 	return counter_comp_id_attr_create(dev, group, ext->name, id);
 }
 
+static int counter_array_attrs_create(struct device *const dev,
+				      struct counter_attribute_group *const group,
+				      const struct counter_comp *const comp,
+				      const enum counter_scope scope,
+				      void *const parent, const size_t id)
+{
+	const size_t length = (size_t)comp->priv;
+	struct counter_comp ext = *comp;
+	size_t i;
+	int err;
+
+	/* Create an attribute for each array element */
+	for (i = 0; i < length; i++) {
+		/* Set index for array element extension */
+		ext.priv = (void *)i;
+
+		/* Generate array element attribute name */
+		ext.name = devm_kasprintf(dev, GFP_KERNEL, "%s%zu", comp->name,
+					  i);
+		if (!ext.name)
+			return -ENOMEM;
+
+		/* Create all attributes associated with the array element */
+		err = counter_ext_attrs_create(dev, group, &ext, scope, parent,
+					       id + i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int counter_sysfs_exts_add(struct device *const dev,
 				  struct counter_attribute_group *const group,
 				  const struct counter_comp *const exts,
@@ -611,8 +719,12 @@ static int counter_sysfs_exts_add(struct device *const dev,
 	/* Create attributes for each extension */
 	for (i = 0; i < num_ext; i++) {
 		ext = &exts[i];
-		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
-					       i);
+		if (ext->type == COUNTER_COMP_ARRAY_U64)
+			err = counter_array_attrs_create(dev, group, ext, scope,
+							 parent, i);
+		else
+			err = counter_ext_attrs_create(dev, group, ext, scope,
+						       parent, i);
 		if (err < 0)
 			return err;
 	}
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 1fe17f5adb09..8ef4dd9d73dc 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_ARRAY_U64,
 };
 
 /**
@@ -68,6 +69,24 @@ enum counter_comp_type {
  * @signal_u64_read:		Signal u64 component read callback. The read value of
  *			the respective Signal u64 component should be passed
  *			back via the val parameter.
+ * @device_array_u64_read:	Device u64 array component read callback. The
+ *				index of the respective Device u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Device u64 array component element should be
+ *				passed back via the val parameter.
+ * @count_array_u64_read:	Count u64 array component read callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Count u64 array component element should be
+ *				passed back via the val parameter.
+ * @signal_array_u64_read:	Signal u64 array component read callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The read value of the respective
+ *				Count u64 array component element should be
+ *				passed back via the val parameter.
  * @action_write:		Synapse action mode write callback. The write value of
  *			the respective Synapse action mode is passed via the
  *			action parameter.
@@ -98,6 +117,24 @@ enum counter_comp_type {
  * @signal_u64_write:		Signal u64 component write callback. The write value of
  *			the respective Signal u64 component is passed via the
  *			val parameter.
+ * @device_array_u64_write:	Device u64 array component write callback. The
+ *				index of the respective Device u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Device u64 array component element is passed via
+ *				the val parameter.
+ * @count_array_u64_write:	Count u64 array component write callback. The
+ *				index of the respective Count u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Count u64 array component element is passed via
+ *				the val parameter.
+ * @signal_array_u64_write:	Signal u64 array component write callback. The
+ *				index of the respective Signal u64 array
+ *				component element is passed via the idx
+ *				parameter. The write value of the respective
+ *				Signal u64 array component element is passed via
+ *				the val parameter.
  */
 struct counter_comp {
 	enum counter_comp_type type;
@@ -125,6 +162,14 @@ struct counter_comp {
 				      struct counter_count *count, u64 *val);
 		int (*signal_u64_read)(struct counter_device *counter,
 				       struct counter_signal *signal, u64 *val);
+		int (*device_array_u64_read)(struct counter_device *counter,
+					     size_t idx, u64 *val);
+		int (*count_array_u64_read)(struct counter_device *counter,
+					    struct counter_count *count,
+					    size_t idx, u64 *val);
+		int (*signal_array_u64_read)(struct counter_device *counter,
+					     struct counter_signal *signal,
+					     size_t idx, u64 *val);
 	};
 	union {
 		int (*action_write)(struct counter_device *counter,
@@ -148,6 +193,14 @@ struct counter_comp {
 				       struct counter_count *count, u64 val);
 		int (*signal_u64_write)(struct counter_device *counter,
 					struct counter_signal *signal, u64 val);
+		int (*device_array_u64_write)(struct counter_device *counter,
+					      size_t idx, u64 val);
+		int (*count_array_u64_write)(struct counter_device *counter,
+					     struct counter_count *count,
+					     size_t idx, u64 val);
+		int (*signal_array_u64_write)(struct counter_device *counter,
+					      struct counter_signal *signal,
+					      size_t idx, u64 val);
 	};
 };
 
@@ -452,6 +505,31 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+#define COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _length) \
+{ \
+	.type = COUNTER_COMP_ARRAY_U64, \
+	.name = (_name), \
+	.device_array_u64_read = (_read), \
+	.device_array_u64_write = (_write), \
+	.priv = (void *)(_length), \
+}
+#define COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _length) \
+{ \
+	.type = COUNTER_COMP_ARRAY_U64, \
+	.name = (_name), \
+	.count_array_u64_read = (_read), \
+	.count_array_u64_write = (_write), \
+	.priv = (void *)(_length), \
+}
+#define COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _length) \
+{ \
+	.type = COUNTER_COMP_ARRAY_U64, \
+	.name = (_name), \
+	.signal_array_u64_read = (_read), \
+	.signal_array_u64_write = (_write), \
+	.priv = (void *)(_length), \
+}
+
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
-- 
2.37.2

