Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C201F52B8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiERLY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiERLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:24:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C8174927;
        Wed, 18 May 2022 04:24:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F16C51F41F11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652873080;
        bh=A9HSqY7N5tc05EjY65ztCb/z2+4AYlU8OBtRhwBVeKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVeP3KgyWZPtLKbKdoAEbgrDQeJPkxwa+ZZMxQOn0di5Y+dA9XUMb0e1cCvlJAMoJ
         4d7X1ZxswdrxNEEWWoIjypf2862J8HeY6tATnfK5pzAhYLHrlS8b6q110pwSu4Y9a5
         H8MVAeX7RO8JvhK0UpTkiDTuOTKDrD5Xl1bSr6k3OILWCOSBrFAsmC25ajVryCp5XF
         +3esnx9JlRZdgQv3OL+66KoKnVgUBAnOSwasyseQYfb7KoJ43q6IYqvo2is94HzQv/
         y3OfZokt2f+m6MUOXbi6j4zPfMy0oQQDhvJ7PEcyvBcgNRM6yJbcIu0bl6wTaqKbs0
         hdfU6FeNql8ug==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 1/2] dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795 compatible
Date:   Wed, 18 May 2022 13:24:34 +0200
Message-Id: <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
References: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
System Timer on MediaTek platforms and add the MT6795 compatible for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 6f1f9dba6e88..49706cbef45d 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -2,6 +2,7 @@ MediaTek Timers
 ---------------
 
 MediaTek SoCs have two different timers on different platforms,
+- CPUX (ARM/ARM64 System Timer)
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -29,6 +30,9 @@ Required properties:
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
 	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
 
+	For those SoCs that use CPUX
+	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
2.35.1

