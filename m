Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3F47165D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhLKVO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhLKVOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEE0C061714;
        Sat, 11 Dec 2021 13:14:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d10so24125620lfg.6;
        Sat, 11 Dec 2021 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYn09FYPJwuESwb/Ie11Kfn38V4YdJcAZDuKfYS1Vww=;
        b=nczLKh4CmX9gy8053RgVP74ct+Jj3SFV/t2aamTuR7gDE/Cfg64SYoCcDbneWmW1iO
         wXXPYoDaob/CKRqsDGswZiLhvnG0cD/Z9YrEZudwRJP7gXsYDqzaAvRAPb6+BbkIXSKo
         IvulP/QYaaIyYkICBT+2apgdJLEutfCbmQnw8ULwWN3GvU12hvLXaTXma8bMqKiG0iVZ
         7PYZamEopLmK6+EaBqVhhbgkNVfhZ3wXiMQApT9Xw2BAU1jiDA2+IH3lXMVtaKl+QVS9
         iGpsm/TgdPWtxAkQNSncByV91nlJx9H3HWrdKL+ZCJcr8CMPMpLwSe5HDPHl3gJeQ9WP
         YvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYn09FYPJwuESwb/Ie11Kfn38V4YdJcAZDuKfYS1Vww=;
        b=UNM8vUPVzt5V2ngwNWTVxwyTuB1F2lEY4YvfftDWl8jZXCaoynQa1H3swuGqoSW1xI
         k/blcgG2h/8UJDLJJcEC0YFP5/byV+oFEFPXqlE5NGqcS6VU+hSDsfNL60Pu9eqAR5uU
         XkXhmMiMPZg/b/x8ThzD0oenCbSmHb9pz2mepTCnFmwhvLnVeOsomVF/ixIZc27WVwKk
         2xF58L/+gfwQ9mLDNx7r+/ZEYhfoXJY/BIAwd39BvERotepkK038ySxtz7mOr7Q0TaLP
         fwZBnEuzCO0EVZggQbg/xaXIP6H7WA/dCMY4k4Tc0a70e9qUv9eFv142WJu6iBdj9w8G
         35zg==
X-Gm-Message-State: AOAM531jOz3LLjBdZWXOcqelTuDAWRG+7Y6KNdXfKhYzOnBh7Pu2p/SO
        iN4SVzGVFdql0jZ+NyU+f/s=
X-Google-Smtp-Source: ABdhPJwd0HasrO7r/JZtE4C0OHafx2wiRRUyNRmJRul2GuF9ajfyN2lrtFAYy8DV3MqzoHP9iaT/9g==
X-Received: by 2002:ac2:5616:: with SMTP id v22mr19562200lfd.91.1639257261374;
        Sat, 11 Dec 2021 13:14:21 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:21 -0800 (PST)
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
Subject: [PATCH v6 01/28] dt-bindings: ARM: tegra: Document ASUS Transformers
Date:   Sun, 12 Dec 2021 00:13:45 +0300
Message-Id: <20211211211412.10791-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

