Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4866C471DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhLLVWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:22:01 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45920 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhLLVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:21:57 -0500
Received: by mail-ed1-f51.google.com with SMTP id y12so45407528eda.12;
        Sun, 12 Dec 2021 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=032w538UVpeATjNmIAIpxMVbSRQ+KkFSikcjH52Go7E=;
        b=E9VJGzDO/MjlF9k/luR3Khbhy1NPRGJFu45WGR11yv2Csut15VlFqb3GxfyXiC5K1R
         KoOjuPxJ74P0WBK6P5Rh4Yk8N3YLtFpHfuaNjG/nuh/tfSGU3NqTk9edZfzSNHKBOR8m
         kPzSD7yXn2hiHnOuT2WH4wXsn02tbX247vyP+WAbNdjC41aD7suYMkTSBhHb57suBLzg
         JDCdqG/x0ozFIiafXt1VhOC6hig+lrppFxitm7BNJIhU1ULZzUrjdQMODUqHIbHIv5lc
         HP4HR2RELBXIYyMaOYQnB3LyrgNZPo6J89xd7q/RgqqbviF8jrhJU82mQviA1Jb3TY/T
         AUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=032w538UVpeATjNmIAIpxMVbSRQ+KkFSikcjH52Go7E=;
        b=37U+YBs1RId0OJNLe51/fIBP+s/PuvPg+DUI075slFsrkcgjXhFUWlvZTfs60JtjuD
         wnWeZCevhY7fGN3v88Neb8dIS2L0gpMrv4GnsiPn9yeggwjdSPLgXw27TA2Tgxxo/Nce
         UNMGNWnrJopw61hVd7Is0QiyIvcIWUI5vwhdUicF9zORMT+lupJIyPiI16udGGoXQMTn
         EYu+nIS8+vApMXtmhhsNneyYpjPu/chYfbqblO6PTJo/UypHKV+R4LoAev+DW6CkwGQf
         83Z0vF9kU594BJ8hBJ7IYlV5Omk8El5VesW3CiI3+QyJGaBGkFaoVb/Nz/vIrMw1wmRK
         0ZpQ==
X-Gm-Message-State: AOAM533XVEJpaJDCgcZAuZzDRSr59Zyw0pv1ZNIos91N+VEJpZn070zO
        1MuoUgsQOFu2+RyI6UkqF/T3vEzKUSQ=
X-Google-Smtp-Source: ABdhPJxUkKeqtg/YDWyN+6uH7IPe04t5eV8J/9ZVzn0URaLN05uRJEwSyylEX1JQ9jfzKVs+jpVePw==
X-Received: by 2002:a19:5e59:: with SMTP id z25mr25760424lfi.686.1639343040878;
        Sun, 12 Dec 2021 13:04:00 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y4sm1197172ljp.16.2021.12.12.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 13:04:00 -0800 (PST)
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
Subject: [PATCH v5 13/21] sh: Use do_kernel_power_off()
Date:   Mon, 13 Dec 2021 00:03:01 +0300
Message-Id: <20211212210309.9851-14-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/sh/kernel/reboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 5c33f036418b..e8eeedc9b182 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -46,8 +46,7 @@ static void native_machine_shutdown(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 }
 
 static void native_machine_halt(void)
-- 
2.33.1

