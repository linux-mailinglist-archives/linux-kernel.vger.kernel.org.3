Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24584A3B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357322AbiA3Xh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357023AbiA3Xhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7315C06173D;
        Sun, 30 Jan 2022 15:37:39 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bx31so5419009ljb.0;
        Sun, 30 Jan 2022 15:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVg2kfJsVdscnSQmsGQYEfiSB/7tSvJBE6eAcPu7Sek=;
        b=c4Z1zQFdWlsKxw9UxAzj2ZQzBVH0IlXZ5Q9hlT/o2eauoc+12KgHtyZnfnu9QRCul7
         XIq2yfEDvsyi714qK62uqrcXiKbZ83JQlipU755myvbplyaKCzIx8SoEbYZQx1g2QPK1
         ZiW0YJxW7z6xKBh2ESJStcRTergJa9YSSKnZXGs2GFxaXBnqnCcNoIMPWorMJ7h8whhy
         F2xnNh9XSw25BmP4Yp0yjpYr8c279tQye0/GiTHl+WGgBlBd/yKdunLMFcBd5VjP++Bl
         z5q6iip6mJ3MI/RtrvT6/DwKfRUy9WgbSLddepD6tmbzL6Xf24XNQo71hEy43Zt7gMYI
         LH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVg2kfJsVdscnSQmsGQYEfiSB/7tSvJBE6eAcPu7Sek=;
        b=6ThZdcJSqnLPGrg9Q7caxkty6iYvzD/Bpx38KWdAj/AbGbxfNROWPhCF5LyTYOWU44
         zocWv42wfkxq+PqtFXK8Z0NlIeDhjsemSh+/hyrZPp9YtIu8T+QzsOVvAAQOZo1D9k+G
         MUL8gjdiZDjs0+7Yhnw0H+6OMpsxKYk2NffoOp0fkiSRS6FPKFHMWWBwimgWMAf+ssxs
         joUnaV9RM6sSQ0GR5baudrYbx62Y3Tjv2Uu5uzFQdmCt48ko9H0FKvOqi9kDVN8rDmUb
         Esfx4hoW80VyBD39rDcCcL+rJs123lu0235vplVXlvusU56S47AwRMxNy+rA/7jwKdZe
         6YiA==
X-Gm-Message-State: AOAM533+pz1tuA4ha8TukLFMeAnsWKNz1+kOp7FSDYpU2xRfubyerTRy
        KC8Irs9ziF26oH/+ADx8ItA=
X-Google-Smtp-Source: ABdhPJw0o4UVP5/vUUv/1Chd11yJ2CJCMOQv44y6t1B7x180Ayz+XFBoJsJgXLguCKSrO7B2enZNZA==
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr12381352ljg.340.1643585858043;
        Sun, 30 Jan 2022 15:37:38 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:37 -0800 (PST)
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
Subject: [PATCH v6 07/21] riscv: Use do_kernel_power_off()
Date:   Mon, 31 Jan 2022 02:37:04 +0300
Message-Id: <20220130233718.21544-8-digetx@gmail.com>
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
2.34.1

