Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9CC490703
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiAQLSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiAQLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1805C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f21so7005356eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgCBczBtPEHYRyvjWuI0A9ytv/aIykozzgSEOheUqfc=;
        b=ipKDNBWS97vbGXeveLzLfhig0ox/GDOkJQwZz2+gK8EJtkwmWpun3D8fzxs2KkCh9j
         xx6BphHNZOA663TTRHAhOj7SIOwZX7Rhhr4W3T2lm3EzeYG0yrkJgK1jPG4P2jitsNvl
         ASAqdvv6DfAJz8VDUyqZ6ESkYA6ALLbFZ8kxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgCBczBtPEHYRyvjWuI0A9ytv/aIykozzgSEOheUqfc=;
        b=IbSkuMx9C8xPwGVIgkNE5hCs14tuAg+/ua2U8r3aNkx0S0+LuVD8Z43xL8n/hohVCD
         1k0pg7oh1cVAsFfvNJ3npzqNrjeU3sbE9/rDopsysO+eAPXnQcjN9PalDndP0GpTsXbA
         M0WDR25d42au9GPrKWtOg5HIZP1J6ihnxeHV7TYid1UQCyFWIJMszxNiNoJHauXduQH1
         Vnq7ep94R11ECOMuY3ee87jyH3/XKiN1GrvqKyjIvQ7mMbtSdJChy5y3MgVD/Sq6zgFa
         ii4qRi3W+OcpAejI7PEpM8LngJLm+TN9x4xoajhSwTBPV2zvVVto6WD2IbxwCxhiynm9
         KE6A==
X-Gm-Message-State: AOAM533vz5WPTpYC4Pf9NtZccGF5FKoUg+H+Dqdp7aASTvejfGaTohv9
        UCFBC/Fxct+jE3TtoLUrbHBOjNXFjRIAGDv6
X-Google-Smtp-Source: ABdhPJyhbA1cojSmJmnyYivZ1NJrFNBpQkyDlYNQjQ1LgTp8AX9cifsCVJdU9uZlz9hbiLtPVIAdJw==
X-Received: by 2002:a17:906:328d:: with SMTP id 13mr12429218ejw.28.1642418315019;
        Mon, 17 Jan 2022 03:18:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:34 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 1/5] ARM: dts: imx28: reparent gpmi clock to ref_gpmi
Date:   Mon, 17 Jan 2022 12:18:25 +0100
Message-Id: <20220117111829.1811997-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ref_gpmi is sourced from pll0 (480MHz), It allows the GPMI
controller to manage High-Speed ​​NAND Timing (edo mode 3,4 and 5).

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>


---

Changes in v2:
 - Reparent by device tree instead of code (drivers/clk/mxs/clk-imx28.c).
   Suggested by Stephen Boyd.

 arch/arm/boot/dts/imx28.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 84d0176d5193..130b4145af82 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -110,6 +110,8 @@ gpmi: nand-controller@8000c000 {
 				interrupt-names = "bch";
 				clocks = <&clks 50>;
 				clock-names = "gpmi_io";
+				assigned-clocks = <&clks 13>;
+				assigned-clock-parents = <&clks 10>;
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
 				status = "disabled";
-- 
2.32.0

