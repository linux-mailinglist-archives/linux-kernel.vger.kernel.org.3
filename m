Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07EF538852
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiE3Uus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiE3Uup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:50:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1D7C15D
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:50:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t13so16093321wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1lLChvyS/A963A4FUBu+MX1MVuqX0L31WAxbAXk0Rco=;
        b=TbWWfG3mwDAj3SlGK80UuCpJ+MU0f/6ckruWH7QPFPzJCTSVxTMObr+5jdPopbqJlc
         m+Xe8iKMzLEPVeY40Ofg+nC0bMhyd3DI/UcEaV6u+W4DH1149GT2GUCTM5XiLrc5eDuZ
         K3MODHqwWUmOH3IsgR2EzmAOPbAdDybF0HU+yL2d66R2Kzf8+KVLa2DYp6t8hiOZsyhI
         oLc+YnVjoPtrWKRwVbTl456dj/Z/n0ZK80hy9nFJ1Ra2pkvzPxQAMZjee3tbPUWVwq+w
         jWymAdqKP8tTerCgrRRNkWONCAkck0LqyJ+Qy7Xrj6E2jfyUteHh0EVy/vO+YFEk2CmB
         PZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1lLChvyS/A963A4FUBu+MX1MVuqX0L31WAxbAXk0Rco=;
        b=KSDldJ8EPfUNVvhduaeyrlHCCjoYOdKaoeK+1DoBekNC2KyTozmJU8KKIhTcPAprtO
         Tq6+3pR96FFrzsb41cwgEgS1In95fJGVIQnkBLOTQ/NglsfixzYePlr4lFl2G2/1wiWw
         dDTPMbhMtGvu2tii/ToKbXghdCac9zjmE1Gzu4S06W3JPpNrEhhxEcwGgLusNyOstUAA
         I5VC4ebFRbuv0+3J0LrwI1SDUoiVglPPNkhVQSputf6H7R7xCpqmVY9Y1UToAZ0AMk6B
         wlQzjAFL/67q/pZOOp6Qn63r1mx3lKo293I7/GoXKvA5e6Ap+BcKjFsVeqMPFkRA/Utr
         Z9wQ==
X-Gm-Message-State: AOAM531KAjZCB0eEGrGrTaNtz9IwLObWA6DytQoSVEtjfXBCBNUMDjwi
        ucAYVh8E8dQUpWnAoH3EaRxC6w==
X-Google-Smtp-Source: ABdhPJzI+EByJbFzqqyfHEexvTgYT9aG7LLERB46N3RzB/NvGbW2le+Yxe0x4SZCCWeuFEYWmA6dWQ==
X-Received: by 2002:a5d:5955:0:b0:20d:4b4:9879 with SMTP id e21-20020a5d5955000000b0020d04b49879mr46283608wri.550.1653943842941;
        Mon, 30 May 2022 13:50:42 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003942a244f2bsm384976wmq.4.2022.05.30.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:50:42 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: pwm: add MT8365 SoC binding
Date:   Mon, 30 May 2022 22:50:37 +0200
Message-Id: <20220530205038.917431-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: fix clock description (five -> three)

 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 25ed214473d7..ff792512399b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -8,6 +8,7 @@ Required properties:
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
    - "mediatek,mt7629-pwm": found on mt7629 SoC.
    - "mediatek,mt8183-pwm": found on mt8183 SoC.
+   - "mediatek,mt8365-pwm": found on mt8365 SoC.
    - "mediatek,mt8516-pwm": found on mt8516 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
@@ -17,6 +18,7 @@ Required properties:
                 has no clocks
    - "top": the top clock generator
    - "main": clock used by the PWM core
+   - "pwm1-3": the three per PWM clocks for mt8365
    - "pwm1-8": the eight per PWM clocks for mt2712
    - "pwm1-6": the six per PWM clocks for mt7622
    - "pwm1-5": the five per PWM clocks for mt7623
-- 
2.36.1

