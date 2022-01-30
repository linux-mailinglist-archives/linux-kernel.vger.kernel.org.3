Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896274A3BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357551AbiA3Xik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357247AbiA3Xhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE5C06173B;
        Sun, 30 Jan 2022 15:37:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u6so23257473lfm.10;
        Sun, 30 Jan 2022 15:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHFCRJN9BVY8RauX1oKR/zvQzYk8hOXc8BKode7q7dE=;
        b=YRe+4ENn+xLHydu0qjVK8NSLNEa98MBt5tDc08FixS3wAMtLqAIaFtklni0+X5AStQ
         NWa/KRzoUn8+IVpsHAm/xOs3k+cj+LL2OhKl5gVUEFkp5ndqFg9Q7IDP7ikRXZxwNK+4
         SbLkN6wlP8yDXzq0kfXqbvVsy1Hp18D+sINvf4RsWjU2CJLvpbxk+Pf4y4Di+ROI2ccO
         YZHUhr0Z8uHoIysiX6fudWOQ4mPt5OAElluDMzBTS4VC1jyp+W5tjIzGJQ2uBLL5DStr
         tO2S0szt+wkyquwgkXuRB6clwJUeXCGMkJhIWs2QZ///pnQ6oMEGbscGlCpylcxuYJ5J
         9wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHFCRJN9BVY8RauX1oKR/zvQzYk8hOXc8BKode7q7dE=;
        b=pTerlkKDEcgElBn3Z5MDo7ylqGVeNzRgavrsAFq9y1TcPRbffNcCc/Uql128YH1m2e
         +aOuTFJ1yKaHxxLsuFmdTq4G+2+j2qwtkt7Nl7OWqpel0r7uyv/dmSaCmqGvFbQlTav3
         sDuLtDMOE+kLOYohU0rKQZIf+hfQTtn2V+kjvmxpbvKx65xUrIMdnexC1EZb8kHKez8d
         ChDp3PYFFvZanpKPyp8y4bg6PlNauA1nXlR8fyPap/qIpWNYCbvKCELEFOdpIGDwdcYk
         m1QNVUCz3asAEUnLFvljG4yeAQttGNztXH3m5a9m8hsHoLkdoB0mdp9wrpBOfYVcAV4+
         O/5A==
X-Gm-Message-State: AOAM530PjOaK5tpaazRN4UTH4mCvcnJFpFnHZRM/+2cUZfKOg/336fbL
        I4qLrj5Y0ehcTc0esmdcRy4=
X-Google-Smtp-Source: ABdhPJykkAmU8QPmCYCQWolQuhTlQmgl/dllVJKfSuOOVtywU8GyeEW3uMb4RjUXLkfRs/7Y/PbgFw==
X-Received: by 2002:a19:6a12:: with SMTP id u18mr13556400lfu.348.1643585870718;
        Sun, 30 Jan 2022 15:37:50 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:50 -0800 (PST)
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
Subject: [PATCH v6 14/21] x86: Use do_kernel_power_off()
Date:   Mon, 31 Jan 2022 02:37:11 +0300
Message-Id: <20220130233718.21544-15-digetx@gmail.com>
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
 arch/x86/kernel/reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index fa700b46588e..c3636ea4aa71 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -739,10 +739,10 @@ static void native_machine_halt(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off) {
+	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
-		pm_power_off();
+		do_kernel_power_off();
 	}
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
-- 
2.34.1

