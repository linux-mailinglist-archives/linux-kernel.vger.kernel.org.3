Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36B584FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiG2LxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiG2LxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD708212B;
        Fri, 29 Jul 2022 04:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBBE61EAF;
        Fri, 29 Jul 2022 11:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D28AC433C1;
        Fri, 29 Jul 2022 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659095588;
        bh=oJXkuDZgul5LRp/Xogo0dUyyZ0gND7D8xz+Zm0ngbR4=;
        h=From:To:Cc:Subject:Date:From;
        b=mmTn4Nz3PafQpRefjSeW0vAGQP/Eys+qI6liap9vjYJ6Pi2RH8YpU9Yi62kh/lvPy
         OLaATBxBkPbcE8A46zWoWM48WP+1nyhR892KiJZ/2KW7dlfQ9usaAAsmjJ7C5/R4TH
         /gWyZbOzTF5S3Pv/PaSyqP2JC07rwpDn5TDZqCAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     platform-driver-x86@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Perry Yuan <Perry.Yuan@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Dell.Client.Kernel@dell.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-privacy: convert to use dev_groups
Date:   Fri, 29 Jul 2022 13:53:02 +0200
Message-Id: <20220729115302.2258296-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=gregkh@linuxfoundation.org; h=from:subject; bh=oJXkuDZgul5LRp/Xogo0dUyyZ0gND7D8xz+Zm0ngbR4=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPT4ntj819J1guzVBwbK9vDYf+mzvXey7sYP3QZx43/fdv j7CZHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRM4kMc3iez8h/uTSho/NTycRaD6 4UK4k1mgxzRTS28wq9ErseNO1MyvNjTyS1rgvMBwA=
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

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner.  Take advantage of
that by converting this driver to use this by moving the sysfs
attributes into a group and assigning the dev_groups pointer to it.

Cc: Perry Yuan <Perry.Yuan@dell.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Dell.Client.Kernel@dell.com
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/dell-wmi-privacy.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-privacy.c b/drivers/platform/x86/dell/dell-wmi-privacy.c
index 074b7e68c227..c82b3d6867c5 100644
--- a/drivers/platform/x86/dell/dell-wmi-privacy.c
+++ b/drivers/platform/x86/dell/dell-wmi-privacy.c
@@ -174,15 +174,12 @@ static ssize_t dell_privacy_current_state_show(struct device *dev,
 static DEVICE_ATTR_RO(dell_privacy_supported_type);
 static DEVICE_ATTR_RO(dell_privacy_current_state);
 
-static struct attribute *privacy_attributes[] = {
+static struct attribute *privacy_attrs[] = {
 	&dev_attr_dell_privacy_supported_type.attr,
 	&dev_attr_dell_privacy_current_state.attr,
 	NULL,
 };
-
-static const struct attribute_group privacy_attribute_group = {
-	.attrs = privacy_attributes
-};
+ATTRIBUTE_GROUPS(privacy);
 
 /*
  * Describes the Device State class exposed by BIOS which can be consumed by
@@ -342,10 +339,6 @@ static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *context)
 	if (ret)
 		return ret;
 
-	ret = devm_device_add_group(&wdev->dev, &privacy_attribute_group);
-	if (ret)
-		return ret;
-
 	if (priv->features_present & BIT(DELL_PRIVACY_TYPE_AUDIO)) {
 		ret = dell_privacy_leds_setup(&priv->wdev->dev);
 		if (ret)
@@ -374,6 +367,7 @@ static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] = {
 static struct wmi_driver dell_privacy_wmi_driver = {
 	.driver = {
 		.name = "dell-privacy",
+		.dev_groups = privacy_groups,
 	},
 	.probe = dell_privacy_wmi_probe,
 	.remove = dell_privacy_wmi_remove,
-- 
2.37.1

