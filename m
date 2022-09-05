Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103F5AD595
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiIEO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiIEO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:57:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2F54C89
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:57:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nc14so17612644ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=N9N6i/JaW8L2HS1S7tkq5MsZgz3zWObqpMqhnVjMCA4=;
        b=oOf7kZ3eJL1A3ghRC8Z39sa7spwW2OoJrASvqNY9D7hDycwOmzEb7kxZlN1miT0Fi7
         BO3zg0mrUGr+vb+wwkods1dw3CEdowWUoKdvP79XGNGvt+4LlLQlfgPvzvBacZ1R0eBn
         pB3L1tDyJ64yzuI0OUKP8b8MhFhnHzK9yk8DiF53DkPm+zwPXXxJ5S73MU7oXTL1DPxx
         v0R+BpKWmkh2RtIyWsbPkkAamCJMexFbeFhboyHTMNmgoriqRjbukUrDXm8vTE4SXkn3
         EOFEHdqODXg3WRz6hrDM0LzJGisPWPG4+SafefT0nSju+M6mE/KXX9R9Pwtx8dJdh8pf
         7CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=N9N6i/JaW8L2HS1S7tkq5MsZgz3zWObqpMqhnVjMCA4=;
        b=NC7kEJUOMPjGuTifSRwjMUE5oyySW1gn4zRdUuPjQaiK8WdKmc2+cv4vaYuKPm+QXI
         piRsLwlk5liYTJS2QzRBQ8clIl8Rx1HP+m8eZLE79k8T1T0OH5SplsdIduWBoz5rZwf8
         hg4UdrPQ0LcfxZUwudrcf2bke8ADrdXaicDpgRZeT9XOFFCj2JRi6xt94T5cnHUb2ihl
         Pju8khjdM01VP42OIf1ZSF3bRqeCZEKx+3Xwrk9UMxWZdOgJxmOuFQ8ZuybVWAsa4NOW
         NXeb5donfYM66wVBVbZ5PZ7XRINIOY/aYPXlvDp+ISP7337hM+ZPO88xJY41VvFHn1ml
         NMkw==
X-Gm-Message-State: ACgBeo01kB5hbFecRx/YtEts4Bh2ryDv1p/NkJQ4lZ1zJofXV0mOL7+4
        S4bU/pnkUD1RzrBXNn1bjGLj2PNp8N/NZoXB
X-Google-Smtp-Source: AA6agR72dOyEGeR4y8CYngmamOIUnzWC8RWDNcnfKBBkevgb8mUu4g0p0t4H2pIRV7lXVhlnR2ZMuw==
X-Received: by 2002:a17:907:2724:b0:741:4a1f:6159 with SMTP id d4-20020a170907272400b007414a1f6159mr28511807ejl.542.1662389838957;
        Mon, 05 Sep 2022 07:57:18 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:104a:337b:6b7c:3b36:dcfa:d968])
        by smtp.gmail.com with ESMTPSA id ch29-20020a0564021bdd00b0044657ecfbb5sm6572244edb.13.2022.09.05.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:57:18 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3] dt-binding: gpio: publish binding IDs under dual license
Date:   Mon,  5 Sep 2022 16:55:55 +0200
Message-Id: <20220905145555.674800-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes gpio.h DT binding header file to be published under GPLv2 or
BSD-2-Clause license terms. This change allows this GPIO generic
bindings header file to be used in software components as bootloaders
and OSes that are not published under GPLv2 terms.

All contributors to gpio.h file in copy.

Cc: Stephen Warren <swarren@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v2:
- Fix commit log.

Changes since v1:
- Publish under BSD-2-Clause instead of BSD-3-Clause.
- Remove Charles Keepax from CC list.

---
 include/dt-bindings/gpio/gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index 5566e58196a2..b5d531237448 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 /*
  * This header provides constants for most GPIO bindings.
  *
-- 
2.25.1

