Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1130147FD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhL0NgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39594
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236818AbhL0NgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:07 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16D863F07F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612166;
        bh=WfhTTV0Y1eE7nwdIxKma7kRI9gj0CY3EEbVZ0tpJfUg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fMvyt3aA5bTwgEqDpsT4bdVKp6tIvOLvmR6cZFeuYfDEidQ7aZGNUh8SmwFxg/Ssd
         yGksGhwFVCUoBep5SceGFF/wW84kAZRc/aZGHGiKoekuHk28ZbmRMkPgsr3agDWTCt
         KUoy6WFrUNZaqZW2oQhdq8Ln64IKsmy+PSZp4z5IsIszxP+/SXMu0kKLvF1BrKAk7v
         V0f12Jzr/fJqq7IAJ0nAB1NRjpTL4m/aEMBYCmIhONj+09EzjMCrAHWRLVTeuLqn3+
         4QnsXWLSTDAGlwz13SVgKdet15dJOcmyWitAo4OcQtOcfAplPqCEbpCx3F+tKK1rWj
         s1vdQwZl9XqXQ==
Received: by mail-lj1-f198.google.com with SMTP id z9-20020a2e3509000000b0022d8e7f5889so4607950ljz.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfhTTV0Y1eE7nwdIxKma7kRI9gj0CY3EEbVZ0tpJfUg=;
        b=b9qdxtVsLiSBwx6nOVDenyxSzbgpKkMLPEEiw4tHzCWXTkGmApAwWiKjq2GyrfiQhf
         AlDpvGlyI2M94mLZeOc8cKKTHvN/wlgvCNbd8Mtrc11vmp/r5Bpz+4T8h6tARgHs+ulE
         DfFs2o6cT0KhSk7RRAa0D0DGEYNDvLpDEowZd+iNH/gsuMxNFxbgEtgwrsG9sG9NQssi
         yXbwbvMh4RiWbpnc9G7uL36BeYQ62m8il7La9BoQxejV8rgAKLQd3sQG38+M5d4OfY+/
         QbkfloI2EGGZIYAan7DG6LLGM0HHKG/aKFAomM2ShB4C3o73Gy+KPw3BnjKDTxPTsZAp
         16ow==
X-Gm-Message-State: AOAM533M2QwvnYlOUXuUxH1UJJAYmLOucWfLRNaN9FHVJK8wNn2pBIc2
        XhNWPO23hw/8MCa53Ab/jmakrNWJhoL7Vp91DdisDfxdFnbD7WWcPpdf76eDMaM1Sd4OGS3UYQj
        q9Eg1coSyrapHEDbvVkWy3Sjq7e4SpkVb3tQ2S5LyJg==
X-Received: by 2002:a19:6502:: with SMTP id z2mr15579097lfb.151.1640612165309;
        Mon, 27 Dec 2021 05:36:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy38iR16DrL9VfxBjC243Im/jp4zdjU6XJ5h3h1PY0QPqf2vwc+9AKP2xWJxPjm2ge92SselA==
X-Received: by 2002:a19:6502:: with SMTP id z2mr15579082lfb.151.1640612165142;
        Mon, 27 Dec 2021 05:36:05 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 10/19] ARM: dts: arria5: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:49 +0100
Message-Id: <20211227133558.135185-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera SoCFPGA Arria V SoC Development Kit is a board with Arria 5,
so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 1b02d46496a8..0e03011d0247 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Altera SOCFPGA Arria V SoC Development Kit";
-	compatible = "altr,socfpga-arria5", "altr,socfpga";
+	compatible = "altr,socfpga-arria5-socdk", "altr,socfpga-arria5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
-- 
2.32.0

