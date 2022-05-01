Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE85516114
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiEAAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiEAAJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:09:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA71DA5E;
        Sat, 30 Apr 2022 17:05:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z12so6090713ilp.8;
        Sat, 30 Apr 2022 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx+5hqspyYEyjq5noUkF2cS/DIWViWG2PCaIwLb1HGc=;
        b=K9lNJB6mzLNUiS/jeSoegXzAM30vWfOuOYa9fnrnWYstdO/q129ZOwmQ8j5Un2yvQO
         0HZ/AvGuO/smdoKVUjOghXRIQ5xjAY/n+66IxO+b950ofpngpE9SvR2Cl/DVfsEqFOhE
         T0GKtvk70WcaF2Fwh1pHjQSIb150EM6Kg3cS3u2go+kllSyeYhDaUxxwK+dRi1vBfhxW
         3QTUep3KOBbXqhLXepFFfXxa/DW26MSoV2U4GbVwt1FjVkg/VvX43bXQU/qv9ILuL/Vl
         c7vNOfErOc6WsagwdJ8gcRELOtcrp38WyQKvgigLT0RTZBC8NVBQMp+RuyoCjPHEP9q+
         Ilng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx+5hqspyYEyjq5noUkF2cS/DIWViWG2PCaIwLb1HGc=;
        b=b7Fxh6FW2NPdDh8WdFbYFqoCYlFlEdp1jSFzODMaVjbIzYv50FSCulAkpesMcKcXLy
         TKVrJPXKw9ZT043RsCxLYV6Q8qVqJMNsFazuM966D8z2RUzMCbTnRDQaANCsS8mRT361
         Re6/1qNRjpTHk2dYfXj0OgzIUjDy4HZEZrs5qiFj1fAd3D/tFts6/vykhlFoYvrROE+H
         owUwsLvIe3SOaiZGwtuILy360hjgujgeyWpGfYEJrF2Ef3zSUaR8kaNE0hJVbrN8NJ6Y
         Kp1hmiAcIkx0rI3pH0rEDQaoVH2e49yo4FBTWaNT5HB48KmsS+JPBOiQknOxW9v8LyOG
         vaaQ==
X-Gm-Message-State: AOAM530lCHCnGUuQxkEL6Tr1UWy9vmACjrn0GvaU97a/Jxr6/zysP6Dk
        sdx60UIurakYllaTjFcM5QfWVq4j65Y=
X-Google-Smtp-Source: ABdhPJxG9ftLXf/jzsFjL5Cdz2mytER5t8dFm0RDb2CkYvhGsWZuncsWIns+/1LY0yXH7SJEmujJkQ==
X-Received: by 2002:a05:6e02:8ae:b0:2c7:90a5:90b8 with SMTP id a14-20020a056e0208ae00b002c790a590b8mr2379536ilt.19.1651363556849;
        Sat, 30 Apr 2022 17:05:56 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:809b:de5d:7e0a:bf83])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b002cde6e352dcsm1567160ilq.38.2022.04.30.17.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 17:05:56 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] of: overlay: unittest: add tests for overlay notifiers
Date:   Sat, 30 Apr 2022 19:05:42 -0500
Message-Id: <20220501000543.1368005-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501000543.1368005-1-frowand.list@gmail.com>
References: <20220501000543.1368005-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Add tests for overlay apply and remove notifiers.  Trigger errors
for each of the notifier actions.

These tests will reveal a memory leak problem when a notifier returns
an error for action OF_OVERLAY_POST_APPLY.  The pr_err() message is:

   OF: ERROR: memory leak, expected refcount 1 instead of 3,
   of_node_get()/of_node_put() unbalanced - destroy cset entry: attach
   overlay node /testcase-data/overlay-node/test-bus/test-unittest17

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

===

Output of the new overlay notifier unittests, as filtered by
scripts/dtc/of_unittest_expect:

   ### dt-test ### pass of_unittest_overlay_notify():2825
ok OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2846
   ### dt-test ### pass of_unittest_overlay_notify():2851
ok OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus
   OF: ERROR: memory leak, expected refcount 1 instead of 3, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data/overlay-node/test-bus/test-unittest17
   ### dt-test ### pass of_unittest_overlay_notify():2857
   ### dt-test ### pass of_unittest_overlay_notify():2862
   ### dt-test ### pass of_unittest_overlay_notify():2866
   ### dt-test ### pass of_unittest_overlay_notify():2869
ok OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2880
   ### dt-test ### pass of_unittest_overlay_notify():2888
   ### dt-test ### pass of_unittest_overlay_notify():2892
   ### dt-test ### pass of_unittest_overlay_notify():2895
ok OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2902
   ### dt-test ### pass of_unittest_overlay_notify():2909
   ### dt-test ### pass of_unittest_overlay_notify():2914
   ### dt-test ### pass of_unittest_overlay_notify():2926

Note that four new kernel error messages are triggered by the new
tests, and of_unittest_expect labels them as expected errors with
the string 'ok ' in the first three columns.

A fifth new kernel error message is a real bug, which will be fixed
in patch 3/3:

   OF: ERROR: memory leak, expected refcount 1 instead of 3, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data/overlay-node/test-bus/test-unittest17


 drivers/of/unittest-data/Makefile       |  10 ++
 drivers/of/unittest-data/overlay_16.dts |  15 ++
 drivers/of/unittest-data/overlay_17.dts |  15 ++
 drivers/of/unittest-data/overlay_18.dts |  15 ++
 drivers/of/unittest-data/overlay_19.dts |  15 ++
 drivers/of/unittest-data/overlay_20.dts |  15 ++
 drivers/of/unittest.c                   | 198 ++++++++++++++++++++++++
 7 files changed, 283 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_16.dts
 create mode 100644 drivers/of/unittest-data/overlay_17.dts
 create mode 100644 drivers/of/unittest-data/overlay_18.dts
 create mode 100644 drivers/of/unittest-data/overlay_19.dts
 create mode 100644 drivers/of/unittest-data/overlay_20.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index fbded24c608c..d072f3ba3971 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -17,6 +17,11 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_12.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
+			    overlay_16.dtb.o \
+			    overlay_17.dtb.o \
+			    overlay_18.dtb.o \
+			    overlay_19.dtb.o \
+			    overlay_20.dtb.o \
 			    overlay_bad_add_dup_node.dtb.o \
 			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
@@ -75,6 +80,11 @@ apply_static_overlay_1 := overlay_0.dtbo \
 			  overlay_12.dtbo \
 			  overlay_13.dtbo \
 			  overlay_15.dtbo \
+			  overlay_16.dtbo \
+			  overlay_17.dtbo \
+			  overlay_18.dtbo \
+			  overlay_19.dtbo \
+			  overlay_20.dtbo \
 			  overlay_gpio_01.dtbo \
 			  overlay_gpio_02a.dtbo \
 			  overlay_gpio_02b.dtbo \
diff --git a/drivers/of/unittest-data/overlay_16.dts b/drivers/of/unittest-data/overlay_16.dts
new file mode 100644
index 000000000000..80a46dc02581
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_16.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_16 - notify test */
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	test-unittest16 {
+		compatible = "unittest";
+		reg = <16>;
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_17.dts b/drivers/of/unittest-data/overlay_17.dts
new file mode 100644
index 000000000000..5b8a2209177f
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_17.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_17 - notify test */
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	test-unittest17 {
+		compatible = "unittest";
+		reg = <17>;
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_18.dts b/drivers/of/unittest-data/overlay_18.dts
new file mode 100644
index 000000000000..dcddd5f6d301
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_18.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_18 - notify test */
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	test-unittest18 {
+		compatible = "unittest";
+		reg = <18>;
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_19.dts b/drivers/of/unittest-data/overlay_19.dts
new file mode 100644
index 000000000000..32b3ba0b66a3
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_19.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_19 - notify test */
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	test-unittest19 {
+		compatible = "unittest";
+		reg = <19>;
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_20.dts b/drivers/of/unittest-data/overlay_20.dts
new file mode 100644
index 000000000000..d4a4f2f32ec7
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_20.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/* overlay_20 - notify test */
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	test-unittest20 {
+		compatible = "unittest";
+		reg = <20>;
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index c4106de9f137..e28c3df2c4c2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2741,6 +2741,192 @@ static inline void of_unittest_overlay_i2c_15(void) { }
 
 #endif
 
+static int of_notify(struct notifier_block *nb, unsigned long action,
+		     void *arg)
+{
+	struct of_overlay_notify_data *nd = arg;
+	struct device_node *found;
+	int ret;
+
+	/*
+	 * For overlay_16 .. overlay_19, check that returning an error
+	 * works for each of the actions by setting an arbitrary return
+	 * error number that matches the test number.  e.g. for unittest16,
+	 * ret = -EBUSY which is -16.
+	 *
+	 * OVERLAY_INFO() for the overlays is declared to expect the same
+	 * error number, so overlay_data_apply() will return no error.
+	 *
+	 * overlay_20 will return NOTIFY_DONE
+	 */
+
+	ret = 0;
+	of_node_get(nd->overlay);
+
+	switch (action) {
+
+	case OF_OVERLAY_PRE_APPLY:
+		found = of_find_node_by_name(nd->overlay, "test-unittest16");
+		if (found) {
+			of_node_put(found);
+			ret = -EBUSY;
+		}
+		break;
+
+	case OF_OVERLAY_POST_APPLY:
+		found = of_find_node_by_name(nd->overlay, "test-unittest17");
+		if (found) {
+			of_node_put(found);
+			ret = -EEXIST;
+		}
+		break;
+
+	case OF_OVERLAY_PRE_REMOVE:
+		found = of_find_node_by_name(nd->overlay, "test-unittest18");
+		if (found) {
+			of_node_put(found);
+			ret = -EXDEV;
+		}
+		break;
+
+	case OF_OVERLAY_POST_REMOVE:
+		found = of_find_node_by_name(nd->overlay, "test-unittest19");
+		if (found) {
+			of_node_put(found);
+			ret = -ENODEV;
+		}
+		break;
+
+	default:			/* should not happen */
+		of_node_put(nd->overlay);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return notifier_from_errno(ret);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block of_nb = {
+	.notifier_call = of_notify,
+};
+
+
+
+
+static void __init of_unittest_overlay_notify(void)
+{
+	int ovcs_id;
+	int ret;
+
+	ret = of_overlay_notifier_register(&of_nb);
+	unittest(!ret,
+		 "of_overlay_notifier_register() failed, ret = %d\n", ret);
+	if (ret)
+		return;
+
+	/*
+	 * The overlays are applied by overlay_data_apply()
+	 * instead of of_unittest_apply_overlay() so that they
+	 * will not be tracked.  Thus they will not be removed
+	 * by of_unittest_remove_tracked_overlays().
+	 *
+	 * Applying overlays 16 - 19 will each trigger an error for a
+	 * different action in of_notify().
+	 *
+	 * Applying overlay 20 will not trigger any error in of_notify().
+	 */
+
+	/* ---  overlay 16  --- */
+
+	EXPECT_BEGIN(KERN_INFO, "OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus");
+
+	unittest(overlay_data_apply("overlay_16", &ovcs_id),
+		 "test OF_OVERLAY_PRE_APPLY notify injected error\n");
+
+	EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus");
+
+	unittest(!ovcs_id, "ovcs_id created for overlay_16\n");
+
+	/* ---  overlay 17  --- */
+
+	EXPECT_BEGIN(KERN_INFO, "OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus");
+
+	unittest(overlay_data_apply("overlay_17", &ovcs_id),
+		 "test OF_OVERLAY_POST_APPLY notify injected error\n");
+
+	EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus");
+
+	unittest(!ovcs_id, "ovcs_id created for overlay_17\n");
+
+	/* ---  overlay 18  --- */
+
+	unittest(overlay_data_apply("overlay_18", &ovcs_id),
+		 "OF_OVERLAY_PRE_REMOVE notify injected error\n");
+
+	unittest(ovcs_id, "ovcs_id not created for overlay_18\n");
+
+	if (ovcs_id) {
+		EXPECT_BEGIN(KERN_INFO, "OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus");
+
+		ret = of_overlay_remove(&ovcs_id);
+		EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus");
+		if (ret == -EXDEV) {
+			/*
+			 * change set ovcs_id should still exist
+			 */
+			unittest(1, "overlay_18 of_overlay_remove() injected error for OF_OVERLAY_PRE_REMOVE\n");
+		} else {
+			unittest(0, "overlay_18 of_overlay_remove() injected error for OF_OVERLAY_PRE_REMOVE not returned\n");
+		}
+	} else {
+		unittest(1, "ovcs_id not created for overlay_18\n");
+	}
+
+	unittest(ovcs_id, "ovcs_id removed for overlay_18\n");
+
+	/* ---  overlay 19  --- */
+
+	unittest(overlay_data_apply("overlay_19", &ovcs_id),
+		 "OF_OVERLAY_POST_REMOVE notify injected error\n");
+
+	unittest(ovcs_id, "ovcs_id not created for overlay_19\n");
+
+	if (ovcs_id) {
+		EXPECT_BEGIN(KERN_INFO, "OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus");
+		ret = of_overlay_remove(&ovcs_id);
+		EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus");
+		if (ret == -ENODEV)
+			unittest(1, "overlay_19 of_overlay_remove() injected error for OF_OVERLAY_POST_REMOVE\n");
+		else
+			unittest(0, "overlay_19 of_overlay_remove() injected error for OF_OVERLAY_POST_REMOVE not returned\n");
+	} else {
+		unittest(1, "ovcs_id removed for overlay_19\n");
+	}
+
+	unittest(!ovcs_id, "changeset ovcs_id = %d not removed for overlay_19\n",
+		 ovcs_id);
+
+	/* ---  overlay 20  --- */
+
+	unittest(overlay_data_apply("overlay_20", &ovcs_id),
+		 "overlay notify no injected error\n");
+
+	if (ovcs_id) {
+		ret = of_overlay_remove(&ovcs_id);
+		if (ret)
+			unittest(1, "overlay_20 failed to be destroyed, ret = %d\n",
+				 ret);
+	} else {
+		unittest(1, "ovcs_id not created for overlay_20\n");
+	}
+
+	unittest(!of_overlay_notifier_unregister(&of_nb),
+		 "of_overlay_notifier_unregister() failed, ret = %d\n", ret);
+}
+
 static void __init of_unittest_overlay(void)
 {
 	struct device_node *bus_np = NULL;
@@ -2804,6 +2990,8 @@ static void __init of_unittest_overlay(void)
 
 	of_unittest_remove_tracked_overlays();
 
+	of_unittest_overlay_notify();
+
 out:
 	of_node_put(bus_np);
 }
@@ -2855,6 +3043,11 @@ OVERLAY_INFO_EXTERN(overlay_11);
 OVERLAY_INFO_EXTERN(overlay_12);
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
+OVERLAY_INFO_EXTERN(overlay_16);
+OVERLAY_INFO_EXTERN(overlay_17);
+OVERLAY_INFO_EXTERN(overlay_18);
+OVERLAY_INFO_EXTERN(overlay_19);
+OVERLAY_INFO_EXTERN(overlay_20);
 OVERLAY_INFO_EXTERN(overlay_gpio_01);
 OVERLAY_INFO_EXTERN(overlay_gpio_02a);
 OVERLAY_INFO_EXTERN(overlay_gpio_02b);
@@ -2885,6 +3078,11 @@ static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_12, 0),
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
+	OVERLAY_INFO(overlay_16, -EBUSY),
+	OVERLAY_INFO(overlay_17, -EEXIST),
+	OVERLAY_INFO(overlay_18, 0),
+	OVERLAY_INFO(overlay_19, 0),
+	OVERLAY_INFO(overlay_20, 0),
 	OVERLAY_INFO(overlay_gpio_01, 0),
 	OVERLAY_INFO(overlay_gpio_02a, 0),
 	OVERLAY_INFO(overlay_gpio_02b, 0),
-- 
Frank Rowand <frank.rowand@sony.com>

