Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842651609A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbiD3VLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiD3VLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 17:11:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A8644E2;
        Sat, 30 Apr 2022 14:08:14 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651352891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYiEoXgZa+1xAFGzJ6pdbgZS9bMkYlHMr5G8hxuq7k0=;
        b=X5/Hv1szmlnx+Kn4ZVFxkz6yfaMIt6UJ+l1gY8T/a9sG0fqV6nIwpUMxSmWEhoRWuWGkUf
        pw6spnQlELZ2G7HacGwrDq7/RWAAix7kyb7bHlFcOzjSSClc0GssKym4B0ZdtbB4NUaN3w
        0q4BDOIEz6gigZA0s6uqWtNw7Fg/O/O/BvM9Om6BsdyH5Ck7dctYYgArOt0Sp6r32/9X1W
        GjPXgN99BYpZItZfVhUFqvXd5S8Wz0mB+k7reHJyIp6AxxSU5Y4pby8R+Lme/J7lgCpNVa
        O6OJ9WgQFC10tOvqwbGyHuRELT8BxVaCvr9J4pvKTkoMimgdw2PUvOpkUQf0zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651352891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYiEoXgZa+1xAFGzJ6pdbgZS9bMkYlHMr5G8hxuq7k0=;
        b=P4+uquywNx3JFpUdyBVMRf/LWCCPvN3ivrNp3YBAvJLOvyGr87StS76UpIdomH9o8F0KTN
        IaZ2p7Pc009IwgBA==
To:     Marco Elver <elver@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [next] i386: kunit: ASSERTION FAILED at
 mm/kfence/kfence_test.c:547
In-Reply-To: <YmwPocGA9vRSvAEN@elver.google.com>
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
 <YmwPocGA9vRSvAEN@elver.google.com>
Date:   Sat, 30 Apr 2022 23:14:10 +0206
Message-ID: <87fslup9dx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 2022-04-29, Marco Elver <elver@google.com> wrote:
> And looking at your log [1], it shows that KFENCE is working just
> fine, but the logic that is supposed to intercept the kernel log (via
> tracepoint) to check that reports are being generated correctly seems
> to be broken.
>
> And this is not only i386-specific, it's also broken on a x86-64
> build.
>
> At first I thought maybe with the printk changes we'd now have to call
> pr_flush(), but that doesn't work, so I'm missing something still:
>
>  | --- a/mm/kfence/kfence_test.c
>  | +++ b/mm/kfence/kfence_test.c
>  | @@ -73,11 +73,18 @@ static void probe_console(void *ignore, const char *buf, size_t len)
>  |  }
>  |  
>  |  /* Check if a report related to the test exists. */
>  | -static bool report_available(void)
>  | +static bool __report_available(void)
>  |  {
>  |  	return READ_ONCE(observed.nlines) == ARRAY_SIZE(observed.lines);
>  |  }
>  |  
>  | +/* Check if a report related to the test exists; may sleep. */
>  | +static bool report_available(void)
>  | +{
>  | +	pr_flush(0, true);
>  | +	return __report_available();
>  | +}
>  | +

I am not familiar with how this works. Is the tracepoint getting set on
call_console_drivers()? Or on call_console_driver()?

If so, there are a couple problems with that. First off, the prototype
for that function has changed. Second, that function is called when text
is printed, but this is not when the text was created. With the
kthreads, the printing can be significantly delayed.

Since printk() is now lockless and console printing is delayed, it
becomes a bit tricky to parse the records in the existing code using a
tracepoint.

I wonder if creating a NOP function for the kfence probe to attach to
would be more appropriate. In printk_sprint() we get the text after
space has been reserved, but before the text is committed to the
ringbuffer. This is guaranteed to be called from within the printk()
context.

Here is an example of what I am thinking...

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2227,6 +2227,10 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 		}
 	}
 
+#ifdef CONFIG_KFENCE_KUNIT_TEST
+	printk_kfence_check(text, text_len);
+#endif
+
 	return text_len;
 }
 
The probe_console() could attach to a NOP function printk_kfence_check().

John
