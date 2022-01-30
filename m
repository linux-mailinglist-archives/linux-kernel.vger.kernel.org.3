Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72A4A3BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357270AbiA3Xkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357008AbiA3XiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:38:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0BC061768;
        Sun, 30 Jan 2022 15:38:05 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a28so23276906lfl.7;
        Sun, 30 Jan 2022 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEaxNtq4BarrclNUiioDBF+6lBsKK3a9toXDktjcMR4=;
        b=HntJ6DyCYL+ke6f/r0is/oFtPZ4gM0JnOcriee/6UCUdnbMrZ6NOZCGasE1GEHraDu
         pCBWJZjwmgcL07nwsUauAU2GlxacbaVxZhonKlPwwFBuAdu9viIQHcwKhf5dcL+qJ3nn
         XhquQFTcfNjpbKfwUnK91j3Ge7sDIsFDFI/0mJTVowVMyA1BhEquZb8cXOuqYsZtg9aC
         IwXRQGqgPsQgyNkeIMf9S+4pn8Wundfp1v2UsKp+neG01ddR2rxW0d3I1LRmyGvULbSe
         5ToOMq/E6pAjk3+OSUQ6ZeKR1+WuSDVpNO845bw8OU98QhOQkdAG7afJAysxD5/92Ee2
         gC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEaxNtq4BarrclNUiioDBF+6lBsKK3a9toXDktjcMR4=;
        b=w1fPv78lWgedNIBanxpYqZC53NvGvi2vz2vyHiIwQk3p6nCZegGVNjIYnhbDTFxU15
         HpP2pxMl9wZcQCf6X99bcGzqC9AXUWWHQhSd1VCubuc8kH43amvs9WHwkYdZSjZZ4uWB
         Uv0sJYhCS6gJrituWKKj8zT0wnXlSUaSdxUSEoY1RjREQjLzjTOdVAFlQRWWJes0ng7l
         NxOOToSpYw2ASMcBnflHo4G29jYQrL7DlVSb68zvwspP93aoEPx0zQsD3wfGeszt5izy
         D+AVYpccTrPQ96vQEQEcZJyaPFwZf24SkDC/VtQo+QGgE5Fkbs1lGEtoYBT1w70rb9zg
         rgCA==
X-Gm-Message-State: AOAM5330N36hGX/Hwmsb7hHX3nhs69r8OqgEdhfUGEZw+vjTeiO4n/ji
        lsHJfD8cZNBLDv1JiQV7gg8=
X-Google-Smtp-Source: ABdhPJy7y3uqXOwOev3QXphmi8L7tLYmjKiDpJEwGe8WqzvjXRaZTuzAa3HaIFQiqtNJq5XkxRnQXQ==
X-Received: by 2002:a05:6512:310:: with SMTP id t16mr13842194lfp.138.1643585883411;
        Sun, 30 Jan 2022 15:38:03 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:38:03 -0800 (PST)
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
Subject: [PATCH v6 21/21] reboot: Remove pm_power_off_prepare()
Date:   Mon, 31 Jan 2022 02:37:18 +0300
Message-Id: <20220130233718.21544-22-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130233718.21544-1-digetx@gmail.com>
References: <20220130233718.21544-1-digetx@gmail.com>
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
index f7d2be686359..62879bfc4b8e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -21,7 +21,6 @@
  * Callbacks for platform drivers to implement.
  */
 extern void (*pm_power_off)(void);
-extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 1ae5ba86b150..6e0d4deda987 100644
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
@@ -828,10 +821,6 @@ void do_kernel_power_off(void)
 
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
2.34.1

