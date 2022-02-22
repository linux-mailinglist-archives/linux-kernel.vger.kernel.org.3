Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E204BF61D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiBVKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBVKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:36:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864515B993
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:35:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so23960072lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+lVCwDiOku8kLSVJnTfKoIgYRuSLH77+xI/uMbyK9OA=;
        b=g42GYshzG9e6NElFaCS8Jefbr7OC5dly7FlECjdhp3xNpsCgJClndEfQTRjDb4e8u7
         2jqdHuQ0aJKFx/7JdrgipgzJd3fTdqCpZ0f5/VE72oALWFrHqtBLylrIqUKokBuJmByw
         xSUNTd+M4uvzCWa91yZzcdnh5pqshAnihRmns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+lVCwDiOku8kLSVJnTfKoIgYRuSLH77+xI/uMbyK9OA=;
        b=Uso9NFB2rnJKW5tns3YsnURkEQBwovi1KiKrUkG+4cv6AIX1AWkO2IcXlknu1SkZC1
         vKKNwYoA9Om6+JCcXho1PSmweDL8NeAnPu9fa3fcPeF+PsO3osWOF3e25fCjjfA8pA+7
         IDRvrBcwFkCIqQT627g6JD1pSqazhE8Ze3JZk7a4s2ewvslr6+jaiazzJfezC7hQRqFI
         Zsb9AjtZmNLjV0N+ksIYWqOm0IwNOsDEZWEmKICYMpyKtdDy3mRqRq2CIpSqaWh+aXaW
         UdhYbh8RX2TXH+Qgt6FoxNa4CwjPfh71pm20apKc+gz59QFehK+h1SncP4nKlzKomTJG
         pcNw==
X-Gm-Message-State: AOAM532LaX/3686ua1T84JoANPpY8Uof7fpGJ39bpEzp77dbeD8xXwWP
        x8Ad/Tg7tx+t8qRv6t7jO7GQPDXxz7y/E9GV
X-Google-Smtp-Source: ABdhPJw7mYLWWpMf+NUtglLOXRjELIKiJZkgSiolfEArK+dH1UUaX9aYYOXYyapKylfEHYLmtw7e6Q==
X-Received: by 2002:ac2:46ef:0:b0:443:3c30:a372 with SMTP id q15-20020ac246ef000000b004433c30a372mr16966119lfo.626.1645526141133;
        Tue, 22 Feb 2022 02:35:41 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m7sm1638575ljb.87.2022.02.22.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 02:35:40 -0800 (PST)
Message-ID: <10bbffc2-f144-8555-d41b-fede69a13c16@rasmusvillemoes.dk>
Date:   Tue, 22 Feb 2022 11:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
 <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
 <CANiq72=mNh415UG_nxDQc=9SCSVSPnqcAbgFZKzavnmsim_L0Q@mail.gmail.com>
 <YhSs5ZTL9ixdCCU9@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YhSs5ZTL9ixdCCU9@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 10.29, Petr Mladek wrote:
> On Mon 2022-02-14 13:12:24, Miguel Ojeda wrote:
>> On Mon, Feb 14, 2022 at 11:52 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>> I think the point is for vsnprintf() to call (back) into Rust code.
>>
>> Indeed, this is the case.
>>
>>> That said, I don't like the !CONFIG_RUST version to return NULL, that
>>> will surely crash moments later.
>>>
>>> So I prefer something like
>>>
>>> [rust.h]
>>> // no CONFIG_RUST conditional
>>> +char *rust_fmt_argument(char* buf, char* end, void *ptr);
>>>
>>> [vsprintf.c]
>>> +       case 'A':
>>> +               if (IS_ENABLED(CONFIG_RUST))
>>> +                   return rust_fmt_argument(buf, end, ptr);
>>> +               else
>>> +                   return string_nocheck(buf, end, "[%pA in non-Rust
>>> code?!]", default_str_spec);
> 
> Any long message might cause buffer overflow when the caller expects
> fixed short string.

If the caller (1) uses a %p extension from C code which should only be
used from Rust and (2) uses sprintf() or another variant where he
doesn't provide the real buffer bounds, well, then he certainly gets to
keep the pieces.

It is a much worse problem that if CONFIG_RUST is enabled, we can't know
that we were actually called from Rust (but when !CONFIG_RUST, we
certainly know that we weren't), so we could call into rust_fmt_argument
with a pointer which certainly doesn't point to the/a data structure
which that Rust code expects. But we can't do anything about it, we will
just have to rely on static analysis to flag any use of %pA in C code.

> The most safe solution would be to use WARN_ONCE(). 

Preferably no, we shouldn't call into the printk machinery from within
vsnprintf(). I know I've added a few myself (AFAIR for use of %n or
other unsupported specifiers, and for overflow of precision/field
width), and I've often thought about a way to get rid of them while
still making sure some message eventually gets logged (once).


Rasmus
