Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0453525C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiEZQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiEZQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:58:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D684A3085
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:58:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 1so2374935ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIrgpKkAzwB07gYimrtbZQWgxesfa74CNz+gljHxsDM=;
        b=Uw2QqULbsgoG8dWkUYz5Wetvt9zrj+w2Z/3KG1NXe+Ga2SYOQA4ahHz0GCrZxRVxxs
         V+aWCEb61jpbUN2D2snj9yzTr4OzNyUFkAE5Zt5ZRUjf0jixHym11fMEvpdfrn+XIvS7
         eBQrWbr/A3ETMNkjZcLBXDbPoHW+g5IGealpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIrgpKkAzwB07gYimrtbZQWgxesfa74CNz+gljHxsDM=;
        b=1n5IhervGKYWeA6D4ClCfgIgACbpbfvx1iPph0rGnp3u/oNpbELGzEPokW7t09SO8a
         59YqF/wS7FLSZXuq242wYXS6O5/RV4NfeYs9CCzw9spYuVJZtPVxlJtr7jbkvBf/WZMR
         i5fBwQCLtXgW68l8USO71StcLusw81HGQQ6dPLTWsZ15FMnW9V0lOkNCtTzusjgVKPgU
         hlztf9IpMcK+uOqxbZP+6lEC1hZZ44QAFuQyjfLYitBqcnyLtRgCa+KmAevI2Qmx/ZMh
         5SlkAV3K1rXLamtRIsucfYuLtBberDaSbhv5j1RC5MGvlS+GpQDDJltJNIzP4q2BncZV
         ouxg==
X-Gm-Message-State: AOAM531E3vzIn0kHfEg1PVOlxzrskU9NdsxNzluWNEkW3RHmfmCbk5Ew
        b9650p4apB+9322a1pTvrvJRNmKZIObKz00Y8h0=
X-Google-Smtp-Source: ABdhPJy7TVjPe6O2CQ7dFTQfiXVKvT2Ola1gYpvrzQpTtH8asuYK+vfcrUKqpbX+YfiqS/ZeJxkWpg==
X-Received: by 2002:a05:651c:1246:b0:253:f0b4:a410 with SMTP id h6-20020a05651c124600b00253f0b4a410mr9957896ljh.288.1653584327289;
        Thu, 26 May 2022 09:58:47 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e29-20020a19691d000000b0047255d211fesm434070lfc.301.2022.05.26.09.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 09:58:47 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id bu29so3327478lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:58:46 -0700 (PDT)
X-Received: by 2002:a5d:58cc:0:b0:20e:643d:e46a with SMTP id
 o12-20020a5d58cc000000b0020e643de46amr30854195wrf.97.1653583940350; Thu, 26
 May 2022 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
 <871qwgmqws.fsf@mpe.ellerman.id.au>
In-Reply-To: <871qwgmqws.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 09:52:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd-RVttYwPc9RYD+x0b=WNYc_PZ2JKwPxc8fm54t0d2w@mail.gmail.com>
Message-ID: <CAHk-=wjd-RVttYwPc9RYD+x0b=WNYc_PZ2JKwPxc8fm54t0d2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, May 26, 2022 at 5:15 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Do you know of a benchmark that shows it up? I tried a few things but
> couldn't get lockref_get() to count for more than 1-2%.

Heh. 1% for a small instruction sequence that is only handful of
instructions and is used in just a couple of places counts as "very
hot" for me.

I assume you did the natural thing: threaded pathname lookup (with
paths being of the longer variety to not be dominated by system call
etc costs).

               Linus
