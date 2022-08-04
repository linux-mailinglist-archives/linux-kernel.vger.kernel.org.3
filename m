Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87081589B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiHDLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiHDLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7D33359;
        Thu,  4 Aug 2022 04:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4160961737;
        Thu,  4 Aug 2022 11:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53249C433B5;
        Thu,  4 Aug 2022 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659612681;
        bh=/qIoohSahmUwBa5cguu2fdpCYDJ/iojFVsokSblsX6s=;
        h=From:To:Cc:Subject:Date:From;
        b=A0q9g2jzYIYXhItG929s/Abcfpv3NF8owVTjI15H2Q/QdLsUPlze0EOIFThh95oC4
         2P9tOjVku2O6nshO0I+LjPgAfuwgOCGENkRzQL1VEaZ1fWt/gcG26r1E+Qbb0HJ6a+
         6cYhz17LWoFz5lyX+vDBZ8tsxN3PmbbD0/xOn9Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: vivaldi: convert to use dev_groups
Date:   Thu,  4 Aug 2022 13:31:16 +0200
Message-Id: <20220804113116.1117378-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3982; i=gregkh@linuxfoundation.org; h=from:subject; bh=/qIoohSahmUwBa5cguu2fdpCYDJ/iojFVsokSblsX6s=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmv17G0p805O1Hn0a1Pv2YlMG49vGrBgZ3rmLbGS2krnUrN uXzrbUcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMRPMZwxwuzk1lvJp6+d+OfSkPkO ftePPi3GqGBWu4Vvn561bv2/Rps3byqsTn2lceqgIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for a driver to individually add/create device groups,
the driver core will do it automatically for you.  Convert the
hid-vivaldi core driver to use the dev_groups pointer instead of
manually calling the driver core to create the group and have it be
cleaned up later on by the devm core.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-google-hammer.c  |  4 +++-
 drivers/hid/hid-vivaldi-common.c | 29 +++++++++++++++--------------
 drivers/hid/hid-vivaldi-common.h |  4 +---
 drivers/hid/hid-vivaldi.c        |  4 +++-
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index ff40f1e55c21..7ae5f27df54d 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -608,9 +608,11 @@ static struct hid_driver hammer_driver = {
 	.probe = hammer_probe,
 	.remove = hammer_remove,
 	.feature_mapping = vivaldi_feature_mapping,
-	.input_configured = vivaldi_input_configured,
 	.input_mapping = hammer_input_mapping,
 	.event = hammer_event,
+	.driver = {
+		.dev_groups = vivaldi_attribute_groups,
+	},
 };
 
 static int __init hammer_init(void)
diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index 8b3e515d0f06..b0af2be94895 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -116,25 +116,26 @@ static struct attribute *vivaldi_sysfs_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group vivaldi_attribute_group = {
-	.attrs = vivaldi_sysfs_attrs,
-};
-
-/**
- * vivaldi_input_configured - Complete initialization of device using vivaldi map
- * @hdev: HID device to which vivaldi attributes should be attached
- * @hidinput: HID input device (unused)
- */
-int vivaldi_input_configured(struct hid_device *hdev,
-			     struct hid_input *hidinput)
+static umode_t vivaldi_is_visible(struct kobject *kobj, struct attribute *attr,
+				  int n)
 {
+	struct hid_device *hdev = to_hid_device(kobj_to_dev(kobj));
 	struct vivaldi_data *data = hid_get_drvdata(hdev);
 
 	if (!data->num_function_row_keys)
 		return 0;
-
-	return devm_device_add_group(&hdev->dev, &vivaldi_attribute_group);
+	return attr->mode;
 }
-EXPORT_SYMBOL_GPL(vivaldi_input_configured);
+
+static const struct attribute_group vivaldi_attribute_group = {
+	.attrs = vivaldi_sysfs_attrs,
+	.is_visible = vivaldi_is_visible,
+};
+
+const struct attribute_group *vivaldi_attribute_groups[] = {
+	&vivaldi_attribute_group,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(vivaldi_attribute_groups);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-vivaldi-common.h b/drivers/hid/hid-vivaldi-common.h
index d42e82d77825..ba9adfa08a2d 100644
--- a/drivers/hid/hid-vivaldi-common.h
+++ b/drivers/hid/hid-vivaldi-common.h
@@ -4,13 +4,11 @@
 
 struct hid_device;
 struct hid_field;
-struct hid_input;
 struct hid_usage;
 
 void vivaldi_feature_mapping(struct hid_device *hdev,
 			     struct hid_field *field, struct hid_usage *usage);
 
-int vivaldi_input_configured(struct hid_device *hdev,
-			     struct hid_input *hidinput);
+extern const struct attribute_group *vivaldi_attribute_groups[];
 
 #endif /* _HID_VIVALDI_COMMON_H */
diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index 3a979123e7d3..cda5938fb070 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -45,7 +45,9 @@ static struct hid_driver hid_vivaldi = {
 	.id_table = vivaldi_table,
 	.probe = vivaldi_probe,
 	.feature_mapping = vivaldi_feature_mapping,
-	.input_configured = vivaldi_input_configured,
+	.driver = {
+		.dev_groups = vivaldi_attribute_groups,
+	},
 };
 
 module_hid_driver(hid_vivaldi);
-- 
2.37.1

