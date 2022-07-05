Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6133566E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiGEMen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbiGEMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:25:43 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D117A96;
        Tue,  5 Jul 2022 05:18:10 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (1-171-254-213.dynamic-ip.hinet.net [1.171.254.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E6DAA3F382;
        Tue,  5 Jul 2022 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657023486;
        bh=iTvnrtGJmHbu5jxs176IxAoGznZUm87Bg9lJ9yagBe8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ofam5KN6BRYtLrlpL0lFvS+M/JTyxh0GjX+aWo6NbSF3kpgWTJaNjvDlgb+LsQtJ6
         FBoXELSK4q1KeQbdnS6rihONcCuK98wXPjgFz6+Ug5KDOu3gVSUlf3pXMv2y+CAbpP
         XuWSLbese+hF0Rd365DfL9l03szZlVB0n7HTU+ADc9lsWwzR9QCBduKbNgfP8bxnJN
         VVGzFLlSamjwM8AIpOahwXKi5zZqBPcxNsvTIC7alkSz5QYdCGOljDUrgeGw/sBifi
         Jgf7Cre/uYZFcz+ynVl/nViyJJgrO5UoUTuEZkCzNxL4PGBTIdGLP3n502SQN3cZGD
         95t+OpFULNKFw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm32181: Add PM support
Date:   Tue,  5 Jul 2022 20:17:56 +0800
Message-Id: <20220705121756.41660-1-kai.heng.feng@canonical.com>
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
 drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 97649944f1df6..e46bc6a54f199 100644
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
+	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
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

