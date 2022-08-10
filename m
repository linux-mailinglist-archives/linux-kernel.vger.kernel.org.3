Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD31858E6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiHJGBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHJGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:00:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2525FF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:00:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f46b4759bso118251187b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=4jRmKhAnaVbGZ2PreR5yx2mRFJMw6J4dpUJKDGI8VVo=;
        b=OxT4AfmfLdEyfSQy0e92Efv0g+qYB6QYUz9bkXmQdeby668KcDAmVDJ7bOyUq7V0F2
         QALyFz4wMMi53j3QRCAb8qA9F+kZ1RKov1W6yjvk3SKS5E1/4yAukI31vXSaR+iB3oH4
         km0WTV6SkAwda2RS0hxEubyt9id8QjSpq7NCkQLS8tmgOqv78QQNaHTuxCkqp8rBkGOH
         fcESgAQOAIZcbW5as7agp9686kHQSepZw1hJrV0JV73xCs8a7LY61agm1fKZt383OK3W
         84tW+occS8vIst00z0DYIJCMd4j9nmKVCYBFqM+yy8FYxe+FfwkJaFWeg01XxWaXlojV
         Zmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=4jRmKhAnaVbGZ2PreR5yx2mRFJMw6J4dpUJKDGI8VVo=;
        b=UWMqC/FqwPSZskYxi6QYxIp02WQsNJ9XJsuDSHPm57UZ1p5sI0kvuTDjXnoePp9No1
         lrmOZeFdiGpOuuW25pUOXLYAjJI2ENYwO3F6JErD7i9JaB8PvaH/2d4nBiyiZVGXSAOG
         9hAoavfvMCuqJc9MHGy0QG2ds8xYAkhlCiTosf/9dnHIxWm4ZOSVd3BMmUm4jv7rIhh3
         8POQzFYU2u5XnrEnwrwVccLLXwEx58/Tr33qyaT+yuV5E6GF9Dky01e2QJxPMZGMuCob
         Yn70zR8VncgDn5jqxeXTIHzccfdIF35fjifNS2pEefONaxWq00fhT4H/vEB7yPsMk/Pm
         5TLQ==
X-Gm-Message-State: ACgBeo0FltrDdKYSYUww4Cl3jh4a48I+ygkE7uuWjqMTg8lXruY6C7gS
        LLplCYhAkifhDnzuiumEIOuI+N1ELzQciA0=
X-Google-Smtp-Source: AA6agR4LK1d08yF8VFqxVeTLzEMYhLg37uu6dTwQPfrrHS+Sz8rRBpZ19EPAFfrDH7CMKMId84Ir4l+P4wWpB8o=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a05:6902:108c:b0:67b:bc33:ef01 with SMTP
 id v12-20020a056902108c00b0067bbc33ef01mr15758584ybu.251.1660111253153; Tue,
 09 Aug 2022 23:00:53 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:31 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 2/9] driver core: fw_devlink: Improve check for fwnode with
 no device/driver
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink shouldn't defer the probe of a device to wait on a supplier
that'll never have a struct device or will never be probed by a driver.
We currently check if a supplier falls into this category, but don't
check its ancestors. We need to check the ancestors too because if the
ancestor will never probe, then the supplier will never probe either.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6f575c2a24ad..8ec2236b1f9c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1866,6 +1866,35 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+	bool ret;
+
+	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+		return false;
+
+	dev = get_dev_from_fwnode(fwnode);
+	ret = !dev || dev->links.status == DL_DEV_NO_DRIVER;
+	put_device(dev);
+
+	return ret;
+}
+
+static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+
+	fwnode_for_each_parent_node(fwnode, parent) {
+		if (fwnode_init_without_drv(parent)) {
+			fwnode_handle_put(parent);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
@@ -1943,9 +1972,16 @@ static int fw_devlink_create_devlink(struct device *con,
 		goto out;
 	}
 
-	/* Supplier that's already initialized without a struct device. */
-	if (sup_handle->flags & FWNODE_FLAG_INITIALIZED)
+	/*
+	 * Supplier or supplier's ancestor already initialized without a struct
+	 * device or being probed by a driver.
+	 */
+	if (fwnode_init_without_drv(sup_handle) ||
+	    fwnode_ancestor_init_without_drv(sup_handle)) {
+		dev_dbg(con, "Not linking %pfwP - Might never probe\n",
+			sup_handle);
 		return -EINVAL;
+	}
 
 	/*
 	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
-- 
2.37.1.559.g78731f0fdb-goog

