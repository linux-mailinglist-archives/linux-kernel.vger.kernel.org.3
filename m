Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5804A3BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbiA3Xjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357320AbiA3Xh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F9C06174A;
        Sun, 30 Jan 2022 15:37:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z4so23317102lft.3;
        Sun, 30 Jan 2022 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69wNajrm4+G/M74hrnrqfe/8gDIP1KRo4GBjc3qiBlE=;
        b=eADmGdhywqGHgBNSOTg6DDqxchm8B8ixUxTFBRIurSpOjI9zmNGmnnTl7ImQhqB8Ei
         0mWnD7TAo0wSYeOZ937uVVcmUSkjlnYWZ7M+/JM6Dh7lyKqqc2++u6LI+atIfPTN5ays
         s+ktDvb2sLXt8MKBHLK9lwAFupFTVgxMIzESdB4QojqTGIkGjlXlLAoIu5tRpwgO0yvf
         ryjVbvaJTv11mzbS9UuOXGg5YPShB0ncAu5hIuMku9PpTrfxOLc753LOzzY0nXEsJ4s1
         aTORw1Zo0yFFM9ZCzLTV1LBU1iplcGdbnitByV0PuagiZ7HTypKyLYaRcYB4LG2Z4YgC
         xHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69wNajrm4+G/M74hrnrqfe/8gDIP1KRo4GBjc3qiBlE=;
        b=TnZXdwpJY4IgPsAIv1kvWbFtLbeOzOp1PYbrlz483HztIGkd5fZANF765Tp7nydKIF
         dkWT/5gMBuPfs3Ufcvyxqdd1A2hmonf/EU0+wXiv6TEj2464XiiOeaSl7bgLoaQOUaFN
         8BysbYTaHQ+c3vkqN8LdQkbDiRw/u2b7CcTBWvrZeOID/FGTDIOfebctFDK9jevNYHpT
         4gLXQMr2yXmaaMZkGBPrQIX2nEC9Bb3Tv0UAch/OQPXEwTbtCBgTE4omqANvZ3vwmZ/d
         K0cYtgWtEEV5Xqj9NP54rSRmggWyCD/IBsVt4ty3JmFh5TvArDH8E2RwkRJutnxCtd4H
         rjGQ==
X-Gm-Message-State: AOAM530DVKFLqncXe4UKhgLk2jA7FHcSfV9mKi9rQtCjYAqpec3Ewhn5
        hZ/fKELL1BoKWSl5XUO0+S0=
X-Google-Smtp-Source: ABdhPJwNSyf/5qJrwp6Ej2liXxYcZa6QcRMNedNFLOrkN6ogQ1iJOFH/fhB+J9LuMCwJeeOYVcQcPA==
X-Received: by 2002:a19:f806:: with SMTP id a6mr13933723lff.592.1643585876243;
        Sun, 30 Jan 2022 15:37:56 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:55 -0800 (PST)
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
Subject: [PATCH v6 17/21] nds32: Use do_kernel_power_off()
Date:   Mon, 31 Jan 2022 02:37:14 +0300
Message-Id: <20220130233718.21544-18-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/nds32/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..0936dcd7db1b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -54,8 +54,7 @@ EXPORT_SYMBOL(machine_halt);
 
 void machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 }
 
 EXPORT_SYMBOL(machine_power_off);
-- 
2.34.1

