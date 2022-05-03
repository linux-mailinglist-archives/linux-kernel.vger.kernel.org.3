Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1551836C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiECLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiECLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:47:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CBF19028;
        Tue,  3 May 2022 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651578235;
  x=1683114235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyYaMPT3VVclWV5fER8SKt1HJ8hGTo2ZrDH3585JNPo=;
  b=ktxJYlONQ9OiREDch5V/1HXx++AgEunWcbUuoGt6q+6CkepOSFJNtARO
   u7r3d2/7roNlTDEvbE+YzNW/zcNDzQc4pL70iYQ7fkyi8jrJosFioAacV
   jIKQ2FV2qaHpZ2/7AcX1gMgkCg8J82XswiZ9xwjMVuBWkALruFeIuM8dc
   yjN9OlnH9D7lo7IlzSGuw/bVpeyzoiBgolZfzQHHOp4lG/Q3WEKdI7y2l
   DIwZ/v/ZEeQXkBORNqQ0YQICRa0bgFiRN0GHhf0eaz+UEPB0dZbvMJxG/
   jsfgpU/7EU6ipLC2Ljn0Ni/pfeSxMDv3ilrkhkoYDtuGTfJrqpyxZ/M0q
   w==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Camel Guo <camel.guo@axis.com>, Wolfram Sang <wsa@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
Subject: [PATCH v4] hwmon: (tmp401) Add OF device ID table
Date:   Tue, 3 May 2022 13:43:33 +0200
Message-ID: <20220503114333.456476-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't have of_match_table. This makes the kernel module
tmp401.ko lack alias patterns (e.g: of:N*T*Cti,tmp411) to match DT node
of the supported devices hence this kernel module will not be
automatically loaded.

After adding of_match_table to this driver, the folllowing alias will be
added into tmp401.ko.
$ modinfo drivers/hwmon/tmp401.ko
filename: drivers/hwmon/tmp401.ko
......
author:         Hans de Goede <hdegoede@redhat.com>
alias:          of:N*T*Cti,tmp435C*
alias:          of:N*T*Cti,tmp435
alias:          of:N*T*Cti,tmp432C*
alias:          of:N*T*Cti,tmp432
alias:          of:N*T*Cti,tmp431C*
alias:          of:N*T*Cti,tmp431
alias:          of:N*T*Cti,tmp411C*
alias:          of:N*T*Cti,tmp411
alias:          of:N*T*Cti,tmp401C*
alias:          of:N*T*Cti,tmp401
......

Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
Signed-off-by: Camel Guo <camel.guo@axis.com>
---

Notes:
    v4:
     - Rewrite commit message due to improper description in old one
    v3:
     - Copy commit message from commit 72fc64c68decf119466 ("hwmon: (tmp103)
       Add OF device ID table")
     - Add Fixes tag
    v2:
     - Put evidence and circumstances in commit message

 drivers/hwmon/tmp401.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index b86d9df7105d..52c9e7d3f2ae 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -708,10 +708,21 @@ static int tmp401_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
+	{ .compatible = "ti,tmp401", },
+	{ .compatible = "ti,tmp411", },
+	{ .compatible = "ti,tmp431", },
+	{ .compatible = "ti,tmp432", },
+	{ .compatible = "ti,tmp435", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
+
 static struct i2c_driver tmp401_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "tmp401",
+		.of_match_table = of_match_ptr(tmp4xx_of_match),
 	},
 	.probe_new	= tmp401_probe,
 	.id_table	= tmp401_id,

base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
-- 
2.30.2

