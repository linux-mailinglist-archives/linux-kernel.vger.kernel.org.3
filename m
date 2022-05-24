Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DACD532B72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiEXNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiEXNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:41:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4EF3205C;
        Tue, 24 May 2022 06:41:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id DC3DB1F442E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653399691;
        bh=qpTUo3+rCDoRa3ZgqFQh1I4V9k0JzWGh76jPDBVw0m4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hRMXxgmEZeDfWxnLgiCfIjezbE8Yst9du0UI+7few0qFS4O6SzexhgUtNR81+UMa0
         KYtGAP7WoJvvCbjb1r9vYJeBeLntuikTxHhQ2xX4GkSM65ZWF51SWtZtKkvG2GsFyp
         ee6wNZ4HuinXH/33e8XTqRPnuFRbKCyO2LU4lEig5MXDWQ8Ifwaf0vGosGA3FpGoOu
         ZY9sVSFR31S/Hc7aRsnDGFMQGEBGJznHN/aWQ9jbnVbO6PcOxcFGWQQ7E0fiyfa2yi
         ZaixIuXh19f/Vi/OJQtn0gKlBU/bhD2aoxUDefuGeAsRvNKuYRcUhucApE0L9xde3E
         WNH0ic23yweUA==
Message-ID: <c4914e14-1882-55a1-bcbd-a905852b45a3@collabora.com>
Date:   Tue, 24 May 2022 16:41:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 07/27] kernel/reboot: Add kernel_can_power_off()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
 <20220509233235.995021-8-dmitry.osipenko@collabora.com>
 <CAMuHMdVGjeFe=Z_1Kr9ZaNZ7HUVH1usvubEB31WUQf0fg8E1kA@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMuHMdVGjeFe=Z_1Kr9ZaNZ7HUVH1usvubEB31WUQf0fg8E1kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 16:14, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Tue, May 10, 2022 at 1:33 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> Add kernel_can_power_off() helper that replaces open-coded checks of
>> the global pm_power_off variable. This is a necessary step towards
>> supporting chained power-off handlers.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Thanks for your patch, which is now commit 0e2110d2e910e44c
> ("kernel/reboot: Add kernel_can_power_off()") in pm/linux-next.
> 
> This causes the "poweroff" command (Debian nfsroot) to no longer
> cleanly halt the system on arm32 systems, but fail with a panic
> instead:
> 
> -reboot: System halted
> +reboot: Power down
> +Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> +CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted
> 5.18.0-rc7-shmobile-00007-g0e2110d2e910 #1274
> +Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> + unwind_backtrace from show_stack+0x10/0x14
> + show_stack from dump_stack_lvl+0x40/0x4c
> + dump_stack_lvl from panic+0xf4/0x330
> + panic from do_exit+0x1c8/0x8e4
> + do_exit from __do_sys_reboot+0x174/0x1fc
> + __do_sys_reboot from ret_fast_syscall+0x0/0x54
> +Exception stack(0xf0815fa8 to 0xf0815ff0)
> +5fa0:                   004e6954 00000000 fee1dead 28121969 4321fedc f0d94600
> +5fc0: 004e6954 00000000 00000000 00000058 befa0c78 00000000 befa0c10 004e56f8
> +5fe0: 00000058 befa0b6c b6ec8d45 b6e4a746
> +---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000000 ]---
> 
> On arm64, "poweroff" causes a clean "reboot: Power down" before/after.
> 
> On both arm32 and arm64, the same handlers are registered:
>   - SYS_OFF_MODE_POWER_OFF_PREPARE: legacy_pm_power_off_prepare
>   - SYS_OFF_MODE_POWER_OFF: legacy_pm_power_off
> 
> On both arm32 and arm64, legacy_pm_power_off_prepare() is called.
> On both arm32 and arm64, legacy_pm_power_off() does not seem to
> be called.
> 
> On arm32, both pm_power_off_prepare and pm_power_off are NULL.
> On arm64, pm_power_off_prepare is NULL, and
> pm_power_off is psci_sys_poweroff.
> 
> Do you have a clue?
> Thanks!

Thank you, Geert! I see the problem, the kernel_can_power_off() checks whether power-off handler is registered, but it's always registered because legacy_pm_power_off is registered unconditionally. So it causes trouble for platforms that don't have power-off handler installed at all. All platforms that I tested have a power-off handler, so now wonder that I didn't notice this before.

This change should fix the problem, please give it a try:

--- 8< ---

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 0bdc64ecf4f6..2d55b8bdb444 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -569,22 +569,6 @@ static int legacy_pm_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-/*
- * Register sys-off handlers for legacy PM callbacks. This allows legacy
- * PM callbacks co-exist with the new sys-off API.
- *
- * TODO: Remove legacy handlers once all legacy PM users will be switched
- *       to the sys-off based APIs.
- */
-static int __init legacy_pm_init(void)
-{
-	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
-				 legacy_pm_power_off, NULL);
-
-	return 0;
-}
-core_initcall(legacy_pm_init);
-
 static void do_kernel_power_off_prepare(void)
 {
 	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
@@ -670,6 +654,18 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if (ret)
 		return ret;
 
+	/*
+	 * Register sys-off handler for the legacy PM callback. This allows
+	 * legacy PM callbacks co-exist with the new sys-off API.
+	 *
+	 * TODO: Remove legacy handler once all legacy PM users will be
+	 *       switched to the sys-off based APIs.
+	 */
+	if (pm_power_off)
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+					 SYS_OFF_PRIO_DEFAULT,
+					 legacy_pm_power_off, NULL);
+
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */




-- 
Best regards,
Dmitry
