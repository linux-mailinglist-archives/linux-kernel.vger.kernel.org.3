Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498614A3B30
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357143AbiA3Xhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356968AbiA3Xhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:33 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652FDC06173B;
        Sun, 30 Jan 2022 15:37:32 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c15so17066054ljf.11;
        Sun, 30 Jan 2022 15:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omD9ii6hdmOPOLz0ZrMYTS/dF5Fa75SnRoAvSUBcMXk=;
        b=cQofKfpuj96FPKIuElG4JVB5ebsyCGvTeW5J4j2MH7X0WRLgzbVACf4DTute0QixNl
         XMz7+003bKZlwkXkPIQbN8oTinvwUmojDoYGjYhv7pjY2trTgrMx6mGzRdNnLsY8mkl2
         7WmE4naskN1xx+dSFpiWKWqfRvBmvOtiRbW6rsCNAcLJPNEVLDCe91z6iUu5+BFugaT2
         bIk9Hfq63C50xsIBoY2u595h9M/qG+2YlE2Nn78b7kg2gyK8fxA4P0H2C4WFKliLAVXZ
         7qPk0tNjqYTPF3ucU8/++kKEXP9ZHsFeIbMKK+4hihzAWu5kciFNMvK+pAj6fKNfAPQ5
         xmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omD9ii6hdmOPOLz0ZrMYTS/dF5Fa75SnRoAvSUBcMXk=;
        b=MYs5UiMmyA1To9moc+iya2wu9ltHXiUn3LiMynnlTYgG2GWAkdN4eyb89s+qBFQWLu
         fe0FIwSYiUp8zJEMkIhgds050HEfMbRNjAgFT1BqpDPYMXyunuUAaE0PDMz+MiY3PoW2
         9Ma++MTwrSUqrc3cKaqfSF1nqEEAg4nqnW1D8yZZb10TIMPdDS4vlUcoGONasjzGGanf
         WCi7xULN885RjfZi8UyOxxAfBAHBjWmkVJ2ExaRvCa2dGxF2fUa6vUdgtkQr0QHjlOxv
         SPqAT06Teu1KIMKgwNKFlZzNAzkry0ofsXyQ0X/7e+Xjc1ViX7Hy2Dr3QMzOpzCgGR8d
         hzpw==
X-Gm-Message-State: AOAM531CQimf2pKY+vVk3oA1xLHyqj9tXiFXTdrRuz59kiOClHdgzslp
        JrvbUyei2fL+9DwmPN+HeHY=
X-Google-Smtp-Source: ABdhPJzH4GGHER1dd7BkRpS9JCpguXkNuEOfM70GPh5pyei2pr3VhMNQQj2zlKMHcg7OCQ6lFFEolA==
X-Received: by 2002:a2e:7a06:: with SMTP id v6mr12281006ljc.301.1643585850758;
        Sun, 30 Jan 2022 15:37:30 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:30 -0800 (PST)
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
Subject: [PATCH v6 03/21] reboot: Print error message if restart handler has duplicated priority
Date:   Mon, 31 Jan 2022 02:37:00 +0300
Message-Id: <20220130233718.21544-4-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130233718.21544-1-digetx@gmail.com>
References: <20220130233718.21544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sanity check which ensures that there are no two restart handlers
registered using the same priority. This requirement will become mandatory
once all drivers will be converted to the new API and such errors will be
fixed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 kernel/reboot.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6bcc5d6a6572..35f0cde641c1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -182,6 +182,21 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  */
 int register_restart_handler(struct notifier_block *nb)
 {
+	int ret;
+
+	ret = atomic_notifier_chain_register_unique_prio(&restart_handler_list, nb);
+	if (ret != -EBUSY)
+		return ret;
+
+	/*
+	 * Handler must have unique priority. Otherwise call order is
+	 * determined by registration order, which is unreliable.
+	 *
+	 * This requirement will become mandatory once all drivers
+	 * will be converted to use new sys-off API.
+	 */
+	pr_err("failed to register restart handler using unique priority\n");
+
 	return atomic_notifier_chain_register(&restart_handler_list, nb);
 }
 EXPORT_SYMBOL(register_restart_handler);
-- 
2.34.1

