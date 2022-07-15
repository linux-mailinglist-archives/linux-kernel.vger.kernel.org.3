Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4A57682A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGOUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGOUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:34:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B68011A3F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:34:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so7732064eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wihsb0n6gcsXnN/ZX11aE7ujpg1ZGkFIavm0CFhkvw8=;
        b=f20Of98/kyuGYRFOXnXeZH0cyAjXmxX6SdDKxnduL83h1e+eQJFgFYNrupiC5rjI99
         zfZgW2XIVud3Nu7477yRKYqPn19f31T+sIGEFFf4chcFXm8tKWzSlyVQKNGcVzg6QURp
         hUDWdHTcKLrv4ZDQxebHE/vURHEoGW8/H+WaLNfKD1ZmL73B5mjRFJV8Z5LCVWHTnqat
         jEkMqoYcElP40Ofav3JDSzz9tMuhv7O978dLrYOMW5y8oJZAPXt9AQvBZyP7qd64xV3c
         26dY+X9oYxiHw6Rk+EMiaKjU5wlYvBpMpEmw2pm/BnwontL3YTnj+eVrVyCjxBpdHGOE
         J8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wihsb0n6gcsXnN/ZX11aE7ujpg1ZGkFIavm0CFhkvw8=;
        b=QU5xq/S2w5QApc2UTCj0wLtmG0DYXbJ+kwNPbwdmYF0E0FB3/3+Ri8yXtwKIyoJjo+
         J7JB0xxlpXW4wYsHMUcgetTigvFnlFC3+RFxP3k1daWzEoaGT4x5ZpTJDh9vLRS1lXjO
         YIjWh5vkqwZ2vCLJhzKubem8zU+0cgKQSlDCYJMov3bnPyqOS6LQm9S8slpWTBGeeOVT
         mUM37e4rvjeHU9nLu9RYu2N+Bzjrvy11bJ0XCRzpithxPWmknCqTsLsdU3YOYhxq9O3G
         +t3zCQO6/4/Fg1IXJBPPeg/G3zMZJ6VaGUuy5+3chA9rPYWknuyZYoCNIyTlEMrEBo7P
         clhQ==
X-Gm-Message-State: AJIora999vv2sFU6yJL0NLmsItyiRCfj5jlCH8QdrG/sDpohzJ3CbcEG
        3YmJaS8h0NBGKeGlPgAIHzM=
X-Google-Smtp-Source: AGRyM1vdCnsNftrR848qgWz3Aqx3x+Fk2pl+eTrwo1Khhu/1iF4kficM7cMbE24EebvUmyG49engEQ==
X-Received: by 2002:a05:6402:3297:b0:43a:9233:23b4 with SMTP id f23-20020a056402329700b0043a923323b4mr21231003eda.397.1657917243605;
        Fri, 15 Jul 2022 13:34:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t21-20020aa7d4d5000000b0043a5bcf80a2sm3465243edr.60.2022.07.15.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 13:34:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] regmap: permit to set reg_update_bits with bulk implementation
Date:   Fri, 15 Jul 2022 22:10:32 +0200
Message-Id: <20220715201032.19507-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A regmap may still require to set a custom reg_update_bits instead of
relying to the regmap_bus_read/write general function.

Permit to set it in the map if provided by the regmap config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---

If this is accepted, this is needed for net-next tree so a signed tags
is needed, if it's not a problem.

 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0caa5690c560..fee221c5008c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -882,6 +882,8 @@ struct regmap *__regmap_init(struct device *dev,
 
 	if (config && config->read && config->write) {
 		map->reg_read  = _regmap_bus_read;
+		if (config->reg_update_bits)
+			map->reg_update_bits = config->reg_update_bits;
 
 		/* Bulk read/write */
 		map->read = config->read;
-- 
2.36.1

