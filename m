Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537553527E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348286AbiEZRYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiEZRYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:24:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B022BD9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:24:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t5so2621481edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvjEOHLIq9Sh9WWlVm5k1WXdPptfENAsp8rVEPdpX98=;
        b=UyfTK4zCywPFtXtJFpp3tYElNgd0u8UNemNFJTk/Ovitu+cPDOX36ZHi1LFPGMRUOz
         eyeBGOphBhoOio8YvUH2x0TGXbaUQNJ6rmMfPipjravKYEHsSSGvsdN3Al5pOmJz3Mzi
         lpN4yiaO/tJ930XEz0yFzopH6FZYXLfmg8iB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvjEOHLIq9Sh9WWlVm5k1WXdPptfENAsp8rVEPdpX98=;
        b=RJgLSMhcwpbkuzcZZ+i4VGTyn1haMnMrGbS4Tys8XEqkO/jj6KG+OvaN4GYNOQfJA+
         /hLsGDUFow94cUunAmde0Wu3QCa9u+OyDdVAMDcDZiAV8yeJf9CmiiSurVbsPK8aBl87
         gAda2G6460cTwlWOkTbCl2gF493GmeVLNAYBY8PuLzNIQM0FSZsedrq4Is81JRYEAW1P
         EU1u/oZ9e+brfEjeg0B5c36O4FcFDdU/Ot5+JTg4tlHi+cRHTAoklO7bSWtUNdjCxLaG
         Ed9PCZIS/5BXmDPOxjAwFISoEQgmCF4CmnbrccyfuEw8c3UDh7rBLICIX5UiepS6HRDU
         J75w==
X-Gm-Message-State: AOAM5325H0WLuatQG/uN58w651S8EsuYhsqiLHltVokNaFqFhVfzJERg
        Q1jUkUcVFM7KhdHQ3I+esT2JZsoq4PETI7s61ws=
X-Google-Smtp-Source: ABdhPJye6LapR8XrtnXId70NkfPMuFTLYvczW8a1Tt1nrrc9f/0kW4MiN8bjgtqqG05n5cmwFYKCHg==
X-Received: by 2002:aa7:d614:0:b0:42b:f24e:e4c2 with SMTP id c20-20020aa7d614000000b0042bf24ee4c2mr67143edr.322.1653585856936;
        Thu, 26 May 2022 10:24:16 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402510b00b0042b6a84b230sm1023750edd.90.2022.05.26.10.24.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:24:15 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id t13so2942110wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:24:15 -0700 (PDT)
X-Received: by 2002:a5d:58cc:0:b0:20e:643d:e46a with SMTP id
 o12-20020a5d58cc000000b0020e643de46amr30956023wrf.97.1653585854913; Thu, 26
 May 2022 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-3-ubizjak@gmail.com>
 <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com> <48001b3d732b418eb5f36def228c2c9d@AcuMS.aculab.com>
In-Reply-To: <48001b3d732b418eb5f36def228c2c9d@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 10:23:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcOMsxThmFoUJYQ+BUmtzMk2J1XJiRWXFsd1LLXyRMZQ@mail.gmail.com>
Message-ID: <CAHk-=wjcOMsxThmFoUJYQ+BUmtzMk2J1XJiRWXFsd1LLXyRMZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_32 && X86_CMPXCHG64
To:     David Laight <David.Laight@aculab.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Waiman.Long@hp.com" <Waiman.Long@hp.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
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

On Thu, May 26, 2022 at 1:30 AM David Laight <David.Laight@aculab.com> wrote:
>
> Perhaps there could be a non-smp implementation of cmpxchg8b
> that just disables interrupts?

As Uros points out, we do have exactly that, but it's not actually
written to be usable for the "trylock" case. Plus it would be
pointless for lockrefs, since the non-cmpxchg case that just falls
back to a spinlock would be faster and simpler (particularly on UP,
where locking goes away).

> While I have used a dual 486 I doubt Linux would run ever
> have on it. The same is probably true for old dual Pentiums.

Yeah, I don't think we ever supported SMP on i486, afaik they all
needed special system glue.

I think the "modern" x86 SMP support with a local APIC was a PPro and
newer thing historically, but clearly there were then later what
amounted to Penitum/MMX class cores (ie old Atom) that did support
SMP.

                      Linus
