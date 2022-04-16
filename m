Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF25045BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiDPW5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiDPW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:57:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36056140F1;
        Sat, 16 Apr 2022 15:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFF65B809E3;
        Sat, 16 Apr 2022 22:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED602C385A1;
        Sat, 16 Apr 2022 22:54:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ke3CzabD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650149696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2nP+VdPEpPNPoKQqSrgbL4ZK7I/c4P/cLhbUMeqeEs=;
        b=Ke3CzabDCTCN7z1X+blAnwmP5mSkY04Aqwf/G5fDtQU6WM6tPriviP3rwnh0y2BbiEiSI5
        kxvqYG3bXaLOy2oV1jIUlAv1SxvW/krAz60U3oZjY/ozmULtrXkPvuBaIxrnDhhjiRe7WK
        DiZ/+FwTFNQXboYw4FOs1PNDoMoDXRw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cef1d983 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 16 Apr 2022 22:54:56 +0000 (UTC)
Date:   Sun, 17 Apr 2022 00:54:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YltJOfEylRC0rhKv@zx2c4.com>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de>
 <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
 <YlfoeGRM6w2O+eXA@zx2c4.com>
 <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
 <CAHmME9qzkZqkGntLn--XfMKzyR=tYiCaZu1uFpoQBzAzCipZ-A@mail.gmail.com>
 <alpine.DEB.2.21.2204161533420.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2204161533420.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Sat, Apr 16, 2022 at 03:44:53PM +0100, Maciej W. Rozycki wrote:
> > Okay, I can give this a shot, but this certainly isn't my forté. It
> > may ultimately wind up being simpler for you to just send some code of
> > what you envision for this, but if I understand your idea correctly,
> > what you're saying is something like:
> > 
> > static inline unsigned long random_get_entropy(void)
> > {
> >         unsigned int prid = read_c0_prid();
> >         unsigned int imp = prid & PRID_IMP_MASK;
> >         unsigned int c0_random;
> > 
> >         if (can_use_mips_counter(prid))
> >                 return read_c0_count();
> > 
> >         if (cpu_has_3kex)
> >                 c0_random = (read_c0_random() >> 8) & 0x3f;
> >         else
> >                 c0_random = read_c0_random() & 0x3f;
> >         return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
> > }
> > 
> > What do you think of that? Some tweak I'm missing?
> 
>  It certainly looks good to me.  Do you have a way I could verify how this 
> function performs?  If so, then I could put it through my systems as I can 
> cover all the cases handled here.

Oh, awesome about the test rig. Below is a little patch that adds some
printf code to init, calling the above sequence 70 times in a busy loop
and then 30 times after that with a scheduler 1 ms delay in there,
printing lots of various about the above calculation. Hopefully that's
enough information that it'll be possible to notice if something looks
really off when we squint at it.

Jason

-------------------8<-----------------------------------------------------

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3a293f919af9..0b32203aa47f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -48,6 +48,7 @@
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 #include <linux/completion.h>
@@ -1781,6 +1782,26 @@ static struct ctl_table random_table[] = {
  */
 static int __init random_sysctls_init(void)
 {
+
+	int i;
+	for (i = 0; i < 100; ++i) {
+		if (can_use_mips_counter(read_c0_prid()))
+			pr_err("SARU %d c0 count: %08x\n", i, read_c0_count());
+		else {
+			unsigned int c0_random = read_c0_random(), c0_random_mask;
+			unsigned long fallback = random_get_entropy_fallback(), out;
+			if (cpu_has_3kex)
+				c0_random_mask = (c0_random >> 8) & 0x3f;
+			else
+				c0_random_mask = c0_random & 0x3f;
+			out = (fallback << 6) | (0x3f - c0_random_mask);
+			pr_err("SARU: %d (%08x >> n) & 0x3f = %08x, inverted = %08x, fallback = %08lx, fallback << 6 = %08lx, combined = %08lx\n",
+			       i, c0_random, c0_random_mask, 0x3f - c0_random_mask, fallback, fallback << 6, out);
+		}
+		if (i > 70)
+			msleep(1);
+	}
+
 	register_sysctl_init("kernel/random", random_table);
 	return 0;
 }
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 5745c90c8800..3871b06bd302 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -62,6 +62,8 @@
 #include <linux/types.h>
 #include <linux/param.h>

+unsigned long random_get_entropy_fallback(void);
+
 #include <asm/timex.h>

 #ifndef random_get_entropy
@@ -74,8 +76,14 @@
  *
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
+ * If a given arch does not have get_cycles(), then we fallback to
+ * using random_get_entropy_fallback().
  */
+#ifdef get_cycles
 #define random_get_entropy()	((unsigned long)get_cycles())
+#else
+#define random_get_entropy()	random_get_entropy_fallback()
+#endif
 #endif

 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..7cd2ec239cae 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/tick.h>
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
@@ -2380,6 +2381,15 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 	return 0;
 }

+/**
+ * random_get_entropy_fallback - Returns the raw clock source value,
+ * used by random.c for platforms with no valid random_get_entropy().
+ */
+unsigned long random_get_entropy_fallback(void)
+{
+	return tk_clock_read(&tk_core.timekeeper.tkr_mono);
+}
+EXPORT_SYMBOL_GPL(random_get_entropy_fallback);

 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function

