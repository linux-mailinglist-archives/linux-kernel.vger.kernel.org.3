Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0266F468A86
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhLELiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhLELiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:38:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45856C061714;
        Sun,  5 Dec 2021 03:34:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so31457741edd.3;
        Sun, 05 Dec 2021 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=DrTKefacAzC9gDzXBkApo71x5UOuu19F4FTFZ3AHLv0dCsQ8pAQ4SqJ5vbnvLTFI7r
         4RKlQF50eNIDKic3cPRyMXusoPWRFYicc9So7TdH60Xg7kub6OZ3i/nolHuYFfbgmlgG
         UyhPGB3+IlWQG1NZ8LMMjaiUQfZdHCrJpdKuUPzVaOOnHz1n/GEN8AawdxN+XNXcKJUX
         +hAM0MRI3JRlEqFK42UHMeuu6ALsOEQFrWo67ZPdk9Q2MnIOQNIW+8rlaOaHYnKhh4xK
         4SrIIqrRyPHwBoPxyDPEiaePN+JtkYtywKrN3rjyZX9UyE9u94Yv59N9kCLnJ6E5tSQe
         xECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=qTetZpa3Xkw2QRKuEIask0GZHEYWQcE9gk/pJkXdtcBDi5PwrG1Tu7K7mRI5GFOK/0
         GVQYgzAnOF5tI12sEO5cOPnRUieCJiWU9J2U5skF2AhfV4ntoFknm+ZKa/RNEHOkqFKO
         vEPFcciHndDr11HLfxiu/P+89/tO7MrsuP4XnpPZKKI7GiwSM0CkqqZNB4F5iN9YIudq
         2+KyGo2pa3Meve/3LewChHspKyxRzcO+4MoB6Z7aMr9y2g3W+HWh4WLUMtbyWAH5DQSL
         l6Y5gk9GvMPkxKjUji4fuwT8U480B4Dxls8rV91WcUaz86YUUojcaUvhXmhvoGbBST2g
         Zkzw==
X-Gm-Message-State: AOAM531fqwFEdY0NGGep8hat55hCOsY6FwPmBxROSlETWaBJvRzgp39+
        0KQ+bP81aTmjYaLMArbaW90=
X-Google-Smtp-Source: ABdhPJyWQmrpfXSvtdZP/z3xUukecqErhAs12Ii038YQaMqQ2Y16kCpa9fCSTzjB+iuIjgwWK7/3NQ==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr44394890edb.158.1638704081948;
        Sun, 05 Dec 2021 03:34:41 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id d1sm5878225edn.56.2021.12.05.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 03:34:41 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v10 1/3] iio: add addac subdirectory
Date:   Sun,  5 Dec 2021 13:34:24 +0200
Message-Id: <20211205113426.41486-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205113426.41486-1-cosmin.tanislav@analog.com>
References: <20211205113426.41486-1-cosmin.tanislav@analog.com>
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

