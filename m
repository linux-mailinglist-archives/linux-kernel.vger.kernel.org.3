Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55223466DAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358099AbhLBX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357757AbhLBX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:28:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFBC06174A;
        Thu,  2 Dec 2021 15:25:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so4163884eds.10;
        Thu, 02 Dec 2021 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=Rz8lmiQJTY+dGKI5GvJQMCEnPxnPXhT3Ay/JZWPoRfkepYklp/c8xWWEIo8R2lVwAD
         Jl2BV6+ndXkwsJ3xtaaCUkZK9ovnXutAo5iDTkK5jFxUMcKZZ8Ga+OccXrjHaMHhCpYb
         Y5gPXEs7hW3qP2uxnSjeAL7MSFQaSfUa60QF9iIM49bAXE+7gy2gmh5M/5YD4QkkcVw/
         5GMWEguWBP9IcvRhd0Q80XWnGvkx7F1y5058AS32vyc43iAC6okR1qdp5jqBJQ+WBfrw
         KlKsh/6s1nlh0gmPAxbjCZVOV2FTyuEDBzhig9P6YCCPzgM8+KZltlnhBI1EUlzGVe+v
         2tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=a96H6VDjcWRiaY+8aJY8/79lcAX0K4Et4S7jfxSHEP/Hj9rm9EgH72oiopkPkmE9qs
         C9owi3lgCF/LjGE4keI7sBYw3llN/V48jbA4xSWFinlluU684Xzw6joFmoXa/G0ZjOLg
         353fKGy8pV8vqCZJHUG9WAwiAgG9snxQ77jmfL5eH8WIhdUibbU/DKAETZdFenymZ0Ye
         2B9BLGxgkesKY/J6K5zZ8gFVmywGywM8IuQmRtcyF/pzNjUAWUrdY8P4j/a+9MxQImW1
         mZsmST86GLKyUYM1LoFWeqEEMB13yleH2etZI0bBCRrTW5ubM9GgGYCqj0DTEnmEZ8PX
         QUaA==
X-Gm-Message-State: AOAM531bbZJ9VMFyrANyMPC8k63F7E2Mmm8WTIzQQwHvCtfJCcO8rQvv
        2m1KpxgTNfpdqKN3OWR5VGY=
X-Google-Smtp-Source: ABdhPJwjWKpc54VmNSWbmPOT0oqP5MUHjnofvTCt6kt8DcEDZ13yj0n3PwVPPEUyytYkQ1R8vMcjkw==
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr20939441edz.69.1638487513948;
        Thu, 02 Dec 2021 15:25:13 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w18sm701898edx.55.2021.12.02.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:25:13 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v9 1/3] iio: add addac subdirectory
Date:   Fri,  3 Dec 2021 01:25:05 +0200
Message-Id: <20211202232507.358113-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202232507.358113-1-cosmin.tanislav@analog.com>
References: <20211202232507.358113-1-cosmin.tanislav@analog.com>
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

