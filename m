Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96958E715
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiHJGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiHJGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:01:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9F26AF1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:01:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f4b76446aso117732177b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=vx+dUbGYOv+iuawfVE7Ay+tk/KEU0DVIy9gKSjJSbfM=;
        b=DHsiPm8AGi/hRuAdwy5HbH6s2r/Oy5+6hpbTVaZ+kokvPnDRVEbJgOyfLDYxmu38/4
         6c/USgm4pyf2vbNHq2+wO1DqxDN5IleK1JLrmt4AmI8cQZgYb+f2P8+NrSaqXDmNELCn
         CG/sox7zZCWs8YPB3eduZ7lrqv9LIN7coqgFfSQDtS+H7/JcQsLLKRN2VBjD4MmQ7DpP
         V+5QayoprOrleKbfgiC/nxCDcHAwk4cSCm1cUXlQqVrZJZ//d/l82UMam/ZZEF7Q/FKj
         9IuQ3rPDGmmZL1xAEzGgeod2tuD2Rqc7w2LAiEWL8rfN2QjYE28QmkM4/wTaMPoRbas6
         UhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=vx+dUbGYOv+iuawfVE7Ay+tk/KEU0DVIy9gKSjJSbfM=;
        b=rg09aTUe+wE7xzt8vmnJlNbAFIgme+COomEhxhDFB9EQj6maoRT83ep6sLuIRi95mr
         6UPCi5WtSudBMQl9efekkmngYSkQ4B7mGsJB380t1oMMNFBMkSnxRKmAzIEHQWk6AAIb
         mNYtUGuaAH2OWZgMIv10QMn/UgNF62UJVYxQRYyqnL7cHGA5epuGvnaJBgg+cylTpPHa
         vfMAEQ3O2vF8NqdCch0fA60VWsslwlW/Up9siNLg2gMR1Z6XSveA+coBaP8Tj1UM/XcN
         Y3BV5gPQMKllxgjHmI3lD17u9yTZE0EB1aiwZzVIF9BIE61AfDRFKeLEiyNHaNOlY64a
         7F3A==
X-Gm-Message-State: ACgBeo3EnSXpVDtBEfOenHFPaT1bEtp4W5boijAlgqWdiWoZNCqV6WJ3
        Dd+JUrKuHyenM+qNhWiwfb8eU637QGiiUBc=
X-Google-Smtp-Source: AA6agR4Khze5AtD+WD0fh1ffw9yPithpzLXIHHaEEIY0YlMjElr9n+/FhIjncVMO9+wvqV/HHySsaIt/gn01T+Q=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a5b:b8e:0:b0:67c:237b:760b with SMTP id
 l14-20020a5b0b8e000000b0067c237b760bmr5624436ybq.627.1660111274504; Tue, 09
 Aug 2022 23:01:14 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:38 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-10-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 9/9] of: property: Simplify of_link_to_phandle()
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

The driver core now:
- Has the parent device of a supplier pick up the consumers if the
  supplier never has a device created for it.
- Ignores a supplier if the supplier has no parent device and will never
  be probed by a driver

And already prevents creating a device link with the consumer as a
supplier of a parent.

So, we no longer need to find the "compatible" node of the supplier or
do any other checks in of_link_to_phandle(). We simply need to make sure
that the supplier is available in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 84 +++++++------------------------------------
 1 file changed, 13 insertions(+), 71 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 967f79b59016..98ca0399a354 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1060,20 +1060,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 	return of_device_get_match_data(dev);
 }
 
-static bool of_is_ancestor_of(struct device_node *test_ancestor,
-			      struct device_node *child)
-{
-	of_node_get(child);
-	while (child) {
-		if (child == test_ancestor) {
-			of_node_put(child);
-			return true;
-		}
-		child = of_get_next_parent(child);
-	}
-	return false;
-}
-
 static struct device_node *of_get_compat_node(struct device_node *np)
 {
 	of_node_get(np);
@@ -1104,71 +1090,27 @@ static struct device_node *of_get_compat_node_parent(struct device_node *np)
 	return node;
 }
 
-/**
- * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
- * @con_np: consumer device tree node
- * @sup_np: supplier device tree node
- *
- * Given a phandle to a supplier device tree node (@sup_np), this function
- * finds the device that owns the supplier device tree node and creates a
- * device link from @dev consumer device to the supplier device. This function
- * doesn't create device links for invalid scenarios such as trying to create a
- * link with a parent device as the consumer of its child device. In such
- * cases, it returns an error.
- *
- * Returns:
- * - 0 if fwnode link successfully created to supplier
- * - -EINVAL if the supplier link is invalid and should not be created
- * - -ENODEV if struct device will never be create for supplier
- */
-static int of_link_to_phandle(struct device_node *con_np,
+static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np)
 {
-	struct device *sup_dev;
-	struct device_node *tmp_np = sup_np;
+	struct device_node *tmp_np = of_node_get(sup_np);
 
-	/*
-	 * Find the device node that contains the supplier phandle.  It may be
-	 * @sup_np or it may be an ancestor of @sup_np.
-	 */
-	sup_np = of_get_compat_node(sup_np);
-	if (!sup_np) {
-		pr_debug("Not linking %pOFP to %pOFP - No device\n",
-			 con_np, tmp_np);
-		return -ENODEV;
-	}
+	/* Check that sup_np and its ancestors are available. */
+	while (tmp_np) {
+		if (of_fwnode_handle(tmp_np)->dev) {
+			of_node_put(tmp_np);
+			break;
+		}
 
-	/*
-	 * Don't allow linking a device node as a consumer of one of its
-	 * descendant nodes. By definition, a child node can't be a functional
-	 * dependency for the parent node.
-	 */
-	if (of_is_ancestor_of(con_np, sup_np)) {
-		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -EINVAL;
-	}
+		if (!of_device_is_available(tmp_np)) {
+			of_node_put(tmp_np);
+			return;
+		}
 
-	/*
-	 * Don't create links to "early devices" that won't have struct devices
-	 * created for them.
-	 */
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	if (!sup_dev &&
-	    (of_node_check_flag(sup_np, OF_POPULATED) ||
-	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
-		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
-			 con_np, sup_np);
-		of_node_put(sup_np);
-		return -ENODEV;
+		tmp_np = of_get_next_parent(tmp_np);
 	}
-	put_device(sup_dev);
 
 	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
-	of_node_put(sup_np);
-
-	return 0;
 }
 
 /**
-- 
2.37.1.559.g78731f0fdb-goog

