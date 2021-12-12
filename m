Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF81A471D57
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhLLVU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 16:20:28 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41818 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhLLVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 16:20:25 -0500
Received: by mail-wr1-f54.google.com with SMTP id a9so23987207wrr.8;
        Sun, 12 Dec 2021 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfpn4GjmPLTNTnhqDUdqufcuPWBAqiXi1zu9JyEbhbk=;
        b=W//sZogq5DTrQ+VT0kVHAjKsMJjonmiTqPPUjDT4t1ux8CgKvrkOa9X6q03Nt3iZO1
         vK/CUo6x7lvuguglmwFE90u1GLXTECmpRMuaG+fr/E6/qyGV8EkU6v+kDK+V7uptl/wb
         HR4Vmw8wUQIABJOLJFGHdK+fNltSfOyFeExxxDa+sfUUZdkfFyFDhmbRR41HvO1R/q2F
         QgB34LqslNlnmvIz0QFHIdfbw4raMLU07LE3ousDHeswLZ4GtLDTJS47wVIBYkWvvQPk
         nOdfyMtdzf0521x2E8c6ZMEWXW3EHh5oerHQGQm9FvsWNypd0dn/oX5dpjU5q537TqNc
         uvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfpn4GjmPLTNTnhqDUdqufcuPWBAqiXi1zu9JyEbhbk=;
        b=tktS6s+0H9eamPVVfvZ58bmNaeGLALuYH7osNy1HHYMoO438LaX8RwFIxw18chxDH/
         K2q9XuIeyt1d6ovYUCMNIXAsyR2ee8n4xZScXYOTNSsLcisgnrFPgSWJH52PNCui/UjW
         KoIMuzaf9CgI7TBR6aVFPfCAriMyYPhmXcqQWcPB4JmeHykJJgz9pSctmTr/hDvMm9ni
         zxIIRwdySDKwt0FLKIZM7zbOFcX4VcFEsZK68hEmQSio703AQP5aoO0NVU3SdnnrCcVe
         Xz40rbs+6PSmIhm5XtRap1AcbckeKE1zFy24tVOM5VMHAon/u3OP10j7A7zF4GOL2+In
         87Bg==
X-Gm-Message-State: AOAM533opI8988FfcZzhyZNNhfIHyBFwTc5RcfElaCL81exFFSjzSeyy
        gH+WmyJ31JZftF66LHh20A4Xgdjxpv0=
X-Google-Smtp-Source: ABdhPJwCwIZWVbs7nRVgDCTh6EM5kFQafVa6fCQVhsWFKnxKFFWHHHKvo3sGM1T0VAQ3LX+X9OwfMQ==
X-Received: by 2002:ac2:4555:: with SMTP id j21mr25986961lfm.120.1639343052782;
        Sun, 12 Dec 2021 13:04:12 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y4sm1197172ljp.16.2021.12.12.13.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 13:04:12 -0800 (PST)
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
Subject: [PATCH v5 19/21] ACPI: power: Switch to sys-off handler API
Date:   Mon, 13 Dec 2021 00:03:07 +0300
Message-Id: <20211212210309.9851-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211212210309.9851-1-digetx@gmail.com>
References: <20211212210309.9851-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to sys-off API that replaces legacy pm_power_off callbacks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/acpi/sleep.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eaa47753b758..2e613fddd614 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -47,19 +47,11 @@ static void acpi_sleep_tts_switch(u32 acpi_state)
 	}
 }
 
-static int tts_notify_reboot(struct notifier_block *this,
-			unsigned long code, void *x)
+static void tts_reboot_prepare(struct reboot_prep_data *data)
 {
 	acpi_sleep_tts_switch(ACPI_STATE_S5);
-	return NOTIFY_DONE;
 }
 
-static struct notifier_block tts_notifier = {
-	.notifier_call	= tts_notify_reboot,
-	.next		= NULL,
-	.priority	= 0,
-};
-
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -1020,7 +1012,7 @@ static void acpi_sleep_hibernate_setup(void)
 static inline void acpi_sleep_hibernate_setup(void) {}
 #endif /* !CONFIG_HIBERNATION */
 
-static void acpi_power_off_prepare(void)
+static void acpi_power_off_prepare(struct power_off_prep_data *data)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
@@ -1028,7 +1020,7 @@ static void acpi_power_off_prepare(void)
 	acpi_os_wait_events_complete();
 }
 
-static void acpi_power_off(void)
+static void acpi_power_off(struct power_off_data *data)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	pr_debug("%s called\n", __func__);
@@ -1036,6 +1028,11 @@ static void acpi_power_off(void)
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
+static struct sys_off_handler acpi_sys_off_handler = {
+	.power_off_priority = POWEROFF_PRIO_FIRMWARE,
+	.reboot_prepare_cb = tts_reboot_prepare,
+};
+
 int __init acpi_sleep_init(void)
 {
 	char supported[ACPI_S_STATE_COUNT * 3 + 1];
@@ -1052,8 +1049,8 @@ int __init acpi_sleep_init(void)
 
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
-		pm_power_off_prepare = acpi_power_off_prepare;
-		pm_power_off = acpi_power_off;
+		acpi_sys_off_handler.power_off_cb = acpi_power_off;
+		acpi_sys_off_handler.power_off_prepare_cb = acpi_power_off_prepare;
 	} else {
 		acpi_no_s5 = true;
 	}
@@ -1069,6 +1066,6 @@ int __init acpi_sleep_init(void)
 	 * Register the tts_notifier to reboot notifier list so that the _TTS
 	 * object can also be evaluated when the system enters S5.
 	 */
-	register_reboot_notifier(&tts_notifier);
+	register_sys_off_handler(&acpi_sys_off_handler);
 	return 0;
 }
-- 
2.33.1

