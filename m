Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5E588041
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiHBQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiHBQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:29:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9E33E0E;
        Tue,  2 Aug 2022 09:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B95B81FA2;
        Tue,  2 Aug 2022 16:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B8CC433C1;
        Tue,  2 Aug 2022 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659457738;
        bh=Hj/CQNaxBVLSLl5kQyeXMjIf/ndHxdLkWD0KIYWve38=;
        h=From:To:Cc:Subject:Date:From;
        b=vy61WoC9aEy7G5ERSRAVWNEYFlE7mQfxgGlhedlsD7Pt/Gqb9CI23xUqgX0+894gI
         VYkMqFSYCrais5okjO6NVFxS8XMdzhSSJ5rC4rGZvjLROuT4lMXd2hrZ0HR1+N/Yu8
         3g01W8slD9mUK1yR+hveeaQpHgPrZqPTpxiu7X18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-input@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: elan_i2c - convert to use dev_groups
Date:   Tue,  2 Aug 2022 18:28:54 +0200
Message-Id: <20220802162854.3015369-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=gregkh@linuxfoundation.org; h=from:subject; bh=Hj/CQNaxBVLSLl5kQyeXMjIf/ndHxdLkWD0KIYWve38=; b=owGbwMvMwCRo6H6F97bub03G02pJDEkvA47sKH1Y2DPx+BLVr9dWi0zSlFpdFen7Ue10lI6QIN+i u8oHOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAilx4wzM+0uaA+PTbX3Poe15vjca kW8puPvmNY0PWmtaEijumxzpbw2M6ow/45ah8ZAA==
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
the driver core will do it automatically for you.  Convert the elan_i2c
driver to use the dev_groups pointer instead of manually calling the
driver core to create the group and have it be cleaned up later on by
the devm core.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "jingle.wu" <jingle.wu@emc.com.tw>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: change text based on Dmitry's review, it's not a race condition,
    it's just less code to worry about in a driver.

 drivers/input/mouse/elan_i2c_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index e1758d5ffe42..d4eb59b55bf1 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1311,12 +1311,6 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_device_add_groups(dev, elan_sysfs_groups);
-	if (error) {
-		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
-		return error;
-	}
-
 	error = input_register_device(data->input);
 	if (error) {
 		dev_err(dev, "failed to register input device: %d\n", error);
@@ -1442,6 +1436,7 @@ static struct i2c_driver elan_driver = {
 		.acpi_match_table = ACPI_PTR(elan_acpi_id),
 		.of_match_table = of_match_ptr(elan_of_match),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = elan_sysfs_groups,
 	},
 	.probe		= elan_probe,
 	.id_table	= elan_id,
-- 
2.37.1

