Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF04965BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiAUTgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiAUTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449CC061744;
        Fri, 21 Jan 2022 11:35:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a13so1504142wrh.9;
        Fri, 21 Jan 2022 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JpeJi0yBD942AUCHxsREdLSnIblSWTMYzLY8RDVTEU=;
        b=g89/RYLsr7FhFgcDDsXD99vhKX5uqRjLhBcwrrLR83njKs5S/mdvoQuwrTKkpynicL
         2CIIZwXJgrN2gpBu36IB7mrmXmE3LRSIcFPclowEwuNpiPrXXRAEW1bVfrgwdHqn95vQ
         J4AHIrGpgjxhZ3IMS0LwolLgm+B6UbiCPij5hYg1lmyx5XFxfbD9it8cUeDvoa4aJDze
         Il5fuhEXqArrzA3s7gw3I49JyQWzEYmNpUh/XD0kszWZ1yZrPlDj0SuP9t8hXa/bJPNH
         2VqPDlo29ZrIKdJYgYCpBGycHUMG8pm2RP9IzVjVbEOFAvPJOj2rvP+g2IMK/wpArgtx
         Ho5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JpeJi0yBD942AUCHxsREdLSnIblSWTMYzLY8RDVTEU=;
        b=1wqIBJKpyXB1ZAszJIJ4L/hPxXIlJ+yleMR7k94kQVgW4jAbJljXchXCRlYBG3AZah
         Y+G12AdfIIAcD2d22q/oDO5v7TzC9B24tmvPdAGgJD22ZMEq1zBXTpkZtFT6+vN9PzVp
         Heb+TTrCazTwEUDLn+Ja7FfYShSGNdf4IAKLYc8BPMRhQ23l8gW1z0szDYwfhDphnPcn
         Rucp6Wf4peT8AT/fl4BosMpdMqZg/m1NTS2GXm8cjBlIYCIKkE8fFyLD/8GwCnACG+ua
         rPfKc6FhXlGsW1X8BCCrW9WywNcR4KY1/P3CwOEXQPn7hrKZs0iW97BnWzVkiB2XSCDS
         hX1A==
X-Gm-Message-State: AOAM532fHInBfpcYpRoYNvVt+6KnZ/7a0m1X+ydxqERMRDzsopRPTC1/
        I5xPkClN5W+T6dtrqPw8rnA+fLUU8b3+/A==
X-Google-Smtp-Source: ABdhPJyAxIZmmPjhGkJnYRvDD5xzZYz10q6HKrGo8VBRZwYaIehVpahipvtp6YOM03iYduGtKcdWmg==
X-Received: by 2002:adf:e806:: with SMTP id o6mr5370065wrm.331.1642793752502;
        Fri, 21 Jan 2022 11:35:52 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id v124sm11517940wme.30.2022.01.21.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:52 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] ARM: mstar: Add cpupll to base dtsi
Date:   Fri, 21 Jan 2022 20:35:38 +0100
Message-Id: <20220121193544.23231-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

All MStar/SigmaStar ARMv7 SoCs have the CPU PLL at the same
place so add it to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 89ebfe4f29da..2249faaa3aa7 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -155,6 +155,13 @@ mpll: mpll@206000 {
 				clocks = <&xtal>;
 			};
 
+			cpupll: cpupll@206400 {
+				compatible = "mstar,msc313-cpupll";
+				reg = <0x206400 0x200>;
+				#clock-cells = <0>;
+				clocks = <&mpll MSTAR_MSC313_MPLL_DIV2>;
+			};
+
 			gpio: gpio@207800 {
 				#gpio-cells = <2>;
 				reg = <0x207800 0x200>;
-- 
2.34.1

