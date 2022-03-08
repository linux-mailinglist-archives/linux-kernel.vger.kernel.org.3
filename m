Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240084D1A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbiCHOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiCHOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:10:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5D4A938
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:09:44 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e22so8733403ioe.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRpJxORzYHfHsib6XQ7pADNjcahneCQRQX9w7pOY0OQ=;
        b=eYia2UnkUujMkCrYJE7d89YSUEUoxjnvl5UJEuhavn8d1SEmdyr42GRkIEpcHs7myn
         pN7VYwTutC7jPYkkMhURoI0yONVTY7jxIPfG8MzdMeCR/7TLVUSC31QR4MQq0yaEJc4m
         v7pl2GcX78WMtKLSqP3Ya65hsfztUJWVkgWdToaDHtYxmMGL/9d2Fv+3WRcprLBlJ1qk
         hIGBxkEi34GmItstGIkhdUHPzOBsSYSs9iZ69kpdp8pSsB9BH4y+IRSB4V4C36SjP0dK
         TmlMqOYK6VZY8GM5a8+sq+PGtpVnyOr+ttU52Hea0UkXgSVGZ4tmtMoOrO4RXpegyqDF
         RkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRpJxORzYHfHsib6XQ7pADNjcahneCQRQX9w7pOY0OQ=;
        b=GGGzo3SnY33mPc+8T++nPL16COwslmGKzz8a4WkT/iPF96BawMORixTGCuoWa1dGFq
         xR/UOXo8Mi5d+9V77aXbjk1B5rcgqQrXwKBx5vMztyK2w+CjsruHBl+scf95KQeBP9RW
         CN66kfVKqHm8NYJJsnz7uaztU4dGKdz0/B9ootBUc8paSnnhNckfqo2u/4eg6y7hORL/
         UBonf7YkPb89mkbRry7+jDigTI3Vr/pD5ARoSUNnuWHOhZQ/PAB9kna3+7B96+DJwkL3
         VS1CxZ6OtEREnW+COEjQKJ1avfWNrk9yYS+w02gyOtAPvFogzBwG9SNGUZi4Hs8TsxJX
         6vCw==
X-Gm-Message-State: AOAM5300nOGiAuUJaPSJqK5yysjl+lsG2xU7a1a0ETMmB5r7BRzrLiyG
        SaPP5EQKO1khMI5sMVwu1/w0f5DudoyVxTPzS75ZGY3I
X-Google-Smtp-Source: ABdhPJwqEfqCA5cagNp4O8IaA+I16blpIODquNOlVcpibSm5zKmOUZYsN+lR33Ipt82RXosZpqekJeJvvjTzV27uuTo=
X-Received: by 2002:a05:6602:490:b0:638:c8ed:1e38 with SMTP id
 y16-20020a056602049000b00638c8ed1e38mr14813042iov.202.1646748584377; Tue, 08
 Mar 2022 06:09:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646237226.git.andreyknvl@google.com> <1c8ce43f97300300e62c941181afa2eb738965c5.1646237226.git.andreyknvl@google.com>
 <CAG_fn=UX_hF4RYdCMy-NRC+=KySFLE4wOTiCmzFPBwhieWjz4w@mail.gmail.com>
In-Reply-To: <CAG_fn=UX_hF4RYdCMy-NRC+=KySFLE4wOTiCmzFPBwhieWjz4w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 8 Mar 2022 15:09:33 +0100
Message-ID: <CA+fCnZdQtjF-wZRiX+CJLpp4BOQbJXDvAL3vE4+xaKVYrCqpqQ@mail.gmail.com>
Subject: Re: [PATCH mm 06/22] kasan: simplify async check in end_report
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 6:38 PM Alexander Potapenko <glider@google.com> wrote:
>
>
>
> On Wed, Mar 2, 2022 at 5:37 PM <andrey.konovalov@linux.dev> wrote:
>>
>> From: Andrey Konovalov <andreyknvl@google.com>
>>
>> Currently, end_report() does not call trace_error_report_end() for bugs
>> detected in either async or asymm mode (when kasan_async_fault_possible()
>> returns true), as the address of the bad access might be unknown.
>>
>> However, for asymm mode, the address is known for faults triggered by
>> read operations.
>>
>> Instead of using kasan_async_fault_possible(), simply check that
>> the addr is not NULL when calling trace_error_report_end().
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  mm/kasan/report.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index d60ee8b81e2b..2d892ec050be 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -112,7 +112,7 @@ static void start_report(unsigned long *flags)
>>
>>  static void end_report(unsigned long *flags, unsigned long addr)
>>  {
>> -       if (!kasan_async_fault_possible())
>> +       if (addr)
>>                 trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
>
>
> What happens in the case of a NULL dereference? Don't we want to trigger the tracepoint as well?

A NULL pointer dereference is never reported through KASAN: for
software modes, it triggers a GPF when accessing shadow, and for
HW_TAGS, it takes precedence over a tag mismatch.

Thanks!
