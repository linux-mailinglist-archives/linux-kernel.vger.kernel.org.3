Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D159421E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348591AbiHOVn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349129AbiHOVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:40:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F33FA04
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:28:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t11so6264172qkt.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NximbAMOoMV20R4H+Pt+opb8nW2ZuY7oXM4yWpuLhS8=;
        b=h69ATRcL92gXuQ6VGM5MF1MRckXXYFUojd/X3wntMkRCO3chXdd6R0J13elRRuSG5M
         /IKB9JK7j1cnkCX0NxuPxXBwQyGvl5SoM+Ec/Pv/V8Rb1ZnfyhBmJhJybowcYi4HU14/
         m5c5hHMhJ+vmu0F4QWCHk8vdJc9L49juEqx+8bC7HJ4b2HDgtwr2japRfh3HAPVBPxYr
         SpOBMe0XPQg/HA84zlYCdh852ON4z4Iw2kWeboRqhRtdgmUqMoMFOvRakUbdpQRHgPXX
         Qi8jx3NcDR6pZfA919bR9dr0IgzSM3JU0lUt6p2z8VB5WNUbJ7ol1pSTCHgceNvru5Cz
         jhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NximbAMOoMV20R4H+Pt+opb8nW2ZuY7oXM4yWpuLhS8=;
        b=dNKyPVYTxj4X84XHPtj4RamWVoX5XMehO/8PXvrhLfaDumDiHtjh1cye64xCK18UHb
         hz1WLcSm8V6IRZUsvwG+fX3YDmOjVM2iARcF9wWyH2E064+b0F5rQ8lsijC+etDNTwJu
         CMemcxFXRSifwq9w5gCKECNuWPJ38Pqc2IaJ202rOaZ7UmOpulg7PwEFvfYrdTJsvtfC
         c0R0fT8GzuTphQNvu0P4X8o3jqXO1EIjY9WJxexCh2jjpABiuVcf7W0/tjZryzLbf6LC
         f7ncM/MyueT4eewCfHXcrpAATs2JE9coT4KQXvPafbvElOto9L/61q8uQ4N1x5fUvoEf
         CUJw==
X-Gm-Message-State: ACgBeo1lGYdWC5J3PM39Yq1S385bJFL300qjzwQfzrbyLQKG3vpPRKVy
        KGdkmbbiXO0QvlUw/TCQKdVkgUqwwon1G+aAdEUQrNSYEmk=
X-Google-Smtp-Source: AA6agR7RR9PHyXS+ooHk7q57vjZve0AGDs+KUrltHP2eBtC31D8TGtGTk8FRbvS5JJYiG5509m5H38LLW5fZmDHsWJM=
X-Received: by 2002:a05:620a:2901:b0:6b5:dfe8:2ea3 with SMTP id
 m1-20020a05620a290100b006b5dfe82ea3mr12465178qkp.328.1660591721008; Mon, 15
 Aug 2022 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220712144917.4497-1-ubizjak@gmail.com> <20220814184823.c6ca2c396db0d8817e518ef9@linux-foundation.org>
 <CAFULd4YuYhNmhx3tBwBeR=ascfy=BZfZKk4e7vMq6gy06zk41Q@mail.gmail.com>
In-Reply-To: <CAFULd4YuYhNmhx3tBwBeR=ascfy=BZfZKk4e7vMq6gy06zk41Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 15 Aug 2022 21:28:29 +0200
Message-ID: <CAFULd4Ydo2BR3-kvHPeabzyHExW2GM3pfLiWa2uStrLDW52buA@mail.gmail.com>
Subject: Re: [PATCH] llist: Use try_cmpxchg in llist_add_batch and llist_del_first
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Aug 15, 2022 at 9:20 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 3:48 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 12 Jul 2022 16:49:17 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > > llist_add_batch and llist_del_first. x86 CMPXCHG instruction returns
> > > success in ZF flag, so this change saves a compare after cmpxchg.
> > >
> > > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
> > > cmpxchg fails, enabling further code simplifications.
> > >
> > > No functional change intended.
> >
> > Well this is strange.  Your innocuous little patch:
>
> [...]
>
> > Does this:
> >
> > x1:/usr/src/25> size lib/llist.o-before lib/llist.o-after
> >    text    data     bss     dec     hex filename
> >     541      24       0     565     235 lib/llist.o-before
> >     940      24       0     964     3c4 lib/llist.o-after
> >
> > with x86_64 allmodconfig, gcc-11.1.0.
> >
> > No change with allnoconfig, some bloat with defconfig.
> >
> > I was too lazy to figure out why this happened, but it'd be great if
> > someone could investigate.  Something has gone wrong somewhere.
>
> Sanitizer is detecting a comparison with a constant and emits:
>
>  132:    f0 48 0f b1 2b           lock cmpxchg %rbp,(%rbx)
>  137:    41 0f 94 c6              sete   %r14b
>  13b:    31 ff                    xor    %edi,%edi
>  13d:    44 89 f6                 mov    %r14d,%esi
>  140:    e8 00 00 00 00           call   145 <llist_add_batch+0xc5>
>             141: R_X86_64_PLT32    __sanitizer_cov_trace_const_cmp1-0x4
>
> Since a new call is inserted, the compiler has to save all
> call-clobbered variables around the call, this triggers another call
> to __kasan_check_write. Finally, stack checking is emitted for patched

Actually, this second __kasan_check_write is for the write in case of
cmpxchg failure.

Uros.
