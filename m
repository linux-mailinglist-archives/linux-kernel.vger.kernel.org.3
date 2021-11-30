Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68E464166
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbhK3WmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbhK3Wl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:41:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC4C061574;
        Tue, 30 Nov 2021 14:38:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p8so30607444ljo.5;
        Tue, 30 Nov 2021 14:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmPsKaRm9yef4zSv/QFCKObVh+CY0ZLlFU03o39rv/g=;
        b=PLZxzchj2eV2gFiq8yKTIg7shdDVecyhask7qxWx4XxT50mxVDIH97xKR+tW+pn90m
         G/HWGUc+FbN+qU7lqopS9jWohR0l9PbF55R4RtmNB9h8cR60Rfsv7nCtSkO6yojADNkx
         y7ctTaCtjGbT/pLnFrtzGaYrgf0+cEWX4P0Vkmr4WEOjySDzxBiQ4FMSdlZzz1mzoXvj
         K94mIKfB4PhtKPdc1D45rP9KuS9ewta7tqgqH8ULzy4v6GmLKH0tzGaQafv+Bz01zMVe
         U4xXSA0l3TzCbMSMJnUdq6g/bKnwiFr/LdiuF3Ti2/HYiAPhMeJ/PTRKDQXk26qITlf+
         /U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmPsKaRm9yef4zSv/QFCKObVh+CY0ZLlFU03o39rv/g=;
        b=sinuXxSjxMmDt47ZTsLMTl4oXSOgHPN9fu2S31MRsGhTVteiekjxNFoExRRRH2qTOI
         NWpqZITXIXBMuyP4bTQYDLwn83NB//HRWWHQmHzjvodl8+8oLp564xCJfuQlWmrRrH2x
         YGOhddeXJGtZKdSv7d+xBjMtcbWe/OvnGRV8WGPjG8mjzQImiyxb22c7YAGBeWEnwiCs
         he4cAMAzWKZh5Hi8Lu9esLg0FBw943DroeYNTCkIe4YT3jVs9UMZa4MSs7dDof06492T
         zCW6yQxYN/1Wgg4d/wETJY/ThDMNL58iGp86eaXzC0j1R/8G+Ncay6JBAfRj2w+M9Pvd
         RGIg==
X-Gm-Message-State: AOAM531o6LXWicamJ2UYc5vCKUmeQIKiFzP7wF9Cr63a5tRGxwctkLfp
        IExvakYBVjSZpurK4vD27tY=
X-Google-Smtp-Source: ABdhPJyXe9flg0K2bYZaQe8PlMo8G2EPPr6u4AzGzYk7X6V2WpSCa3VqU3I6YSSfItFsOt4TMM4yRA==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr1745367lje.415.1638311917433;
        Tue, 30 Nov 2021 14:38:37 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:37 -0800 (PST)
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
Subject: [PATCH v4 01/24] dt-bindings: ARM: tegra: Document ASUS Transformers
Date:   Wed,  1 Dec 2021 01:37:57 +0300
Message-Id: <20211130223820.23609-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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
index d79d36ac0c44..49ae6319336d 100644
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

