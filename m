Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F94FA21D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiDIDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDIDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:51:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECFB1B;
        Fri,  8 Apr 2022 20:49:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n9so9538654plc.4;
        Fri, 08 Apr 2022 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAB1CWkgxiHw4HUF6r2P4Qy7CzN4zneAQv5QlrZk820=;
        b=AN20H0givpH5a95igRcZjHt3XQq2YUXOfgGMbt6u8WNJ6JkvEiBj1PnG4ICcL4amcM
         GMW33lpsP/TOn9LtPO/Xr+F5C7siXktQEoRggajVqaiN8mqP6bDDDhI4/RoSZBVyQLs4
         hiqrM1pQW50wp/H3vH4iPriBTXa3eSpSg75J8VpIkOHs8HnTzvYOAvYkzi25KntbwgRT
         i/Qm32spMigx84YDt52TICsVQpXcXv09OEbnj6eIhgSdKwtCF4yyKcdfxFxesLKITpdL
         g/xO+rKUKW4w+9CWp+5ogJ4hl/H2JXJe93Zxi1yGSkZsifnU4zwh7eSinIGKLscAb98u
         t8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAB1CWkgxiHw4HUF6r2P4Qy7CzN4zneAQv5QlrZk820=;
        b=beY1wf0bftC6jNVrFs5lfzFmDSCsPgEDfFT5ZjIQQ/q08AX0H3y81rI84x+uoyAmYe
         xdycd6ECb6qqyWPMho+VfI2ToB5cCqN0XiKPTOXQajF7dgFHeObPnhcSQJ24hD9Ismsj
         I1ACGZWk4mnI2iBVvTyTHIStBqyljx3qyYAFoUt/UqzP/NRi/mritqEO7qkzyh1bdkmP
         pOFym7fMhKSWE9V44QDCDsPK20YoHN5ejLeU0+ok9/0RJm5ZEY92eH7JxTEz4xGPr6RR
         T0h+jprH2LGxi8LSdBZrMy6m/RIvy3YjjwRE4KzIvndpntQRP2+RKyDkGYRPfRr5d9Ra
         pplg==
X-Gm-Message-State: AOAM533NmJV1a+wtDRWi8t/zMCiIOAMraVpIEQK22LrZfaiR2bCbTsUo
        mHFHJkUVpBMecJxwVA41Jpi//jNvRoFIEIE=
X-Google-Smtp-Source: ABdhPJyXuJ8HBFY3m+XmrZ/pnkRNv0gA7p4d5haDnUbfzC/fQCFsfko3tQ6/GIu+s0g6nmt4EnW+mg==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr21977224plo.103.1649476147161;
        Fri, 08 Apr 2022 20:49:07 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a154600b001cb59d912f1sm1381875pja.13.2022.04.08.20.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:49:06 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()
Date:   Sat,  9 Apr 2022 11:48:49 +0800
Message-Id: <20220409034849.3717231-2-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409034849.3717231-1-zheyuma97@gmail.com>
References: <20220409034849.3717231-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails to enable the regulator 'vid', we will get the
following splat:

[   79.955610] WARNING: CPU: 5 PID: 441 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   79.959641] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   79.967570] Call Trace:
[   79.967773]  <TASK>
[   79.967951]  regulator_put+0x1f/0x30
[   79.968254]  devres_release_group+0x319/0x3d0
[   79.968608]  i2c_device_probe+0x766/0x940

Fix this by disabling the 'vdd' regulator when failing to enable 'vid'
regulator.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 088f748b683e..2432e697150c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -416,6 +416,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	if (ret) {
 		dev_warn(&data->client->dev,
 			 "Failed to enable specified Vid supply\n");
+		regulator_disable(data->vdd);
 		return ret;
 	}
 
-- 
2.25.1

