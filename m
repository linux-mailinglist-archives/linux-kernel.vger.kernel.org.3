Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2884466D30
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377439AbhLBWuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbhLBWuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:50:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96283C06174A;
        Thu,  2 Dec 2021 14:47:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so3875639edd.9;
        Thu, 02 Dec 2021 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=NvA4yU0aeYAxAsVX3Zon8SYBW61kE3hk1UKpOULhWCK09whkPbzasdvRCiyG2LHLCE
         lgpnME5sgdvTwvnDXPMfxQ2OiutFM0Ot/PEAaTOQLe4YQdo7dgMM6KxdMNZQHvjf04wt
         kZaDH5KKFHgl39fUvrEIMGH2d5eFsTBhF4zgSRAU64sXEP1BjwEKywy6hkOux83F/pI3
         2OjBZA5ONrVpNSi0Vas+0TlUDFBSku+1WRI3WLLuVGWXdoosGj2Fu2xUqICO8L2B3Bwk
         koVBKcNsS8kDLmtFCZD55MxsXepxhEEK0OtIEHga5TyBt1MtJ1Sf6IdWYFUMNusR1l+1
         d+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y8SZh/fUjZzS5/Y2/K/xo9Vkl5DVyyFl68Ne+hrQ7Y=;
        b=ZrBUClv43X/aFdLdfdwtlA8XP+0Ng6MZ+6tRiB2H6FuAPEzHW5rb2wY++VL7JjKwgB
         IiGjDLNowh3TIuWv7MEKCCEd1fAfzP9wbrlbxg0bwMb4GOYeZSwA3nE09/LfoIEqZ151
         8YuC9xEL2lngnzKiF7VcNPTwm2+aZJyW3dnSxdyMO4y5XvYBYpUiwTMmdsvcZmDk6Qoh
         awWWKUcqba9dLK7y4t5pG8VLcODF7D1UmPWRx4pp1wF0LntkVjB8IYjHXyuIRU9PQenE
         PeLTctTnFQe3V+5ehbecnQxO4GWhrqHroIDBKtNyIOZKJfHe3wbSwmM2HjOT8mfvDjtM
         rtrA==
X-Gm-Message-State: AOAM531EFib+SUUfls0HOxasVAIDCyr6nHK0Hh0FIuIK8I+AT9izwOYw
        +jKEuaCbpk5GSJxowptc2Us=
X-Google-Smtp-Source: ABdhPJyT8/na5JeFOSUA+y71AKYEiWhn2WX9Eh411PcgeXJ0HusHbGwHZWBOkFhufJJNKZbHPYibkQ==
X-Received: by 2002:a17:907:168f:: with SMTP id hc15mr18622559ejc.115.1638485234238;
        Thu, 02 Dec 2021 14:47:14 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id gn16sm641360ejc.67.2021.12.02.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:47:13 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v8 1/3] iio: add addac subdirectory
Date:   Fri,  3 Dec 2021 00:41:01 +0200
Message-Id: <20211202224103.218278-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202224103.218278-1-cosmin.tanislav@analog.com>
References: <20211202224103.218278-1-cosmin.tanislav@analog.com>
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

