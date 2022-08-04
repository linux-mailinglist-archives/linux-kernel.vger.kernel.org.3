Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B54589B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiHDLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiHDLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8932DB1;
        Thu,  4 Aug 2022 04:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23868B8244B;
        Thu,  4 Aug 2022 11:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5175AC433C1;
        Thu,  4 Aug 2022 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659612658;
        bh=0lIrQ5m66OPyqwxfRIL9z1KcvRuFNWjXTPQqJfu5jHA=;
        h=From:To:Cc:Subject:Date:From;
        b=ff89RAbzzGudYUir8oV2vo0sGTuj5DGwIBNcGD6vg+J/VG/sFLoKphMqUgA/ooacf
         G/Do0yFRb4rcMb843iblr2mDfBCF5e+HRrTtVCELBV+bZoon7JdknAkbZ5J94K2D5W
         ofs6MK70prDfezm4jE4MPEZaHjnvVPaJ6AtfXcMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: playstation: convert to use dev_groups
Date:   Thu,  4 Aug 2022 13:30:52 +0200
Message-Id: <20220804113052.1117009-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=gregkh@linuxfoundation.org; h=from:subject; bh=0lIrQ5m66OPyqwxfRIL9z1KcvRuFNWjXTPQqJfu5jHA=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmv1766rrUiL7FRrefRg6IjGl7Rf6/4PrVx0naY7Om5/rt1 WNfMjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI6E+GuTJzflZk7ZWvu9v5uPz0pL /HArYcdGdYcNzgm8m8e+48S4v/Ct/61h8wcZvDLAA=
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
hid-playstation driver to use the dev_groups pointer instead of manually
calling the driver core to create the group and have it be cleaned up
later on by the devm core.

Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-playstation.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index b1b5721b5d8f..40050eb85c0a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -692,15 +692,12 @@ static ssize_t hardware_version_show(struct device *dev,
 
 static DEVICE_ATTR_RO(hardware_version);
 
-static struct attribute *ps_device_attributes[] = {
+static struct attribute *ps_device_attrs[] = {
 	&dev_attr_firmware_version.attr,
 	&dev_attr_hardware_version.attr,
 	NULL
 };
-
-static const struct attribute_group ps_device_attribute_group = {
-	.attrs = ps_device_attributes,
-};
+ATTRIBUTE_GROUPS(ps_device);
 
 static int dualsense_get_calibration_data(struct dualsense *ds)
 {
@@ -1448,12 +1445,6 @@ static int ps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	ret = devm_device_add_group(&hdev->dev, &ps_device_attribute_group);
-	if (ret) {
-		hid_err(hdev, "Failed to register sysfs nodes.\n");
-		goto err_close;
-	}
-
 	return ret;
 
 err_close:
@@ -1487,6 +1478,9 @@ static struct hid_driver ps_driver = {
 	.probe		= ps_probe,
 	.remove		= ps_remove,
 	.raw_event	= ps_raw_event,
+	.driver = {
+		.dev_groups = ps_device_groups,
+	},
 };
 
 static int __init ps_init(void)
-- 
2.37.1

