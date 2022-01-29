Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973BB4A2F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbiA2MYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:40 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32902
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345336AbiA2MYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:36 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 464523F1D8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459075;
        bh=WHnGp+/co0yjLFJTld0gSMGvtw/E8RuZJ7zwbzyKcNU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nxIXBXA0ALLdeBN8GDiaqVxef49iz4HTbGo5K+WfUScHf8SIHJWG1og/x3F90FZNE
         oql5zpzbnGXb3z2Sxzt3GO/6zNEbKu+izgN6xNJRLrKZlvJhjenuD5Gt4h0BEX4BiK
         hiCoIYzkwcDc5vGjzAdJlb0xJ+WtpxNmlsmbQnPbZQfoNP3uc/q6R8xPS7PlbAnlL9
         J30GyTTjYExEAFXwdAFCDE755v/3lQ+uQ2FQkWRSFz5bppUAnCaOM3JjhZGenJ4Pj4
         Rxf5Hn9ZDsNtRlMKbwQRjlNIQth3PWoDl1g0XtNPDD+2EAxOaRFGY2dcaxj/lrQ0m6
         q0EDdApMcWSWw==
Received: by mail-wm1-f70.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so7438689wmb.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHnGp+/co0yjLFJTld0gSMGvtw/E8RuZJ7zwbzyKcNU=;
        b=n3CfjUsHcGPcNJBUY+bB7MANJnlgtyoZrAzsAUbgjK6W10ctdbBsseOsN3EAkAb2mM
         mNXiZGThwydcdNwAjetyaJfME7wjfOq28lfonPso4jQdSDNHq+ISzY2GmkWDsCYfMkxp
         LGSefUaVMQDL+03wD2K8jyrY5UlS6oWvwNlj2Q6rqvdmknU0ljTcO0rWP0hGLWli5EO4
         JuyUCI1iFo7aqVySMyw2NKg04R52zyEXU5/Ykfy2opURtcr2XzZAc2gBWl6sj8BMyKiD
         Eoz2urayDLG023TXyqwFEzX0+PftvxzWujCxw0jQjJzqqWGxxitwbL+bkkHrMKYnrR5E
         bDAA==
X-Gm-Message-State: AOAM530vTrgx8a0Y/rlDl20PBRNDE0hTRX0JdXgp/umaQ/JrYcdy52X7
        zYnLdSznJavDLf79fz+vLJajcfgInWE3GjJh+e8x6sKAD1vpq7HJ4+hByMn1rYCEVVtXkzM3zeR
        2scTSFNEN0t1Gm0nYj/Zy3eHHCzwVsmyfkxToUAWN5g==
X-Received: by 2002:a7b:cc93:: with SMTP id p19mr10768234wma.175.1643459075061;
        Sat, 29 Jan 2022 04:24:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEYEjraGsXvaSH5x5kd6wGHrIGvpR2dGZG+9P2CfNNVi65TtZt1Y5RbfP/w5kfBPlc33FJqA==
X-Received: by 2002:a7b:cc93:: with SMTP id p19mr10768229wma.175.1643459074936;
        Sat, 29 Jan 2022 04:24:34 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm1106875wms.34.2022.01.29.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:24:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ASoC: dt-bindings: samsung,arndale: document ALC5631
Date:   Sat, 29 Jan 2022 13:24:27 +0100
Message-Id: <20220129122430.45694-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arndale audio complex might come with ALC5631 which is compatible
with RT5631.  Document the compatible since it is used in Linux kernel
sources.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/sound/samsung,arndale.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,arndale.yaml b/Documentation/devicetree/bindings/sound/samsung,arndale.yaml
index e7dc65637f02..cea2bf3544f0 100644
--- a/Documentation/devicetree/bindings/sound/samsung,arndale.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,arndale.yaml
@@ -13,6 +13,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - samsung,arndale-alc5631
       - samsung,arndale-rt5631
       - samsung,arndale-wm1811
 
-- 
2.32.0

