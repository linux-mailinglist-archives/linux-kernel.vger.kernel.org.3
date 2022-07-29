Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD77584E16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiG2JfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiG2JfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:35:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2614140B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:35:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bf13so3584572pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVF3y7QB8gY+KNNuUfkiCKf/IXKM8mP2Ri70A+tABKc=;
        b=Mg0AXzsUX+08glZ5ua8BKGJOWS9ZgPWopKBkPg3u3Mjahu2Ptdc689CwTbvUNQklCV
         3b/sSwvG1BWHv+B+m+LE0qcph9ulUlqq47lpMbBrE9h8R4cCBmzq+Df1Xnmc/SyX23R4
         YigcAS+ezWhEIjDa6jiQ5Fc0qXTDK5pKa+HE0h6J9eeUz0oSo0UEI+83GkdhpwKhx9h7
         WvNqbZ6Emgk+OOGWdHxFIazxxMAhyayqJDqNNk2J4WUZRN9EvKxKTvYRlYqhf/NMA6uf
         3/RAt6ejM/j5S1aatHw+cMLOLZD6Lqs9tGjChUywbhnwpe51gICrHs3+/4sf0Wm6NN+0
         Qu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVF3y7QB8gY+KNNuUfkiCKf/IXKM8mP2Ri70A+tABKc=;
        b=oMTfZqUNWS81tCNWKNO8znB6gguTTvKSAu+46d6VpsAo75IKXRGXXzmfnIgztv9Pty
         aK6/T0eTDQq4WcRpKEE9zAJP68fRB5dUJKNqRJEq9FnkfOxDg3p9ND9LcxxgpjxvtWOJ
         40lcHOHAv2ASw//3KL7oXvFxvjXzcUNjMfCz5fnUaMdP9gdtsUQVBSlgiYQlaGJvKauf
         oFWu+OUjKWCXpUiegoaTgmdzpevmFWGIM5BGmNy3cwZ3TbTtuW+xMjUZaC9isPtQQbao
         gx5m/r14Ar1597EsSkw7P2yZL5DOIRn6JI6uppunv869l4y6rY5TGedtV+Nrcac/MVVS
         82yQ==
X-Gm-Message-State: AJIora8/1GGPWFLUMZZErKLDQBUaZw8y6ujB8WfLvfUiOr/jsKIfgRGV
        2OFIVdeuSRZ1NzNbkst10A==
X-Google-Smtp-Source: AGRyM1s1OBR0CdZueQ6wLASKBU/Xr85jaWW4z4VigRVFw0nPop5Rf+vD8b7gwmtamzJECFF6bsTYdA==
X-Received: by 2002:a65:6e82:0:b0:41a:9b73:f0e6 with SMTP id bm2-20020a656e82000000b0041a9b73f0e6mr2297713pgb.371.1659087301099;
        Fri, 29 Jul 2022 02:35:01 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a7bc800b001f2ef3c7956sm5407398pjl.25.2022.07.29.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:35:00 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: ismt: Fix an out-of-bounds bug in ismt_access()
Date:   Fri, 29 Jul 2022 17:34:51 +0800
Message-Id: <20220729093451.551672-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver does not check the data from the user, the variable
'data->block[0]' may be very large to cause an out-of-bounds bug.

The following log can reveal it:

[   33.995542] i2c i2c-1: ioctl, cmd=0x720, arg=0x7ffcb3dc3a20
[   33.995978] ismt_smbus 0000:00:05.0: I2C_SMBUS_BLOCK_DATA:  WRITE
[   33.996475] ==================================================================
[   33.996995] BUG: KASAN: out-of-bounds in ismt_access.cold+0x374/0x214b
[   33.997473] Read of size 18446744073709551615 at addr ffff88810efcfdb1 by task ismt_poc/485
[   33.999450] Call Trace:
[   34.001849]  memcpy+0x20/0x60
[   34.002077]  ismt_access.cold+0x374/0x214b
[   34.003382]  __i2c_smbus_xfer+0x44f/0xfb0
[   34.004007]  i2c_smbus_xfer+0x10a/0x390
[   34.004291]  i2cdev_ioctl_smbus+0x2c8/0x710
[   34.005196]  i2cdev_ioctl+0x5ec/0x74c

Fix this bug by checking the size of 'data->block[0]' first.

Fixes: 13f35ac14cd0 ("i2c: Adding support for Intel iSMT SMBus 2.0 host controller")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/i2c/busses/i2c-ismt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 6078fa0c0d48..63120c41354c 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -509,6 +509,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 		if (read_write == I2C_SMBUS_WRITE) {
 			/* Block Write */
 			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  WRITE\n");
+			if (data->block[0] < 1 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
+				return -EINVAL;
+
 			dma_size = data->block[0] + 1;
 			dma_direction = DMA_TO_DEVICE;
 			desc->wr_len_cmd = dma_size;
-- 
2.25.1

