Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7E47FD92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhL0NgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54682
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236862AbhL0NgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:11 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D881F3FFDD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612169;
        bh=2raMQbTEO7GSuDvkY6ovvPJxx8orpnvUqhVxP2Jtxb8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QqxrP9aLF3CkaHVaRnB4b6gz5KiA537BhdOAC0aCGFgcIZ1Fp9Wz5q2Z8bqqVg7or
         Tzqu7DPAEQv3gIM7ZUuonaeV2h5rIczORENCGzk7rfK9/cmvH7evBqqw1+yGysTq60
         8oR92jq5thvJJRVYr3ZyrogjVp8PSVDkKXs5TJLSmdnF0aacn4vhFgwwtk1p4fgHnO
         zg+BbLhzu6zduBXmH6KFicfcSjxSw0qCodRi+n0jW55GVBZ/BgY3thEGxJq/Yw6w9m
         rXVV9dsgbx+3g+PRoyZ7FyYmXyFBH3dOs5osvv3MtvAveEPYn0NZ2b9r2Blbb4b/be
         1qL0S47iroWpQ==
Received: by mail-lj1-f200.google.com with SMTP id u9-20020a05651c140900b0022dd165d92bso1407157lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2raMQbTEO7GSuDvkY6ovvPJxx8orpnvUqhVxP2Jtxb8=;
        b=1hlF+/+oLEdyK1f2xSDj30k64392NB0FK7fBV3s32PaIvptEzJODnwgKqeVdRyPMQ4
         CDHgrm5kG/63NuDZgMKXgcnm65ZgiOKhRYXeu2WSqLyT4b4XjzmQdOBVV9+t5cWZi7ef
         BrUc+Y367fMGRfxwLePl13BfJgkIiTBFdBQqP9EWXyKKC23Cn8okrvEfde3/OulJo13d
         sioxKQfOh7/vlCgCPUOu3hGXmds4ckHloorUjRlK2fCe/NAPK+BPcVy59LiU+DlpCb5T
         m6ImvTpyoKk9MUxGdNjPuse674pvtvD/2e2oHGxUH9W92071Og59PIblKJn7aUv/FBaq
         cbPQ==
X-Gm-Message-State: AOAM5319Yjax/CIIGnLyb1WCSuw+Y7iojvE/r389wBZ/ENJXqnvhIbH/
        DjoffO8GJPD/0pMy7xH8UU5SladV4zGOqKVQ9mW9ZX5A0Ilf5SofbsmIjVcQV3RUUcaG23wn5c1
        U8XD0JXR/8B2UF21dI0v/UuNKKrm/Qg6EXVL4E2N61A==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr14726556lfr.295.1640612169355;
        Mon, 27 Dec 2021 05:36:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8X2sqRJEu3DvxBtUDtpU3Y5uc/tMDwNZZNmfbYtUwIkhKBrQTFmqTLlfc1ZtsOof7nER7vw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr14726540lfr.295.1640612169204;
        Mon, 27 Dec 2021 05:36:09 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 13/19] arm64: dts: stratix10: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:52 +0100
Message-Id: <20211227133558.135185-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera SoCFPGA Stratix 10 SoC Development Kit is a board with
Stratix 10, so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 46e558ab7729..12392292c62c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "SoCFPGA Stratix 10 SoCDK";
+	compatible = "altr,socfpga-stratix10-socdk", "altr,socfpga-stratix10";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index bbc3db42d6e8..2d53a06deab5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "SoCFPGA Stratix 10 SoCDK";
+	compatible = "altr,socfpga-stratix10-socdk", "altr,socfpga-stratix10";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.32.0

