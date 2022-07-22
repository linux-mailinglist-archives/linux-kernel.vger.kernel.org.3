Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F057D800
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiGVB1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGVB1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:27:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF618383
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:27:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y9so3246322pff.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x74EByhAjUR4S4QERukbdXYXC+VGF9BbefPOBdSvQY=;
        b=AXbx6IKULGDWhEYtsxIdDwmvPAyndqX7jtFA4ZyAElg8ijCrdu9LSwjjIs9zVG9LYM
         B4/WkK4s68SY2pD5azZqc8CGtkJYQA/3XFVRQSmsgW/EzrvHkSynhzCWZxwYi7lUbQYD
         A0xgaVvHi4Z1l9iDuhP+BoEq4j54XZAIb9SKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x74EByhAjUR4S4QERukbdXYXC+VGF9BbefPOBdSvQY=;
        b=x8Yd7XZkDxKYNSkK2DEq3ibWFEN/8JV3kLl8wgPbERcnkhXpppUfGjBo7qjiqGFPXZ
         2r6boVpFfW/9JtsBn4h94fF7GFcOTp8wsk98KJgxxHAVLwsgc0jPdB+ghHQH5TMdGLYo
         59bmyOrjpObf7YUNTFJiH9CcQNZjfmWJwM1Bwk+GdcN4Z+du/dzLWSZizbUT1pRT/aJL
         tb3VEHLYti9GKHNHzQwtt80c3aoeg+61kLwCTVU0iF3MsEM5DEbbRa4KGxTk7Wsha5Zc
         EmdSTR5p/iqfNQm+ihFBwsqnk3IksRNknrI4RWynFyuvKeZE1EzDJdHjgsKeUYw4FvE2
         egKw==
X-Gm-Message-State: AJIora8dhFi2iv5O6UvvkHJxGx8HvfD9dfqqcnlafSBFT2Mj45529a6n
        Kcaab9iSWym1/NsH2boFVb5RqQ==
X-Google-Smtp-Source: AGRyM1tN7kDgJ29s153VKEAFmAloSz/yKtt427YY6GP9JQbPm09UKAfUrqBhtkMYETa36XtdYC1wlA==
X-Received: by 2002:a63:3d8:0:b0:412:9a7b:685a with SMTP id 207-20020a6303d8000000b004129a7b685amr1035168pgd.73.1658453226738;
        Thu, 21 Jul 2022 18:27:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:29c7:7a23:197d:913d])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090ab90200b001f0097c2fb2sm2052832pjr.28.2022.07.21.18.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 18:27:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] regulator: core: Allow for a base-load per client to come from dts
Date:   Thu, 21 Jul 2022 18:26:44 -0700
Message-Id: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through the current users of regulator_set_load(), all but one
or two basically follow the pattern:

1. Get all the regulators.
2. Go through each regulator and call regulator_set_load() on it with
   some value that's sufficient to get the regulator to run in "HPM"
   mode.
3. Enable / disable the regulator as needed.

Specifically it should be noted that many devices don't really have a
need for the low power mode of regulators. Unfortunately the current
state of the world means that all drivers are cluttered with tables of
loads and extra cruft at init time to tell the regulator framework
about said loads.

Let's add a way to specify the "base load" of a regulator in the
device tree and hopefully make this a bit better.

There are lots of ways we could combine this "base load" with a load
that the driver requests. We could:
- Add them.
- Take the maximum (assume that the "base" is the min).
- Only use the "base" load if the driver didn't request one.

I have chosen the third option here. If the driver knows better then
it can override. Note that the driver can't override to "0". To do
that it would just disable the regulator.

The choice above means that we can effectively treat the "base" load
as the "normal usage" load. It's expected that with this load set we
could use the device normally. If a driver could go into a low power
state then it would only need to set a load when in that low power
state and it could effectively set its requested load back to 0
afterwards and the system would bounce back to the base
load. Presumably someone could also set the load higher than the base
before putting a device in "turbo mode".

This property is specified as a separate property from the supply
because it's expected that the load for a peripheral could be
specified in a SoC's dtsi file. As an example:

SoC.dtsi:
  nifty_phy: phy@1234 {
    vdda-phy-base-load = <21800>;
  };

Board.dts:
  &nifty_phy {
    vdda-phy-supply = <&pp1800_l4a>;
  };

NOTE: if we want to keep old binary dtb files working with new kernels
then we'd still have to keep existing crufty regulator_set_load() in
drivers, but hopefully we can stop adding new instances of this, and
perhaps eventually people will agree to deprecate old binary dtb files
and we can get rid of all the extra code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I have only done incredibly light testing with this but I wanted to
get the idea out there. We'd obviously need to get device-tree folks
on board with this and adjust the dt-schema for it.

 drivers/regulator/core.c     | 65 ++++++++++++++++++++++++++++--------
 drivers/regulator/internal.h |  1 +
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f2cf..cc817f5efc77 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -94,7 +94,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 				     suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
-					  const char *supply_name);
+					  const char *supply_name,
+					  int uA_base_load);
 static void destroy_regulator(struct regulator *regulator);
 static void _regulator_put(struct regulator *regulator);
 
@@ -417,6 +418,29 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 	return regnode;
 }
 
+static int of_get_regulator_base_load(struct device *dev, const char *supply)
+{
+	char prop_name[64]; /* 64 is max size of property name */
+	u32 pval = 0;
+
+	snprintf(prop_name, 64, "%s-base-load", supply);
+	of_property_read_u32(dev->of_node, prop_name, &pval);
+
+	dev_dbg(dev, "Looking up %s-base-load from device tree: %d\n",
+		supply, (int)pval);
+
+	return pval;
+}
+
+static int regulator_eff_load(const struct regulator *regulator)
+{
+	/*
+	 * If a load has been specified then use that; otherwise fall back
+	 * to the base load.
+	 */
+	return regulator->uA_load ? regulator->uA_load : regulator->uA_base_load;
+}
+
 /* Platform voltage constraint check */
 int regulator_check_voltage(struct regulator_dev *rdev,
 			    int *min_uV, int *max_uV)
@@ -774,7 +798,7 @@ static ssize_t requested_microamps_show(struct device *dev,
 	regulator_lock(rdev);
 	list_for_each_entry(regulator, &rdev->consumer_list, list) {
 		if (regulator->enable_count)
-			uA += regulator->uA_load;
+			uA += regulator_eff_load(regulator);
 	}
 	regulator_unlock(rdev);
 	return sprintf(buf, "%d\n", uA);
@@ -965,7 +989,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	/* calc total requested load */
 	list_for_each_entry(sibling, &rdev->consumer_list, list) {
 		if (sibling->enable_count)
-			current_uA += sibling->uA_load;
+			current_uA += regulator_eff_load(sibling);
 	}
 
 	current_uA += rdev->constraints->system_load;
@@ -1604,13 +1628,14 @@ static int set_machine_constraints(struct regulator_dev *rdev)
  * set_supply - set regulator supply regulator
  * @rdev: regulator name
  * @supply_rdev: supply regulator name
+ * @uA_base_load: default load to apply when we need the supply
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
  * core if it's child is enabled.
  */
 static int set_supply(struct regulator_dev *rdev,
-		      struct regulator_dev *supply_rdev)
+		      struct regulator_dev *supply_rdev, int uA_base_load)
 {
 	int err;
 
@@ -1619,7 +1644,8 @@ static int set_supply(struct regulator_dev *rdev,
 	if (!try_module_get(supply_rdev->owner))
 		return -ENODEV;
 
-	rdev->supply = create_regulator(supply_rdev, &rdev->dev, "SUPPLY");
+	rdev->supply = create_regulator(supply_rdev, &rdev->dev, "SUPPLY",
+					uA_base_load);
 	if (rdev->supply == NULL) {
 		err = -ENOMEM;
 		return err;
@@ -1769,7 +1795,8 @@ static const struct file_operations constraint_flags_fops = {
 
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
-					  const char *supply_name)
+					  const char *supply_name,
+					  int uA_base_load)
 {
 	struct regulator *regulator;
 	int err = 0;
@@ -1800,6 +1827,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
+	regulator->uA_base_load = uA_base_load;
 
 	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
@@ -1825,6 +1853,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	} else {
 		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
 				   &regulator->uA_load);
+		debugfs_create_u32("uA_base_load", 0444, regulator->debugfs,
+				   &regulator->uA_base_load);
 		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
 				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
 		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
@@ -1968,6 +1998,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	int uA_base_load;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -1997,6 +2028,8 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 	}
 
+	uA_base_load = of_get_regulator_base_load(dev, rdev->supply_name);
+
 	if (r == rdev) {
 		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
 			rdev->desc->name, rdev->supply_name);
@@ -2043,7 +2076,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		goto out;
 	}
 
-	ret = set_supply(rdev, r);
+	ret = set_supply(rdev, r, uA_base_load);
 	if (ret < 0) {
 		regulator_unlock(rdev);
 		put_device(&r->dev);
@@ -2077,6 +2110,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
 	struct device_link *link;
+	int uA_base_load;
 	int ret;
 
 	if (get_type >= MAX_GET_TYPE) {
@@ -2128,6 +2162,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		}
 	}
 
+	uA_base_load = of_get_regulator_base_load(dev, id);
+
 	if (rdev->exclusive) {
 		regulator = ERR_PTR(-EPERM);
 		put_device(&rdev->dev);
@@ -2163,7 +2199,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
-	regulator = create_regulator(rdev, dev, id);
+	regulator = create_regulator(rdev, dev, id, uA_base_load);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
@@ -2737,7 +2773,8 @@ static int _regulator_handle_consumer_enable(struct regulator *regulator)
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	regulator->enable_count++;
-	if (regulator->uA_load && regulator->enable_count == 1)
+	if ((regulator->uA_load || regulator->uA_base_load) &&
+	    regulator->enable_count == 1)
 		return drms_uA_update(rdev);
 
 	return 0;
@@ -2763,7 +2800,8 @@ static int _regulator_handle_consumer_disable(struct regulator *regulator)
 	}
 
 	regulator->enable_count--;
-	if (regulator->uA_load && regulator->enable_count == 0)
+	if ((regulator->uA_load || regulator->uA_base_load) &&
+	    regulator->enable_count == 0)
 		return drms_uA_update(rdev);
 
 	return 0;
@@ -5850,6 +5888,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	struct regulator *consumer;
 	struct summary_data summary_data;
 	unsigned int opmode;
+	int uA_load;
 
 	if (!rdev)
 		return;
@@ -5893,11 +5932,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
+			uA_load = regulator_eff_load(consumer);
 			seq_printf(s, "%3d %33dmA%c%5dmV %5dmV",
 				   consumer->enable_count,
-				   consumer->uA_load / 1000,
-				   consumer->uA_load && !consumer->enable_count ?
-				   '*' : ' ',
+				   uA_load / 1000,
+				   uA_load && !consumer->enable_count ? '*' : ' ',
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 1e9c71642143..8e20808bfbba 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -49,6 +49,7 @@ struct regulator {
 	unsigned int bypass:1;
 	unsigned int device_link:1;
 	int uA_load;
+	int uA_base_load;
 	unsigned int enable_count;
 	unsigned int deferred_disables;
 	struct regulator_voltage voltage[REGULATOR_STATES_NUM];
-- 
2.37.1.359.gd136c6c3e2-goog

