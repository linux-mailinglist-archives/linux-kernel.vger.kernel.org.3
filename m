Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5759B59F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiHURbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHURbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:31:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1A17A94;
        Sun, 21 Aug 2022 10:31:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so10636399wrp.10;
        Sun, 21 Aug 2022 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aSJ84KqrNn6MWyh6FORcW3yirHeYw6hYSs0IzGec01M=;
        b=oMPqfpeHVVfNLHP2MjvlbDraFSkaHgYrFskuQI4NmmbhLtDnnhLOa3vC2pdNgKyy9t
         +Fb4PAHxafTxVQLv2RdYwIQnu469rsfq3eC5wkJkZGheKOO0TwANXPxpol8qfr8qCYWM
         jV075pLCfKUO0CMi68yqYoaMawBNfzo4UJxSCYGRmD0bnBj9Q7e28YKUOEKxio16M1I+
         qb8ON1lB2aOqY+jhfsDiOnyXb+gY6gH6jLnP+97TO2I+mqwhlqhr1LFVdrFuUc24nUdj
         Da6dWlIzJccvrTZ2TlyNOhkKBm4OBpPMrIBaiyljjVAwCOR40N+l5yczII4Td45mMr1Y
         ScaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aSJ84KqrNn6MWyh6FORcW3yirHeYw6hYSs0IzGec01M=;
        b=i5wwujPd0oHGM17ebfYd1b5+bJxY6v2PQXQKIXUWPOEsePFsD0joEWMU9kfoufGySA
         L5uXaHPEmCiHhOu8l0fPx8Io4iNQFFp7A6aJ9AkIdNV/EQPkMC+XyZrGVk+jduhiNO0s
         NUNS5SSJpaBRPvRzMF5iewH+mTF5MwwHb+51XVfmFm3r5Xn+OHwwLF74qo5PYP4ZU8Sg
         4103ShXbBQ90EmkyLINxYwSlInzyvakicp1IG94HCfXDFw9vVxmL+jS5Gb74G7O0G0+R
         i1bwDI6K2sRbXed6G2JA9D7IBu0jFR2q03tM5QZcdGRqq9qE1xx4h0GbjcRcbPf5D6Ua
         4r/g==
X-Gm-Message-State: ACgBeo3jtP4GHFEHrtFVX8A+03Isd1JXCMR1hCDvQCzahZN+hOZcRic/
        eWHW3z8/QBuZFODoe7slQ8s=
X-Google-Smtp-Source: AA6agR6fKo9R8ycp4Gb4tGnIr8ckPmGoMswlycqEn46ezfu/KXVXYdHG72MTfHpaSq4d5MQIOxl36Q==
X-Received: by 2002:adf:eb01:0:b0:225:294d:c9c6 with SMTP id s1-20020adfeb01000000b00225294dc9c6mr8779399wrn.285.1661103065929;
        Sun, 21 Aug 2022 10:31:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:a77:3d70:9d84:ec8d:98d9:c29a])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b00224f7c1328dsm9387205wrr.67.2022.08.21.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:31:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/4] arm64: defconfig: Enable devfreq cooling device
Date:   Sun, 21 Aug 2022 19:30:48 +0200
Message-Id: <20220821173051.155038-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220821173051.155038-1-peron.clem@gmail.com>
References: <20220821173051.155038-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..109004e44d21 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -584,6 +584,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
-- 
2.34.1

