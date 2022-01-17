Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF64900B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiAQEJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiAQEJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:09:43 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:09:42 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id y4so28244890uad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmmkS3q8ZkXEFM/EfahUjYOnFrF8f8Sbt6FKWsNonmM=;
        b=CBkXYlkHam9W5jNovje/cCHa4ISIYJRBd//Z+sGOHZXu26YSjLN61ge/FaMsKuqPA0
         8/I8Q6gOUHHxkCq9FVusyMiZgvIbM9QfTA4z1gBKvnM989qDdOjwbdnFQaw6aib06TfD
         yBpr5NQlRbV5IBGKYf7z0hL2fTifWAzfRBdbXKvVmBUPFfI7VOveJS+q0R9cHz2GiBXE
         QMBDXlUHa6g2qZS77tZVgCT0tDDz3SOFxJTZKEltgOMFLfb1bmjRhAwpkEgr0GpKHEnm
         dxuOToZUFrW5CQz4EOioJ3pGybxJb0v5GufR/xbDcATxSTKj5CYcq1IGy1XjEKjDO9Tu
         +liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZmmkS3q8ZkXEFM/EfahUjYOnFrF8f8Sbt6FKWsNonmM=;
        b=L+pV5BaY+teFM0zIH61pbdVOhwgr1PlOABIgkl8AWI6jTM25oaA2W8zH6RyeWGh93t
         YCljHdD0Qtv76m2yhwZ9+r2Rr3UbIDoXufUHaDTaiKQsL9129sjeA9Sw+ogQS0i+P1Yj
         SIZn+sH9js+tBl1b4amfeqdvnzJu0kLKRRW5I1dYDSMU3gdJASlnTWsfHoVPV2aUpPKf
         rB8GClbRnKRkTtEJW59COf29/MbHEfBcNBj4tLUyVOf5VoE54Z1GrmPE02v0nvDzclM/
         Icj3uMKbcoVuW9fSQU03y5bjG5i4MA03ZS+XeeM0EWMUAIa1qNHzFvGMuPLZ7EVjdDlB
         J8Gw==
X-Gm-Message-State: AOAM532P1sVfqG739FQ1beFWnd5UfJmwlCCxfy/2xueqZ+dLPZyGdsbl
        nKCFdvVFBwMU3g4ZH7xLrCA=
X-Google-Smtp-Source: ABdhPJxe+snmvv0fxYJqzx5jT9nGR2K5zVmSV0xqGaj5QsWFwqijOndsPTwAeVCOa5C7AkbEOKB3TA==
X-Received: by 2002:a05:6102:cc7:: with SMTP id g7mr5891753vst.37.1642392581744;
        Sun, 16 Jan 2022 20:09:41 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id 188sm2117451vkb.24.2022.01.16.20.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 20:09:41 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     patches@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        geert+renesas@glider.be, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH v2 RESEND] ARM: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE
Date:   Sun, 16 Jan 2022 23:09:40 -0500
Message-Id: <20220117040940.59557-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this to properly add it to the patch tracker - thanks for letting
me know, Arnd :)

When ARM is enabled, and BITREVERSE is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
  Depends on [n]: BITREVERSE [=n]
  Selected by [y]:
  - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]

This is because ARM selects HAVE_ARCH_BITREVERSE
without selecting BITREVERSE, despite
HAVE_ARCH_BITREVERSE depending on BITREVERSE.

This unmet dependency bug was found by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2:
Changed this fix to remove the dependency on BITREVERSE from
HAVE_ARCH_BITREVERSE, since it isn't actually necessary.

v1 link:
https://lore.kernel.org/linux-arm-kernel/20211029203110.8343-1-julianbraha@gmail.com/

KernelVersion: v5.16-rc5

 lib/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c80fde816a7e..9b5a692ce00c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -45,7 +45,6 @@ config BITREVERSE
 config HAVE_ARCH_BITREVERSE
 	bool
 	default n
-	depends on BITREVERSE
 	help
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
--
2.32.0
