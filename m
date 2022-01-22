Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57EE496C23
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 12:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiAVLZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiAVLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 06:25:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE07C06173B;
        Sat, 22 Jan 2022 03:25:21 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e28so6806781pfj.5;
        Sat, 22 Jan 2022 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/4VnUAXL5ONgzX9ydAg0PKaB9FlIr5gjgL4EP+vufg=;
        b=EOeXh5KxL7YK0fjfhOeEkIJhpNFS3FvfkSVD70lf8dWn+iAknt9bZFwdbqrBcQLX5o
         uytSN74w4KCBlB8mNuPeb5EUbudUiP3N2s/V/s9D1JANH0y/MI6P8TM6oOaNtwqDhWTa
         McvIZKJ+n5YipFlJ5snVBRG4DEz9Qn3PJqKdEJhRMRIQvkYXz91scJ697es8xvF1oIQo
         6x7eTQo9FcT7XvCXQcsBYRM3FuYzYSRWuGN9g5CKO4UL5aCjuNn6s7iXKJuU5gBdwF9P
         CSXo8YNoeX84jkIxGVWcBIeWhRZIeHI+9edGkoMBfvrZWk3nPJNEi1Pe1GHhq2LguAR3
         K0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/4VnUAXL5ONgzX9ydAg0PKaB9FlIr5gjgL4EP+vufg=;
        b=YeRMlYuB5yBFjeRgQRzB8TY/58x5S8IvhCQmI+6mlyaodHnN03MIvsgqlZHzTUu5c/
         NIiH/AwqBkBFVGdrFLVyp8j57KPoqg9Ik5rVxt8RTJj46vsT+Jc/NVqCzVQkZNM5k8IS
         lc4zTk5xh+jj944AvZ+iadpjSnI2L9mCRfkUmh92qKT/kZb4jXcqvzfS8u4XLk0jHm0c
         LJy7k76uBCwgger7chK/BXObNCQqONbKN5/Zv9v1R1bPW0vfG/Zi99QyhvENgGpB8zRS
         TF+a0+o2fNohGG2kW/sv7+6Npvtzx6yrwYEZdx3iVnLqL14mDG4aL3/LB543jahOLC4C
         xWOA==
X-Gm-Message-State: AOAM533YboK2QnW6wBNfMfVgnJwJ54CBe0rfZ60tquO20JICOmkEzl6o
        WLW4SNAIq3Oy6aCGiBekEQyDVu+0qBkWIA==
X-Google-Smtp-Source: ABdhPJxIifEA7bEf/l5XYeIOQ7mP5nOrp06jkC+e6x5uUaFIjgXldGwIs7Z3yJ3dmp7Zr2GJYdKBrw==
X-Received: by 2002:a63:4456:: with SMTP id t22mr5739132pgk.52.1642850720651;
        Sat, 22 Jan 2022 03:25:20 -0800 (PST)
Received: from lxb-server.lan ([2605:52c0:2:32c::])
        by smtp.gmail.com with ESMTPSA id f6sm9862935pfv.48.2022.01.22.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 03:25:20 -0800 (PST)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Jack Pham <jackp@codeaurora.org>,
        Colin Ian King <colin.king@canonical.com>,
        Pawel Laszczak <pawell@cadence.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] usb: gadget: f_uac2: allow changing interface name via configfs
Date:   Sat, 22 Jan 2022 19:24:41 +0800
Message-Id: <20220122112446.1415547-2-t123yh.xyz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122112446.1415547-1-t123yh.xyz@gmail.com>
References: <20220122112446.1415547-1-t123yh.xyz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds "function_name" configfs entry to change string value
of the iInterface field. This field will be shown in Windows' audio
settings panel, so being able to change it is useful. It will default
to "Source/Sink" just as before.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 .../ABI/testing/configfs-usb-gadget-uac2      |  1 +
 Documentation/usb/gadget-testing.rst          |  1 +
 drivers/usb/gadget/function/f_uac2.c          | 46 ++++++++++++++++++-
 drivers/usb/gadget/function/u_uac2.h          |  2 +
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index cfd160ff8b56..3524f2b8446a 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -23,4 +23,5 @@ Description:
 		p_volume_min	playback volume control min value (in 1/256 dB)
 		p_volume_max	playback volume control max value (in 1/256 dB)
 		p_volume_res	playback volume control resolution (in 1/256 dB)
+		function_name	name of the interface
 		=========  ============================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 2cdb59411929..6df834f87bf2 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -934,6 +934,7 @@ The uac1 function provides these attributes in its function directory:
 	p_volume_res     playback volume control resolution (in 1/256 dB)
 	req_number       the number of pre-allocated request for both capture
 	                 and playback
+	function_name    name of the interface
 	================ ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index ef55b8bb5870..8f72ef361882 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -107,7 +107,7 @@ static char clksrc_in[8];
 static char clksrc_out[8];
 
 static struct usb_string strings_fn[] = {
-	[STR_ASSOC].s = "Source/Sink",
+	/* [STR_ASSOC].s = DYNAMIC, */
 	[STR_IF_CTRL].s = "Topology Control",
 	[STR_CLKSRC_IN].s = clksrc_in,
 	[STR_CLKSRC_OUT].s = clksrc_out,
@@ -959,6 +959,8 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	if (ret)
 		return ret;
 
+	strings_fn[STR_ASSOC].s = uac2_opts->function_name;
+
 	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
@@ -1834,6 +1836,42 @@ end:									\
 									\
 CONFIGFS_ATTR(f_uac2_opts_, name)
 
+#define UAC2_ATTRIBUTE_STRING(name)					\
+static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
+					 char *page)			\
+{									\
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
+	int result;							\
+									\
+	mutex_lock(&opts->lock);					\
+	result = snprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
+					  const char *page, size_t len)	\
+{									\
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
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
+CONFIGFS_ATTR(f_uac2_opts_, name)
+
 UAC2_ATTRIBUTE(u32, p_chmask);
 UAC2_ATTRIBUTE(u32, p_srate);
 UAC2_ATTRIBUTE(u32, p_ssize);
@@ -1855,6 +1893,7 @@ UAC2_ATTRIBUTE(s16, c_volume_min);
 UAC2_ATTRIBUTE(s16, c_volume_max);
 UAC2_ATTRIBUTE(s16, c_volume_res);
 UAC2_ATTRIBUTE(u32, fb_max);
+UAC2_ATTRIBUTE_STRING(function_name);
 
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
@@ -1879,6 +1918,8 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_c_volume_max,
 	&f_uac2_opts_attr_c_volume_res,
 
+	&f_uac2_opts_attr_function_name,
+
 	NULL,
 };
 
@@ -1932,6 +1973,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 
 	opts->req_number = UAC2_DEF_REQ_NUM;
 	opts->fb_max = UAC2_DEF_FB_MAX;
+
+	snprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
+
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index a73b35774c44..4df23262db6e 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -59,6 +59,8 @@ struct f_uac2_opts {
 	int				fb_max;
 	bool			bound;
 
+	char			function_name[32];
+
 	struct mutex			lock;
 	int				refcnt;
 };
-- 
2.25.1

