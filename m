Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DF5398A9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbiEaVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347989AbiEaVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:25:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD149CF26;
        Tue, 31 May 2022 14:25:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 4C9F21F43F0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654032299;
        bh=dWPjJiUcTEsCTwSVeYSxHnF1/ruJ13+dt9/M97DHXpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iw1cl93DawB1wUr9b6KkZdHCFs5+L/GBohLHlROEAOks05zME/v6MXMPk6D7ui5Yi
         RNRHdZFdzCLwhRjjb38P9M6JexB3Wbp2yKOPr5eeU8sVg/8ntyHzURiHlZSY6J8Cm9
         q6oV/gJyO14M2ElVzYwoEuvi7LeAOBJpJO7JVAQIQbIk2iZISrAGCD8WEks6N0mo8W
         PABIM3KRc5wMYvZgEpozGR6zO7yQLUE2dke3U5CmMfjFhmLTkzt3Ddgs0XBxEfDRJn
         c+JlwyAdHThzhqLupTWaB45a5dOVfxT+a6WiHu8uAbSXS41ExvvXWl05U0ZRpjuSZP
         ldNnEXKzwDRFg==
Message-ID: <a41c323a-5d69-0ff1-d0da-38eb55e1e4db@collabora.com>
Date:   Wed, 1 Jun 2022 00:24:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 16/27] m68k: Switch to new sys-off handler API
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
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
 <20220509233235.995021-17-dmitry.osipenko@collabora.com>
 <CAMuHMdUFqf58F31EAGnhp_cu9k-G4Sx1cmwx-PGb3mU+6bjRnQ@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMuHMdUFqf58F31EAGnhp_cu9k-G4Sx1cmwx-PGb3mU+6bjRnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 22:04, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Tue, May 10, 2022 at 1:34 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>> Kernel now supports chained power-off handlers. Use
>> register_power_off_handler() that registers power-off handlers and
>> do_kernel_power_off() that invokes chained power-off handlers. Legacy
>> pm_power_off() will be removed once all drivers will be converted to
>> the new sys-off API.
>>
>> Normally arch code should adopt only the do_kernel_power_off() at first,
>> but m68k is a special case because it uses pm_power_off() "inside out",
>> i.e. pm_power_off() invokes machine_power_off() [in fact it does nothing],
>> while it's machine_power_off() that should invoke the pm_power_off(), and
>> thus, we can't convert platforms to the new API separately. There are only
>> two platforms changed here, so it's not a big deal.
>>
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Thanks for your patch, which is now commit f0f7e5265b3b37b0
> ("m68k: Switch to new sys-off handler API") upstream.
> 
>> --- a/arch/m68k/emu/natfeat.c
>> +++ b/arch/m68k/emu/natfeat.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/string.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/reboot.h>
>>  #include <linux/io.h>
>>  #include <asm/machdep.h>
>>  #include <asm/natfeat.h>
>> @@ -90,5 +91,5 @@ void __init nf_init(void)
>>         pr_info("NatFeats found (%s, %lu.%lu)\n", buf, version >> 16,
>>                 version & 0xffff);
>>
>> -       mach_power_off = nf_poweroff;
>> +       register_platform_power_off(nf_poweroff);
> 
> Unfortunately nothing is registered, as this is called very early
> (from setup_arch(), before the memory allocator is available.
> Hence register_sys_off_handler() fails with -ENOMEM, and poweroff
> stops working.
> 
> Possible solutions:
>   - As at most one handler can be registered,
>     register_platform_power_off() could use a static struct sys_off_handler
>     instance,
>   - Keep mach_power_off, and call register_platform_power_off() later.
> 
> Anything else?
> Thanks!
> 
>> --- a/arch/m68k/mac/config.c
>> +++ b/arch/m68k/mac/config.c
>> @@ -12,6 +12,7 @@
>>
>>  #include <linux/errno.h>
>>  #include <linux/module.h>
>> +#include <linux/reboot.h>
>>  #include <linux/types.h>
>>  #include <linux/mm.h>
>>  #include <linux/tty.h>
>> @@ -140,7 +141,6 @@ void __init config_mac(void)
>>         mach_hwclk = mac_hwclk;
>>         mach_reset = mac_reset;
>>         mach_halt = mac_poweroff;
>> -       mach_power_off = mac_poweroff;
>>  #if IS_ENABLED(CONFIG_INPUT_M68K_BEEP)
>>         mach_beep = mac_mksound;
>>  #endif
>> @@ -160,6 +160,8 @@ void __init config_mac(void)
>>
>>         if (macintosh_config->ident == MAC_MODEL_IICI)
>>                 mach_l2_flush = via_l2_flush;
>> +
>> +       register_platform_power_off(mac_poweroff);
>>  }
> 
> This must have the same problem.

The static variant should be better, IMO. I'm not sure whether other platforms won't face the same problem once they will start using register_platform_power_off(). I'll send the fix, thank you for the testing!

--- >8 ---

diff --git a/kernel/reboot.c b/kernel/reboot.c
index a091145ee710..4fea05d387dc 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -315,6 +315,37 @@ static int sys_off_notify(struct notifier_block *nb,
 	return handler->sys_off_cb(&data);
 }
 
+static struct sys_off_handler platform_sys_off_handler;
+
+static struct sys_off_handler *alloc_sys_off_handler(int priority)
+{
+	struct sys_off_handler *handler;
+
+	/*
+	 * Platforms like m68k can't allocate sys_off handler dynamically
+	 * at the early boot time.
+	 */
+	if (priority == SYS_OFF_PRIO_PLATFORM) {
+		handler = &platform_sys_off_handler;
+		if (handler->cb_data)
+			return ERR_PTR(-EBUSY);
+	} else {
+		handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+		if (!handler)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return handler;
+}
+
+static void free_sys_off_handler(struct sys_off_handler *handler)
+{
+	if (handler == &platform_sys_off_handler)
+		memset(handler, 0, sizeof(*handler));
+	else
+		kfree(handler);
+}
+
 /**
  *	register_sys_off_handler - Register sys-off handler
  *	@mode: Sys-off mode
@@ -345,9 +376,9 @@ register_sys_off_handler(enum sys_off_mode mode,
 	struct sys_off_handler *handler;
 	int err;
 
-	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
-	if (!handler)
-		return ERR_PTR(-ENOMEM);
+	handler = alloc_sys_off_handler(priority);
+	if (IS_ERR(handler))
+		return handler;
 
 	switch (mode) {
 	case SYS_OFF_MODE_POWER_OFF_PREPARE:
@@ -364,7 +395,7 @@ register_sys_off_handler(enum sys_off_mode mode,
 		break;
 
 	default:
-		kfree(handler);
+		free_sys_off_handler(handler);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -391,7 +422,7 @@ register_sys_off_handler(enum sys_off_mode mode,
 	}
 
 	if (err) {
-		kfree(handler);
+		free_sys_off_handler(handler);
 		return ERR_PTR(err);
 	}
 
@@ -422,7 +453,7 @@ void unregister_sys_off_handler(struct sys_off_handler *handler)
 	/* sanity check, shall never happen */
 	WARN_ON(err);
 
-	kfree(handler);
+	free_sys_off_handler(handler);
 }
 EXPORT_SYMBOL_GPL(unregister_sys_off_handler);
 
