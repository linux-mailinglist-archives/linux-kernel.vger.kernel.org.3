Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B91476F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhLPLNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhLPLNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:16 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C6C061574;
        Thu, 16 Dec 2021 03:13:16 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x6so34406528iol.13;
        Thu, 16 Dec 2021 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ci/iieSAzRzH/2rNrz9vVPVHZbfFcrg+DugyyrDVWRg=;
        b=avulS/IasZOsM1IErPUXlsBP9HRJ/FmY0hN2g7eFCyffTaOijll3DLWB3r0MBj73lh
         N+OA0lK4XQH5RLgynwNhZm7QUUtsJHKeOxvHflyujgtADBKCSoj3rx1aWsIDjpSzUXSo
         EUeYFs/pSRMK9oY19clTmBz1yxbm1y8P2TzGXAkeDXNAx60qcga3j1uU/K3iJQj1tG2k
         jKeygqbKwxMviXQ9XBfFaFxHz+9zz8GEgnVAd6giqbthw3VJiOGWuoO0JNN8IMjGEhHh
         n+0oEmuJqnqNqhXKAjCTIpTM5v7Nxq+5xd0OYNUNchTm8Vm1tZFkvpqDa/dqKeN9/asr
         7eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ci/iieSAzRzH/2rNrz9vVPVHZbfFcrg+DugyyrDVWRg=;
        b=3LJCESl0qYq2TvJD/8VANRuhGTvrd52jJWOoQPMfm19rD31CBtlFXDplxLH4GPf/+r
         LtrSJWWM6BcQ61adBJsXUt6Lvo9SQZZgHbUroejZ5QFtLxm4kcu3OmQMnH9aBzxM0LPT
         7c71YZ3Veb1ohO3Gc87e7bLaOSBmK7jTICZSCEaIYHnHqRNBo2YuyIADD0UADm4OZLHL
         Dc86U8rPcGe7i54L1zWUqaspN6zD2BtMqJgmbAiugJyFjwNNONGzP/kZdFWZKkb1W6OQ
         nRhDGXNxonS7R5br1B+8AFtrETd6gne4gH9Qc2eL+jap/eBhaUNCGO8YEzBAiyc1Z3kT
         cCWA==
X-Gm-Message-State: AOAM531I5pxE2ls+5uFkblJFscIw8pVKtGqVw5NQGi7yNMGRmgqUASxc
        f17b50qvb8EUHr93ZrQvMUfegS5Zer9u5CjP
X-Google-Smtp-Source: ABdhPJx1Pz6IYHOEHrltpVoTw61dTFcY60VVPwhS85F3uFkPQ68JSVa9jDbF1/4mjZxQuXQKK69RlQ==
X-Received: by 2002:a02:ceb9:: with SMTP id z25mr8847344jaq.121.1639653195540;
        Thu, 16 Dec 2021 03:13:15 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:15 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
        Lucas Stach <l.stach@pengutronix.de>,
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
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V2 01/10] dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
Date:   Thu, 16 Dec 2021 05:12:46 -0600
Message-Id: <20211216111256.2362683-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the defines for the power domains provided by the VPU
blk-ctrl on the i.MX8MQ.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8mq-power.h
index 8a513bd9166e..9f7d0f1e7c32 100644
--- a/include/dt-bindings/power/imx8mq-power.h
+++ b/include/dt-bindings/power/imx8mq-power.h
@@ -18,4 +18,7 @@
 #define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
 #define IMX8M_POWER_DOMAIN_PCIE2	10
 
+#define IMX8MQ_VPUBLK_PD_G1		0
+#define IMX8MQ_VPUBLK_PD_G2		1
+
 #endif
-- 
2.32.0

