Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108C471663
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhLKVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhLKVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74CC061714;
        Sat, 11 Dec 2021 13:14:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf39so12010205lfb.8;
        Sat, 11 Dec 2021 13:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59LCHopwA1ye+fHN+U24sTHxmwoBZhDAKkgeJfmrX98=;
        b=gvoBUnwlReP7znalNzTlyiSEqoyxk3tYSKM2qTQZT2EVqi8zAu1MU3ghMm+IFYlFix
         1gq4GbLliY8e+EJ/UkgAYVsYnA6X6racNojbbNy4K43iMZ8HsDdwJHUaf9uLOZlRNkyv
         1lokwotnlzTwgWENfFhLJ9cTdFpIq8Z3UFnqiaNikRAn7hQqBansXuUG6dEfgmq3nREk
         suT52OWisn4PMuHAfmMSKT8yH8rn30nAHmxRtowpD3SAwZjZg2ivVuxRr66YdnWCGdHe
         ggn7zh5UP2Bs7qH74xJjUxy0UI2TiVQrMBSGxMcn8QWmWwhBW9bTIsXfM5kKq5fvvthu
         WytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59LCHopwA1ye+fHN+U24sTHxmwoBZhDAKkgeJfmrX98=;
        b=7pYDHcKQtsGHd/K/A4xYq6zu2Lzmn2FjC3egUH4TkZ0Z3qjl+R89jSub/DN35BsVZG
         3AeNXE78yCwq3ZSU+UXBnn+FbVAMJ4NNXCiXY193Pdb47hTOkUvA7MpPAm+xUYcq+eia
         MmxK6qw5EDx/A69S1OMIQcHkmSU0dKnz7+4T6hdzgF+feA1eueNT7DIdvGv7ZKJgB/Ww
         OJODXyqfM3p+5wFCiZ7oriKoSO2mXJ/xoNzeEwa3PGHzXy5dInXmxPNVQurUcBi0gQJ1
         +Fe4ATSTDbOEqDSon6p13X0GX2qiL/oIXxQLjAwIYUrym0R9lVWo7quXcZrJrXHzLfqD
         dyRg==
X-Gm-Message-State: AOAM531V9fFptM+yoXK9L2hT4aQXxwhoztoskYYIPHt9PfdlYtHuaWAt
        rO8cR7fgGyU4Fn7I3oUWG/I=
X-Google-Smtp-Source: ABdhPJxguSZYiSuCYUn5Twnyj0p3w0JVIeKQ+itLDxknl6UycqWouU5H3+SP43fEV9Z03nw9XHT7ow==
X-Received: by 2002:ac2:54bc:: with SMTP id w28mr14607058lfk.405.1639257262450;
        Sat, 11 Dec 2021 13:14:22 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/28] dt-bindings: ARM: tegra: Document Pegatron Chagall
Date:   Sun, 12 Dec 2021 00:13:46 +0300
Message-Id: <20211211211412.10791-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Document Pegatron Chagall, which is Tegra30-based tablet device.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 64b7b770a0dc..49841ca272ee 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -89,6 +89,9 @@ properties:
       - items:
           - const: ouya,ouya
           - const: nvidia,tegra30
+      - items:
+          - const: pegatron,chagall
+          - const: nvidia,tegra30
       - items:
           - enum:
               - asus,tf701t
-- 
2.33.1

