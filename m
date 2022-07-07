Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5D5696B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiGGACp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiGGACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:02:42 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F522D1E0;
        Wed,  6 Jul 2022 17:02:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B52813F103;
        Thu,  7 Jul 2022 00:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657152159;
        bh=+uLBVOziiWmLh5CeiyH/bxZC10Qn3rIy3RsnruTA3rk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=f2em4TPDTDnAizo2+qHcwv4/oOmrgEflG7Xi2Q0xcQX5ABl2bKptsZp3jncMIfxkI
         +oQC9Rx56GBWYJGo3m4KHeURgYjutYDGxkQBI5wpMTSykMXAhd1SiWG6ZMTwxClPfX
         5Lhi4PkcjPCMCHtLBl5H2rg3Fdh50fFFPCVM1gYceA9CrgNCF5kRLkP81tEICqsfDa
         7vYoYQeNryDgZ+iOQQXuF4Ob47jZ1Nhe75KFxhPmgUGxa5p5KIu4XOfDSY1YD4XTi8
         OHi+1R7uBVpuVOY+A1ZaDlWOz896neXLj8ivZOayeQhgb7CpASqdZ9CupfC916DnoY
         3TNrncHxrFdNw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: cm32181: Add PM support
Date:   Thu,  7 Jul 2022 08:01:51 +0800
Message-Id: <20220707000151.33381-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read on in_illuminance_input keeps at 0 after system sleep.

So add proper suspend and resume callback to make the sensor keep
working after system sleep.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use dev_get_drvdata() instead of i2c_get_clientdata() to avoid extra
   dereference.

 drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 97649944f1df6..edbe6a3138d0b 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -460,6 +460,8 @@ static int cm32181_probe(struct i2c_client *client)
 			return PTR_ERR(client);
 	}
 
+	i2c_set_clientdata(client, indio_dev);
+
 	cm32181 = iio_priv(indio_dev);
 	cm32181->client = client;
 	cm32181->dev = dev;
@@ -486,6 +488,25 @@ static int cm32181_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int cm32181_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
+					 CM32181_CMD_ALS_DISABLE);
+}
+
+static int cm32181_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
+
+	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
+					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
+
 static const struct of_device_id cm32181_of_match[] = {
 	{ .compatible = "capella,cm3218" },
 	{ .compatible = "capella,cm32181" },
@@ -506,6 +527,7 @@ static struct i2c_driver cm32181_driver = {
 		.name	= "cm32181",
 		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
 		.of_match_table = cm32181_of_match,
+		.pm = pm_sleep_ptr(&cm32181_pm_ops),
 	},
 	.probe_new	= cm32181_probe,
 };
-- 
2.36.1

