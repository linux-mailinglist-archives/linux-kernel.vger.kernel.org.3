Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1B4ECEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiC3VnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiC3VnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:43:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C46429
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:41:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 17so29526158lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNE+K6aDu2enlAqgj6GeTztEPSnohzO8AyYtemy/F9c=;
        b=pSATyB9fxJRjKEikBn3WvyikYkXymXibarl1mN1dcFTbIN27zwEc8vevuL1nXX5js/
         JEVZc18MRnPscESjwF5tO70CzTtuHdRPAEynfwS5gn3CTeB4tyFmqGXwbOXrdosLxdcB
         N2NgQLm/c3DwyDo29EhcupwYnqsY1ZBy1PeUVlDLbwlGTgSqAm0yyME+u2jNIWP+TzmZ
         ctlZs/Hj4OxKDL2dvwLkEWSt96TnrGxK7hGcGOceNhWrGj5zf8MTjelH7GjQN+PXw1Ef
         ZUgcF2UJtVMYLC1nQafns3G1V5JP6gYGijv3kVWHFpjJRGqxGVVnCwQPjpfENyd5J+lx
         Fdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNE+K6aDu2enlAqgj6GeTztEPSnohzO8AyYtemy/F9c=;
        b=7yuDWzwK/4OEFjcmJkGCWb7CbAbv8QsB7awcoNUEVQet2Zc8Gppo4s/noSGZKYFCAu
         BZfAnAA1WEsmdJFkNoWHLgIMtsxHsUU/WwDR7tdKlZryDYsHt7W+BOzmrLuZxREIokxQ
         hQkIF5MBhLMt4u15Q1YjBmgXc8xWjeDfAwhD/ekuZ1vmKcERRJbNBuU0VsYzC1ebiRqE
         2VCW2opIfKQuveU8gbhHr+CrrGcEpNI+wZ2+fYrfp0/1tvb27BtkQnwdxBNFCprI1xUx
         ABU5AHvAJbBak59r8iZuDtv6KwryLI23v4AbKVGtjBwHkR6+hfJdmfJXSRKjV7+f5vQx
         OC2A==
X-Gm-Message-State: AOAM531CDa558IXzErK/dNPB7PZ7DVuffU7ZwBqWa/OBMfVVpzZZPZtD
        2xtmYHdta+q0JlSbiZjoJ2M=
X-Google-Smtp-Source: ABdhPJzxAu3iSmYC4lOB6RR/z8J9giVm1Jjfve0X5UL3Btez7hAHjHPm4Vf0c4LB2bYx4DniHHCcTw==
X-Received: by 2002:a05:651c:887:b0:247:f630:d069 with SMTP id d7-20020a05651c088700b00247f630d069mr8334582ljq.514.1648676489693;
        Wed, 30 Mar 2022 14:41:29 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-188.NA.cust.bahnhof.se. [82.196.111.188])
        by smtp.gmail.com with ESMTPSA id h22-20020a0565123c9600b0044a3b2549c1sm2460848lfv.165.2022.03.30.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:41:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] regmap: Constify static regmap_bus structs
Date:   Wed, 30 Mar 2022 23:41:10 +0200
Message-Id: <20220330214110.36337-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to pass their address to __regmap_init() or
__devm_regmap_init(), both which takes pointers to const struct
regmap_bus. Make them const to allow the compiler to put them in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/base/regmap/regmap-i3c.c     | 2 +-
 drivers/base/regmap/regmap-sccb.c    | 2 +-
 drivers/base/regmap/regmap-sdw-mbq.c | 2 +-
 drivers/base/regmap/regmap-sdw.c     | 2 +-
 drivers/base/regmap/regmap-slimbus.c | 2 +-
 drivers/base/regmap/regmap-w1.c      | 6 +++---
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
index 1578fb506683..0328b0b34284 100644
--- a/drivers/base/regmap/regmap-i3c.c
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -40,7 +40,7 @@ static int regmap_i3c_read(void *context,
 	return i3c_device_do_priv_xfers(i3c, xfers, 2);
 }
 
-static struct regmap_bus regmap_i3c = {
+static const struct regmap_bus regmap_i3c = {
 	.write = regmap_i3c_write,
 	.read = regmap_i3c_read,
 };
diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
index 597042e2d009..986af26d88c2 100644
--- a/drivers/base/regmap/regmap-sccb.c
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -80,7 +80,7 @@ static int regmap_sccb_write(void *context, unsigned int reg, unsigned int val)
 	return i2c_smbus_write_byte_data(i2c, reg, val);
 }
 
-static struct regmap_bus regmap_sccb_bus = {
+static const struct regmap_bus regmap_sccb_bus = {
 	.reg_write = regmap_sccb_write,
 	.reg_read = regmap_sccb_read,
 };
diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index fe3ac26b66ad..388c3a087bd9 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -42,7 +42,7 @@ static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *va
 	return 0;
 }
 
-static struct regmap_bus regmap_sdw_mbq = {
+static const struct regmap_bus regmap_sdw_mbq = {
 	.reg_read = regmap_sdw_mbq_read,
 	.reg_write = regmap_sdw_mbq_write,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 966de8a136d9..81b0327f719d 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -30,7 +30,7 @@ static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
-static struct regmap_bus regmap_sdw = {
+static const struct regmap_bus regmap_sdw = {
 	.reg_read = regmap_sdw_read,
 	.reg_write = regmap_sdw_write,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 0968059f1ef5..8075db788b39 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -22,7 +22,7 @@ static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
 	return slim_read(sdev, *(u16 *)reg, val_size, val);
 }
 
-static struct regmap_bus regmap_slimbus_bus = {
+static const struct regmap_bus regmap_slimbus_bus = {
 	.write = regmap_slimbus_write,
 	.read = regmap_slimbus_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index 1fbaaad71ca5..3a8b402db852 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -172,17 +172,17 @@ static int w1_reg_a16_v16_write(void *context, unsigned int reg,
  * Various types of supported bus addressing
  */
 
-static struct regmap_bus regmap_w1_bus_a8_v8 = {
+static const struct regmap_bus regmap_w1_bus_a8_v8 = {
 	.reg_read = w1_reg_a8_v8_read,
 	.reg_write = w1_reg_a8_v8_write,
 };
 
-static struct regmap_bus regmap_w1_bus_a8_v16 = {
+static const struct regmap_bus regmap_w1_bus_a8_v16 = {
 	.reg_read = w1_reg_a8_v16_read,
 	.reg_write = w1_reg_a8_v16_write,
 };
 
-static struct regmap_bus regmap_w1_bus_a16_v16 = {
+static const struct regmap_bus regmap_w1_bus_a16_v16 = {
 	.reg_read = w1_reg_a16_v16_read,
 	.reg_write = w1_reg_a16_v16_write,
 };
-- 
2.35.1

