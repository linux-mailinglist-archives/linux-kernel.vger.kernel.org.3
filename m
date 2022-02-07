Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC804AC80B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiBGRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbiBGRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:54:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CE1C0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:54:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cz16so13543767edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1ETeFDR6QJoYK3+OnwDD9R/6p2RNSYvL2g2p2WxrBU=;
        b=FjxpjtKC6mnVb94wEpqK3SB05kX+867ndWTnG6a01gqIyqpM5Dv8ZQE5HqdUg94+KD
         KoVT08PorrKfo8w6PAO1jK1GgI+cHmdFwwTml97oJ/66Z2eInN1VNvD3opwpU7cDAG4M
         nhCHrFWvF6rJsCA7ZCQVVgxj0WPXovb9hWNK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1ETeFDR6QJoYK3+OnwDD9R/6p2RNSYvL2g2p2WxrBU=;
        b=cVC/YmRc+V1DrqBr52shFg0BM/FUnq+vq5ZAuCZ9/POUASr+w/72s0MNZzkhvopaMS
         7N3z79QtSiXLJZXJOc/DXAqP7r36hxvGQOpVS6oyFF3uH4paaI0wq/FYTnlMIwxeA2kY
         Wo0DvjO7Hn50ycZfY8+d+e/9hAsUhOEiDOj9aWwQr3X297iA1aOxCFPSAanyBV1o1j9m
         w91L0QS/wRbhD8HwhE+BmCTDWRMv80eiiLZcS2K2uoykPjx95/YNVCDi8gEvVnuvj4ZD
         Ruc9qYFfB+7SwNgm9e+67VVrmM1xOSKbXMBkbJJ1/KQGvHBZpPPo5WV1h5ZjpXP0gE3m
         BP6w==
X-Gm-Message-State: AOAM5311wBevqdwLF1wS6Ozj9o5uwVqkQDRMFhlarx4Cs0N6BxN0xjME
        YqXtWL+qaja4mREme+HV99uY1FBSydyVlTF/
X-Google-Smtp-Source: ABdhPJxjpXj65pmw3KGRtK1tDpaqCTbwe8U0Asco1HSoX6gMnR0nc6rXTDdDCbeueA3ne8GAlasj7w==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr646635ede.358.1644256443245;
        Mon, 07 Feb 2022 09:54:03 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id e26sm1794536eds.10.2022.02.07.09.53.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:54:00 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id m5so8985692wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:53:59 -0800 (PST)
X-Received: by 2002:adf:d087:: with SMTP id y7mr480299wrh.274.1644256438786;
 Mon, 07 Feb 2022 09:53:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
 <20220207001141.GA1833089@roeck-us.net>
In-Reply-To: <20220207001141.GA1833089@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Feb 2022 09:53:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaOAA3hLXD2B8B2kaPpaZh-hHu-i_H=_nDnMg5LoUt6w@mail.gmail.com>
Message-ID: <CAHk-=wiaOAA3hLXD2B8B2kaPpaZh-hHu-i_H=_nDnMg5LoUt6w@mail.gmail.com>
Subject: Re: Linux 5.17-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
> arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace'
>
> Introduced with commit 1614b2b11fab29 ("arch: Make ARCH_STACKWALK
> independent of STACKTRACE"). Discussed at
> https://lore.kernel.org/lkml/YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net/T/
> No fix posted as far as I know, and no recent progress.

Well, there's actually a suggested fix in that thread (PeterZ's "I
suppose this ought to cure things...").

But I'll leave it to the powerpc people to decide how they want to
sort out that #ifdef confusion.

There's some *generic* #ifdef confusion in this area too, with
<linux/nmi.h> having

  #if defined(CONFIG_HAVE_NMI_WATCHDOG)
  #include <asm/nmi.h>
  #endif

at the top - which is where you want it for those #ifdef
arch_trigger_cpumask_backtrace games later in that file, and then

  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
  #include <asm/nmi.h>
  #endif

at the bottom of the file - by which time it is too late for the
arch_trigger_cpumask_backtrace games.

The exact Kconfig rules are a bit obscure too, with
HAVE_HARDLOCKUP_DETECTOR_ARCH and HAVE_NMI_WATCHDOG being all mixed
up.

What a mess.

                Linus
