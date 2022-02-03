Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2F4A8910
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiBCQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352419AbiBCQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:51:10 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A68C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:51:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so4939235oih.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWhhT8jFmnU2pjoM0/QnnyBc9JunG/+wIXj29Er2ODU=;
        b=AwjURXAsePvPFZJhH+OSnGku4Vh9TFmYnIeoBQS/eEW0NXTgZ51DGx2kTm0Y4ot/xd
         gPVzs77zllpgmtphMo3F0Kt43MqBp/ijLPe6VLm08OyItdSeSpuWT0Kn3mWoW9AUoLuI
         9ZVSeEXWTev6q3diuxhfjcVlJE+3TEeyHHixxxj7Z0kyhLr7qP6L1J3Ib1+4E/A1hrdV
         mef4TxbI390vqGSuvz6CFMaehZo5HxOwBKUT1oL5Vht1ofz1CIXEGhws+KzoAh60BO/T
         XO/fCkCSb/QS9/UtaDWtCXo0SG4HFKi3JU+TBL4QqtVz4ONl8IY23qKd/Y3BoPqcWjae
         KXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWhhT8jFmnU2pjoM0/QnnyBc9JunG/+wIXj29Er2ODU=;
        b=WH0rMmXdweFBeXfQGmNQdzRI6PBQ4PfG/6X/YvoR2jh433v+2mvxQNkWdnFnMgoXOn
         Ld6sVCjNHn1ZC4UPnk/cvB3emzPLEtarA5rAmyTMaOO4QBuXTRriAMJwl8w5MspKydkt
         tzh7Ykc1y4wjDvH5wPgAk8ruZF0NK5Ne8WK41aXdIFnCWV0xPpHd8+BJ+JiqXGeuo2sp
         GqW5hmjuF/9mYPcgPYdDVIqSbYdsVUmgV6J7MN3BQwKPVrw64amP3dXREghG6E1pNMLn
         kpsD3MlJ/rjLrJqrblNGPvlTqnmOmq7fR4MttiIhjrBmF0gLe+XM3/sbTI8xo7YYmIhz
         hqjQ==
X-Gm-Message-State: AOAM533hNPGq1pxrUtFtsElNb44d1HKeV7IluUYaOdiYnpXrZYXCG9GZ
        NhM/IY104DSUCIJU6QCCdkIezQ==
X-Google-Smtp-Source: ABdhPJxaT3cPRcpsyD4k8sjJlFVMFrC3zLlGRYIIRXfr/snRsI8zExSxkR8BniB4Y0vzhsjpPg07pQ==
X-Received: by 2002:a05:6808:14c1:: with SMTP id f1mr7988292oiw.12.1643907069791;
        Thu, 03 Feb 2022 08:51:09 -0800 (PST)
Received: from calvin.localdomain ([186.205.28.163])
        by smtp.gmail.com with ESMTPSA id t20sm18348318oov.35.2022.02.03.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:51:09 -0800 (PST)
From:   Jonas Malaco <jonas@protocubo.io>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonas Malaco <jonas@protocubo.io>, stable@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: ee1004: limit i2c reads to I2C_SMBUS_BLOCK_MAX
Date:   Thu,  3 Feb 2022 13:49:52 -0300
Message-Id: <20220203165024.47767-1-jonas@protocubo.io>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit effa453168a7 ("i2c: i801: Don't silently correct invalid transfer
size") revealed that ee1004_eeprom_read() did not properly limit how
many bytes to read at once.

In particular, i2c_smbus_read_i2c_block_data_or_emulated() takes the
length to read as an u8.  If count == 256 after taking into account the
offset and page boundary, the cast to u8 overflows.  And this is common
when user space tries to read the entire EEPROM at once.

To fix it, limit each read to I2C_SMBUS_BLOCK_MAX (32) bytes, already
the maximum length i2c_smbus_read_i2c_block_data_or_emulated() allows.

Fixes: effa453168a7 ("i2c: i801: Don't silently correct invalid transfer size")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Malaco <jonas@protocubo.io>
---
 drivers/misc/eeprom/ee1004.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index bb9c4512c968..9fbfe784d710 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -114,6 +114,9 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 	if (offset + count > EE1004_PAGE_SIZE)
 		count = EE1004_PAGE_SIZE - offset;
 
+	if (count > I2C_SMBUS_BLOCK_MAX)
+		count = I2C_SMBUS_BLOCK_MAX;
+
 	return i2c_smbus_read_i2c_block_data_or_emulated(client, offset, count, buf);
 }
 

base-commit: 88808fbbead481aedb46640a5ace69c58287f56a
-- 
2.35.1

