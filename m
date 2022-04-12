Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4626D4FCCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiDLDCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiDLDCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:02:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD68659E;
        Mon, 11 Apr 2022 20:00:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so1270273pjn.3;
        Mon, 11 Apr 2022 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uU3ASWwQMXglTC0BJovN6yhg5XXxgX4m5/XBuAm/JyI=;
        b=jvcE4mrDotCy7xNE4Bu4NGcT7b5pc9/AWKU40YrtiyQHLR6QLCwoupFxGocFjHnpMK
         DVWtoyjnX5XzMglhlVp8adrLOJnU3Wcfq7E37bGJcMd4bKa+dre0Q+hdh2mQii+xGd4K
         ggn2Qe6kMJUG0tVTAIN+ZNYVKup/SWOtn8+MWWrxZv5N6ErTXvZrDBpxNG1XVESnF+Df
         bg+N/27iAJ+i3/c5V3dD1Dwx+qHG2p6Zr3KvpZ/Qf4ZJHRny/ZunGxcYIXD8YUhSL7RF
         HgKyrV8YHD4DNIlKlc+dVEfY7xXTjRituLaJG058MnLfEqvgj8VsA9suIxXvtOiCcJP6
         xrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uU3ASWwQMXglTC0BJovN6yhg5XXxgX4m5/XBuAm/JyI=;
        b=dnrEKZ5zUQULmpJnQvbYNaRTKZwbULTzaqkkAvJ65VeRv4W9PhyKVRd7gVAUkauvau
         Pj4dbR7sK8U5beCjTQuse/0BTo/IGkQOYevVYZGihnPbtkqJIFx1vTyY0EcXKKopXGin
         2fcPG40/4oqaoKoGID2XEIIuRoLJqinzofoNSWASL7wXeNLRXC7cOYm7xNp32qd5ncy3
         1CSCgpc97jz08ew7/3e1MdumeISiN7MtjjtFQMlr/LZIO7WoSgPYPGW9KzypCg93SMK2
         WPAuDhG99JCmgeil/A4XZ6hhfFxSYBgrriBsVNYry+wKh9eXcqDE1e/Q0HPgY8FItVtL
         HGyg==
X-Gm-Message-State: AOAM533VJfsadg+sBb35NDxWVD9teS8ZaWzgHTtUvglqvi9Mw+701h7a
        xMW1pK/e0FO9MxX+oJoXcOne2fsYkOCQjzaaV5E=
X-Google-Smtp-Source: ABdhPJw7lrJR/7sYrVrkxswZFXRGv/C7RoD6rHnhOaG/5pCsYoRqU6xVpldn1WqGT+fq5T93EQY8nA==
X-Received: by 2002:a17:90b:2685:b0:1cb:6521:dd78 with SMTP id pl5-20020a17090b268500b001cb6521dd78mr2580838pjb.194.1649732427708;
        Mon, 11 Apr 2022 20:00:27 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm860544pjb.2.2022.04.11.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 20:00:27 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] iio: proximity: Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 03:00:21 +0000
Message-Id: <20220412030022.20249-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 3cef2e31b54b ("iio: proximity: vl53l0x: Add IRQ support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 661a79ea200d..a284b20529fb 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -104,6 +104,7 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	u16 tries = 20;
 	u8 buffer[12];
 	int ret;
+	unsigned long time_left;
 
 	ret = i2c_smbus_write_byte_data(client, VL_REG_SYSRANGE_START, 1);
 	if (ret < 0)
@@ -112,10 +113,8 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	if (data->client->irq) {
 		reinit_completion(&data->completion);
 
-		ret = wait_for_completion_timeout(&data->completion, HZ/10);
-		if (ret < 0)
-			return ret;
-		else if (ret == 0)
+		time_left = wait_for_completion_timeout(&data->completion, HZ/10);
+		if (time_left == 0)
 			return -ETIMEDOUT;
 
 		vl53l0x_clear_irq(data);
-- 
2.17.1

