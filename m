Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A753546416C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbhK3WmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbhK3WmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D292C061574;
        Tue, 30 Nov 2021 14:38:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu18so57768901lfb.0;
        Tue, 30 Nov 2021 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDDlr9B376Ggk4kgjKCc/UuR9uKjQ0/t5tpcNUpdYW8=;
        b=lgrsrhHIy5bcM+fxFvLaQna6BdwojpaqarQkIAjXuf7TBgp3lHrrRt+059abQ1D5wW
         PNWSiZfbyvEZe8+VSZ/5xMa2d/5DqCKjAwZ6j2NlgI9ZhtPRbcZGQE+tgy+un4dfoMqe
         1ltJghnIVYm+cv/AttBQ0LhChuRpNiXvLliB2Cyz/BRwXkelIXqm5v3JHwlPaVRdKt1A
         wtCTt/OttELHNs0csGzORlVmg7Oazog8BgF3jedFOOayykM+6IZkrctTMW7wVst4PGKH
         MJg50Ob3AQRH4n2tEN77WjGvUzq/KLvUMFlpPaWXeYRAUgpDZmkqwcCM9bKM9OdLrQ0P
         m+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDDlr9B376Ggk4kgjKCc/UuR9uKjQ0/t5tpcNUpdYW8=;
        b=TYEozZfHm5pfsqZRPXitRHjysXUdpTul2lkab/9eDHfJgnQRfstYVOiRCguN5WDT82
         Hds+pzMVeiT/6fhKjSaKCeitUdeK4ICrHdtGt9byyl8u6K4aI2M8aF7jlCnaIHy8FbyS
         qiLiwfJhOmdSU7JbunW+dpOwDymHSWaCK/RsXMMdbbzeRw9/AjmJh2mE151BkuzBXUKM
         Nd0KNB0SNt4FWZjpisnhYslpxu8HWjEWvP80UYbGr9JIxfinhR6f2000S1nV1b6BRO8X
         50P2ykdf7xJUmmboysiHA6SMUOyXJ9QJpB1L3Gw4iGAOE3C/NC9vDkGFuKnngbKVGMw3
         xnaQ==
X-Gm-Message-State: AOAM531dGqd79+uSGzuOxAkFW9dnBtp//NA5DLaYB58l3mQ6DK18Ffeg
        CfVY8w4uVr3RQGHmNCQ7Ihkwd8zr7jU=
X-Google-Smtp-Source: ABdhPJzlqvpgCXE3SojGwRJICOwdDknx/S4UvOtTFmUWO7sFiSBNaQczLNpR3ksPtPU2SjGgrkqXSg==
X-Received: by 2002:a19:6717:: with SMTP id b23mr1956920lfc.659.1638311918815;
        Tue, 30 Nov 2021 14:38:38 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:38 -0800 (PST)
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
Subject: [PATCH v4 02/24] dt-bindings: ARM: tegra: Document Pegatron Chagall
Date:   Wed,  1 Dec 2021 01:37:58 +0300
Message-Id: <20211130223820.23609-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Document Pegatron Chagall, which is Tegra30-based tablet device.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 49ae6319336d..91a7d4a75fe6 100644
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

