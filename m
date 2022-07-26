Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3749C58113A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiGZKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiGZKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:34:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4B2CE33
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b6so8455904wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QHCyTIRLNQ/OUCi6dUmgrM3Y9T7C/9FW0O1buPIAQjQ=;
        b=pA1UDfyauG57hX/HGYq50O3qF4ZqTy08+zbcjw8u8c4qDSHkTJ+6BJM+9VWl8+AphZ
         oDyXdcynfiaFvrEdQTFhrQjmu/Wwny4Hj4Eo8Fv5w4DQwxIOAuRnNaQKO3j2s/7f3ZBb
         NMcXv1c11TEo+cy/mdOJVQW/bFR3tXzZ8j2ppnARrT+7fqNfac9BrTvrL4zbbXoT5BC9
         ZqFk3OflRvCalb9kAFWBLy+sFJ1rgA/+Mojk/wNvgbEca7lH3DmKPDOgJVL+KUvhNciv
         xfjyUL/r6/O4nDey6GZffovNPpJQn25YCnw1VLk4mu7WUkBCZxJxz6nnrr9gI4EnnFy+
         VYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QHCyTIRLNQ/OUCi6dUmgrM3Y9T7C/9FW0O1buPIAQjQ=;
        b=Pats1/6QsnVg909TnydhARX/A2TkT6IQgzf/dG/rlOtQeY+IYY7riLLxDy91a8cEMF
         O4TnLNYC+kOZOItj/Lb7ukZw+RO0OSdmlroc1b/Q23FBAI+wqARdL4mRn4OETCygsWFz
         N731uIptxQsrGIlUyB0Hhrdq2KrWrnYiomqWiRH3lTX9M9lXj2Wz8QWQC4sMK4JjKe2G
         Z72TJ2XWFWuZpFSGhWktbMMk1cGKS8E5Bk03FzlwoQ+r0cMWxuovo20WnueDhncF6GEI
         qUcOmI5PQgOYOBzMoQRdeZYm223lHDzFKhI5Qcadbbv2ogQxRlTz9aRozVPsbFOlDL+j
         p2kw==
X-Gm-Message-State: AJIora8zUjaqVXCzTgpqOQHy8mIssfeTp8wzZgykmeMvPjd7gdZkNIyV
        ZI/6z4fjSr2ClUOhuorkpF2pjA==
X-Google-Smtp-Source: AGRyM1uMtX6RJnHdH3iRbZ+Uud9uMoY67ZHIhhGq7kUhKKWqF6rPmysZgFIbC3VBsgLjO0q2FORd6A==
X-Received: by 2002:a05:600c:1552:b0:3a3:2e4c:bd0a with SMTP id f18-20020a05600c155200b003a32e4cbd0amr20435408wmg.82.1658831656595;
        Tue, 26 Jul 2022 03:34:16 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:16 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/11] MAINTAINERS: OMAP2+ support, add tps65218-pwrbutton
Date:   Tue, 26 Jul 2022 12:33:48 +0200
Message-Id: <20220726103355.17684-5-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726103355.17684-1-jneanne@baylibre.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

The entry for the pwrbutton driver seems to be missing. Add it to the
list for OMAP2+ SUPPORT.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..67850b321cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14704,6 +14704,7 @@ F:	arch/arm/mach-omap2/
 F:	arch/arm/plat-omap/
 F:	drivers/bus/ti-sysc.c
 F:	drivers/i2c/busses/i2c-omap.c
+F:	drivers/input/misc/tps65218-pwrbutton.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
 F:	drivers/mfd/menelaus.c
-- 
2.17.1

