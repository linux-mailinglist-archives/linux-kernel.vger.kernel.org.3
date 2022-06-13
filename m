Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05DA5481E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiFMIQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiFMIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:16:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46213D20;
        Mon, 13 Jun 2022 01:16:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d14so6003126eda.12;
        Mon, 13 Jun 2022 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cykRIEYlm/tBwzENkk2TswJzyqXZCOuXhPNHpNdfGrc=;
        b=PNNSc/2tcFUqXn+STVjJrt3YBVbm04LZM/EczU3wx+RhleoVGwex112Q6q79dxZKBG
         1zHrKWORgdIecXTx58b97Y5FqcJgG/A8FJAeozNHBZQpuM5uQGJgaTorXGdK5EBVe4iA
         6qgbddL7W/kHyxtkqgGsFTjOqyKqaLZWHORWLtIrC2nMw6XXge5RD8q7csa03u3qBBej
         Yf62uELtb4UgL+2fYfehn0W4BapkHeeo3AAYrAALTCnqCNHWpT0W1SsK3BRDm2TnZ7vC
         qbtBQ5CmeL22g42cWDivjP0OrV2m3P7iBun5l3rrKZii44RO8dRcX6y7hR1i/408A+Lf
         YXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cykRIEYlm/tBwzENkk2TswJzyqXZCOuXhPNHpNdfGrc=;
        b=dlEHhsj83t3EoZk+tJT3wfUg1hNtueBRcIJswaJu985lopmZVHCvbez9JZpsULknfs
         dM+XsQVlm4XCJqZvrmyb+jwFRfVZuf+qJvOFXPQJG4Ay7u+hlqUClAV8dn8WKLzb5n0e
         /plkCdHFM29agqLnKbOR0oeq6POpcixxWPXkJRg6S+IfhsuxQsZ3cDgZ+fPRviAUfnna
         ahZzfWY5c/msKuZvb+MKvPazKkqRjDK6PiqrVFNZIngSnN9/DpknCZX8mZeymwRHvYoE
         gKHjgVCwRs1LR/3bHx6o7HWQnYj//ckq1s+Rujn7Owa4VqTPAWlX9CuL0NEAkFpiF06P
         0/mg==
X-Gm-Message-State: AOAM532Oxx+g1HCz+6bQLC3LOOrMDDLqce8iOKli0eLYD0M3Q13yXJhg
        Fes8pYua0AqN9s51E5ltuhc=
X-Google-Smtp-Source: ABdhPJxU5ol0WWdzFAKE+XHFc3NjaWzaZAwloGvNiBa3wKLi5OHbCKAKFFzQxJuRc2pgxbQ/cFGv8w==
X-Received: by 2002:a05:6402:500b:b0:431:78d0:bf9d with SMTP id p11-20020a056402500b00b0043178d0bf9dmr36550223eda.184.1655108207464;
        Mon, 13 Jun 2022 01:16:47 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b0042dd1584e74sm4397781edq.90.2022.06.13.01.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:16:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clock: Move lochnagar.h to dt-bindings/clock
Date:   Mon, 13 Jun 2022 10:16:31 +0200
Message-Id: <20220613081632.2159-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the clock-related dt-binding header files are located in
include/dt-bindings/clock. It would be good to keep all the similar
header files at a single location.

This was discovered while investigating the state of ownership of the files
in include/dt-bindings/ according to the MAINTAINERS file.

This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
("dt-bindings: clock: Move at91.h to dt-bindigs/clock").

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 2 +-
 MAINTAINERS                                                 | 2 +-
 drivers/clk/clk-lochnagar.c                                 | 2 +-
 include/dt-bindings/{clk => clock}/lochnagar.h              | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/dt-bindings/{clk => clock}/lochnagar.h (100%)

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
index ad285cb480c9..ef4814ced8db 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -261,7 +261,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clk/lochnagar.h>
+    #include <dt-bindings/clock/lochnagar.h>
     #include <dt-bindings/pinctrl/lochnagar.h>
     i2c@e0004000 {
         #address-cells = <1>;
diff --git a/MAINTAINERS b/MAINTAINERS
index 91e9cd30326d..86e6198b206f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4801,7 +4801,7 @@ F:	drivers/hwmon/lochnagar-hwmon.c
 F:	drivers/mfd/lochnagar-i2c.c
 F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
 F:	drivers/regulator/lochnagar-regulator.c
-F:	include/dt-bindings/clk/lochnagar.h
+F:	include/dt-bindings/clock/lochnagar.h
 F:	include/dt-bindings/pinctrl/lochnagar.h
 F:	include/linux/mfd/lochnagar*
 F:	sound/soc/codecs/lochnagar-sc.c
diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
index 565bcd0cdde9..80944bf482e9 100644
--- a/drivers/clk/clk-lochnagar.c
+++ b/drivers/clk/clk-lochnagar.c
@@ -19,7 +19,7 @@
 #include <linux/mfd/lochnagar1_regs.h>
 #include <linux/mfd/lochnagar2_regs.h>
 
-#include <dt-bindings/clk/lochnagar.h>
+#include <dt-bindings/clock/lochnagar.h>
 
 #define LOCHNAGAR_NUM_CLOCKS	(LOCHNAGAR_SPDIF_CLKOUT + 1)
 
diff --git a/include/dt-bindings/clk/lochnagar.h b/include/dt-bindings/clock/lochnagar.h
similarity index 100%
rename from include/dt-bindings/clk/lochnagar.h
rename to include/dt-bindings/clock/lochnagar.h
-- 
2.17.1

