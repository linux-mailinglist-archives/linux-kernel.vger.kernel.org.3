Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7C549FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351117AbiFMUrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351027AbiFMUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2219FE1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so6636095pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cz4B4vTiwX5UFau4AlWKqfaChYjGtYceKsM8SbFuknE=;
        b=xjwz6pVR2JDlnJi8TjlC8OitJtEVZVJPyMn8cHS3OQlIO2PADiAOLWzb05pnZ6YcX4
         Fb9Kob2xPXQ4rqY0Pdo2651kMwz3skiiO+5CdNp27D7oef/3TBvYFUDPcq7umJ32lJ09
         zmr8KgDWWAxwESoI8LMVx8GAToSFf8OFvO0JlTTDs+Dr1IOh+4eWA1Rn5yfaccqq4Fth
         sOIocGaremFfwfoeFGncg9LSakyM0QXXswP65KJtlYs/sVAmuj6hv3+zQD2H7RptdtqO
         ccXPrS7rpidsTXeE/FG/0LygFLfgHRpvUxtJgjpEQmGBQGJAE57Cbrpz37woyZZ9AjKQ
         +99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cz4B4vTiwX5UFau4AlWKqfaChYjGtYceKsM8SbFuknE=;
        b=S71OKThgMm7CVOO1vaiNTI09kYFJae752qGyu8C8DcGHg5YtJByPMTWnC0TzbPIXV0
         yzndJn96NbbJinHXpH87jRuqzmPb/h2YISezutOhQVTxI16lp4lx1l8MNzyTP0vy3+oG
         ltO6fyOptiOesKOvbvTB+NuI6RZ/+fkRQyUaAeVwOVbN+WL9RLSr4G+7AiQeNqgNwj4h
         6Fm+qXET7IAthOzVSMMt69CXUpNNl07gvOBiJlYYxzwzwN9NIIVvQxtMMzvrrUA+tyqE
         wLxE8Kbz8vDVEpdl5JCWJ762JekDVs5X2Y8Q7pLWsSr6QjfS0t9yjN1v8f2+Lph3U59n
         /Z5w==
X-Gm-Message-State: AOAM531RiG+qaVKkX/PtaKQBiWZIGSJAkKjNLhqyw4RPdAWZWz77TWxz
        yyGykq4Ywu7ROXWuEx+15hI8gg==
X-Google-Smtp-Source: ABdhPJwTorzgmVtvoHEfYfDX2UNle7UxXE4lSi2QpJ1e4qxBfNkkySveTDtLUH7tmdCIQ7155hzAtg==
X-Received: by 2002:a05:6a00:1481:b0:51c:4e9a:f618 with SMTP id v1-20020a056a00148100b0051c4e9af618mr971562pfu.43.1655150261438;
        Mon, 13 Jun 2022 12:57:41 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:41 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 09/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Mon, 13 Jun 2022 12:56:52 -0700
Message-Id: <20220613195658.5607-10-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add ARCH_PENSANDO configuration option for AMD Pensando
SoC based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4e6d635a1731..c650a89d8452 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -202,6 +202,18 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "AMD Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based AMD Pensando SoC
+	  family to include the Elba SoC.
+
+	  AMD Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

