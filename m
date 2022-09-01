Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156255A9D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiIAQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiIAQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:36:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4F86FF3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:36:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso1841051wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UX8+/drfB0LYjWl3ZMYBdvnqKRofZz48IvTklCuKdy4=;
        b=lT8+AtXKFyLlnH8w8rkpgnaXUj8cMRnMUQWCQq2I8u+As93kk81vSn1PF/Yqsm0V2j
         R2DQqRNmiYIRLFT4F+3flE9TntJuWirnVfo/cHF/xGB6R4o7rfGjBUoqIo1MigzTKAEw
         QnrZt/N6vKn+a69/1kAvnFU4SUp4pHHVT/m5brM4cNnsitqtO9LkUONEdmarZQB6U9Zu
         WY2KXckflasp0rIQfzm9E5B03vRfJ4VxVH7sVUD0b8ZKw0CPfgfxGj0Ge1WttJ3vyRx9
         sJ02PV7khg/C5VIVSsg1/GnFSudi4ocqPhT5URxq+13F9tTG8u+NMdzhYKtJ5ihvTsrD
         Ko2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UX8+/drfB0LYjWl3ZMYBdvnqKRofZz48IvTklCuKdy4=;
        b=xIDT+UDFTUVM90dufM/XxXUtK47pR+J+TkGguC+vBGRdVi1v+2XuyvALRPAXYjUv1R
         ZUmYbSw0lh0cA3KZyXMhbwepvR2a6DvuSghEa3cthBSr8Q6eBbU4hekI7Eey6tC0Mfes
         ce6JOMBOe2SAlfxCPBcqCwAVTpHrStqtIsliwXvMtVkEg6ikvVmKygofxRGuGIKNyXIA
         O9c57ETiZtRX79R3wKHbWN27IKFYn5N/U5Km0HcUPGlPJkuV0NNhfQJo5PUDTNT30vYg
         EwTKJydN1OI06sjbCsNnWAQIWK0bo/7g/kfiRFWwry/qM2UTSMxCSZn8I/VatBgu33oo
         kqIg==
X-Gm-Message-State: ACgBeo3cspDMZKEHCUVQ4CaYYrUZos8MAUi49ruHKp0edyXFqlwnRw/m
        Bw+PnzMkWY7eYbDXATFEGMAImXtTPd2+rA==
X-Google-Smtp-Source: AA6agR5PtLEruNhaSErUwdXG85T497H72DcWeRB604VuwD/PaSChk2TaFxCLlfdV5v8XWYwXelmwuA==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id be13-20020a05600c1e8d00b003a5e37f6fd2mr5805041wmb.33.1662050204396;
        Thu, 01 Sep 2022 09:36:44 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:113c:1b95:dcc0:68a1:a4ac:9dac])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003a317ee3036sm5767115wmk.2.2022.09.01.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:36:43 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: [PATCH v2] dt-binding: gpio: publish binding IDs under dual license
Date:   Thu,  1 Sep 2022 18:36:36 +0200
Message-Id: <20220901163636.3930634-1-etienne.carriere@linaro.org>
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
BSD-3-Clause license terms. This change allows these GPIO generic
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

