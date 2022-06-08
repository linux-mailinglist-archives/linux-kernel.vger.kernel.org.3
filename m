Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF7543D15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiFHTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiFHTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:46:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7C2755B8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:46:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 25so28203679edw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhtzZ9/+YJ8kUb1nFAroKIyulEyrhISYonq+AswBPr0=;
        b=TcmsN9mOlA8bP2rZnnucTbbVTFpfHrbBTVeCL/Pi1vlWrTzL5v327k8N9s5oN9q0WY
         ZKDjqXOfAw1qGniZ7H5FXu4txkapnU15nG6VG93XcpVhPMMSZOLrwsHwfZnzNuST7sad
         /5szK7e4nkKLsKiIH7Tq9qY45jhAL/JhE1NA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhtzZ9/+YJ8kUb1nFAroKIyulEyrhISYonq+AswBPr0=;
        b=EytSWwTnQu7flpsxzx49gxBVYaVqZWvfbtJGov4NslX8W/ShavvHQ725enRoHbsL69
         tV2Z/HD3nPFA1aDlCxg86Ekz3GkOe4Y7JwqWXQBW7JHvhlEhdlAzB7tdctYXIEbEZ0gG
         noM2jXP7Qwm9A9TQQPAGU5i/tMU5Pq78EhqXaQ8uPK1NBsw8dH2obpplLzXyRZK1aDz+
         LIWtC/Omsd9l8s4xTv6Uv5OZatMV2CNwuPuQlVVFr9vyi7MpEW57gT/qFIfHTV3xQAUe
         PKOpsxW95D7pUsitZe6m+fbL4IdR7sVDU2GjCqkf17RVHB+K9ckM6na4EBp8eNNLaiAi
         AbDw==
X-Gm-Message-State: AOAM5338XSYjK+F+vBdLMLsQJHO5GnAG2dylJ08dutj8LqyvxpPG/rwC
        9WTcDjgQArAbwJWeXfMNhiAH47RX27c8e8TG
X-Google-Smtp-Source: ABdhPJz8qZKiPMleb/7ARvJNqyLoLJvrX+CySsPcW4864jhRdTtgduMlb67iZvrVSrJLyVXhIO0kQA==
X-Received: by 2002:aa7:c054:0:b0:433:2d3b:10ed with SMTP id k20-20020aa7c054000000b004332d3b10edmr3303325edo.211.1654717559977;
        Wed, 08 Jun 2022 12:45:59 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id pk16-20020a170906d7b000b006fee526ed72sm9380728ejb.217.2022.06.08.12.45.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 12:45:59 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso11609302wmr.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:45:59 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:39c:4bfd:a4a9 with SMTP id
 j6-20020a05600c42c600b0039c4bfda4a9mr850467wme.8.1654717201668; Wed, 08 Jun
 2022 12:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
 <87k09s1pgo.fsf@oracle.com> <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
 <877d5rt0uz.fsf@oracle.com>
In-Reply-To: <877d5rt0uz.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jun 2022 12:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGjmCwyrs4Druy26rUddoWj29PjAKRZD=q0pzfVNioDg@mail.gmail.com>
Message-ID: <CAHk-=wgGjmCwyrs4Druy26rUddoWj29PjAKRZD=q0pzfVNioDg@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
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

On Wed, Jun 8, 2022 at 12:25 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> But, even on x86, AFAICT gigantic pages could straddle MAX_SECTION_BITS?
> An arch specific clear_huge_page() code could, however handle 1GB pages
> via some kind of static loop around (30 - MAX_SECTION_BITS).

Even if gigantic pages straddle that area, it simply shouldn't matter.

The only reason that MAX_SECTION_BITS matters is for the 'struct page *' lookup.

And the only reason for *that* is because of HIGHMEM.

So it's all entirely silly and pointless on any sane architecture, I think.

> We'll need a preemption point there for CONFIG_PREEMPT_VOLUNTARY
> as well, right?

Ahh, yes.  I should have looked at the code, and not just gone by my
"PREEMPT_NONE vs PREEMPT" thing that entirely forgot about how we
split that up.

> Just one minor point -- seems to me that the choice of nontemporal or
> temporal might have to be based on a hint to clear_huge_page().

Quite possibly. But I'd prefer that  as a separate "look, this
improves numbers by X%" thing from the whole "let's make the
clear_huge_page() interface at least sane".

                 Linus
