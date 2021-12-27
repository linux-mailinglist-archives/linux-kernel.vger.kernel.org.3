Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCB47FD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhL0Ngj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:39 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54736
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236947AbhL0NgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:16 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85B403F1A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612175;
        bh=3AbZgxGDXgdNiIa0Jk7Nnp9ACqroRk58o0FdzMEMrPY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hcFzRTVeGyuEiNCIrKYtINddTewEergq5sWGmwhkFNvIwX5HPHynD7NfXnLZDCnSS
         1YZeV94RiHp0refr8gIfYY94BA00BX/zNUYYGvH9kfuDnwB84YWxo+/n0byzmfQANm
         HQOBL5iltGp41HojuH2NvjKkRtsMepAk05dO7monp/fB2WkpwzJQjEugBoQaKyoZHu
         RCvFucIAceApTtJfIn59uqtkM1vAKnXIE3O3KwK6Xv48W6IMpdoXJYDezcLf6ATYAK
         wwj0pFJxUUUQ8uoYIby8kI8OrRi77htR9EWwZpq7Z/I3SzGnwTh0XPIuE+LeGCcbnG
         xGf8vWxeNLQXQ==
Received: by mail-lj1-f199.google.com with SMTP id k11-20020a05651c0a0b00b0022dc4d55f14so1984933ljq.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AbZgxGDXgdNiIa0Jk7Nnp9ACqroRk58o0FdzMEMrPY=;
        b=tx4JKf6J8lCGWNtiWTKaBIyWT9t5Wze6zV5vdWvA/n2mUMG+UzOuVsXIpZ0D6BoNiM
         jeZUJqT9w77SCNeqEXdcWTJ4uT+O26sQf7R1flyA5st5y1Cfrs21quWdoKOHok6IW9Ga
         ilxKF47yEyUIjAnZbYM1cHqPKLM49H663VGmP3ECWRZCY5X45dpQ+T9fICh3R44tFYUm
         vG3TL8vg7ZeLdA6gOoFJ3tI8KLgGAg9AALhZJiJp+1mxtJACeq46U8biuHQ/LmD8JfEr
         6lymdpXPFvp20NK0/lfIKshVR9p3l3gTXM/YM9bBiyNF8sZ0vxjEDLPymEuSItXNMkrT
         oVJA==
X-Gm-Message-State: AOAM531rimJTAG1VcLTSKUGnUCh19VsM2W/6bMSacJ9/Vnmo9tYgw84B
        6LCpuPK6mU0aLC1kjLP8bjTLImBKO/2roSZ6uurl31sox6zpE5NDtb4kZ/yETpaKESfB6CLxhYc
        FbaMjszcT8VsF++tdo7bCR60ouEVso42iJ9DZoRtdnA==
X-Received: by 2002:a05:6512:12d5:: with SMTP id p21mr8942033lfg.569.1640612174867;
        Mon, 27 Dec 2021 05:36:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfQu6n8QDkb9KxZ3wkpoGs+rZ8DmC5Rse+TWkIV2qUXfeuDeJNbHXLY+a1Sk3njem4BbGbmA==
X-Received: by 2002:a05:6512:12d5:: with SMTP id p21mr8942022lfg.569.1640612174714;
        Mon, 27 Dec 2021 05:36:14 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 17/19] arm64: dts: agilex: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:56 +0100
Message-Id: <20211227133558.135185-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel SoCFPGA Agilex 10 SoC Development Kit is a board with
Agilex, so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts      | 1 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 0f7a0ba344be..ea37ba7ccff9 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -6,6 +6,7 @@
 
 / {
 	model = "SoCFPGA Agilex SoCDK";
+	compatible = "intel,socfpga-agilex-socdk", "intel,socfpga-agilex";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 57f83481f551..51f83f96ec65 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -6,6 +6,7 @@
 
 / {
 	model = "SoCFPGA Agilex SoCDK";
+	compatible = "intel,socfpga-agilex-socdk", "intel,socfpga-agilex";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.32.0

