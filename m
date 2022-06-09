Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C6545046
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiFIPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiFIPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32FF3AD88A;
        Thu,  9 Jun 2022 08:09:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n28so31621794edb.9;
        Thu, 09 Jun 2022 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zyoX3J2UqcYH5PT2bQLhLyl8uSg9U2s9ZbqDt24Cvo=;
        b=RtLZcNl/AgRAQjhFkQvpJ0UW/So1xS2328Un3IhLMvp4XbNnd77aGArBISzwkr9elj
         /D6UQydRfkHLXYPkbZdi6vK+cYPj4+PrVu/rf3s4Tr2xM2Hi0K8pun87BtYuib2zXTDV
         Ws/UR7Pt5KZ+DyPSfqq+bmq7DzNZ7KlChY/fuIKDpNVsiZ9MO8DlU3Yt/ODeCO50p2+s
         RmJhVCjWvp1FgaWi/8FZSw8rQvFVYLTrp1RiyijUtd1bvG0FBkXsaREAWTXlU01V160A
         LhsRAK4X3K8B5Q/HYsjb5LbFBgIDzeph/ggCIduNMv9UUi08paa9zry8JKujiVsFifQp
         iqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zyoX3J2UqcYH5PT2bQLhLyl8uSg9U2s9ZbqDt24Cvo=;
        b=EENTSn8L89vsz5d/pVK/Qsuhe9kEb0IK8PblnavXL63oNKwe9IjoGPudbcaK1sHRMa
         UsnO12LcodHF17WZeNp3VgRzhoLgHwoztkDFGdSpXpVRKnztCseTztWWs4MkKLpgPqNt
         4rCHpzWsx6VgYd31IdS3249GZuxSUpQnI0duDUzUTnYGEl+zokBoRaYEjoEuyt7Z2Yr6
         +KRkBGRwn9CMJw6JXheUsTBBYpzIFBJ6q83g+U7Wzka5JeYIa2wEwLn0f2q5yMhrR17f
         9HfSFzSQVG7QuGBVM1pvk6k7Fi82rGNdSRL8lqKipqHueMhocvjaXWXe1AJx09sUlLUY
         N8bg==
X-Gm-Message-State: AOAM533MnPinAhy4jRnCDTUG5ggSFrKWam7f8YD5OT1bO/A3q9J5aK5y
        3ptFUgWpPmo8n+aJG/iwi9E=
X-Google-Smtp-Source: ABdhPJzDqLykgUBPOwI4HennALxPgVw9azc7HG62oHbwy0087GZYucimsjtbfT1ao+9khSUcJL9Tdg==
X-Received: by 2002:a05:6402:e81:b0:432:7f12:1878 with SMTP id h1-20020a0564020e8100b004327f121878mr9904565eda.179.1654787383281;
        Thu, 09 Jun 2022 08:09:43 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:42 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/5] arm64: defconfig: Enable generic power domain controller controlling a regulator
Date:   Thu,  9 Jun 2022 17:08:50 +0200
Message-Id: <20220609150851.23084-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
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

Enable CONFIG_POWER_DOMAIN_REGULATOR which is used for controlling
CTRL_SLEEP_MOCI# on a Verdin iMX8M Mini SoM.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..fa53a85cee18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -564,6 +564,7 @@ CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
+CONFIG_POWER_DOMAIN_REGULATOR=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_QCOM_PON=m
 CONFIG_POWER_RESET_XGENE=y
-- 
2.20.1

