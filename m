Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381A51F8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiEIJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiEIJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:03:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72D1A3B8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:59:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k1so13248781pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sx4X5idiTB8diHSkHofGP7McwC9VOX2bxNNbtsqQ25g=;
        b=RTlCVXMRkBRx7ZUc8I4lCbIk1BB+b9OR4ZKDkuCW8re6QEYw7hwZB3O7t3HZGsPpVX
         8+9CANeoTlvXFyxID9IUrFZjtLX0lgWFhRDKB/IJb6m701ulacPVPInNOwbjLcsWsC6a
         rA2O4a98nRz8o+wDHPdBKWhfGRmn2ynDZL8uY5Guat4KzCLWX90WLm3yB6v57kyC+cfF
         29QLm4X/ty4ir2S1FKPJbujvf7oIyRJV30Xrr+IE2OfkfbeLKbifEX6EgJz81u46grF1
         Pn05W4Y+UCDp6zj7rasqXbbiiTzyqgQ+P0uSo6PDguSEeh7uKwseBPSKhnG6rUS1F/3v
         0waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sx4X5idiTB8diHSkHofGP7McwC9VOX2bxNNbtsqQ25g=;
        b=1V8iovVuF/jfhjtFCz92j9jZwzoJpiWRBRf6MDz+TbbW0+anAeKOLeunY+uoI28dyW
         aiC0ey48Ia7fIBIRi/sSkxfgN0H5gxYvHK+EuMRNvqHawLAfQ90dsa1EJjlJJkwAy80M
         1Jj/P3BNLDuJhGDq4kVz721MYUU6EcyxgkQXXWSUMe5kMRmppNcVxJCoBHDSB6g/04Bc
         Z8NuwqpceoHANLBdBA+7cYNMMypRZzpP8tXHXI/y7dcMOAfmp3BNKW5JKr8u8fkuA2vC
         kBrKEIPa/RHkQUYU5qbKVl0rExKGwggYepxD9IHqDPbLOQKJ3JWfUQsbdE5u2fnN8UhV
         /zBg==
X-Gm-Message-State: AOAM532GIePZO3eVAWRoI3wFKzY9xurskZv5fGf68bez/uNsOhw6qQbQ
        rI0wOiwxY3sVKIGN1l+Rkw==
X-Google-Smtp-Source: ABdhPJwSUOEf5enWGUDjDGUYXVYfE7P7K5G3N+W0oPGsMNLPlQZ1JtL9o+AiSKOGqoPSgCM6dHWZWA==
X-Received: by 2002:a17:90b:3445:b0:1d6:91a5:29fe with SMTP id lj5-20020a17090b344500b001d691a529femr25286739pjb.138.1652086784472;
        Mon, 09 May 2022 01:59:44 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709028c8f00b0015e8d4eb1d7sm6455346plo.33.2022.05.09.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 01:59:44 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ASoC: tlv320adcx140: Register a callback to disable the regulator_disable
Date:   Mon,  9 May 2022 16:59:25 +0800
Message-Id: <20220509085925.1548328-1-zheyuma97@gmail.com>
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

The driver should register a callback that will deal with the disabling
when it fails to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/tlv320adcx140.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 32b120d624b2..f70ea59259f1 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -1083,6 +1083,13 @@ static const struct of_device_id tlv320adcx140_of_match[] = {
 MODULE_DEVICE_TABLE(of, tlv320adcx140_of_match);
 #endif
 
+static void adcx140_disable_regulator(void *arg)
+{
+	struct adcx140_priv *adcx140 = arg;
+
+	regulator_disable(adcx140->supply_areg);
+}
+
 static int adcx140_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -1113,6 +1120,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 			dev_err(adcx140->dev, "Failed to enable areg\n");
 			return ret;
 		}
+
+		ret = devm_add_action_or_reset(&i2c->dev, adcx140_disable_regulator, adcx140);
+		if (ret)
+			return ret;
 	}
 
 	adcx140->regmap = devm_regmap_init_i2c(i2c, &adcx140_i2c_regmap);
-- 
2.25.1

