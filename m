Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD2475B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhLOPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbhLOPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:11:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D78C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:11:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o13so38702583wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBNIoCCyN9wSgcuJ37qg24pNF3XF+D3632+cAPkIV/M=;
        b=VERVctzGgIsLj3+lwneUvXiEV3svF43ASp7TtqW1gpFhbfmQUCr9EyKBBftmf0UJtG
         LEgLMMv4mfy0FQmPX+M12EfCa91FQXr+tgZfhcAKhw3FVuNnPmStIi3LfvaDvojqRoyv
         zwoIuDJU/2z8orq/tvRihBQ5ZXn9V1Q87APNWxtw6JS9bnqRAzh6KkxLcR5KfQa6Tvw1
         vw9NGIwIeDBHrV52QkU1TJOkY4WiwqrP3jkklGS9DXx+r79kQo7OeDTdRNjAPGlxebQg
         M4mucbcFYuifxFlsAzi8U3GPAGlyowuj5942EjODJ9jsTSI6oSgJ9cGs/WRHkdgQcP5d
         8mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBNIoCCyN9wSgcuJ37qg24pNF3XF+D3632+cAPkIV/M=;
        b=yO94JOH2peVNeAw+/1kZApUEdPPOrrhbpej+eQhjktfSRQV3g3qoUzVQoO129zRykW
         buiAV8C8T1mUg1IIXmpkSxwpFRS1nV26rKBioG3kyFkvJOhczf/aL7RB5QTIDUTfNkph
         tWTHkdE7Q6JYCzyNEOq9lgzqeGJ29m/rvxQjukksDzqmBC9mYRZiARe8C5cZ9IPkts1v
         2b9SS43UHk3sZpss0ttOZAyZevxq4UrDlg1n3BnnxsnaG00QgtURbZO0apctOqtkf7cc
         slIwBzY3b6qtgYRZODVLBNeOHD6niwNiOYWebqsaJskwgEbG4tddjczM9r9xIC6eCQnG
         27qQ==
X-Gm-Message-State: AOAM530gs3XG0u8EgeKLg08mAhd7E/ciyBe+Af33+OPET63LGYXnTlq8
        QGLlOIJB9GtoF38Fg+S/rTd1Fqc/P0I=
X-Google-Smtp-Source: ABdhPJwcjuVgJPq5jg/PUnjQS7Vbsdf97HNtKAUTIXfQsza/9eqTI74AUUyFNjxNC4J0AHQ5gLI5cQ==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr4645263wru.384.1639581059094;
        Wed, 15 Dec 2021 07:10:59 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id k37sm2262168wms.21.2021.12.15.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:10:58 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Liebert <liebert@ibv-augsburg.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Keerthy <j-keerthy@ti.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: mach-k3: am642_init: Unlock MCU PADCFG regs
Date:   Wed, 15 Dec 2021 16:10:23 +0100
Message-Id: <20211215151049.101913-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Liebert <liebert@ibv-augsburg.de>

Currently only the PADCFG registers of the main domain are unlocked.
Also unlock PADCFG registers of MCU domain, so MCU pin muxing can be configured by u-boot or Linux.

Signed-off-by: Michael Liebert <liebert@ibv-augsburg.de>
Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm/mach-k3/am642_init.c                 | 3 +++
 arch/arm/mach-k3/include/mach/am64_hardware.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index 533905daeb..958fa05af4 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -37,6 +37,9 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(CTRL_MMR0_BASE, 3);
 	mmr_unlock(CTRL_MMR0_BASE, 5);
 	mmr_unlock(CTRL_MMR0_BASE, 6);
+
+	/* Unlock all MCU_PADCFG_MMR1 module registers */
+	mmr_unlock(MCU_PADCFG_MMR1_BASE, 1);
 }
 
 /*
diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
index 96383437d5..e06e1f9532 100644
--- a/arch/arm/mach-k3/include/mach/am64_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
@@ -12,6 +12,8 @@
 
 #define PADCFG_MMR1_BASE				0xf0000
 
+#define MCU_PADCFG_MMR1_BASE				0x04080000
+
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK		0x00000078
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT		3
 
-- 
2.33.1

