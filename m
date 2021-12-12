Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F641471E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhLLVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:24:57 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46058 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhLLVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:22:53 -0500
Received: by mail-ed1-f47.google.com with SMTP id y12so45411683eda.12;
        Sun, 12 Dec 2021 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRRUcggihxuvvuxXR8avhK/eModbACqCMIG7s3bijm0=;
        b=cwgMkLRmIC5Jc7bTumRtZfdR/utOuYZMGz1d8ygkTHHtVzgzo42XHF3MxCIlHJHEyT
         C7LdLWylZ0pNaMDQhDT13J5l+njgSg9TNbzeMmfiPFReiWjuLN3BPKhAAriju1eHl9cw
         v0xZYrbokM5iV9yDxCHW4tROVpkV6lIWT7CatJGFsO5P7KMEX+3KZoYfdE3quHDnbdkY
         jpj2wUw+3g4R/1VtteNb23NQNkNZ2V1/PAhs7heDgq209kuV3pPkDwgZ1aWLoWFqzEEX
         OFHc08yxalGQachdnm1D3b45tSRQQlH3u/KkV4GShGX8mzd5qIB7iZpCyJ01mJBdqNcV
         pVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRRUcggihxuvvuxXR8avhK/eModbACqCMIG7s3bijm0=;
        b=MnM5fd9o5CYQ7BgAkgoEob/ZkqXMTehB/iN9E4jzKVKC4pmvXQ3I7KqQwe+5RAVT5B
         boGbYDZ54VArfZ3fK3p30isfmEZ84BSSCfgU/n1aL47XIKRAJWzavdpoD52Q/JQF5Kle
         TzewIzakG6lt65F3lpBIc2YtCsnZRDkxNE2c/K+AWHaYNA1PcnUbfsrfavoir3O3wUo7
         ZHtXCyKGH8vKomoabAxMAWgw+/ipbT5GTAK4XkNLmaFj8VbPvdm64NT7GnIYuOBbJhFU
         TXqVvPeqZxynFaXeFDr96ArMWkPnTdY+IKsiO+GuZL30tn4rhsZ3qY+R9+QOKkOeIZi9
         cE7A==
X-Gm-Message-State: AOAM531vhPoRow8DDQImpWnR1q53cp8Ji7RrSp0xplrENTuQjJXTZjgu
        pNxDJTzG/DFonuUfR21dJAlIMMRXgCs=
X-Google-Smtp-Source: ABdhPJwkugCxrPdxtc+DUdPqlE8VTgsZlj2PXoqJkSrC88l4/tv/AsdhkMaJuxd6V34n0G6eKbJ/hw==
X-Received: by 2002:a05:651c:1790:: with SMTP id bn16mr25960176ljb.475.1639343032645;
        Sun, 12 Dec 2021 13:03:52 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y4sm1197172ljp.16.2021.12.12.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 13:03:52 -0800 (PST)
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
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 09/21] parisc: Use do_kernel_power_off()
Date:   Mon, 13 Dec 2021 00:02:57 +0300
Message-Id: <20211212210309.9851-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211212210309.9851-1-digetx@gmail.com>
References: <20211212210309.9851-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel now supports chained power-off handlers. Use do_kernel_power_off()
that invokes chained power-off handlers. It also invokes legacy
pm_power_off() for now, which will be removed once all drivers will
be converted to the new power-off API.

Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/parisc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..928201b1f58f 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/ptrace.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task.h>
@@ -114,8 +115,7 @@ void machine_power_off(void)
 	pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
 
 	/* ipmi_poweroff may have been installed. */
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 		
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
-- 
2.33.1

