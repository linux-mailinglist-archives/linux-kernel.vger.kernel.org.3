Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB54ACB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiBGV24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiBGV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:42 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96271C061355;
        Mon,  7 Feb 2022 13:28:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so21593687ljh.8;
        Mon, 07 Feb 2022 13:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsnvO3rI0+4fx0hfi5N5XanAKysJ+GmqbV5i8hTt1PU=;
        b=YIfY4SL0GTsR8+0O8tf1ZeI9rQE/y62ul1fzP6lIGyz8802y80cdTc21Wj6LVDNeHO
         Zy+HBlM9G9YfPIVX+BXrhxxu7at9jTvasrv/nM+Sci0NH077UZMJFJvyymHv4qWGsqXa
         p4vBrrxu6eowtMSRleEME8DiX7wYeziYcFeFWydNXDgH/lhRnbgH9+zljgShvsr2jduy
         rVTCHmcOzGvPrJwFd9WMYAqjp8/oc+62DJiN6gxZdlHy2fjJfviIaagPKO++Na8E6WT5
         4Jvfn14xQN2xyiCK/lRqEKlgw268c2DwDuhgJ9G9yuuJnr4oGfb7m/gGtnnvn0HPguj1
         /OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsnvO3rI0+4fx0hfi5N5XanAKysJ+GmqbV5i8hTt1PU=;
        b=qKp5VQvMPkFAYxWkHSozfMQo6za1zENkCmCJlYsBTaK0Cg0uCQq//B/0rZ05OFt0P/
         StioeBojk9vHsljRuuimQcXjfLp/F0X3vsDoJRzenyXVQxi0PktBCREFFyYo9er1GxNG
         y0ajPq9lPq3tSaI/2L2fTZ4uAeWbEzZgW3msRG42QyTH4SJUlLoQCGX7AljWUfwtWY1k
         lIRVrLx1LRsd0ynJyfZiAszTXcrwBNF9JmLJgBDj813TzYuYfXsgJgVzB3VxinWBwraU
         iIlLZktMigzg+UOeGKQ2J3x6opAd8ZNUAmYAUD/i3vQeCGRxFpIu2fAoaVpr9LGwXdxP
         9ezw==
X-Gm-Message-State: AOAM533iPwvwEAkKPyeahMSMOL58UPnIQeimxKh6vJ9yKoM8nvAQ319q
        ZMfiX7UTtGCrcMd4NFaODpU=
X-Google-Smtp-Source: ABdhPJzYfESh7qQYfY3f8FgXV5iyT4MTLoMeKiZZXdkSkmU+76CoZyNmut0UCSBJVXCWeuFe6UDgWQ==
X-Received: by 2002:a2e:bc11:: with SMTP id b17mr879679ljf.74.1644269320006;
        Mon, 07 Feb 2022 13:28:40 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id i3sm1650867lfj.144.2022.02.07.13.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:28:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Robert Eckelmann <longnoserob@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] ARM: tegra: paz00: Add MMC aliases
Date:   Tue,  8 Feb 2022 00:28:26 +0300
Message-Id: <20220207212826.10307-5-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207212826.10307-1-digetx@gmail.com>
References: <20220207212826.10307-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC aliases to ensure that the /dev/mmcblk IDs won't change depending
on the probe order of the MMC drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index d53a175dc17a..0fb4b1f5bc1c 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -13,6 +13,8 @@ / {
 	compatible = "compal,paz00", "nvidia,tegra20";
 
 	aliases {
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* MicroSD */
 		rtc0 = "/i2c@7000d000/tps6586x@34";
 		rtc1 = "/rtc@7000e000";
 		serial0 = &uarta;
@@ -558,7 +560,7 @@ usb-phy@c5008000 {
 		status = "okay";
 	};
 
-	mmc@c8000000 {
+	sdmmc1: mmc@c8000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
@@ -566,7 +568,7 @@ mmc@c8000000 {
 		bus-width = <4>;
 	};
 
-	mmc@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
-- 
2.34.1

