Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5591159AC27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiHTHRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbiHTHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A98C6B6F;
        Sat, 20 Aug 2022 00:17:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f4so3469931pgc.12;
        Sat, 20 Aug 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VCrPOIohHxLmVfDrC2sy48yiF41OfgNylthp59ZduCI=;
        b=dchGxaCKupq9BXoOYaw19H8frLNwc6XeTZCiWGW9TTi/8T2+w1+H0N2Qo0v1FbNiY4
         APXAIasrV88C5hsA3n4Sm3+xeBoxCp7EYmARcrmc/Nl0niRndeUkJnT3q0wi8k5LcWn5
         5ed0mfpFI0ZEFFKPdS3hA7Yy/tFsDgX30TXncYI+0IQIc66aglSot7at6jzom1PSKdWp
         3JH9zmPNjJnbLIBhVqnAXfrRYbLelo6sywfdpz8SmDv47wkla9983/thXe7bst0HubYE
         GexVSwh63IDHKdRaIHMNVnrmEjRuGgwkXe4o8vMSHAAPT9gNl9OGx7HTv5CKuRtxeV7f
         I1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VCrPOIohHxLmVfDrC2sy48yiF41OfgNylthp59ZduCI=;
        b=PIXhd7iTip3EQa3R9EfmhcYpDd2t+fzWHuMOn6a8kUtLQX5dwr7u8MKeMW1s1erpei
         NzzriB1eTZt81TU8v4RcWsm7Ke3TZ4Tz06AwThFFG70qro+bERt4hhd9T3Goo8jHyPTp
         akVyDpY9fqaI2jWZQAMSsYtxkjhl6F3ry1XZnIF4O/rBv3tN/Hxbi9KpTsZpSpevi2Aq
         5HZl/icoRiKY/5Rj/3+fR1zbXSufdt2z2O9mJcxvI0xQs0FpA/Z0j25PWT9Ht+czI4ph
         fUTzO6nSnjhk35ABwi/R9JnRSJuwwjoe3t0bqLYl3eRK8KK990v5fCwgeY6beRhyoUfI
         WpsQ==
X-Gm-Message-State: ACgBeo1Ht+Vdm04EJ3JXk1++m6CDVd+6xlL+j1k93qSiI1DFjbM38O1O
        U0Vxhe7kS3b9kHT+0WEiuz4piBlFP2T7iIiUHKM=
X-Google-Smtp-Source: AA6agR7SEcSo9UFWLqpeucJoo+pblvH13x2pFJP0jpXEp1hAqnl3YWy9qYl/x4fPjD/CfLOTTS67+Q==
X-Received: by 2002:a63:4f10:0:b0:426:9c61:5e48 with SMTP id d16-20020a634f10000000b004269c615e48mr9085640pgb.360.1660979858113;
        Sat, 20 Aug 2022 00:17:38 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:37 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 04/10] dt-bindings: input: twl-pwrbutton: Add support for twl6030-pwrbutton
Date:   Sat, 20 Aug 2022 12:46:54 +0530
Message-Id: <20220820071659.1215-5-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation for the compatible string for twl6030 powerbutton
support.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
index f5021214e..9a0b765d3 100644
--- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
@@ -8,6 +8,7 @@ This module provides a simple power button event via an Interrupt.
 Required properties:
 - compatible: should be one of the following
    - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
+   - "ti,twl6030-pwrbutton": For controllers compatible with twl6030
 - interrupts: should be one of the following
    - <8>: For controllers compatible with twl4030
 
-- 
2.25.1

