Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE433471692
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhLKVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhLKVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:45 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21CBC0698C6;
        Sat, 11 Dec 2021 13:14:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a37so17385526ljq.13;
        Sat, 11 Dec 2021 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=A0/eEJCRr4yxgiDbcCJzgPvdLv4vDKX8MAe62tMYjj1A4g0e8tP1n84v5HYTc0ZyyM
         bjKA5GDpmpq6LIlntPL88zwIPVI+AmXgJdqXKX3XzVEGPkwBM4leRt9tx/z4NIlXO8vh
         zCvnfbxkboZqEHCJyXq6yP9CxzTxN4NnIEeh+ePtNAO42A1N+7aox6Z5QdWM85KFOmlF
         vR78Z1uGGTbQ+g+RGn9AhjCnwTOsIOEryoknJyGewpKVljsVuUsavQeo3tYPVZ8kiWJp
         cJ1pDsMo1S7oMCJIJTH3Kiaputtmnv8ZK8bF6CHFW7eGLD78MONYNnkNJBqTx9ZPmCrM
         xdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=mg7cyAh9J0sDHz52RMtKjauiLLFluzhHgMM7OjQemYpIFCf344HGvGH031QcmaJgi+
         tzwHABTu6pgavYbAqHwOG+txB2qreSofeHNn5AQnIDLk/90v6j3gKZtyX/Hu7ogNSlXb
         groppnQQphcDmKuJqCr1O8+6uHamlJBAkj79F/P3I+Ppcu6ctYrNgdc2buwPbTH4Wj3X
         0n45F9X59FLYQ5l2Doo33P9HnOvTp+ZpRxuJ09uSJWSy9VLSMiuo9YEyPvLBt0KgCZiM
         SMJ5m5QMnpsU0IcXmv+KuRukdpyTOy+olGRW8XuDLk8b7UShYm3HeUi9i8DdyjjNbqL/
         Cysg==
X-Gm-Message-State: AOAM532PRApEDF1tUGd+5CIQ9xYILMX6+WXxo//0g4qwmNYSYBFfq0xv
        dmW7+ik+qtRYxY9MKfV0H4E=
X-Google-Smtp-Source: ABdhPJx8r1dnuhpvs3Uq0EhR4PnH6o4X0NVnJg1pmv4pDiAyMHMIzIl1cXQIfC0Mbzgy47wSM0CcEQ==
X-Received: by 2002:a05:651c:1722:: with SMTP id be34mr19890642ljb.52.1639257278043;
        Sat, 11 Dec 2021 13:14:38 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:37 -0800 (PST)
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
Subject: [PATCH v6 16/28] ARM: tegra: Enable HDMI CEC on Nyan
Date:   Sun, 12 Dec 2021 00:14:00 +0300
Message-Id: <20211211211412.10791-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDMI CEC on Nyan Chromebooks. It allows to control TV over HDMI.

Suggested-by: Thomas Graichen <thomas.graichen@gmail.com>
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 93a40a84b792..a5dff226831b 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -390,6 +390,10 @@ pmc@7000e400 {
 		nvidia,sys-clock-req-active-high;
 	};
 
+	cec@70015000 {
+		status = "okay";
+	};
+
 	hda@70030000 {
 		status = "okay";
 	};
-- 
2.33.1

