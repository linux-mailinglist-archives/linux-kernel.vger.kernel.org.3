Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A558513E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiG2OD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiG2ODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:03:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560532EF7;
        Fri, 29 Jul 2022 07:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48086B826FB;
        Fri, 29 Jul 2022 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76752C433C1;
        Fri, 29 Jul 2022 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659103430;
        bh=uw4qFdbyEK/Ys9lEVALI4CkulncvctAkAkXgWmZQ0Do=;
        h=From:To:Cc:Subject:Date:From;
        b=Sp9DnNPzhKMxfxlBbMjJEOCfcXbaUBUtWGh8ji662sPVx9CYmgO6bzwbxzswU3PrB
         B7B3Ae7A9u4vIFASuBt1urJzvtxxLTBJR0f63XukXEDBK+TY1IadVb0Cp8mbV79kSk
         1z1uqi6NtTjwoU7hSs/naHy1Lx7uAtRJvPuuXGyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-leds@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: turris-omnia: convert to use dev_groups
Date:   Fri, 29 Jul 2022 16:03:46 +0200
Message-Id: <20220729140346.2313175-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=gregkh@linuxfoundation.org; h=from:subject; bh=uw4qFdbyEK/Ys9lEVALI4CkulncvctAkAkXgWmZQ0Do=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPXxxSSbirNLv/cmjMtJXXJs5QWvAuftZFz3Ob9gSJuj/l cWd+2BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATya9nmO9au8X4MsMh7lD91trlad /eOx1p72FY0CEnFvY08WhijmlnutZ9s+mrbHouAgA=
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

Cc: "Marek Behún" <kabel@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-turris-omnia.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 1adfed1c0619..eac6f4a573b2 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -239,9 +239,6 @@ static int omnia_leds_probe(struct i2c_client *client,
 		led += ret;
 	}
 
-	if (devm_device_add_groups(dev, omnia_led_controller_groups))
-		dev_warn(dev, "Could not add attribute group!\n");
-
 	return 0;
 }
 
@@ -283,6 +280,7 @@ static struct i2c_driver omnia_leds_driver = {
 	.driver		= {
 		.name	= "leds-turris-omnia",
 		.of_match_table = of_omnia_leds_match,
+		.dev_groups = omnia_led_controller_groups,
 	},
 };
 
-- 
2.37.1

