Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D0E48A5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiAKDBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKDBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:01:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:01:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso2485283pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOBQRy/88gLq1oZJIE5ZrO/xHrvt7W0czi8f7RbBxVk=;
        b=lWvS7xbypXrkh1JtDO38Ck/LHec3D/7OgBk2Sc1UBgTGrsIhekup6X/VcbBeo4qYI6
         7T9iJ4gtMuYWZGx6WvCuCGmpYPIi33YiYgcL5j9qTsxRMBv0Wq48blEOguPeRMtO7gQx
         N3VsWqsaXRjTx+i5xSsw/WReuBAykoeLScv9sGygAh6zdm+Lu00/SY61zhJLjk1T/sTZ
         Fx4pdOkX4qeQTI+YyVsBBTnOd2PclCgLcafwkYl+8avQt8YL3UAM5JtY63IS/3JgX5HK
         ytjCrmlzkBS3iFQFYxMa88vN7s4KxK6ABke8zQaPxsl8IOpdQzU1tJXFd01Z26DPVTaa
         Ye4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOBQRy/88gLq1oZJIE5ZrO/xHrvt7W0czi8f7RbBxVk=;
        b=BKQiS9V2rnbauK54MoQgRF1k0B0tMEUhIcHOBg2Dn2bkfGEUBp6H1zwvmQ5Ll/LtMk
         QlblaTuc4dT2sVC4S5JR/lq2Vck1zQGs+f3/6ElVNlvqAQuh/tCjtQqXkg5yCEyXGFb0
         oEuPP1wir0iWFKWcWmRJ7IWezUqgEvDHAKLd8OS1+OfessKRsbe5/Qkb4/rYYz2kiles
         Keq0emgK9paJVOYgrZ8UyMzeuKxJWUsJcwfHFMjEadYbG5tacuJI57DIZVLSx5k2jPwN
         tNP9km5dxL95/tdKMgevFWMYvWCxDoAXVhmctEV+0zgjvMSFOqpa6hsC0HIORbwRLNKi
         G9jw==
X-Gm-Message-State: AOAM532TmnN7LemUpPXE+n8Rh0z5teOeZWisoU8qtPtH3UTfv2IkL6ZI
        d6jKUg3o15t28mo1zQxyKC5qsRjPpjkBLg==
X-Google-Smtp-Source: ABdhPJwtMTflS/meiKWegPwN2yR+R7g7HsqX03ppmS205L91ZnCXf2Z+xcucTYPEua7QpAGcnsZ+sQ==
X-Received: by 2002:a17:902:d2c8:b0:14a:419c:7c46 with SMTP id n8-20020a170902d2c800b0014a419c7c46mr2582454plc.7.1641870091008;
        Mon, 10 Jan 2022 19:01:31 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y79sm418851pfb.116.2022.01.10.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:01:29 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gabriel Somlo <gsomlo@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: init: Add support for common clk
Date:   Tue, 11 Jan 2022 12:00:54 +0900
Message-Id: <20220111030055.2043568-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing the new litex_mmc driver it was found to not work on
OpenRISC due to missing support for common clk.  This patch does the
basic initialization to allow OpenRISC to use the common clk framework.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig       | 1 +
 arch/openrisc/kernel/time.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c2491b295d60..f724b3f1aeed 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,6 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index a6e69386f82a..6d18989d63d0 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -20,6 +20,7 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of_clk.h>
 
 #include <asm/cpuinfo.h>
 
@@ -169,4 +170,7 @@ void __init time_init(void)
 
 	openrisc_timer_init();
 	openrisc_clockevent_init();
+
+	of_clk_init(NULL);
+	timer_probe();
 }
-- 
2.31.1

