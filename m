Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E94B09EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiBJJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:49:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiBJJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:49:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F29D94;
        Thu, 10 Feb 2022 01:49:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q7so8399081wrc.13;
        Thu, 10 Feb 2022 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRYGNAl0pjBDWXPtAqz7vqkpRSHwTyJKPqb9oNWE6kY=;
        b=HeGoYP/rEatGVaml9kregQlj4BieZdcc6Hr/q8qOEE+zwHfIHOccZJxCp23L2LcDhh
         1qBplkuUzOpLa3OIrzGR5RpFGZrPqKH+LCOzB51nYmlsiiEqQ94cMMDZS+siEb+CK3Qj
         ZjEFQto/zsnriMdxKtSmvHq2npjJKxYZPr6BrcinSuIsaLdh1dqQnyWRSRaxNrFinOVs
         mkr3LDI6l2tGAouSwAkuQMO2wHgUT60gW2HLG+r0o400jEuNyz0xFKOl3NkC66ae76ht
         hx1M2aD45aShmjxzAGuv2DPIf0w0t9+M7P47N3kCekKKgThCudS5wFEdorCjuIsKeaVT
         3/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRYGNAl0pjBDWXPtAqz7vqkpRSHwTyJKPqb9oNWE6kY=;
        b=cp6VA46sWuqyub+vyFRdmDbPscXLxY2iTLE5+0jP5FmSj+27q+hVsNuaG+6OsPrelV
         ifrweHsSuCyy3i5zD4U/nIblt3G1td/BfsXyFB3CCkT6eAzilDgwWyBkejFdIzc62OQ/
         TIHbXJ6hnej5l4aN6OetHENRkHyqI/OlHiL3JKSsN16lyhxL+Winlml2LR6rStmF/Qk6
         8gFqa6AMV/k7IcOslzFi+7a8TRp2KN6HvpblKJRCUFVBqiwqQNIB3l2dkfVQdU+sprag
         /Q+3grC1ZyCusD8ZeTQUwWnGww5a2WKfcoPDyVkxOZIaxl8ZxFaR07avSVImqXTUfq7I
         /mUQ==
X-Gm-Message-State: AOAM533Uwinx/Fin5sYsLmmecJWkhtEF1Cs75/E/lcJAoOekxECHvKb5
        iNDkg1zF8u2wqeAqlifbOQNldLGfeNA=
X-Google-Smtp-Source: ABdhPJxMtyxbSIk/k+sdqBups7FdUOW5IVuEgRYZUww7uBfCYCvpSjvX1C0BqI3TuFqFOm2X1Wg1MA==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr5528274wrs.682.1644486542341;
        Thu, 10 Feb 2022 01:49:02 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id j6sm6636601wrt.70.2022.02.10.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:49:01 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Thu, 10 Feb 2022 10:48:58 +0100
Message-Id: <20220210094859.927868-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210094859.927868-1-sergio.paracuellos@gmail.com>
References: <20220210094859.927868-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.25.1

