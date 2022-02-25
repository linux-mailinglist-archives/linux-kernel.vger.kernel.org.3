Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD394C3D92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiBYFTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiBYFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:19:00 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963871DDFED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:18:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o8so3662677pgf.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J3pbOHjbfILDxHP0y1Ok94VaunSLaIJn2gdLdZgG3mU=;
        b=PhVuSe0UGX4cX5gAyK+7YFrme9Gkl1j9vk5Kbrpaavmu/K40K7Rf5DRt9g2Bk1MWet
         +LjCK6aEP0WVCGsfYjDK7B/p5P/mTSzYi7nzkDikY1xvkxDbl8eTNL/22hxaWi89RKZo
         YeNlE+/oNCgGbcdX2AulgONkvIWxIIz95z3gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3pbOHjbfILDxHP0y1Ok94VaunSLaIJn2gdLdZgG3mU=;
        b=0krZmeq+pdiAsCpqWwMjG2aoy2PG104vi5kxu0r1x8rkBQS/MO9Ju9gSCuIFxfFwBJ
         K9cS1hHrX2Qthci0brt2tljAvTRtrSCV1xiuQSH08hEBU6hDM0yfn/IhZyJ7RchACUxK
         p7zsPrzHAJPhTxLS2i7OBlWf23SpgXL7DmpTwjpkqIC6d7JU6a9kdZwwJJR2sgqgu5mv
         1LxLl1a72NZKN1OnUPKgTkmY/pH51MVOQkGgncLKfEIFIDmnBaF+fSm2bOdaywKonr1R
         NieaWA48pV3fWKBuQIik++VOipuHyaW6Ef0M+vNBb29LJBqmSyGRgl5vwlke/hhrG8du
         KAeg==
X-Gm-Message-State: AOAM533XwjGunYOw/6X0oYzE8TbY98qNd+kSwLzeqzjCm7k+wBfFGyvW
        +275FiT005A+DC1SFI6NREuD0Q==
X-Google-Smtp-Source: ABdhPJwOAiUFtHofplDoutdY6PZKAqBM5IAgkD30p9wzxeLTVMoqOtruft0+/vCexW0QWyEbAzRvzQ==
X-Received: by 2002:a05:6a00:b84:b0:492:64f1:61b5 with SMTP id g4-20020a056a000b8400b0049264f161b5mr6083258pfj.52.1645766309109;
        Thu, 24 Feb 2022 21:18:29 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e94f:9f5e:13f6:a198])
        by smtp.gmail.com with ESMTPSA id y74-20020a62644d000000b004f129e94f40sm1282136pfb.131.2022.02.24.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:18:28 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:18:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhhmnmgAlVCcVqSV@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <YheXRmmWr619Qxin@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YheXRmmWr619Qxin@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/24 15:33), Petr Mladek wrote:
> > My bad! I did not spot the `return` at the end of the new branch.
> > 
> > +       if (console_flush) {
> > +               if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> > +                       console_flush_on_panic(CONSOLE_REPLAY_ALL);
> > +               return;
> > +       }
> > 
> > Hmm. Yeah, well, that's a bit of a tricky interface now
> > 
> > 	panic()
> > 		// everything (if corresponding bits set), no console flush
> > 		panic_print_sys_info(false)
> > 		...
> > 		// console flush only if corresponding bit set
> > 		panic_print_sys_info(true)
> 
> I agree that self-explaining names are always better than true/false.
> It is pity that replay the log is handled in panic_print at all.
> 
> I sometimes hide these tricks into wrappers. We could rename:
> 
>     panic_printk_sys_info() -> panic_print_handler()
> 
> and add wrappers:
> 
> void panic_print_sys_info()
> {
> 	panic_printk_handler(false);
> }
> 
> void panic_print_log_replay()
> {
> 	panic_printk_handler(true);
> }
> 
> Or just split panic_printk_sys_info() into these two functions.

Agreed. I also tend to think that panic_printk_sys_info() is needed anyway,
just because now we do

	debug_locks_off();
	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
		console_flush_on_panic(CONSOLE_REPLAY_ALL);

It probably would be better if we do

	debug_locks_off();
	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
		console_flush_on_panic(CONSOLE_REPLAY_ALL);
	else
		console_flush_on_panic(CONSOLE_FLUSH_PENDING);

instead.

IOW move console_flush_on_panic() handling out of panic_print_sys_info().
console_flush_on_panic() isn't really related to "print sys info" stuff
that panic_print_sys_info() does.

Something like this may be:

---
 static void panic_print_sys_info(void)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
-
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
 
@@ -196,6 +193,23 @@ static void panic_print_sys_info(void)
 		ftrace_dump(DUMP_ALL);
 }
 
+static void panic_console_flush(void)
+{
+	/*
+	 * We may have ended up stopping the CPU holding the lock (in
+	 * smp_send_stop()) while still having some valuable data in the console
+	 * buffer.  Try to acquire the lock then release it regardless of the
+	 * result.  The release will also print the buffers out.  Locks debug
+	 * should be disabled to avoid reporting bad unlock balance when
+	 * panic() is not being callled from OOPS.
+	 */
+	debug_locks_off();
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	else
+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -329,17 +343,7 @@ void panic(const char *fmt, ...)
 #endif
 	console_unblank();
 
-	/*
-	 * We may have ended up stopping the CPU holding the lock (in
-	 * smp_send_stop()) while still having some valuable data in the console
-	 * buffer.  Try to acquire the lock then release it regardless of the
-	 * result.  The release will also print the buffers out.  Locks debug
-	 * should be disabled to avoid reporting bad unlock balance when
-	 * panic() is not being callled from OOPS.
-	 */
-	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
-
+	panic_console_flush();
 	panic_print_sys_info();
 
 	if (!panic_blink)
---

> > If everyone is fine then OK.
> > 
> > But I _personally_ would look into changing this to something like this:
> > 
> > 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> > 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
> 
> These lists cause merge and backporting conflicts. I vote to avoid
> this approach ;-)

OK :)
