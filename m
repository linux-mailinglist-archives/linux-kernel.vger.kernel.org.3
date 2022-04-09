Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8F4FA21C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiDIDvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDIDvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:51:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E2B1B;
        Fri,  8 Apr 2022 20:49:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t13so9410163pgn.8;
        Fri, 08 Apr 2022 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92wj7gMEVaUp8lV7pE8Nu1NOt/1g7RPRL2sDQ/iSfsk=;
        b=ETk+Rk8C1nrNtSH55oFVg2VGJ4UdnbtJKBTwLPFprn14T+ZBzLaWPlsm3bM/yq3jSM
         EGXrbX4igGn6nWnvZ9S29ONmh+5IU9b7ZcAkmZ91wqTEhjHp2GEYCbFRIkGgBtNAY0kN
         euiB1m5pVTt6SeknokuhRRF0dSe7ZZ+2iLelXwyimDXoCzLbvOZQ/o4W+OswlTxzSfq3
         EGgcDbcJaNThAIbJkQa76oV8BeQWp1rT486OsA39+2FsDBUXVWXLJLDGgoLvUxOn3ghh
         uYCMu18GsgSrqbm42hmo0Hu8VofT0glZfBy/aOMvlCGgdNMABNz17raWwqIrvYZHZ0Gq
         IaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92wj7gMEVaUp8lV7pE8Nu1NOt/1g7RPRL2sDQ/iSfsk=;
        b=f8F82Sg29qdBAr5XKvkoVsLQRPNsqjF8pc6IGp//Fz71CoqFtxDWWjJ6jK9KBWjg3Q
         m7wwIytTmBBMGXv6wt/ccoSnC+urENZ7SZsBYHwrHekKSZnqXEw0Eg6/jpw1icHNRfIT
         L+rM2P3JoDU1uAYamzn4Oqlc4hO0g2yDjihgWnOrIjvjfp2X/mF6bCfJVu7/PORtp4Hw
         yR/sIvMvmqchoxQTQrHp+nQ2SNP8rbRXBqYFShqL9D3dQI9Bh0LJomxPO7E2kOY8FBCH
         2IQBSF68hhSqqFxymF+sXKXFNLyMO+qFFrS196cseAR8tQsQ7v9FHmgbKQGog6axzh4O
         TnPw==
X-Gm-Message-State: AOAM530JecSXpuzLv7qzHhSjo3qUpVn/pvqfq8wSLq3gba+U2x5nnf5I
        cPIDw56pfGvpoxOW8u7DD7IK9aoYGjJ4ktw=
X-Google-Smtp-Source: ABdhPJysLtgFULrIrJEmugF8C6BEoAYT3IgFsAFbtRsCZexzRejP+0fLUE4Yr1NevoF6agJcpbOlzA==
X-Received: by 2002:aa7:978d:0:b0:505:895a:d38d with SMTP id o13-20020aa7978d000000b00505895ad38dmr6352749pfp.12.1649476143270;
        Fri, 08 Apr 2022 20:49:03 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a154600b001cb59d912f1sm1381875pja.13.2022.04.08.20.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:49:02 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] iio: magnetometer: ak8974: Fix the error handling of ak8974_probe()
Date:   Sat,  9 Apr 2022 11:48:48 +0800
Message-Id: <20220409034849.3717231-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When the driver fail at devm_regmap_init_i2c(), we will get the
following splat:

[  106.797388] WARNING: CPU: 4 PID: 413 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[  106.802183] RIP: 0010:_regulator_put+0x3ec/0x4e0
[  106.811237] Call Trace:
[  106.811515]  <TASK>
[  106.811695]  regulator_bulk_free+0x82/0xe0
[  106.812032]  devres_release_group+0x319/0x3d0
[  106.812425]  i2c_device_probe+0x766/0x940

Fix this by disabling the regulators at the error path.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/iio/magnetometer/ak8974.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index e54feacfb980..84bbf7ccc887 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -862,6 +862,7 @@ static int ak8974_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "failed to allocate register map\n");
 		pm_runtime_put_noidle(&i2c->dev);
 		pm_runtime_disable(&i2c->dev);
+		regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
 		return PTR_ERR(ak8974->map);
 	}
 
-- 
2.25.1

