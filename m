Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57499579C67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiGSMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiGSMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:38:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319A52E66
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:15:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bf9so24384231lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34WEw9awHu7gIj88S8fD4edkfHyl6opCxCuZk5MV1WY=;
        b=AsAWj/AoIqTCw/y/vRqi6d8PBRZR41f9vcEoK7NedJ6XFDli5M0KyZDzdKjJWDJoWG
         LDjCB7vRB7MYilrC0pCactxmsHmQkI6bUavPH+Lv7JtztyqDLzwlbI5Q8FEZAn9I1QkZ
         WdrxeJjZ+YZ3BrKlgAxyiCtVQHLCRIDPd27xFEANiIu/7EQlkYZq3Faxfw4xJiCE1aKQ
         +Rcnxihrxu/rYwRLNsH0R7EJUTM/W1i78x/z2r7Bo8ePRTSjYonHaZOdZMglfR7jvGEJ
         xmaBVkCPXGLEXflU1IEFmQdYpwpeEa7ftbgXZCQpGS494JPwzLt0W5gg0d1S8PxgHBF7
         pW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34WEw9awHu7gIj88S8fD4edkfHyl6opCxCuZk5MV1WY=;
        b=swBuj9unujzmwfjvRHg+3OfF3a1LMtkmynN9tk8nmtsqlDc71mnJ+J4J/x59K2ejaA
         24E4/GoTyBBSlEJcBNNHljqWcMkgMbzdoCgjNZk45w/kGNV8ZDVUR7PIt9VdApkSMEjR
         4vTGWdU5Wrnyqrf2wZPcgY3SFtgPtUYG3i+xpjsxp/6b2pH/Jmes7WXkpbHOgJkWPUSm
         4zowCjW2opK8IpBioTOfZhKndWKqoPoAfc0YDiR6B5RdIT2+oEKIFXkly8wYyVFWAfVQ
         eBdoFiR6NJ7BsPVS2VuIELQaZd05RQ57Czza2aaS+hbWQir+fkzwEdPwHiyd/dtYCJpU
         HYDQ==
X-Gm-Message-State: AJIora+QIxYek6KB6kGLC17i2zuevTp4+YDwf13QOTUvQFOS1BncToh5
        0ukbEyjFDW4OLylanjKj6Oy+Thzsk+NgyPNc
X-Google-Smtp-Source: AGRyM1vwNaBHrVb4CXTu+XUlQy3SHZi0HMjGdsNr6AqpyVAKYAfPFMrJ1wVoHuOPNgq3wvLyxpSTZQ==
X-Received: by 2002:a05:6512:344e:b0:489:f4ad:88d8 with SMTP id j14-20020a056512344e00b00489f4ad88d8mr19034026lfr.297.1658232899046;
        Tue, 19 Jul 2022 05:14:59 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p4-20020a2ea4c4000000b0025d6c8cfafcsm2645676ljm.93.2022.07.19.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:14:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] regmap: support regmap_field_write() on non-readable fields
Date:   Tue, 19 Jul 2022 14:14:46 +0200
Message-Id: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of regmap_field_write() performs an update of
register (read+write), therefore it ignores regmap read-restrictions and
is not suitable for write-only registers (e.g. interrupt clearing).

Extend regmap_field_write() and regmap_field_force_write() to check if
register is readable and only then perform an update.  In the other
case, it is expected that mask of field covers entire register thus a
full write is allowed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/regmap/regmap.c | 50 ++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       | 15 ++---------
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0caa5690c560..4d18a34f7b2c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2192,6 +2192,56 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_noinc_write);
 
+static int _regmap_field_write_or_update(struct regmap_field *field,
+					 unsigned int val, bool *change,
+					 bool async, bool force)
+{
+	unsigned int mask = (~0 << field->shift) & field->mask;
+	unsigned int map_val_mask, map_val_mask_h;
+	int ret;
+
+	if (regmap_readable(field->regmap, field->reg))
+		return regmap_update_bits_base(field->regmap, field->reg,
+					       mask, val << field->shift,
+					       change, async, force);
+
+	map_val_mask_h = field->regmap->format.val_bytes * 8 - 1;
+	map_val_mask = GENMASK(map_val_mask_h, 0);
+
+	/* Writes of parts of register are not allowed for sanity */
+	if (field->shift)
+		return -EINVAL;
+
+	/* Mask of field must cover entire register */
+	if (field->mask != map_val_mask)
+		return -EINVAL;
+
+	if (change)
+		*change = false;
+
+	if (async)
+		ret = regmap_write(field->regmap, field->reg, val);
+	else
+		ret = regmap_write_async(field->regmap, field->reg, val);
+
+	if (ret == 0 && change)
+		*change = true;
+
+	return ret;
+}
+
+int regmap_field_write(struct regmap_field *field, unsigned int val)
+{
+	return _regmap_field_write_or_update(field, val, NULL, false, false);
+}
+EXPORT_SYMBOL_GPL(regmap_field_write);
+
+int regmap_field_force_write(struct regmap_field *field,  unsigned int val)
+{
+	return _regmap_field_write_or_update(field, val, NULL, false, true);
+}
+EXPORT_SYMBOL_GPL(regmap_field_force_write);
+
 /**
  * regmap_field_update_bits_base() - Perform a read/modify/write cycle a
  *                                   register field.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7cf2157134ac..08507e764dfa 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1307,6 +1307,8 @@ void devm_regmap_field_bulk_free(struct device *dev,
 				 struct regmap_field *field);
 
 int regmap_field_read(struct regmap_field *field, unsigned int *val);
+int regmap_field_write(struct regmap_field *field, unsigned int val);
+int regmap_field_force_write(struct regmap_field *field,  unsigned int val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
 				  bool *change, bool async, bool force);
@@ -1316,19 +1318,6 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force);
 
-static inline int regmap_field_write(struct regmap_field *field,
-				     unsigned int val)
-{
-	return regmap_field_update_bits_base(field, ~0, val,
-					     NULL, false, false);
-}
-
-static inline int regmap_field_force_write(struct regmap_field *field,
-					   unsigned int val)
-{
-	return regmap_field_update_bits_base(field, ~0, val, NULL, false, true);
-}
-
 static inline int regmap_field_update_bits(struct regmap_field *field,
 					   unsigned int mask, unsigned int val)
 {
-- 
2.34.1

