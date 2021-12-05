Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBC468A99
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhLELoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhLELoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:44:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685DC061714;
        Sun,  5 Dec 2021 03:40:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w1so31101214edc.6;
        Sun, 05 Dec 2021 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=qqDG36Im/SqcWK08VkQJsKEabZenC0fo96rTKOG7DutFouW/AOFgA0yyhn4RXprTSL
         aTUIGLQx9FZjc6LwvcyDqaebuuzWeZGedtvwafCTMx1ym9iHU1w7sQoBPV+cx7oajmaP
         VF7V5fbrjSRy4g6GemCL4CGH1hu03W2iJmfRGUvpCENjqpscZi0R66jIHYlqXOdOEDap
         I2VgvcOZv+guM1RSU17lSHzp/BKGw93mE5x51+cl40x2YSsmCkJlLq9hzLpZTgQ0TdAV
         L6G8LZ7rV+sy4fWC2u16zkxRBnfZCWEYzBr8WPDf11JktIcaFlmf6UNh3bYLp11ecExx
         1jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=0/GBNMMEjBUIdA3gzXtqHCaMayuAOLV7VbI5IgpygZ1vigduQ/u4CP8TLoTzne+Mo5
         sUJCSphwG5l4CIOP2xCn6zorVCAeuoaOwtcbtUFR0BJfjEHy4CeiIEefgekEiu4oALRt
         AWrZ74tXpd5bpAjtnbZL+O+/QtckW12RviEyn/o1ucw+z36aFAp6hzWIwhvj5GEMuDon
         XAbmwRQCNvTqPSfyepE61c91OeqSxvZV4Boou2MtstiG0C+dlnp/oP8CPFgQlj9LpZBg
         gz9UO9xgh+vwJbCU7ZUkWEw99xHcAJVBbzlZStCX0Q6UDpcDI7gyc9XAuUza5BDqESRT
         K0mQ==
X-Gm-Message-State: AOAM531zjbKTlF+W90n0ID7D/je6NvmoQ68XD62xbtODaRP+syPBaYUN
        +t3gFPuNI2hxv+bwm04ZgEQ=
X-Google-Smtp-Source: ABdhPJwqYwGdGa5w3/MJ/UjlgrAYMR2ZqIipFIVSgD545YJ+M8PLeZryRW+gcuIiM9ZvALUvJTh1Ew==
X-Received: by 2002:a17:906:4bcf:: with SMTP id x15mr38029624ejv.273.1638704452461;
        Sun, 05 Dec 2021 03:40:52 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id g11sm5870469edz.53.2021.12.05.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 03:40:52 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v11 1/3] iio: add addac subdirectory
Date:   Sun,  5 Dec 2021 13:40:43 +0200
Message-Id: <20211205114045.173612-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205114045.173612-1-cosmin.tanislav@analog.com>
References: <20211205114045.173612-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IIO devices that expose both ADC and DAC functionality.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/Kconfig        | 1 +
 drivers/iio/Makefile       | 1 +
 drivers/iio/addac/Kconfig  | 8 ++++++++
 drivers/iio/addac/Makefile | 6 ++++++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 2334ad249b46..4fb4321a72cb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/addac/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/cdc/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 65e39bd4f934..8d48c70fee4d 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += addac/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
new file mode 100644
index 000000000000..2e64d7755d5e
--- /dev/null
+++ b/drivers/iio/addac/Kconfig
@@ -0,0 +1,8 @@
+#
+# ADC DAC drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog to digital and digital to analog converters"
+
+endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
new file mode 100644
index 000000000000..b888b9ee12da
--- /dev/null
+++ b/drivers/iio/addac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O ADDAC drivers
+#
+
+# When adding new entries keep the list in alphabetical order
-- 
2.34.1

