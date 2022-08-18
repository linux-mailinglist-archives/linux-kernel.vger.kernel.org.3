Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3504598E34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiHRUjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbiHRUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:39:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4BDCAC94
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:39:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ba1so3003310wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xygn6gbcrMpkU6O3LJ14UZxn1nCFuKxX8e/wHh/7Pno=;
        b=hDoGWC05/Y3Yjy5+Kzqp+U5WYRjYFZycwb09fnHn9n+Hz8YHHFWEiDh28HyuITaWr5
         oMZQ0tVlU5Nf8UWEUmE3qYgwV1V1J/4KpyybLUNGfdRF8zaSl2SmU8922xVh+1bzHszb
         ssDsor3eAuiOnlSouoY68hI0LeObyV8tYmJmqLVt3VDzaWhgcpypZt2qbrRd8CsPkZ62
         C56HijPTJlxO2iIo3EAU708uoANyraQjmFv9A+4f2aEhg+xx2NtUaQnNswbrspysvBLG
         XrkJYoWjiH3NJJaxzRQLU9ZWKHqHF76X4Wh40Pl1JMlbEOsEx41tI17N5oqMrKTrpIZz
         cBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xygn6gbcrMpkU6O3LJ14UZxn1nCFuKxX8e/wHh/7Pno=;
        b=kpnjYXh/H81UNQcH3Bj9SwxadC0rFJNQT2dZlgC8scOYPfdJUixjcpaVAV1d7eKVuR
         V//+Z2HXUZQsIc3GHCdtEkrDchpArVumfMWFe4XIYnUDTUXi00caYCO7LBeWaccOejSa
         b8lqB2LGClXIcq+xHgFySVDYYMR5ZkEDhWwd10Hlycb7yunqrzNbkw6mjnk7Tkr7sls7
         r0dxRffFl3tsHEUl9wesa8sM281QoXxn6/ReZPVEEOTVZVMLxIrh3zvOv4qhxwmeMhfX
         KoxZ/M3u+QgUI4pe0XqwzvK6+kqY+vlaMUl/lf0VpoWh9ZJwSaHRrSW1ZQUpVGVQYnrO
         zuBQ==
X-Gm-Message-State: ACgBeo0/yqwwaK189ijP8KWzY3CnFzLvW8EWLaWEDEzHgOZZUhKv1m6H
        e8QvMgk9oQA77xET4BkHvK3gdNFoYZQODA==
X-Google-Smtp-Source: AA6agR63LHfoemL/kg5QS25U8mqGufbAT7XDxsG8MKNfAZ5DniFWkDDq8xOXZipXmh3DKHD3pH49pw==
X-Received: by 2002:adf:f64c:0:b0:225:28cb:3334 with SMTP id x12-20020adff64c000000b0022528cb3334mr2485613wrp.700.1660855174760;
        Thu, 18 Aug 2022 13:39:34 -0700 (PDT)
Received: from localhost.localdomain (2a01cb000c0d3d00cc34c67bc193cac8.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:cc34:c67b:c193:cac8])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a54d610e5fsm1571648wmq.26.2022.08.18.13.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:39:33 -0700 (PDT)
From:   "=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=" <peron.clem@gmail.com>
X-Google-Original-From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <cpe@outsight.tech>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: defconfig: Enable devfreq cooling device
Date:   Thu, 18 Aug 2022 22:39:25 +0200
Message-Id: <20220818203928.131059-2-cpe@outsight.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818203928.131059-1-cpe@outsight.tech>
References: <20220818203928.131059-1-cpe@outsight.tech>
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

From: Clément Péron <peron.clem@gmail.com>

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

