Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548946A06A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbhLFQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356951AbhLFPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:52:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87AC036FA8;
        Mon,  6 Dec 2021 07:37:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j3so23357631wrp.1;
        Mon, 06 Dec 2021 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnondPYhtDqnzA9WeK7ZjYBbINrqnDY4dMWpT980crM=;
        b=SYcNtvUZpDAdUwU3CpqBjd3Zx9k/sN00WH5X0LqXhAUoKjTgEiUkymOxw/LCSPBl6t
         k/uaMfCkp+TBYnWZuxBugcNB69uHD6tTz/ssZdfa5WXwMzf4RUgXalzLE5CXZWH0Ahqa
         uwkmY28OXFLig7stde9ob71xDiZ+apoRVGgAu1oavVOTAvVERzBY+H3mgpMsvkwZjRtt
         DCJCqpDOtxb8/qpuOvnbMEY62Bn0nNwZeLluf4xmq0l9YkaNFSgO+Y0NDgoqdr4TLgP7
         kO40eAOhvGy/fUBHNPvBzrsR9fvGyFYMP9y2FCa92DaAXYTpS6WiN3Kw51d4MwChsJK7
         Yxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnondPYhtDqnzA9WeK7ZjYBbINrqnDY4dMWpT980crM=;
        b=qd4/NEUJ/NooFqiVh4kYZEINuv+LoWTUhNqI1+xGWfV64Njoo8uLeztig4r2ArL+iQ
         nxfP29h1TNPegJupfICtdGGtB7R0L5rhE493oisordrVlBgAL1tOh9Cue5YRw6Snq4BD
         vD32PR9dDvDzCDw7tKuA+GtUdv4QowT9RfpbpvY4aYk68cClMGywBbKdiOR9PtA45a3Q
         31PWJSLtdcheuFrsAAtrJKe4X3sEEEr13+BvFGhW2iTAa5R3ZxeCjc0uqtJTg4iH53FG
         gIDYgCakA80HFxV3z6Okg/4BBFiQ6DU5tyjtnYCgQekoSvC2ADgZKog8TdfkNKGuSccE
         lFmA==
X-Gm-Message-State: AOAM530PlKkED1nAKCxINu83Z8/2Ubqh1/47/clP5VqUQ9NWI+MtgeSv
        p3FO1ZXXbOxQgsVZDW50xMY=
X-Google-Smtp-Source: ABdhPJy0sFhNh+f/5q2EBkmmMA+8xtmqzbZjvW3Valk9SbIYh7PgQUFq6fZyONKTBct2MR/Y/VMcOg==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr43974041wrs.605.1638805048053;
        Mon, 06 Dec 2021 07:37:28 -0800 (PST)
Received: from localhost (pd9e51d39.dip0.t-ipconnect.de. [217.229.29.57])
        by smtp.gmail.com with ESMTPSA id y6sm11982909wrh.18.2021.12.06.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:37:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: Fix type of regulator-coupled-max-spread property
Date:   Mon,  6 Dec 2021 16:37:26 +0100
Message-Id: <20211206153726.227464-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

According to the description and the various uses of this property it is
meant to be an array of unsigned 32-bit values, so fixup the type to
match that.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/regulator/regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index a6ae9ecae5cc..ed560ee8714e 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -218,7 +218,7 @@ properties:
     description: Array of maximum spread between voltages of coupled regulators
       in microvolts, each value in the array relates to the corresponding
       couple specified by the regulator-coupled-with property.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
 
   regulator-max-step-microvolt:
     description: Maximum difference between current and target voltages
-- 
2.33.1

