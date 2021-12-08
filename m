Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2746D9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhLHRlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbhLHRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44350C061746;
        Wed,  8 Dec 2021 09:38:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z21so7015536lfu.8;
        Wed, 08 Dec 2021 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ka3D8GMAXsA/EMTXPvO7m3XK/1LbwMpc2cvOt59MQM=;
        b=d9SbBeM6CVENa0dc8NX17BogYs7OVNi1U8AqKcThcCKuq9GHD4QPdNABBuqEP0fEhX
         uAAVg3L+sI6KCpQWjJgU3TlgQvWoP90/hNbtRCr6AHOiMOJZeSe3yOxb7GgjM+7efA+Y
         +Ne1nljSlTsOAR5iTiXWwTsj+fCFDvVU0dAHlitc5z1pIWCDcS/V+PMUby4U5rwn6Z8d
         U7N0eTWDY/Sk4gpLbW4B+6p7dDIi5Q8kdO9+1OKD6ct5F5LNp9acLwEPYOgNUv/x1TuA
         t6NUXqsyzPOsGf0k6iWgq/KsYft77PuYO84IlUNgc6j39y7yts9VdaZJt5cRgjUYg4Pm
         ho7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ka3D8GMAXsA/EMTXPvO7m3XK/1LbwMpc2cvOt59MQM=;
        b=3OzyDqHtnrt2LkAqgeP2GAudV4CopYO3mLxoYLR84j4tuy7L8raudBMStTnEru2d0C
         y57uQjmf5tghYZcwm7PDbaj0r8twHd4ouwjAndimzWwvHVCrYjCGep64vO9X4WEAqAIo
         yqHGTxfecOItUMumkKeomewWllrqi2imjWlTXg46NcfIcDgO1pzxjHndpwedNb+Pa/79
         NJjCpazw3qLmFj2HdhKbwLntrDwA56iQox3ugX8wgs5+1iNP1LvdHNUoVWioACjM30rc
         wNDwrD6azaTUYZgHWp6cqgD5tXyc3RTJW6pPCz/kYfUnNOVcPig2UH1aWSGCykRfch6K
         9eWA==
X-Gm-Message-State: AOAM530Dz/PQgBhDzDwSkSv8GOGzrE5yIEcjA0Wl+GJ2lZxROLN5QwFP
        fjwVFj1CZjRQ8rzIlliQsfk=
X-Google-Smtp-Source: ABdhPJwpNGyqtUA+regV+iG3MnnY2//vF9dy6c3F6Z20SpPjEfHmrszyGGa2Llb+nnBowGw0SgN2Kg==
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr824045lfb.475.1638985079576;
        Wed, 08 Dec 2021 09:37:59 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:37:59 -0800 (PST)
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
Subject: [PATCH v5 02/24] dt-bindings: ARM: tegra: Document Pegatron Chagall
Date:   Wed,  8 Dec 2021 20:35:47 +0300
Message-Id: <20211208173609.4064-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
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

