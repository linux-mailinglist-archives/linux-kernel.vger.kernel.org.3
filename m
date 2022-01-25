Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1C49BA14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587584AbiAYRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiAYRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:37 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B38C061788;
        Tue, 25 Jan 2022 09:12:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d3so17388009ilr.10;
        Tue, 25 Jan 2022 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrtH5ghaKPN4zPq0sPHDAur3BisSAdvDShbVq3dIejA=;
        b=qfiSSeIxefWvWW91HY1bM17R0N/s6o0+Yjh0p4BV/GcxYzIkNnorxVtPITTcwXvpI9
         TLcDMfDF+wuNR5qhQUpsq2OOvaJ3QX+ase3dO7BliS2YLsm//qPllzUxk1yGEbhooRhO
         i5U3KuLFBMsUzdAmQeMyD3aBKR/oaCtzEXjdcCwYf/zjkcyzDfZjLrnBnqtnlzwv0/Hy
         AF0d+nV/lEjuL2TtWvolLPHu/Kt70emVwZQ2nmvHSTrvlzbt62kqHevDG5RHvfXTG8F3
         Bp+FyZRL79jGpWuBhI6bp02kkU5zwaNlAA/fxQ/7+iw/TDCGgd5BIokiJwShQ1jDX1nB
         exbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrtH5ghaKPN4zPq0sPHDAur3BisSAdvDShbVq3dIejA=;
        b=8MCGij8k/Cn4j664RWvg36AlE0uwWDK47QUstH+teNAHehoTxwm4USUFInO4xuGu8u
         dmoARyZZw7jwVKk/SDrw1jck6FmzJnosPIBZTiDTPE2A2GuQmlKkzvk7mrNU+hVL/xk8
         ROxmqOTuiU9gC3uphMa5/ysfIaKouU5mvKfxQle/kxkBF/mC01Yufc+woZcCA6gqiNUY
         npXqawUVQ9QQWnt+vvpNRmeZrA4/XzrG+fjOYz/gXhnWzPOg/nzH53xR32+7kKOJ6QGK
         tZx/BpTwlMX8UU42KbhGMqHQJAEqgO3s3JKnib7YIYgsVuFo+FKxMM7kP9auuq/DX75t
         Sy5w==
X-Gm-Message-State: AOAM532Ne8CYxAcB10XdoDwAc6RxrUdUJAA2LYaY3QfBxA33USS/w4VF
        V5davxaEyrK+XxIz8rTCVZLwPm5yjm0=
X-Google-Smtp-Source: ABdhPJzkxyIibb1FGTbKN+rTHBAFQa3lU1Qx2tprXS7p7+K9mSBL7V22s7wjlfzr5Avd5Q1iORjH7A==
X-Received: by 2002:a05:6e02:12ca:: with SMTP id i10mr11495329ilm.284.1643130743930;
        Tue, 25 Jan 2022 09:12:23 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:22 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V4 01/11] arm64: dts: imx8mq-tqma8mq: Remove redundant vpu reference
Date:   Tue, 25 Jan 2022 11:11:18 -0600
Message-Id: <20220125171129.472775-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpu is enabled by default, so there is no need to manually
enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
index 8aedcddfeab8..38ffcd145b33 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
@@ -272,10 +272,6 @@ &usdhc1 {
 	status = "okay";
 };
 
-&vpu {
-	status = "okay";
-};
-
 /* Attention: wdog reset forcing POR needs baseboard support */
 &wdog1 {
 	status = "okay";
-- 
2.32.0

