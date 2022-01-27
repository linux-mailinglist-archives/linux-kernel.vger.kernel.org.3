Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB67649E076
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiA0LPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbiA0LPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:15:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82791C061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:15:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a13so4071158wrh.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlQywLM4SRqpFvXyB5cSelAzc/97HjHZ8/iIFU/mpmM=;
        b=YAjPQHn2jyReqNUQMXrw1ZayyBkZHfk+LHsA57oh0s+AisAvo0tKWI8P/KBeFkz+j8
         qwMKQlXRNDE6OBbqypYngIp1GgtcbBnRotElRJ9iYemRnoQm4dlNlm7uG/0UqjDwO6k3
         Fc2qEg2YXJz/BZXRKURbGqu4o/fo1jeR7fF/s3TnxSSB/z/xEt4/ypS22ansyQQKHR8P
         Hjre9Mo1g/347I3Z1ReqEE+9v/9opB93MNklB1e/EJR7e7jLtkbxoV12OnSufjBA/f/4
         qElFOVXmgJP01MYw6yZkTnMdLZvba3th0qupQXXF14tvGUehY/jX703yA2xwTNyWPYJp
         De0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlQywLM4SRqpFvXyB5cSelAzc/97HjHZ8/iIFU/mpmM=;
        b=mRfaKS2stZuI7VegY6cFbIuZvSsPuWAl24cC5hVuTYtprZxYTuQZ1Y+ysLNaaaFKlR
         uNTlopi8FYvISz/pv2qQY0s0/unw1Wh7zf7FquNyaJherwvJhqD1JCe/dJTyVjCiWg8S
         VtCTX4b9ZalUEccmUkF6ihx2Zct9zU+HyhzR50884fteIFA/S/hkVIyf1bMfr1MhcrAm
         neNuD+ceS6n6Is7U+VO59vjfzCJ7Vs5MEGOfiJfKvd4FGsYZ4fZ9TPerxkfor0gPnUv/
         vv28c8ms+6xhDPwzxt8aYy4JVzer2BLhCuTDKTarUfxJFW7NxNyf353Y0F27nU7qUUUz
         H5ZQ==
X-Gm-Message-State: AOAM533qrdQnbh6XRE9io5/r5nadTvPEyuqYak5vKId9TFuqfg2EmrTf
        ypAESIf61UJkbw4uVObG09wZNQ==
X-Google-Smtp-Source: ABdhPJw+JjcilDSvB+7drez4412ivVAsEaAb4cKkUtfLWoOfBwIh3hzJFVfLRydnxEUIl87CwlU9lQ==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr2582361wrn.637.1643282149126;
        Thu, 27 Jan 2022 03:15:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb19:8b2c:5e00:7d3d:d638:46ec:78dd])
        by smtp.gmail.com with ESMTPSA id r7sm5956311wma.39.2022.01.27.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:15:48 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v20 3/3] arm64: defconfig: Add CONFIG_KEYBOARD_MT6779=m
Date:   Thu, 27 Jan 2022 12:15:26 +0100
Message-Id: <20220127111526.3716689-4-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
References: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "fengping.yu" <fengping.yu@mediatek.com>

Add Mediatek matrix keypad support in defconfig.

Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..099a9e68711c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -390,6 +390,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
+CONFIG_KEYBOARD_MT6779=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
-- 
2.32.0

