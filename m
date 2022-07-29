Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256B2585133
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiG2N6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiG2N6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6071736;
        Fri, 29 Jul 2022 06:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DEAC61F70;
        Fri, 29 Jul 2022 13:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C54C433D6;
        Fri, 29 Jul 2022 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659103100;
        bh=jaUjsv1PVnXc526rmanhZp9VEH+hoxg6XeDwxPCiOOA=;
        h=From:To:Cc:Subject:Date:From;
        b=HV8VUJkgX9NAwSeaIs3MdC4LKBMuuTABvG2n/RwJG39e71c6CFeWFTyalg1K6A7gx
         prjZndMzoU22mWAxOn7cPhJyGMndlYuvwI4d9A0Qt152dVSd3k64pSNzA+fZM6E8Id
         60MbbzZop0t2PWQOW7jEEvjgvm16YoentaBvb6Ws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-input@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: elan_i2c - convert to use dev_groups
Date:   Fri, 29 Jul 2022 15:58:16 +0200
Message-Id: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=gregkh@linuxfoundation.org; h=from:subject; bh=jaUjsv1PVnXc526rmanhZp9VEH+hoxg6XeDwxPCiOOA=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPn1fEW+xoVncOX/nw4VGXtWdWpSby3/FcwtLJtddrY3kr R/+cjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZgIvwTDgplV3VIXShKu3umukfCv5f /10PJiEMOCw5dKKxVLFkpN3yv67yn7nvMJzr9vAQA=
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

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "jingle.wu" <jingle.wu@emc.com.tw>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
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

