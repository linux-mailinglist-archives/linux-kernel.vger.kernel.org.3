Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA046D9E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhLHRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhLHRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B144C061746;
        Wed,  8 Dec 2021 09:38:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d10so7042853lfg.6;
        Wed, 08 Dec 2021 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYn09FYPJwuESwb/Ie11Kfn38V4YdJcAZDuKfYS1Vww=;
        b=gYmQ4eYAZxro6xUk9NIYE7Dz3An/jcvgFXQlUIh/XccMkcD5cau6D2S1kmzHXLMZAx
         WiCNJvUmmM0ePIMBSpmD6LrtlYyOGEtB0HOmRpKEiHSf/0pjWvjNlQoZuMHFftgNYvzX
         ddJ12W7+NEQd5GDuKSRD4tC2uOIL+EP1Nn1tC4Z84olJrwgXNryC233A5Wr/0m3vBCHZ
         cRZKjPJhH29ZLf6Lz3KZn4N5g1dJbfs8RcGtWiOCsmeg+oS69cVyr/4fPe24b81Hihi5
         hGsk3s5uO7YC5Tv9F1QlpqBRtbHUJJwtmLK1li5cQqcGD51LsIKO3UCUFL0rEEePsSii
         fdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYn09FYPJwuESwb/Ie11Kfn38V4YdJcAZDuKfYS1Vww=;
        b=RZPS4N9wol+Y1zD0Y2GMZ98m1J/sEA8x+UIHikULy6plR3mRl12+42x7ongy8OwshY
         JZcyBYcQ7okX7H4Ix0ZM/RSXCzPWTahKA+lQq9QnDXipHxg51bRKX6DcQTsGizPw+Pca
         Rgs8CTgzbddwsPBtdXs79eW5HY42OpO9ywiI0DddL4tVKWhPPLDATdY+acnOYrzAvRnM
         Jw6Ak6Tib0rN8AcTTZj/foCOKkC4vbENS1s9n3ImDbTBPHoZ+10Cu+slKyK7wAet7wSV
         B4eq6QCiI3MvjvjxCammN+nSgp2plr4i1JEUhNrNK3Bf3yOcyFbGuhZObi7hoMb55Ryr
         CwRw==
X-Gm-Message-State: AOAM532PLdLc0JtXbEC4RqiW+glb9O4hbaa2H+bQxBnW3oG8qxt2z9Ve
        IrMTdUgVTTz0U5LFerMEcwc=
X-Google-Smtp-Source: ABdhPJyXWUDndKLuFiAAqrqAbZA6suUXYNuA4nXgkPOKYk7U0ErcbnkOogmbJ/TshMoBDXNSYZyAIQ==
X-Received: by 2002:ac2:4e0b:: with SMTP id e11mr836112lfr.208.1638985078635;
        Wed, 08 Dec 2021 09:37:58 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:37:58 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/24] dt-bindings: ARM: tegra: Document ASUS Transformers
Date:   Wed,  8 Dec 2021 20:35:46 +0300
Message-Id: <20211208173609.4064-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

Document Tegra20/30/114-based ASUS Transformer Series tablet devices.
This group includes EeePad TF101, Prime TF201, Pad TF300T, TF300TG
Infinity TF700T, TF701T.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 3bd0920da274..64b7b770a0dc 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -36,6 +36,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: asus,tf101
+          - const: nvidia,tegra20
       - items:
           - const: acer,picasso
           - const: nvidia,tegra20
@@ -49,6 +52,18 @@ properties:
               - nvidia,cardhu-a04
           - const: nvidia,cardhu
           - const: nvidia,tegra30
+      - items:
+          - const: asus,tf201
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tf300t
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tf300tg
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tf700t
+          - const: nvidia,tegra30
       - items:
           - const: toradex,apalis_t30-eval
           - const: toradex,apalis_t30
@@ -76,6 +91,7 @@ properties:
           - const: nvidia,tegra30
       - items:
           - enum:
+              - asus,tf701t
               - nvidia,dalmore
               - nvidia,roth
               - nvidia,tn7
-- 
2.33.1

