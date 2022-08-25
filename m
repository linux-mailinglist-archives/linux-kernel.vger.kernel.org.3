Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B855A0C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiHYJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHYJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:21:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C0140CB;
        Thu, 25 Aug 2022 02:21:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D531D6601E99;
        Thu, 25 Aug 2022 10:21:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661419278;
        bh=L9ZVFMIScm8330R2s3//rOLooqtPQxwHhFvtUAlxza0=;
        h=From:To:Cc:Subject:Date:From;
        b=kTD1bfnxBVizc2u3eJhfzcYwb5ulms0qpLl1MfwAAVfPjQp358GZMT6jVz5IBs/SU
         LSPRMreXPjY+ax4ylT46l22nAhF7+a5rPtz7c+DjIu+zn5W2Uhu2zIgmP4RqQDembW
         Qf5gKiXr+K9mrYXjhq8oWOriFbjbJwo1S/gKbjLYO1l78TEoj2u/YIREFoFYzMfdV7
         Ouihb2RXUb0cENF1L7bQh4KxO76dOYpqHZ7fpKKjfMhuq3chiMakZTVrAP/tnyWpo5
         cTXo1SygU+BJQXrDLo8o+1KSgr/JPBInu+21rGN/nea0kjffLXVW54Pt94nSjwnc4U
         0O9bv7VdOm6BA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     krisman@collabora.com, dmitry.osipenko@collabora.com,
        kernel@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] iio: light: tsl2583: Fix module unloading
Date:   Thu, 25 Aug 2022 14:50:48 +0530
Message-Id: <20220825092048.136973-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsl2583 uses devm_iio_device_register() function and
calling iio_device_unregister() in remove breaks the
module unloading.
Fix this by removing call to iio_device_unregister()
from tsl2583_remove().

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/light/tsl2583.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 82662dab87c0..36c25f79e6a6 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -878,8 +878,6 @@ static int tsl2583_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.30.2

