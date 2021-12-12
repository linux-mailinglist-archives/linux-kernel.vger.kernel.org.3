Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B35471C22
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhLLSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhLLSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F31C061714;
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k9so5750602wrd.2;
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i19kb1HIi1Xsd5I+hkb6PULQ2un2r4KYU7MSxf9j0Is=;
        b=dhU6u1t5w/gbGYLFUHZif2lsTCppIrashJsHYnFTc6rtg1wfwQdztCtJANLxJLZoVW
         EaxDKt/qYHEo6XB1uDt7lgsurIf77Of9CFuV5FU50yHowEEnwF4Ts+za501nU3ovFWrF
         t0Y+bOfxxq7MdmKUQghT7PchciEMgDkIuGp3Q4oioxwj74n5FOkk/rjv4HIDAIqPGrCz
         aklFhLeJX0Li1o1PHTZGJZXdKXlzf/Gb9bUQ8ExYfEkSucJpgxy+N2lhRD9T9+FABhyX
         I/9kDuHkzw8dqBbZZdORElmGECq9CL00CzluNtj4rkvPQNsMN+Vt1rXta8gSorSMhyUl
         cCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i19kb1HIi1Xsd5I+hkb6PULQ2un2r4KYU7MSxf9j0Is=;
        b=V7qR5pS/FDHs4Jk1aP5LVoiEinexVScMtAYCoKL0CAwR1asILp3jSfkyc6gdzj4ASw
         UhhkvCAXdngUPKB7cRlnVhLdg1vKBnkKKQItproFH2rQYgmsNh09h0OCaqpUZItMQoN8
         jI2nKnR9KWqQPVS63aZMGqPQ1A0QA+EqdAcJYszhdmfD9VU0fCmO9UB9eluLMyey8bBh
         5AAXBEs3RI5keqvNFqcnodPMUbm7lrxlNi+TRd/bvkrI4hQ2eTvwwPdzkK/irXBxnjOX
         eCDV7rtk+NeRvRnZZkPoBs2WAOT2ggCqILPNPmWhHV7iUnzELHNCWIBRsf7iUbndN7aJ
         gSBw==
X-Gm-Message-State: AOAM531W1myBk0mwWakNTXqj5c6E/FiKAcePFvWk8YXJLJ7dHiAu72AX
        k47DiwtUhQXtm7/Xqpah3h6rDVfTjzg=
X-Google-Smtp-Source: ABdhPJy4iscW+86WtDBokp9/K83XMVptdoD8RM/TKpnQk5wdHrqPCZyOu2ggt9K0fhR0pK6xiqWjYg==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr26151124wrn.183.1639333152035;
        Sun, 12 Dec 2021 10:19:12 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id c7sm6145660wrq.81.2021.12.12.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:11 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: mstar: Select MSC313E_TIMER
Date:   Sun, 12 Dec 2021 19:19:03 +0100
Message-Id: <20211212181906.94062-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212181906.94062-1-romain.perier@gmail.com>
References: <20211212181906.94062-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the ARCH_MSTARV7 have timers that can act as clocksource or
clockevents so select the corresponding driver.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index cd300eeedc20..d079d567bb72 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select MSC313E_TIMER
 	select MST_IRQ
 	select MSTAR_MSC313_MPLL
 	help
-- 
2.33.0

