Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9C472B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhLMLRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhLMLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AC7C06173F;
        Mon, 13 Dec 2021 03:17:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so10686322wmi.1;
        Mon, 13 Dec 2021 03:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAImPKKHaAYwlUU7qMVUHA3q/9QaJM2yKtO0MluHZcY=;
        b=DuhiwHVXmDCroXicHe6YOt/c46mbgZtuqtk/R/pzpdfPrG/AI0ipWBI9X6pp0W4Dey
         GrkWw8Nn7jT7FbkXmn9Lhr4ea5/y4k/MSSZ5m3p3hpd2zxHQ28tH4O1fupk4tfpGwR4b
         jziMLOYSUksrcgzt35GZuUHdJVT+o/ZnnXjkK0F2zlmBZfojwuzbMenYL6gtf22VN6cG
         XvUNJcNbtX4wQ5VRJa1pZEamVjndXxkBGLt2BEpEixgS98f7S78Dcr41Bo3EzZ638YQr
         FcVCLYELT/OCIohd6YDNU3FKfRY0rrmXKjVzSwQocYKX702470uUDEbPAPrxuB3LFblM
         pMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAImPKKHaAYwlUU7qMVUHA3q/9QaJM2yKtO0MluHZcY=;
        b=h8H0WYhyLv41F706rFlMAXTdayUHerVai5tq46iMqInuHIdyA10MQd0mGrWajHh+oA
         UVCmtWsIpaBRJwYJ0z1EyJx78s1hZ3f2Qx4yfTqlLadQ8pRi7JDf6/gBwcwvDUaEen4M
         WFTi2GPHmn0DMkKN3UiuIKvwTWEUd1bkMyrKLAtiZGqjkCGtuO8Kiu8TgFFoIUauk5ze
         E1XIz38fM4oezE5XitJ4dilnZ8KQmXbZlLXx3WgK+G1C5eOZYCUCvrmApwWvxygco6Xa
         rscd808BTPiXON+OQJu4ou/WMkYicami/FkHi9P/m+rGK8xeU7riypj2U3MWAHzjD99F
         Rd6A==
X-Gm-Message-State: AOAM533ror7QTHGGj8Y7ax/Kfm9coqhJk2l3pczh6SLOvkIrBBZjMD8R
        ExLutkNUI+RCL4zFrkVjgt0=
X-Google-Smtp-Source: ABdhPJxYwbe/DhF5e5KPoK5EFW8X9bM0oJbG8/rvhDucAIHWBtCDWz0jnEJ7zTVVrPxM3rVySjSWkQ==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr38568800wmh.158.1639394221607;
        Mon, 13 Dec 2021 03:17:01 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:01 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/9] mips: add SYS_HAS_CPU_MIPS64_R5 config for MIPS Release 5 support
Date:   Mon, 13 Dec 2021 12:16:35 +0100
Message-Id: <20211213111642.11317-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ab7c01fdc3cf ("mips: Add MIPS Release 5 support") adds the two
configs CPU_MIPS32_R5 and CPU_MIPS64_R5, which depend on the corresponding
SYS_HAS_CPU_MIPS32_R5 and SYS_HAS_CPU_MIPS64_R5, respectively.

The config SYS_HAS_CPU_MIPS32_R5 was already introduced with commit
c5b367835cfc ("MIPS: Add support for XPA."); the config
SYS_HAS_CPU_MIPS64_R5, however, was never introduced.

Hence, ./scripts/checkkconfigsymbols.py warns:

  SYS_HAS_CPU_MIPS64_R5
  Referencing files: arch/mips/Kconfig, arch/mips/include/asm/cpu-type.h

Add the definition for config SYS_HAS_CPU_MIPS64_R5 under the assumption
that SYS_HAS_CPU_MIPS64_R5 follows the same pattern as the existing
SYS_HAS_CPU_MIPS32_R5 and SYS_HAS_CPU_MIPS64_R6.

Fixes: ab7c01fdc3cf ("mips: Add MIPS Release 5 support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c89ce68d9580..878affb643e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1905,6 +1905,10 @@ config SYS_HAS_CPU_MIPS64_R1
 config SYS_HAS_CPU_MIPS64_R2
 	bool
 
+config SYS_HAS_CPU_MIPS64_R5
+	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
+
 config SYS_HAS_CPU_MIPS64_R6
 	bool
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
-- 
2.26.2

