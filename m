Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55835496C20
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 12:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiAVLZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 06:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiAVLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 06:25:01 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B47C06173D;
        Sat, 22 Jan 2022 03:25:01 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id d5so9100797pjk.5;
        Sat, 22 Jan 2022 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3XDyDuJWLpYr5zIqFPpqMNaYaotTwu4a/tdKPuNOtE=;
        b=cJr/FGdgF4L8mYXHBz/YzvOe7NyfV+045gFKZe2TvhElvpQjh7HTL7isZakkE4BvQx
         hfSeusngDzdqrBBVu54ykdF93uP9K/QUFr+ZScs4k2Y484nNdFS5rIgH9P3CU4ZfB096
         5m5yyHthYmjEbXNbtM9vZGGRNNsIiwMDeFP78Ah87Ek7uknUiuXkcMleLLj6UTcB3q5M
         4yQYngQvkCmd7r5d28dAFBQJeHnpHWiAjh/sNwRezCH0cjLzefw2uJKI/OY+Lf7/qgML
         MtRD/9w11JZcTNpo6+G3iOIwYzF9wMshO0KdHHKMEfNbCNBDsSj6jeYjMz83qDNk6cEa
         f3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3XDyDuJWLpYr5zIqFPpqMNaYaotTwu4a/tdKPuNOtE=;
        b=ior9sENpLQA+SQVP8StLsUjsbS9HrUAmMDXKmqD06xyIssV0xm67Rc8u40v+XwY6YE
         9Ukt+4UXVajTSYBMIwi+c3tQFPJIvRyjYUT3fF6KkOM4BARp3qaOWHCaFMIrfqv5J1Fs
         wjW1K1CX14E7wMxeaHhnNfMHwiobr51YmGSxE5mRA8mUF2/jFWfmT5+C2TyXtyhxuc/0
         dl+Z+41bxo5WK1ATU9t68/TDWeRx74wqnldBZwic30wyNqXBXeOMBinFaWZ5M87bHnIQ
         XVTygv6XQrARG8BcUkU8/roJtWh1X5hsTNHxW5WtHp9ThQXdeWV6CcOJ6GZn2WyE9FHS
         dGNA==
X-Gm-Message-State: AOAM530eYK4LKxDYQc3xsOka6AHvv1RpmJuHokkRlUE+8GFf6jl9UK8F
        GSkNVU8fYczXFvivYkXURuS/0bhwbnYzFA==
X-Google-Smtp-Source: ABdhPJxzSnHKNLdAdzjvrSCvdh0WN9EClPUthGwLkPn022xWPQyGcPocoNbFkvvc1XkZekDMpmfNnA==
X-Received: by 2002:a17:90b:380f:: with SMTP id mq15mr1651973pjb.106.1642850700612;
        Sat, 22 Jan 2022 03:25:00 -0800 (PST)
Received: from lxb-server.lan ([2605:52c0:2:32c::])
        by smtp.gmail.com with ESMTPSA id f6sm9862935pfv.48.2022.01.22.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 03:25:00 -0800 (PST)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jack Pham <jackp@codeaurora.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] usb: gadget: f_uac1: allow changing interface name via configfs
Date:   Sat, 22 Jan 2022 19:24:40 +0800
Message-Id: <20220122112446.1415547-1-t123yh.xyz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds "function_name" configfs entry to change string value
of the iInterface field. This field will be shown in Windows' audio
settings panel, so being able to change it is useful. It will default
to "AC Interface" just as before if unchanged.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 .../ABI/testing/configfs-usb-gadget-uac1      |  1 +
 Documentation/usb/gadget-testing.rst          |  1 +
 drivers/usb/gadget/function/f_uac1.c          | 46 ++++++++++++++++++-
 drivers/usb/gadget/function/u_uac1.h          |  2 +
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index dd647d44d975..ca66623a7700 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -23,4 +23,5 @@ Description:
 		p_volume_res	playback volume control resolution (in 1/256 dB)
 		req_number	the number of pre-allocated request
 				for both capture and playback
+		function_name	name of the interface
 		==========	===================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index c18113077889..2cdb59411929 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -745,6 +745,7 @@ The uac2 function provides these attributes in its function directory:
 	p_volume_res     playback volume control resolution (in 1/256 dB)
 	req_number       the number of pre-allocated request for both capture
 	                 and playback
+    function_name    name of the interface
 	================ ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 5b3502df4e13..b1f9f4d36abb 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -303,7 +303,7 @@ enum {
 };
 
 static struct usb_string strings_uac1[] = {
-	[STR_AC_IF].s = "AC Interface",
+	/* [STR_AC_IF].s = DYNAMIC, */
 	[STR_USB_OUT_IT].s = "Playback Input terminal",
 	[STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
 	[STR_IO_OUT_OT].s = "Playback Output terminal",
@@ -1129,6 +1129,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
 
+	strings_uac1[STR_AC_IF].s = audio_opts->function_name;
+
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
@@ -1413,6 +1415,42 @@ end:									\
 									\
 CONFIGFS_ATTR(f_uac1_opts_, name)
 
+#define UAC1_ATTRIBUTE_STRING(name)					\
+static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
+					 char *page)			\
+{									\
+	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
+	int result;							\
+									\
+	mutex_lock(&opts->lock);					\
+	result = snprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_uac1_opts_##name##_store(struct config_item *item,	\
+					  const char *page, size_t len)	\
+{									\
+	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
+	int ret = 0;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = snprintf(opts->name, min(sizeof(opts->name), len),	\
+			"%s", page);					\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(f_uac1_opts_, name)
+
 UAC1_ATTRIBUTE(u32, c_chmask);
 UAC1_ATTRIBUTE(u32, c_srate);
 UAC1_ATTRIBUTE(u32, c_ssize);
@@ -1432,6 +1470,7 @@ UAC1_ATTRIBUTE(bool, c_volume_present);
 UAC1_ATTRIBUTE(s16, c_volume_min);
 UAC1_ATTRIBUTE(s16, c_volume_max);
 UAC1_ATTRIBUTE(s16, c_volume_res);
+UAC1_ATTRIBUTE_STRING(function_name);
 
 static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_chmask,
@@ -1453,6 +1492,8 @@ static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_volume_min,
 	&f_uac1_opts_attr_c_volume_max,
 	&f_uac1_opts_attr_c_volume_res,
+
+	&f_uac1_opts_attr_function_name,
 
 	NULL,
 };
@@ -1505,6 +1546,9 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	opts->c_volume_res = UAC1_DEF_RES_DB;
 
 	opts->req_number = UAC1_DEF_REQ_NUM;
+
+	snprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
+
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 589fae861141..c94b6da16b68 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -51,6 +51,8 @@ struct f_uac1_opts {
 	int				req_number;
 	unsigned			bound:1;
 
+	char			function_name[32];
+
 	struct mutex			lock;
 	int				refcnt;
 };
-- 
2.25.1

