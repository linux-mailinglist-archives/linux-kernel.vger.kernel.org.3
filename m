Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED74FC093
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiDKP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiDKPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A133CA6C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:23:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h16so10155981wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tIzMDmEoNcDD+2BtKiLkK7oNwkjSU9e9gIp9qy7KOQ=;
        b=IlWfHjo0c3mj6Uyuu2TBZ7xyNyDp6o2n2U7Tteo3kdMh4IYxL1H4V/I72rQAYoXwb6
         Kjezj9pJpqKoWUzefw/w6U1XcrqwB+V2ED5odZ4+wkaJBSMK/uZgPX2b6MrBz26YWEqe
         +fakxkRcdEucrleJhlPkbzGnHIcG/wBLzFvRyhVRDb0qoMai7BGU5oMqkKDUDUJfqt/2
         2PYZUuOXC1t0cDomJ/vCGYSVckeXNlD5G50WTCSXflJGxvpPqkAIw/fh8kXlHDgySRUh
         lYhB3sGHvyILjSTeQJW29d8OjWTUy5PQkaDPPWcigXhEEgJ6QPXu2bxQ7AI5tRMjdkyk
         xBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tIzMDmEoNcDD+2BtKiLkK7oNwkjSU9e9gIp9qy7KOQ=;
        b=45KK4En8FTSiSU71D5wADQHHt/uGCsbwBNdZ9TGxd7TOw4eDA27HX5k9zhb33yCpxq
         5vnJjXuX0hz9ETl781Vyig5wjFDuCl2P3u3HrLRHp81/KJRN1/D2jv7xEKBaXBJB7gnT
         nQaMZY8RP42GOSS7CVaAzef2ekBwZ/tQLXopPcP31mponR+Vt0w2v9QMl1sXiF5VkuXu
         E/u/eFwjndfLdZQwmFrNSIqJUDfAuUCgJ83LH2c3mTOPSSDC7057wiBHeVI7mzO2TTOr
         O221opDE6M6YgTUvRSkV12/GtvYUhrp0k5DR+Y1Jp7c6l3nOSJE4k0bq+6kjSDjsaYL8
         xj8g==
X-Gm-Message-State: AOAM5331H+aEp0gkI4cDvTcFZm6Jwyh2+H7yi5ypZJi0+f5hpblgaKki
        +olTY4BR7iOeIbUhN/j1oNw=
X-Google-Smtp-Source: ABdhPJwxwQceQZlnxuSy4C3lfI9cmMFbbFFvMQAUsnOMvqm20+VFI/DZ4u1iM1ekYC+fPv6NjzuRjg==
X-Received: by 2002:a7b:ce11:0:b0:38e:c257:4c76 with SMTP id m17-20020a7bce11000000b0038ec2574c76mr1870639wmc.151.1649690581211;
        Mon, 11 Apr 2022 08:23:01 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:23:00 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Alistair Francis <alistair@alistair23.me>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] ARM: imx_v6_v7_defconfig: Enable the ADC part of the STMPE MFD
Date:   Mon, 11 Apr 2022 17:22:34 +0200
Message-Id: <20220411152234.12678-15-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The SoM Apalis/Colibri iMX6 use the ADC of a STMPE 811. Enable
its driver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Addressed 'From' address as reported by checkpatch / Shawn's feedback.
- Added Rob's Ack to the 'dt-bindings' patches.

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f7498df08dfe..88a3602c4e58 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -402,6 +402,7 @@ CONFIG_IIO=y
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_RN5T618_ADC=y
+CONFIG_STMPE_ADC=y
 CONFIG_VF610_ADC=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
-- 
2.20.1

