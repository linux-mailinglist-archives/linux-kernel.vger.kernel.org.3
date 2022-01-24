Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320EB49775B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiAXCcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiAXCbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:49 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D4AC06173D;
        Sun, 23 Jan 2022 18:31:49 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i14so12607612ila.11;
        Sun, 23 Jan 2022 18:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMhTEWTe94/lxvR3iguUuMULiaaMgsYkOT2qY7s3xZk=;
        b=iJ2k95ZXWZirEU8bh7HgcSE0cLcZLG8UBsmAXLbZx9hvWK1MtzagTzps3fE9ud0Dt6
         3dl1qjaI1gdmN1GxlYJXDkE+uXmsTyZazE2HLsJBU2WJoAIVn6+MJ58eC6ct/1/5xQzA
         6sQTNCiu8F5Ijk7PTZpf8seB/5qcxwqwEuEs2RqnJCB6yEIXvGk6C/yTlt65lnn28k1J
         Z1EdyWuI5GQSnSzct51pe3r/ejd2W0/roNplZDbgIOIDwBczinrOcMrEHFYfXRpW1z4C
         SbRx4kyUvDow7ajO+pSP+CLVWn283R3l8Q0ow0zy3VNtA4K8Cs2LaTFD+TY2kKd7ZZwa
         ISkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMhTEWTe94/lxvR3iguUuMULiaaMgsYkOT2qY7s3xZk=;
        b=5Ruhcveys5yKcB0UKCvRtkZUPeHo/r6FhMMHsNkRM3+MU1I7hHVrl9k12ULD2R1iuf
         u5d1xlsCWGkaZuPZmNDH0eX64GAU2j5nfH9dogCX+HKJoaKzRBBOPLVJX0P71qR3Mt06
         2xZrQmYUobeVQbbCJ/YRlDHJYqi7vu3t0WFkqhkLdw2DQidv3AJwUYYx/oMvJiwfWulD
         FRWV9Vy29MIDNWTZpRvm97I7rTn9KXNP9NxA3gQKBEOOwpYNgvE9YL1ZGlkxKcd6rViX
         8F5AmeQhaZxRFKTNfT6Bwum05OBTfAo0FM1oH/o4jDnRxBTlvwTqN9hAdLYm4ZBLEHil
         flzg==
X-Gm-Message-State: AOAM530k1JYIvwfsIFBTmf2UdYq6Ij9b4K5dOxVPb6bFDyd+AArAv04C
        jnApUuTdTyy26wN3E377PcCT1iudyXk=
X-Google-Smtp-Source: ABdhPJwHTfqTsXF+kZcb3xdm1e8LTE53DcTCXSzva0z9kKf4O8RhDcx2Gr+M5yR2Za1D9tLhQp22Hg==
X-Received: by 2002:a05:6e02:c71:: with SMTP id f17mr7680778ilj.309.1642991508220;
        Sun, 23 Jan 2022 18:31:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 07/10] arm64: dts: imx8mm: Fix VPU Hanging
Date:   Sun, 23 Jan 2022 20:31:21 -0600
Message-Id: <20220124023125.414794-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpumix power domain has a reset assigned to it, however
when used, it causes a system hang.  Testing has shown that
it does not appear to be needed anywhere.

Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f77f90ed416f..0c7a72c51a31 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -707,7 +707,6 @@ pgc_vpumix: power-domain@6 {
 						clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
 						assigned-clocks = <&clk IMX8MM_CLK_VPU_BUS>;
 						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>;
-						resets = <&src IMX8MQ_RESET_VPU_RESET>;
 					};
 
 					pgc_vpu_g1: power-domain@7 {
-- 
2.32.0

