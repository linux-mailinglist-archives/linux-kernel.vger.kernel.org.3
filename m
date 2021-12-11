Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052EA4716A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhLKVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhLKVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0648C0698E1;
        Sat, 11 Dec 2021 13:14:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d10so24126577lfg.6;
        Sat, 11 Dec 2021 13:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmQg/p/Vn2YKZaq3yQvTU2o68zUY2EoLoTpiJk2fogA=;
        b=R3kTb5Fpo3WUYZnWolBlr0u65HsjnFNjCk1T37dLPQn+qgY1ndHNAXHu2osf3c3Gph
         HGTbj7frBChvgdQT9g3NE1wWw0GsOSJOlM/hjmyFdK5gjBgnsjVJommToDg+cYmM3KlW
         MJURIxqmhYwvzEcYr/8eh28Ccm2MHg/2tULxyYCDxMiILg97SHWqc5VqGovqWcoERvgR
         wkzidlr9wzEBlaHY+TZmYHEC2P9Kr7HszgtOvJPFHEDFkrPclv2NB2WdsJjf9TDwDqI1
         9cEsJa2u/7TeT2gsFZ4XQHll7JxsWsSkTGEmp4v8geng8xj9NpDwbZQ5/cLScosrjzid
         7CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmQg/p/Vn2YKZaq3yQvTU2o68zUY2EoLoTpiJk2fogA=;
        b=eLQect7adwf6oz2ZIMKoNQIoVaqqmRMx/esOl029+db6kJ+jj5Q92X4vad+e16O9Xj
         LGZQScN0ax+mqJKUZALvWqQ6a9XBXXSuZDkB3IqqB5axtzl0wYy4kjwepFquTl+zAoaf
         d3Nq42h4kAp7jhXekZ+1lU3P3M4r94yvvsUjP6EONaTJrizCcsadB2PCq9c6JDsp7NBT
         VStrS+hWtw1A7Q6K7FQezL3oR1CpBY/Rjlo9HL96w2ROC628d8pxb+xNF93TmxD3fU7O
         Zpa/eP7rjIuzvp6xPub8pzgZmMRlFoYoasbB4VhWCgFeGpoqX4sRNbn1+Wooq89dS5XG
         U3ZA==
X-Gm-Message-State: AOAM532C1/CW2/pjcp7gKFMPbA4BJngrI1yvpA1h+BVvOW+J7hZG7og+
        l15zU4KQJhzluJ3UA9+msPldBspV5IE=
X-Google-Smtp-Source: ABdhPJxI5/pMnQ9lMH1qDS+TSdx82+bb2ufnCih2cYHizJubjlC4ZezpafcgYz7f2FMVY5flQDnVzQ==
X-Received: by 2002:ac2:4e09:: with SMTP id e9mr19086127lfr.657.1639257285333;
        Sat, 11 Dec 2021 13:14:45 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:45 -0800 (PST)
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
Subject: [PATCH v6 23/28] ARM: tegra: Add #reset-cells for Tegra114 MC
Date:   Sun, 12 Dec 2021 00:14:07 +0300
Message-Id: <20211211211412.10791-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra memory controller provides reset controls for hotflush reset,
so the #reset-cells property must be specified.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 563ee262f41d..d487bc180f09 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -543,6 +543,7 @@ mc: memory-controller@70019000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 
 		#iommu-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	ahub@70080000 {
-- 
2.33.1

