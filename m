Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A945832B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiG0TDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiG0TCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F8B50181
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:19:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31dfe25bd47so143133387b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rft0qT+eTQrjzwXUJvwNiWLDtbj8bhCn91PlOIVUvGQ=;
        b=tTLoU+0fnCtq7N0iBtEJa5JLly3sAsLQ4L6JfPyJGH09Gn7sjoNj/rU6GJC4wf1wyg
         Er4CGSQtJHL0R1z1YY7TQEG779vAyyGlHz4DOPM1ihY2jw+5AZyY1KD8LeA626U8scAa
         CZZxmuOKTN8K+SJ/xqkTY2vXRO/3ksEVGNzLvMBUDYM9iY0GRNNawZw8ktacrp8It9an
         h+hwguAh3n5vh/SU1EN2bkZB8OuB8EgF25CkQ3i6MMGJZIXcHvEE089vEyeDux3FAs0o
         S1yF6bW9jBNtGASU9elbqIBbk6uH7RI3uW6hUgV2zGvJ3f7RhpWdiVUEYATecqhTxH8F
         X1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rft0qT+eTQrjzwXUJvwNiWLDtbj8bhCn91PlOIVUvGQ=;
        b=MzMA8l+noiS4/xCRjz4VBKFkQ0Gr7s5OmRCHiFWSlsjcQL6iTqNX6az8WLZ02e99wC
         mbWVmf1ceDRrqxO0dc8QGgUhp597hhT2hR+Tq4m6cy7Te9elOZHYirmk8wWtwBR5rRI+
         IMsnoMjnd6xy8lHyQsAwN9RfQsdGs0bTQr00Mear7sLc38zlvOh3FTWXpLg4cWCVBb/m
         azPxCV7m5G73u7RLZh2xLgC2VqbJMPee2aR09KRttkdqU3fGyVO3Z8BIkpIiGMqPH18o
         K82HtWwE5uR44AwsEzFHKFYgyJAtQ9fWQZZPZPBXQRvF1BYyZJOx28ecnU3eC/p+m524
         Schg==
X-Gm-Message-State: AJIora8Nqnx31eloUF/Y1sz/KCw5zHOXviyh1alVKwEW9GWnZUo9awIO
        9LDg00OXQjW5KvvrUPCZHUHaTXo9xDWg1sE=
X-Google-Smtp-Source: AGRyM1uSnMDerCPioFeVO7R4JqhvfbHhTM7kXczEDxm/vt4AYO+9Y6YXrH1OqQ3qtjY6B/biWVIbElvfZmxCI7w=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:40ee:bae0:a4fd:c75b])
 (user=saravanak job=sendgmr) by 2002:a25:a4a4:0:b0:671:833e:eac7 with SMTP id
 g33-20020a25a4a4000000b00671833eeac7mr2922711ybi.372.1658945980553; Wed, 27
 Jul 2022 11:19:40 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:19:35 -0700
Message-Id: <20220727181936.3250466-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6] amba: Remove deferred device addition
From:   Saravana Kannan <saravanak@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uevents generated for an amba device need PID and CID information
that's available only when the amba device is powered on, clocked and
out of reset. So, if those resources aren't available, the information
can't be read to generate the uevents. To workaround this requirement,
if the resources weren't available, the device addition was deferred and
retried periodically.

However, this deferred addition retry isn't based on resources becoming
available. Instead, it's retried every 5 seconds and causes arbitrary
probe delays for amba devices and their consumers.

Also, maintaining a separate deferred-probe like mechanism is
maintenance headache.

With this commit, instead of deferring the device addition, we simply
defer the generation of uevents for the device and probing of the device
(because drivers needs PID and CID to match) until the PID and CID
information can be read. This allows us to delete all the amba specific
deferring code and also avoid the arbitrary probing delays.

Cc: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: patches@armlinux.org.uk
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
KernelVersion: rmk/for-next
---
 drivers/amba/bus.c | 313 +++++++++++++++++++++------------------------
 1 file changed, 145 insertions(+), 168 deletions(-)

v1 -> v2:
- Dropped RFC tag
- Complete rewrite to not use stub devices.

v2 -> v3:
- Flipped the if() condition for hard-coded periphids.
- Added a stub driver to handle the case where all amba drivers are
  modules loaded by uevents.
- Cc Marek after I realized I forgot to add him.

v3 -> v4:
- Finally figured out and fixed the issue reported by Kefeng (bus match
  can't return an error other than -EPROBE_DEFER).
- I tested the patch on "V2P-CA15" on qemu
- Marek tested v3, but that was so long ago and the rebase wasn't clean,
  so I didn't include the tested-by.

v4 -> v5:
- Fixed up amba_match() to always return -EPROBE_DEFER on any failure.
  This fixes the issue Sudeep reported on Juno.
- Rebased the patch on top of Russell's for-next branch to avoid
  conflict with linux-next.

v5 -> v6:
- Added Sudeep's Tested-by.
- Cc patches@armlinux.org.uk
- Added KernelVersion

Russell,

Hopefully I got everything right. Please let me know if I need to do
anything else for this to be picked up.

-Saravana

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0cb20324da16..32b0e0b930c1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -130,11 +130,100 @@ static struct attribute *amba_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(amba_dev);
 
+static int amba_read_periphid(struct amba_device *dev)
+{
+	struct reset_control *rstc;
+	u32 size, pid, cid;
+	void __iomem *tmp;
+	int i, ret;
+
+	ret = dev_pm_domain_attach(&dev->dev, true);
+	if (ret) {
+		dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
+		goto err_out;
+	}
+
+	ret = amba_get_enable_pclk(dev);
+	if (ret) {
+		dev_dbg(&dev->dev, "can't get pclk: %d\n", ret);
+		goto err_pm;
+	}
+
+	/*
+	 * Find reset control(s) of the amba bus and de-assert them.
+	 */
+	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&dev->dev, "can't get reset: %d\n", ret);
+		goto err_clk;
+	}
+	reset_control_deassert(rstc);
+	reset_control_put(rstc);
+
+	size = resource_size(&dev->res);
+	tmp = ioremap(dev->res.start, size);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
+
+	/*
+	 * Read pid and cid based on size of resource
+	 * they are located at end of region
+	 */
+	for (pid = 0, i = 0; i < 4; i++)
+		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
+	for (cid = 0, i = 0; i < 4; i++)
+		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
+
+	if (cid == CORESIGHT_CID) {
+		/* set the base to the start of the last 4k block */
+		void __iomem *csbase = tmp + size - 4096;
+
+		dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
+		dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+	}
+
+	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
+		dev->periphid = pid;
+		dev->cid = cid;
+	}
+
+	if (!dev->periphid)
+		ret = -ENODEV;
+
+	iounmap(tmp);
+
+err_clk:
+	amba_put_disable_pclk(dev);
+err_pm:
+	dev_pm_domain_detach(&dev->dev, true);
+err_out:
+	return ret;
+}
+
 static int amba_match(struct device *dev, struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
 
+	if (!pcdev->periphid) {
+		int ret = amba_read_periphid(pcdev);
+
+		/*
+		 * Returning any error other than -EPROBE_DEFER from bus match
+		 * can cause driver registration failure. So, if there's a
+		 * permanent failure in reading pid and cid, simply map it to
+		 * -EPROBE_DEFER.
+		 */
+		if (ret)
+			return -EPROBE_DEFER;
+		dev_set_uevent_suppress(dev, false);
+		kobject_uevent(&dev->kobj, KOBJ_ADD);
+	}
+
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
 		return !strcmp(pcdev->driver_override, drv->name);
@@ -368,6 +457,42 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
+static int amba_proxy_probe(struct amba_device *adev,
+			    const struct amba_id *id)
+{
+	WARN(1, "Stub driver should never match any device.\n");
+	return -ENODEV;
+}
+
+static const struct amba_id amba_stub_drv_ids[] = {
+	{ 0, 0 },
+};
+
+static struct amba_driver amba_proxy_drv = {
+	.drv = {
+		.name = "amba-proxy",
+	},
+	.probe = amba_proxy_probe,
+	.id_table = amba_stub_drv_ids,
+};
+
+static int __init amba_stub_drv_init(void)
+{
+	if (!IS_ENABLED(CONFIG_MODULES))
+		return 0;
+
+	/*
+	 * The amba_match() function will get called only if there is at least
+	 * one amba driver registered. If all amba drivers are modules and are
+	 * only loaded based on uevents, then we'll hit a chicken-and-egg
+	 * situation where amba_match() is waiting on drivers and drivers are
+	 * waiting on amba_match(). So, register a stub driver to make sure
+	 * amba_match() is called even if no amba driver has been registered.
+	 */
+	return amba_driver_register(&amba_proxy_drv);
+}
+late_initcall_sync(amba_stub_drv_init);
+
 /**
  *	amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure
@@ -410,156 +535,6 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-static int amba_read_periphid(struct amba_device *dev)
-{
-	struct reset_control *rstc;
-	u32 size, pid, cid;
-	void __iomem *tmp;
-	int i, ret;
-
-	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret)
-		goto err_out;
-
-	ret = amba_get_enable_pclk(dev);
-	if (ret)
-		goto err_pm;
-
-	/*
-	 * Find reset control(s) of the amba bus and de-assert them.
-	 */
-	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&dev->dev, "can't get reset: %d\n", ret);
-		goto err_clk;
-	}
-	reset_control_deassert(rstc);
-	reset_control_put(rstc);
-
-	size = resource_size(&dev->res);
-	tmp = ioremap(dev->res.start, size);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto err_clk;
-	}
-
-	/*
-	 * Read pid and cid based on size of resource
-	 * they are located at end of region
-	 */
-	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
-	for (cid = 0, i = 0; i < 4; i++)
-		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
-
-	if (cid == CORESIGHT_CID) {
-		/* set the base to the start of the last 4k block */
-		void __iomem *csbase = tmp + size - 4096;
-
-		dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
-		dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
-	}
-
-	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
-		dev->periphid = pid;
-		dev->cid = cid;
-	}
-
-	if (!dev->periphid)
-		ret = -ENODEV;
-
-	iounmap(tmp);
-
-err_clk:
-	amba_put_disable_pclk(dev);
-err_pm:
-	dev_pm_domain_detach(&dev->dev, true);
-err_out:
-	return ret;
-}
-
-static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
-{
-	int ret;
-
-	ret = request_resource(parent, &dev->res);
-	if (ret)
-		goto err_out;
-
-	/* Hard-coded primecell ID instead of plug-n-play */
-	if (dev->periphid != 0)
-		goto skip_probe;
-
-	ret = amba_read_periphid(dev);
-	if (ret)
-		goto err_release;
-
-skip_probe:
-	ret = device_add(&dev->dev);
-err_release:
-	if (ret)
-		release_resource(&dev->res);
-err_out:
-	return ret;
-}
-
-/*
- * Registration of AMBA device require reading its pid and cid registers.
- * To do this, the device must be turned on (if it is a part of power domain)
- * and have clocks enabled. However in some cases those resources might not be
- * yet available. Returning EPROBE_DEFER is not a solution in such case,
- * because callers don't handle this special error code. Instead such devices
- * are added to the special list and their registration is retried from
- * periodic worker, until all resources are available and registration succeeds.
- */
-struct deferred_device {
-	struct amba_device *dev;
-	struct resource *parent;
-	struct list_head node;
-};
-
-static LIST_HEAD(deferred_devices);
-static DEFINE_MUTEX(deferred_devices_lock);
-
-static void amba_deferred_retry_func(struct work_struct *dummy);
-static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
-
-#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
-
-static int amba_deferred_retry(void)
-{
-	struct deferred_device *ddev, *tmp;
-
-	mutex_lock(&deferred_devices_lock);
-
-	list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
-		int ret = amba_device_try_add(ddev->dev, ddev->parent);
-
-		if (ret == -EPROBE_DEFER)
-			continue;
-
-		list_del_init(&ddev->node);
-		amba_device_put(ddev->dev);
-		kfree(ddev);
-	}
-
-	mutex_unlock(&deferred_devices_lock);
-
-	return 0;
-}
-late_initcall(amba_deferred_retry);
-
-static void amba_deferred_retry_func(struct work_struct *dummy)
-{
-	amba_deferred_retry();
-
-	if (!list_empty(&deferred_devices))
-		schedule_delayed_work(&deferred_retry_work,
-				      DEFERRED_DEVICE_TIMEOUT);
-}
-
 /**
  *	amba_device_add - add a previously allocated AMBA device structure
  *	@dev: AMBA device allocated by amba_device_alloc
@@ -571,28 +546,30 @@ static void amba_deferred_retry_func(struct work_struct *dummy)
  */
 int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
-	int ret = amba_device_try_add(dev, parent);
-
-	if (ret == -EPROBE_DEFER) {
-		struct deferred_device *ddev;
-
-		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
-		if (!ddev)
-			return -ENOMEM;
+	int ret;
 
-		ddev->dev = dev;
-		ddev->parent = parent;
-		ret = 0;
+	ret = request_resource(parent, &dev->res);
+	if (ret)
+		return ret;
 
-		mutex_lock(&deferred_devices_lock);
+	/* If primecell ID isn't hard-coded, figure it out */
+	if (!dev->periphid) {
+		/*
+		 * AMBA device uevents require reading its pid and cid
+		 * registers.  To do this, the device must be on, clocked and
+		 * out of reset.  However in some cases those resources might
+		 * not yet be available.  If that's the case, we suppress the
+		 * generation of uevents until we can read the pid and cid
+		 * registers.  See also amba_match().
+		 */
+		if (amba_read_periphid(dev))
+			dev_set_uevent_suppress(&dev->dev, true);
+	}
 
-		if (list_empty(&deferred_devices))
-			schedule_delayed_work(&deferred_retry_work,
-					      DEFERRED_DEVICE_TIMEOUT);
-		list_add_tail(&ddev->node, &deferred_devices);
+	ret = device_add(&dev->dev);
+	if (ret)
+		release_resource(&dev->res);
 
-		mutex_unlock(&deferred_devices_lock);
-	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(amba_device_add);
-- 
2.37.1.359.gd136c6c3e2-goog

