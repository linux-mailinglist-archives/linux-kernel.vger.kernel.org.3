Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72A94A3B97
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357487AbiA3XiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357171AbiA3Xhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:47 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1EFC06174E;
        Sun, 30 Jan 2022 15:37:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u6so23257166lfm.10;
        Sun, 30 Jan 2022 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOoRrU+XNCvH4y2De/y0/3nvouQcv+AIk9CqttDCqGU=;
        b=Xenhc8uEX5pndBJlaDWs7DZMq++uCKYCaPhTRn+v8Pl6kdDQBiq3K+xk68g+lJ4bfb
         xZ0s68SQJzgN7roWd+Sm2QhFGePj8q4/xhI0aeufWhORrHMmrI9Me+kOtUbih63bZtb6
         0ONUKG+oe3tUPDlqh+XwtnfSXapDSUNhobEfHkXXD2jWYeC/eLrTsR82DtHf6HHPZ3Ti
         T856rZoGRovN/ZZzwL74avJYGt+XINSCwpiKRk5t0Q88fCFTaGgu6LEev5sylA8ww9qW
         bEbiz2YJdBL1j7FCE0FI146AM6wMNEQmt3CI8lSlsxZpxhGAK8uAOhBigDyDJ64IQ5ph
         fLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOoRrU+XNCvH4y2De/y0/3nvouQcv+AIk9CqttDCqGU=;
        b=oy4qJY+NvTNpkzyTqHL1xIYrF4pW2FaR2HjzrbadbVAHiVaYwhEoMvmeteWPJVT1p9
         sshR8eLohKMcOLsHYxO6ucgGxnqvqZBGva0t0x5BE52E7SRH9hIYIxds69xtP0s40ygM
         Y3tSl97l+CKQG13f0QkEHREeVLD07LIm12wDXeUJBZAFy5kFYTOLAi+lOdT/Eu6tqVFe
         NeHohJ1XGuacrQMt6O6Gn1HjFLiMi05PP7K1YwEO0P3iDhONFepGoMg3eR/nWKHCGn7z
         Adnk2Ww3Og2yKJfhD4CLhjdvFoV28GBHYweszTeF1aKoO/i3sbVTGjYddnYHCoH6E9qu
         C6Hw==
X-Gm-Message-State: AOAM530n0J+xi3GNU5P7PxAOuog1+OHyPWjDRmZMNWLOZRmBK+sKrATn
        5h9dhQmuGC6ETNigrQZCkoE=
X-Google-Smtp-Source: ABdhPJwHvsxF1vvJkDiGpTgqSXjFtQ+p50F4FDOHob5db5lzmW0uNoHuWaSIs7Seja+8JuHVDBb7qw==
X-Received: by 2002:ac2:5333:: with SMTP id f19mr13304920lfh.451.1643585865359;
        Sun, 30 Jan 2022 15:37:45 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:44 -0800 (PST)
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
Subject: [PATCH v6 11/21] powerpc: Use do_kernel_power_off()
Date:   Mon, 31 Jan 2022 02:37:08 +0300
Message-Id: <20220130233718.21544-12-digetx@gmail.com>
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

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 4 +---
 arch/powerpc/xmon/xmon.c           | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f8da937df918..8158e940db81 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -161,9 +161,7 @@ void machine_restart(char *cmd)
 void machine_power_off(void)
 {
 	machine_shutdown();
-	if (pm_power_off)
-		pm_power_off();
-
+	do_kernel_power_off();
 	smp_send_stop();
 	machine_hang();
 }
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index fd72753e8ad5..c916bf250796 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1243,8 +1243,7 @@ static void bootcmds(void)
 	} else if (cmd == 'h') {
 		ppc_md.halt();
 	} else if (cmd == 'p') {
-		if (pm_power_off)
-			pm_power_off();
+		do_kernel_power_off();
 	}
 }
 
-- 
2.34.1

