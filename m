Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39B4ECDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350894AbiC3UHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350893AbiC3UHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:07:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773B5BD04
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:05:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so31868099lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leYvi+cDZUOrDBc7G8or9bc7gxfHRObwcuo9/M9zt8A=;
        b=Cb72t/cRjaiariN8lx6yjbeoYYe+LTSD1X0yXgkFAsVKShM9sXIaEj6kIA3dxLzoPC
         ZI3TJ/dsOPCcHBHGs+0s/a+le08A4UDAO8XzJUfImHKwDtW4m0rluPtB29SRmoMvx/jY
         IiJCe6dZ8ZGw1AZGSznUgKyCguN8z/Nw3ocnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leYvi+cDZUOrDBc7G8or9bc7gxfHRObwcuo9/M9zt8A=;
        b=GInwV/MqhkxaDVyDhjAtEvZYkwwCxMHAIXEk+g0WRFmhnIBlGO3Genlep2Tfkzk8+v
         NRlCc2z5NnWBiQjUhS9rw1RmAWtlhYNPpilC5g4nLrhF+ATDPe5jQfXGKyN1fRwUJUlA
         f/7qT7VM0Q96afkit4V2nanBqJx0dvUU2GHo/BNDS1vI6c7ZDMIG+NZx1+OsQg+zq9g8
         Gr83ovz5+pjg5Xon/MaWsQ76gpDgEc6xoXWD13JzCEIJnnLvVGGGaV5GVnppANCcdKDv
         7tRFO6Yfb9O/MD2ai4jd4f7fwKag5chgDY/es/3Hr3xzz81b23f7h5vfNmihLzI+ReNY
         aDqA==
X-Gm-Message-State: AOAM5333gkzL4SqlWH3naJEwDDcteUpaLO3ESDAzaZN4ywMr6tKG0Ds6
        /3c0jKyDKb2SlyfRNVm15VURFsoai9ddaQtE
X-Google-Smtp-Source: ABdhPJx0S5PzAIOlmbpkR+Itd2DjE4tO7ziL8BTgfQd5ZcRgRGYMfUILPWReyQDJ6veoT+QF07gYww==
X-Received: by 2002:a05:6512:2809:b0:44a:94d1:ad8e with SMTP id cf9-20020a056512280900b0044a94d1ad8emr8054668lfb.175.1648670717784;
        Wed, 30 Mar 2022 13:05:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p17-20020a19f111000000b0044a6522f9acsm2283143lfh.135.2022.03.30.13.05.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:05:16 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w7so37754705lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:05:16 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8016762lfh.687.1648670716244; Wed, 30
 Mar 2022 13:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220330154208.71aca532@gandalf.local.home>
In-Reply-To: <20220330154208.71aca532@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 13:05:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
Message-ID: <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I started testing new patches and it crashed when doing the x86-32 test on
> boot up.
>
> Initializing HighMem for node 0 (000375fe:0021ee00)
> BUG: kernel NULL pointer dereference, address: 00000878
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> *pdpt = 0000000000000000 *pde = f0000000f000eef3
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> EIP: get_pfnblock_flags_mask+0x2c/0x36
> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb ff ff 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 90 d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1

The whole function is in that Code: thing, and it decodes to:

   0: 55                    push   %ebp
   1: 89 e5                mov    %esp,%ebp
   3: 56                    push   %esi
   4: 89 ce                mov    %ecx,%esi
   6: 53                    push   %ebx
   7: 8b 18                mov    (%eax),%ebx
   9: 89 d8                mov    %ebx,%eax
   b: c1 eb 1e              shr    $0x1e,%ebx
   e: e8 f7 fb ff ff        call   0xfffffc0a
  13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
  19: 89 c1                mov    %eax,%ecx
  1b: 89 c2                mov    %eax,%edx
  1d: c1 ea 05              shr    $0x5,%edx
  20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
  26: 5b                    pop    %ebx
  27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping instruction
  2a: d3 e8                shr    %cl,%eax
  2c: 21 f0                and    %esi,%eax
  2e: 5e                    pop    %esi
  2f: 5d                    pop    %ebp
  30: c3                    ret

with '%eax' being NULL, and %edx being 0x21e.

(The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler does
similar code generation, so it's out-of-lined part of pfn_to_bitidx()
despite being marked inline)

So that oops is that

        word = bitmap[word_bitidx];

line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').

Looking around, your 'config-bad' doesn't even have
CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is this
part of the change:

-               if (unlikely(has_isolate_pageblock(zone))) {

which used to always be false for that config, and now the code is
suddenly enabled.

Alternatively, that code just can't deal with highmem properly.

But I didn't really analyze things, I'm mainly doing pattern matching here.

Zi Yan - and all the people who ack'ed and reviewed this - please take
a deeper look..

                Linus
