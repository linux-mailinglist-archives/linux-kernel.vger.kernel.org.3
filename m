Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C123A471DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhLLVVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:21:51 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46688 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhLLVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:21:30 -0500
Received: by mail-ed1-f48.google.com with SMTP id y13so45752446edd.13;
        Sun, 12 Dec 2021 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKgqav8a8uS+JOYHQI8KBeK4UU43xCMXoqbNcSGFyUw=;
        b=KUwqX4BEtYi0Tl6FHY2CY8/c97CDNjqMcby3q7qakxzQRe7fXsisnIY/MWhKC0c/of
         zGMKDdImy6NTe9G0A7mThOpcw6K/S+1AR3eVT8uprZ/XHyIT4qyf2Wds12KFazsicm2w
         bCeOnXKrjzFNqWMPd1F+4GYHIWkBe3KzeOKUJ7KCKaBggqii376yhMOZjBlnlQ+uIszq
         o5w0MaH69JTpDhOPa5VxphJ3hllwl22I2McYWQ9jDuw0qGIyBUeZs+8S9NMFTWPSbYZ6
         7nWpNaZC68XoQbuOZZurBgla3U0x2zQDP37QsCnspr/jFi2Zol4uIo+V9XhzwJK0tYnt
         /a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKgqav8a8uS+JOYHQI8KBeK4UU43xCMXoqbNcSGFyUw=;
        b=POfytYgrZ1RqLErxPIQGX7JPIfIyu9zEQP/M9PiF3KHBzUpgLRK5lR7n1ZPoB44e4u
         n8XJKzj3p+797zGMBamMpgK26XbtXsidV8wJN/kf/vHtI6TQevQvoxhZdw/2l8+esz4T
         MGa9tWm+0Yccw59NPeBTcKktLkQSZDy91IkizC6twRre79xqu/oozxTrRLo3507bcR+t
         brU74hm/yx03B5bZYdWrPE/GHJGADTnrjQERnB7ckTHeuw99zd1Sn1HiypkCnqR1TLU4
         Ew/ehM+R2z8w5kIYH7SXoDXzQF32Ka66y9LfRgpf6gcXcpgFB/lar+5H5etn1RPDN+hR
         fOXQ==
X-Gm-Message-State: AOAM533pFy+EOJpLCrYq9aAd50rYQTgJfzrQgS5nTqzV7wUZ00B5kE9x
        l+DTb8wrG3O2i/DHam8ERC3A/5+LvJg=
X-Google-Smtp-Source: ABdhPJx8zOHfYkUzyKpEFmy9Fj+BAxzXOZqHBn3tHFlW4guWn1rgQHHNzqejujAnyj7ZOsRsx/6BSA==
X-Received: by 2002:a2e:920a:: with SMTP id k10mr25768511ljg.234.1639343028659;
        Sun, 12 Dec 2021 13:03:48 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y4sm1197172ljp.16.2021.12.12.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 13:03:48 -0800 (PST)
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
Subject: [PATCH v5 07/21] riscv: Use do_kernel_power_off()
Date:   Mon, 13 Dec 2021 00:02:55 +0300
Message-Id: <20211212210309.9851-8-digetx@gmail.com>
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

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/riscv/kernel/reset.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index 9c842c41684a..912288572226 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -23,16 +23,12 @@ void machine_restart(char *cmd)
 
 void machine_halt(void)
 {
-	if (pm_power_off != NULL)
-		pm_power_off();
-	else
-		default_power_off();
+	do_kernel_power_off();
+	default_power_off();
 }
 
 void machine_power_off(void)
 {
-	if (pm_power_off != NULL)
-		pm_power_off();
-	else
-		default_power_off();
+	do_kernel_power_off();
+	default_power_off();
 }
-- 
2.33.1

