Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812C1516B71
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359079AbiEBHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358993AbiEBHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:55:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363E2C649
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:51:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so18533910wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/iZcbm+HsfS7NtVRG8PqR/TcI1wEubO1WbobcyN2js=;
        b=NrF1p/vNwCzwdOYH7qCK1EBvF/CKACJY2M9sKOXdr6oQJseU4N4LwaXAB6h2h5cNWq
         0lxfrVjHZkVZV/LXmNg4T9vhuLCrzjRXijIwClM9wI1G3XRMOYjNobEoosZIiOgOvzZq
         2mDl8j8F0eKZuYiYPNOQ0ONvaf7yL+d1UqgN6bWUHX41ncUrQLxCnVRxSvADN2hGmRgK
         WOS4Yn/c06NzsBUhv3MFLh+ln9zmVdzkPTAuPdRRp3Ir4TDN8edrajtGYYe+yla24mpZ
         it1GjNJoKk3JzC6K+QNAqqptIH41WfOJXzIcTejDGsFy3SCtiiogW7z7Xg0EZowfP/VF
         N+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/iZcbm+HsfS7NtVRG8PqR/TcI1wEubO1WbobcyN2js=;
        b=VSRUs9P7vSZdJrAJZC4nEzFgjFmB2UxIAq3zcnhCpyXjDK/u0BcRn9CvGBv8d3nJGZ
         pgUpf2wfViwT9OTbZKhditPGm9k7ylkSgfVlWdNTjTru4smDu+2zsvFJzNq6Zwl3JAjb
         oSFYznbIs+7fhl9Zo8hAG0GEL8Ga8Amuhi9Rgv7azWpBMtqFmcQZVTygpreB/H0JZsoi
         kim3iKhlOhikOTHpb2ik6/dWkMulQ1pqvlHhivCMAqF9qfYSDpViyj3v4PTXHgiZX5Xy
         MwMFlA9xc+nZI4u1GU/Xqz2WljtKqZXeU/R2O/mn6NH+ZwwqWO5Kc3sYofw6yJi7revB
         YsfA==
X-Gm-Message-State: AOAM5310e+arqNBTFCacTAc8goyIurYWcBdw6q+byFx4YmQBRj8XkIye
        jRc7SEneGP78xw3eOQiOhzIU3Q==
X-Google-Smtp-Source: ABdhPJxsSzLA8P20zIPWb1gO6clHzj+py+j7QZhWipmTlyvk1D+UG5nDQrYdqbUSvV1EkldQMALWLw==
X-Received: by 2002:adf:f0cb:0:b0:20a:ef39:d42b with SMTP id x11-20020adff0cb000000b0020aef39d42bmr8699587wro.8.1651477913781;
        Mon, 02 May 2022 00:51:53 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:ee30:3795:2e49:1a19])
        by smtp.gmail.com with ESMTPSA id z10-20020a1c4c0a000000b003942a244f54sm5668256wmf.45.2022.05.02.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:51:53 -0700 (PDT)
Date:   Mon, 2 May 2022 09:51:46 +0200
From:   Marco Elver <elver@google.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
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
Message-ID: <Ym+NkkglHI5D89Dx@elver.google.com>
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
 <YmwPocGA9vRSvAEN@elver.google.com>
 <87fslup9dx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fslup9dx.fsf@jogness.linutronix.de>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 11:14PM +0206, John Ogness wrote:
[...]
> I am not familiar with how this works. Is the tracepoint getting set on
> call_console_drivers()? Or on call_console_driver()?

It's at the start of call_console_drivers(). See trace_console_rcuidle()
call.

> If so, there are a couple problems with that. First off, the prototype
> for that function has changed. Second, that function is called when text
> is printed, but this is not when the text was created. With the
> kthreads, the printing can be significantly delayed.
> 
> Since printk() is now lockless and console printing is delayed, it
> becomes a bit tricky to parse the records in the existing code using a
> tracepoint.
> 
> I wonder if creating a NOP function for the kfence probe to attach to
> would be more appropriate. In printk_sprint() we get the text after
> space has been reserved, but before the text is committed to the
> ringbuffer. This is guaranteed to be called from within the printk()
> context.

I think we just need to fix the existing tracepoint, since it has
changed its semantics vs. what it was intended to be:

 | commit 95100358491abaa2e9a5483811370059bbca4645
 | Author: Johannes Berg <johannes.berg@intel.com>
 | Date:   Thu Nov 24 20:03:08 2011 +0100
 |
 |     printk/tracing: Add console output tracing
 |
 |     Add a printk.console trace point to record any printk
 |     messages into the trace, regardless of the current
 |     console loglevel. This can help correlate (existing)
 |     printk debugging with other tracing.
 |
 |     Link: http://lkml.kernel.org/r/1322161388.5366.54.camel@jlt3.sipsolutions.net
 |
 |     Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
 |     Cc: Christoph Hellwig <hch@infradead.org>
 |     Cc: Ingo Molnar <mingo@redhat.com>
 |     Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
 |     Acked-by: Thomas Gleixner <tglx@linutronix.de>
 |     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
 |     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Specifically using it to "correlate (existing) printk debugging with
other tracing" is now broken.

> Here is an example of what I am thinking...
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2227,6 +2227,10 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  		}
>  	}
>  
> +#ifdef CONFIG_KFENCE_KUNIT_TEST
> +	printk_kfence_check(text, text_len);
> +#endif
> +
>  	return text_len;
>  }
>  
> The probe_console() could attach to a NOP function printk_kfence_check().

Thanks for this! However, I think we can't have a KFENCE-specific
helper, it needs to be a tracepoint, because there are more tests that
want to check console output (kernel/kcsan/kcsan_test.c did this before
the KFENCE test actually).

My proposal would be to fix the tracepoint like so:

 | --- a/kernel/printk/printk.c
 | +++ b/kernel/printk/printk.c
 | @@ -2002,8 +2002,6 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 |  {
 |  	size_t dropped_len;
 |  
 | -	trace_console_rcuidle(text, len);
 | -
 |  	if (con->dropped && dropped_text) {
 |  		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
 |  				       "** %lu printk messages dropped **\n",
 | @@ -2178,6 +2176,8 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 |  		}
 |  	}
 |  
 | +	trace_console_rcuidle(text, text_len);
 | +
 |  	return text_len;
 |  }

This fixes the KFENCE and KCSAN tests.

Unless I hear objections, I'll prepare a patch explaining why we need to
fix the tracepoint.

Thanks,
-- Marco
