Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D205806B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiGYV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiGYV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9802528E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so17697611wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIkP5yEBR5GKJ3aUA9N+TAtTaSaKWh3Ceyc1uHZ1AFY=;
        b=zKLep7ZP4eQUE2OtQJy0AcAkUoBJ1gNOPxidZBMf41sAXrCfPPR+G890EhSHjDAZ2S
         OUoOG1Cp+aYpe50QOoRLEykFmbyk7h4EzowjtaWirRl9p04XknlmIbar33NEA0LemQcY
         owFAsyIenT0g3mA21NWs4H2bSAXPrlEYK6Q/A/7hWz/hZaCXQxvvyR3Qcrb1yFuwc9Dg
         nUuAJ9ZzZOGc3HnnSV5o5DhTvhOgHPXHmbu2a7u57TWBJNAW0x0hanzFzqAsCE+JI+0I
         unWOilFgalslP+48Qzq/YRPld1PDT6GqVt1ObqXctp3UIpKl2dqe7kwk04qH+Zxiiqa0
         maAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIkP5yEBR5GKJ3aUA9N+TAtTaSaKWh3Ceyc1uHZ1AFY=;
        b=Fhwl5ZkW8h4WfAiQPILs8XmIXVTqLnzraOIIOYx4g1skjazX7K74tlWFqRVdS3ETm7
         wgDy+XF4XSBc5JoU62cZC9NZjIXx1kheLsh8tI8qhA3gMSWUCv5NkNvsy/XUsYtDeDTC
         u3yRaqjuT+HKvKdKtCmWJt0WalNDy+OxEVGRLGySAA98Lk0vAA992wCUy7WMAXl+jeAa
         F0VbvZHAoGVQmLyN3hhJz79pgYRwvyOjDVHDpj5nJ0itlrt8p7qhgaBbL2Eoj4c9eSLa
         XiAYYOum7k2zVmeDhLvUvjHm40I5vgQ9LVtoNywhnE6T9IKDMpRv1a5bjGtZQelg5Tpk
         G6Kg==
X-Gm-Message-State: AJIora+IocOG52YcXlu1J6WQSvnuYlCv9PiFVbfH6d/+X798jEThtOHo
        /waCmvYamtwj8mH+Zy11jjdcpg==
X-Google-Smtp-Source: AGRyM1tARCp7uSjffUfQKVUoW24wjazyAHV4sc+dIhjRlduqJetCsedMAajv81sq9LCv7v9b5urcgw==
X-Received: by 2002:a5d:4ece:0:b0:21e:7ed1:f195 with SMTP id s14-20020a5d4ece000000b0021e7ed1f195mr6434201wrv.662.1658784460116;
        Mon, 25 Jul 2022 14:27:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 18/32] thermal/drivers/rzg2l: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:23 +0200
Message-Id: <20220725212637.2818207-19-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index be07e04c6926..0db784f7d5ed 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -111,7 +111,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static const struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -203,8 +203,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
-- 
2.25.1

