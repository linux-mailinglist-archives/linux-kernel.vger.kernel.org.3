Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EE471DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhLLVWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:22:18 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40697 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhLLVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:22:14 -0500
Received: by mail-wr1-f53.google.com with SMTP id t9so24021055wrx.7;
        Sun, 12 Dec 2021 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnM2oqI/P3qkpx3c1EWtD4sLNI6B6gG/+oTBL+kWCNQ=;
        b=Ti+UtGG8XV6c0zOWqrHGbE59RojWkw4ydpgjMyPnKydCS+/MWggp7Pc9vXP3/dSIcd
         3jnWTMBd8zv/qBtjyyIl9yIZVhT8x6fyMjQXI7luWmrCTc61AVDnaWwsG+mIfuPQO9dB
         vcqOllWLO88CRGpuT6+xXO8ZmzEOzeGTj/s4L1fT4s6+Ybm6rqbTcVdA4UXyNrivjGv5
         UJ6UviXyCjmc4b8nSyi1dpErcal2pEnmBKVfp4o/3mh7A8Qp+zHAUZCcABQgpQssHyoG
         UiW2FFO7QpKrXAOmKzFmfqtuBRyQuxNiF7hVzSScTIX4m9O5uZ05fsLoNM2XxAyyofSA
         atBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnM2oqI/P3qkpx3c1EWtD4sLNI6B6gG/+oTBL+kWCNQ=;
        b=asJJiaHc5bM7+CB5NpE8eLCw3a4UOw6xsxWUFj1yG5oGQ4u8nQuqZDjxZ0e6Sunh0u
         DjZ6tQVn/fHe8ftX7m8uji5AFIEnd3JtmIoqFKqbOAkbwkpJrNjkrPFi3FNjwsWgMjK4
         EvqWzPfhvT1Uqqg3UblIEUrSZh/xZph2NdL3rRoujC6f2VNw3+hSdCAxovxpv9Q4Ui3A
         AaZivXVRBz5UUsytjITRSyRVYUGoqgSi5wVZ+iQ0z7xejzhilPXRp1bwcncixIF+jzOH
         PRvno/sDrE1T5vL4ykU9CXZTpbyPzH/M9EDPtkCVRalb78IYeUPqdl1EoWjhlhZTe7Dk
         OQPQ==
X-Gm-Message-State: AOAM530gtrAMv8gNA7d64+4EU/4N9tt3Z6vl8xGUSgRbkSuOkwoPfQrk
        N9i/0S63mtnvxjPWEOXMX/AXUjlik78=
X-Google-Smtp-Source: ABdhPJzqEv9dTDNrIB5aKtlnsJyeHcmVeske90TevqdWeeks/wIjllK9zuSKBLKrf6g7j5l1fLZDZQ==
X-Received: by 2002:a05:6512:3c9e:: with SMTP id h30mr24792667lfv.212.1639343056911;
        Sun, 12 Dec 2021 13:04:16 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y4sm1197172ljp.16.2021.12.12.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 13:04:16 -0800 (PST)
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
Subject: [PATCH v5 21/21] reboot: Remove pm_power_off_prepare()
Date:   Mon, 13 Dec 2021 00:03:09 +0300
Message-Id: <20211212210309.9851-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211212210309.9851-1-digetx@gmail.com>
References: <20211212210309.9851-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All pm_power_off_prepare() users were converted to sys-off handler API.
Remove the obsolete callback.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/pm.h |  1 -
 kernel/reboot.c    | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d8209c09686..d9bf1426f81e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -20,7 +20,6 @@
  * Callbacks for platform drivers to implement.
  */
 extern void (*pm_power_off)(void);
-extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3085873a876f..2f79d4f7cfaa 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -48,13 +48,6 @@ int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
-/*
- * If set, this is used for preparing the system to power off.
- */
-
-void (*pm_power_off_prepare)(void);
-EXPORT_SYMBOL_GPL(pm_power_off_prepare);
-
 /**
  *	emergency_restart - reboot the system
  *
@@ -829,10 +822,6 @@ void do_kernel_power_off(void)
 
 static void do_kernel_power_off_prepare(void)
 {
-	/* legacy pm_power_off_prepare() is unchained and has highest priority */
-	if (pm_power_off_prepare)
-		return pm_power_off_prepare();
-
 	blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_PREPARE,
 				     NULL);
 }
-- 
2.33.1

