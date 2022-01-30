Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651184A3B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357248AbiA3XiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357046AbiA3Xhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E696C06174A;
        Sun, 30 Jan 2022 15:37:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b9so23275087lfq.6;
        Sun, 30 Jan 2022 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66lCIOUKcPJ2J+m4Cr3ZW94G0lABJXZaED/s9f5QGmA=;
        b=IaLlORDZoeaYRpO44854hgYk2/vgTJOclvwIF3Vv/dy/WRswOVfYMTb/lgYFF6u20R
         kgD4kuaMUZhPrzrsrp+1aHUtVBmfCdIQHjkOsK+D3JxP5SLPXm0dCS3YEeqxtX5eYSIx
         8EdSobISpvnT22JqnHeoUtNW+EX+/cnH1SeCCQB6STOy1ozdbhelGYqvV1xMpt5YBA99
         B/96htM+mne2xjdlCrcPFCtKPM7GzoR7BZlH1OzPT5hR1hE9cLpw2j5lrnPZ7ZPlmwwI
         nMOCD5Tt0vJ4ks8CXxb7pk/YLn1ILllHgnHrKEVAgGpxNOjR5JCV7EBSVseqXYt1IKk7
         FSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66lCIOUKcPJ2J+m4Cr3ZW94G0lABJXZaED/s9f5QGmA=;
        b=QpEcDSDiayNvkQ76D3dsmgmr0Iwh68el8GXWnbyfIJUUuOTzqwuXr2Q7Vaqh+wZJpo
         4w5e9tP+i50A6X2rA/gKcqb9avQgg28kVyAQIA1P8mJ6SSF4pykpqFOywgy1nN+1cK9u
         jEneYOw+gpieySlEm8QFgnoY3uWvaRHGIzGEzMs4M2r3Khpue7rywXq8a/GvpodC6sRn
         BJ/YOTF4SlwEO73940ncHpO+GiHjNzh4BVLnG9pe5UsVnT3nCfnE93ViQrhHQLLe4gg4
         fLPGD43bXELTeumgsuPSbUXh2hTSisKao7H5PV2aEABNhLW6fdXwiUQdH35djJGU9qlO
         wWFg==
X-Gm-Message-State: AOAM533RdK9TY97pM15JtF+xkOiNnD/6Wp8vKZlMaYYqBDVY423KTEo3
        qNNYeZKYDeM/eb6XU3pOh04=
X-Google-Smtp-Source: ABdhPJw0xUt9j/jtl0uaDt91Bsr3KfV7lR3RRZqMVEqi4OIibegSJcLOPzN3p/u9YZbK6f72FdmH0g==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr13662510lfd.216.1643585863533;
        Sun, 30 Jan 2022 15:37:43 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v6 10/21] xen/x86: Use do_kernel_power_off()
Date:   Mon, 31 Jan 2022 02:37:07 +0300
Message-Id: <20220130233718.21544-11-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130233718.21544-1-digetx@gmail.com>
References: <20220130233718.21544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel now supports chained power-off handlers. Use do_kernel_power_off()
that invokes chained power-off handlers. It also invokes legacy
pm_power_off() for now, which will be removed once all drivers will
be converted to the new power-off API.

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/x86/xen/enlighten_pv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5004feb16783..527fa545eb1f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/edd.h>
 #include <linux/objtool.h>
+#include <linux/reboot.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -1068,8 +1069,7 @@ static void xen_machine_halt(void)
 
 static void xen_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 	xen_reboot(SHUTDOWN_poweroff);
 }
 
-- 
2.34.1

