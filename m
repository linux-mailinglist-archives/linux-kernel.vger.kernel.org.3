Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A183492355
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiARJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiARJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:55:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DA3C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so76906632edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFGsugHXHNFuRFx4hHuDIfTzJdjawgvKHVHNvYFVuVA=;
        b=qVIHUaepCN0HqkZNKvU8ObV6khhWZ37zrRJSGg04Y6fi4JwTrl3Ja2/LlPybNdKfvv
         /GevgzLzoNVsfQr5Q97ySxTvXikXobpRqcc8Pti5900PnNzrUimxoyINJK8W/Nzpz3qe
         0tpTSJvRsL3uYuB4orG9DjnY4VeWIrjbKOFfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFGsugHXHNFuRFx4hHuDIfTzJdjawgvKHVHNvYFVuVA=;
        b=4t9vBjxLEVYtwEeiIFzaNHRqQXnsESzzSJZ9iiLFNx/6VEqNUwsBBUZ/7sj9vS8c+3
         /HL6HSRnOvesCgAIhIms/OEiRV5tV0EbPalX0gbhsUVryaub9RMTvsIlgBz5kHQpw/Fv
         T8bE0a6wOpFWkZ2bL1FQwU+rrl4yC80iWlwR96viegfoqUdWS1/RJUPrVQcJMJdODvfk
         C9zt+xZ6T0831uPcWsm129XoZoMW8qyIE0VhTBbe2Z1DdR3kHjfOx+zSYEx8ImpEcMqd
         5jITesAYhCLK6HG718R2QgLYA92tsZ/RJ5bfQdvFyxZm7rI+HdsiQYcpm7sGvJOUPDbW
         T1RQ==
X-Gm-Message-State: AOAM5300+sT8cUoWns9abiHDyrHA8CKXBmoU44zwepOP3chYQgqWQqg7
        tZyk3scs9jX7UxJjVXKwNsxGaPPQb+J4Mg==
X-Google-Smtp-Source: ABdhPJyPeinfZ9O9gFd8mP62imIiuC1JcRKYr8SXHZwMuK6NI61glNVbnVUNBfzAo5J/X2HEUy6Zww==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr20836082ejc.105.1642499708031;
        Tue, 18 Jan 2022 01:55:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id w3sm5173520eji.134.2022.01.18.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:55:07 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: imx28: reparent gpmi clock to ref_gpmi
Date:   Tue, 18 Jan 2022 10:54:31 +0100
Message-Id: <20220118095434.35081-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
References: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ref_gpmi is sourced from pll0 (480MHz), It allows the GPMI
controller to manage High-Speed ​​NAND Timing (edo mode 3,4 and 5).

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

---

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

