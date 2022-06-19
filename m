Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB46550C35
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiFSQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiFSQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7963F6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so6687418wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdzijZhojJfexvUiHUDLq5z4PsGSFwQ1Ytr2BP9BCIg=;
        b=PWA4JJOFAtMdKuAwHauf5W0ilkam9+c284EfGOoeFfBxf73/U3WhmRonRDLM9YkFq7
         bXrvdq1MvbW4jcJQNEfv99schOsEgU8AxXsLtq8HqNmK8RTgB+WPs3prQdtrSpXphsv3
         PDKpjD2sE+YGBKavd99Z/4KdZH8b+vD/EGw1aMT/nhcIx17IdEMnfi0klW+QvxETCrdu
         ufR/+VR5poo6Nnp+w5yM2u4joLnHecINMOecWblxkbCXSka3zerwe2DdgAGjrgl063bq
         OeLVMsyhBjIQnxfYid1cwKIYct0v1Lb4aYeptnBNQIH+0Ki8ewyuz2pi/YMcTgDZS6VM
         So3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdzijZhojJfexvUiHUDLq5z4PsGSFwQ1Ytr2BP9BCIg=;
        b=IquOo+EXH2nnAlDQ6Ef+u+AUkcg0AgQK0h6BlKauLvavzhpufKmEDgm7YESioNrwOz
         zKjsPrNoB4T51JQ1RQyD6g7Kio0orJW4PKk3Fam5aqyeHeSAZMaGsoVOY04++0gZ2I4z
         kaY6sf0Yb+yPUIj/Aq4X2V2hURWBe6LekTsQ3AFsDwjEubxvhc6CLSkm6nhE744ZqrrT
         0tRZsdMbWK8D8xBuzcI0AtbjeuLkfdrwKfTrKsMwEuAgDF5FQ71BKyliblNwz5eYjzrp
         0VUEaB9j3HvJ9hKnJhFVvZlFF4U6rQE8+C212fyb/MN+4EjU5yuNeP2H0krUYsZDNvA+
         sOgQ==
X-Gm-Message-State: AOAM533/pNUvnSBXgmjMKe2rMzA8BfolaLKpQi/mgCP1j4a6upEQNueX
        xokOQNVi7xvOfgkF62rd11oHiyLQvaViSAlvwis=
X-Google-Smtp-Source: ABdhPJz0xPBZmWQTo9K8KRhE/AtjcNNKaUjJZKnJFvDuhZ5Qur5cAWc+N3xl1u+1XObV9D2uRhHE6g==
X-Received: by 2002:a05:600c:3048:b0:39c:4c03:d54f with SMTP id n8-20020a05600c304800b0039c4c03d54fmr30692648wmh.89.1655657418512;
        Sun, 19 Jun 2022 09:50:18 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:17 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 1/6] dt-bindings: clk: microchip: mpfs: add reset controller support
Date:   Sun, 19 Jun 2022 17:49:31 +0100
Message-Id: <20220619164935.1492823-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The "peripheral" devices on PolarFire SoC can be put into reset, so
update the device tree binding to reflect the presence of a reset
controller.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs.yaml          | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
index 016a4f378b9b..1d0b6a4fda42 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
@@ -40,8 +40,21 @@ properties:
     const: 1
     description: |
       The clock consumer should specify the desired clock by having the clock
-      ID in its "clocks" phandle cell. See include/dt-bindings/clock/microchip,mpfs-clock.h
-      for the full list of PolarFire clock IDs.
+      ID in its "clocks" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
+      PolarFire clock IDs.
+
+  resets:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      The AHB/AXI peripherals on the PolarFire SoC have reset support, so from
+      CLK_ENVM to CLK_CFM. The reset consumer should specify the desired
+      peripheral via the clock ID in its "resets" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
+      PolarFire clock IDs.
+    const: 1
 
 required:
   - compatible
-- 
2.36.1

