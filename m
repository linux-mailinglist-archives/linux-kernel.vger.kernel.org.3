Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5274C93E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiCATFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiCATFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:05:03 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217273D482;
        Tue,  1 Mar 2022 11:04:21 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso12989727otq.4;
        Tue, 01 Mar 2022 11:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W6dJaxiOp1gz+LypeQFfrkYd+uggMOKCgfxzK1OLdFs=;
        b=01CzNnXhalUKWfK13abO3CdncPweDa+98fRHeVHxxqwF9dz2iwcYahwYAsKDejbALe
         cVAE9k1qpqGtel3dz85iJydy5DM/Oqj79LKXuUVJRD/4KSPXMaPonHq8JjIO/46DkSmZ
         mhzLT8KMsjd8/miecDstgmIwxyjBhjMqvp5noxNbWnejnPUIwoAroMUNk7HLBWkBfvyt
         bi6lomz8YPn8ZpLcrjq08a+8OFNEKLZ3cFpw5BQX4BuUi7elw6NN6me6Gfw8aMl70bUO
         XFy4WDobNcwkVJWMpeZO9wVWIieRIUIPlFj3x9KMSgD/IO4bzQK7zZZddvI0D5vYV5Sg
         MDdw==
X-Gm-Message-State: AOAM531nx1A3lDJ7xjtecx6eKu5xsrE1xW7/H008VOBi+A5tdoVoHgoA
        XRq8HnhmnKFpOYNxen5dLQ==
X-Google-Smtp-Source: ABdhPJx/wSYI8AKhpxxGP2pKtOBTLTlhS4dgno53M3yvL99mzPXPB/8amZsdzoZiwMk0AChQHpQGKw==
X-Received: by 2002:a05:6830:1bc7:b0:5af:8e92:aff6 with SMTP id v7-20020a0568301bc700b005af8e92aff6mr12994215ota.147.1646161460391;
        Tue, 01 Mar 2022 11:04:20 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id z3-20020a9d2483000000b005acf7a66184sm6667429ota.76.2022.03.01.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:04:19 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
Date:   Tue,  1 Mar 2022 13:03:59 -0600
Message-Id: <20220301190400.1644150-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clocks' in the example is not parsable with the 0 phandle value
because the number of #clock-cells is unknown in the previous entry.
Solve this by adding the clock provider node. Only 'cpg_clocks' is
needed as the examples are built with fixups which can be used to
identify phandles.

This is in preparation to support schema validation on .dtb files.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/renesas,cpg-div6-clock.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clock.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clock.yaml
index c55a7c494e01..2197c952e21d 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clock.yaml
@@ -51,6 +51,18 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/r8a73a4-clock.h>
+
+    cpg_clocks: cpg_clocks@e6150000 {
+            compatible = "renesas,r8a73a4-cpg-clocks";
+            reg = <0xe6150000 0x10000>;
+            clocks = <&extal1_clk>, <&extal2_clk>;
+            #clock-cells = <1>;
+            clock-output-names = "main", "pll0", "pll1", "pll2",
+                                  "pll2s", "pll2h", "z", "z2",
+                                  "i", "m3", "b", "m1", "m2",
+                                  "zx", "zs", "hp";
+    };
+
     sdhi2_clk: sdhi2_clk@e615007c {
             compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
             reg = <0xe615007c 4>;
-- 
2.32.0

