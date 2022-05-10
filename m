Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A3520D37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiEJFet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiEJFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:34:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63B3ED11
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:30:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so15815355plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZBTRCetz4f8JjwfC8Y2BGBpMlfsgeXFFqeHVV3ckOA=;
        b=jw/srrS0ZfUDJ8keMulrQPjAw7MT4o+47nOXcHWUxrKOxQL4O5nQUr8Kq49LQ0Go5D
         GrF0x3TZyChuMYBM+dernNDY1QslDGXEUP4tf3snZB+mX21Uo52ie19mIBalAUtYUg3M
         qhweROzoXjmE6g2BeBbrhYwjGoE/1KMVDw9p9WnfJ+66cqDUbDLFO0F+n/6+fJHuWotA
         z1tLeE/ziJT0rDUi/yB9NEIKjB+Mst4G6oQatN7f3fjAjdLqqN2Yq/ieWMyUntP4pOoj
         d8zPL+Mg+sQd2L3/rEbvDTc84woLxjljrLXTFFSYSeBRC//k1HtKA5sd7BqbqNgmZ2wR
         Tkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZBTRCetz4f8JjwfC8Y2BGBpMlfsgeXFFqeHVV3ckOA=;
        b=8Et4mFxGBkCe3juOG12N8AlH2AsHae5Y2QR7ocJnYpwD7e2EmNAc0jzMa5P+fkqQQ7
         IA91mKSjHBYX1j+07glUDFJH4e/9gyW+bMv5apaI1B2DpU4rADfD6Ej9Ur45O1sgoChI
         7nbj47+vFJOvqAqDFcW95Vjbh37gWC+mCgGgVa4zGCsA+sKuNlKKIW2PziD1Ib/pQvIg
         9C9A1vFv+1z+/bDR63UTCKa9Te6S8NCe0BIJW8n9W+2nohZj74YBGBKb0HyPX9qIo3Ce
         Ccx2SfVLBMgKYYpyFw3Sj83AnBHt2Fp9J3RwJtr1iZ7YwirG5/K84sDm5J8kIMdelo3B
         ehsw==
X-Gm-Message-State: AOAM531xlPY7ibj7Mosj5FLtSf+W1Sq/ybhuXM0tTznSryMawwPI0Pzs
        LZj4BDfl9/rvpE2N/KDfMQ==
X-Google-Smtp-Source: ABdhPJww23i8t0fb9Ibrlq2hy+Be5xXcM/Aqi2CmI/X1KigvrQ83dU1sRY+YbgPQjrmP6cYYQBxZ2g==
X-Received: by 2002:a17:902:e5c7:b0:15e:9bba:d4dc with SMTP id u7-20020a170902e5c700b0015e9bbad4dcmr18989466plf.95.1652160648124;
        Mon, 09 May 2022 22:30:48 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id 205-20020a6219d6000000b0050dc762814bsm9676527pfz.37.2022.05.09.22.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 22:30:47 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] ASoC: tlv320adcx140: Register a callback to disable the regulator_disable
Date:   Tue, 10 May 2022 13:30:31 +0800
Message-Id: <20220510053031.1685337-1-zheyuma97@gmail.com>
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
Changes in v2:
    - Generate the patch based on the latest source tree
---
 sound/soc/codecs/tlv320adcx140.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 0b06fbb14171..b55f0b836932 100644
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
 static int adcx140_i2c_probe(struct i2c_client *i2c)
 {
 	struct adcx140_priv *adcx140;
@@ -1112,6 +1119,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
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

