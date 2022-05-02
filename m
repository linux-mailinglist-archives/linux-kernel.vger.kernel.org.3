Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A1516D41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384220AbiEBJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384255AbiEBJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:24:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBFB6149;
        Mon,  2 May 2022 02:20:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651483232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzfdL55sKTwT/KWa9oyx9CtM+emKdBvooXpdLahQrpU=;
        b=j8CmyZoLzBOC0GXUd5JxjOeb0G3xhiKAMqdvpix3YrULTPsGMUg8u2dkETM4tANAnK2hQt
        VwOo0gJvZs+/ifhnW7U2L9Caf5r8VNTP7lUfnh4BMffWqMBn8QoJG6v5guk50DtPfAOMpR
        YzrHkf/dbt8N1GhtNgWtf0T5vgGGBiPJSiJDM3wxgyPBon6UIwfXxELweaBEeokBpJTVZe
        w4HQOJkgIrwq5UQebHJEK4PnuBraQ7D3/XBEn0LZgSbivVIKJpRRWuvnuUgHxF4Rq+2MUM
        uXMmVh/GGpgyVFxM6CDXFCyt6eS2sCmnGh2OJNaHPymdaMaGwkv4GRn12RIHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651483232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzfdL55sKTwT/KWa9oyx9CtM+emKdBvooXpdLahQrpU=;
        b=ypr5ktzoRR9yKPEgwzApJC1WmvpkyzQ9I1B6fwNKOqIWB5S1Ua0CEpFbf0/mUuc3CViB8t
        VuZ9NafLOLpuHZCg==
To:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
In-Reply-To: <Ym+WqKStCg/EHfh3@alley>
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
 <YmwPocGA9vRSvAEN@elver.google.com> <87fslup9dx.fsf@jogness.linutronix.de>
 <Ym+NkkglHI5D89Dx@elver.google.com> <Ym+WqKStCg/EHfh3@alley>
Date:   Mon, 02 May 2022 11:26:31 +0206
Message-ID: <87czgwmgtc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-02, Petr Mladek <pmladek@suse.com> wrote:
>> My proposal would be to fix the tracepoint like so:
>> 
>>  | --- a/kernel/printk/printk.c
>>  | +++ b/kernel/printk/printk.c
>>  | @@ -2002,8 +2002,6 @@ static void call_console_driver(struct console *con, const char *text, size_t le
>>  |  {
>>  |  	size_t dropped_len;
>>  |  
>>  | -	trace_console_rcuidle(text, len);
>>  | -
>>  |  	if (con->dropped && dropped_text) {
>>  |  		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
>>  |  				       "** %lu printk messages dropped **\n",
>>  | @@ -2178,6 +2176,8 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>>  |  		}
>>  |  	}
>>  |  
>>  | +	trace_console_rcuidle(text, text_len);
>>  | +
>>  |  	return text_len;
>>  |  }
>> 
>> This fixes the KFENCE and KCSAN tests.
>> 
>> Unless I hear objections, I'll prepare a patch explaining why we need to
>> fix the tracepoint.
>
> It makes perfect sense to me.

This is the easiest place for it. However, it should be clear that in
the context of trace_console_rcuidle(), the message is not yet visible
to any readers. The message _will_ get committed and definitely _will_
become visible at some point. But it is not (yet) visible at _this_
point. Maybe that is OK for what it is being used for.

If trace_console_rcuidle() must be called at the point of visibility for
readers, it becomes more complicated.

John
