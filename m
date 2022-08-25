Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB85A1BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbiHYVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiHYVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:54:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F39E11A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:54:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id og21so4538304ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LL7WsDHbFm5E+eXFntbV7YAH3fSJ/uBWE2CxgYTPVj4=;
        b=H+RsnqVaIXkUild8vuZkOvOlcglKNftG6coYigDxEsYP6mD1FHEmQt2p9v1se5g6CW
         gID96igO0YRsUG8XVCnS34RTQZMRCdVbyKVDiGFMRH8RuQzY6APzQ5Ik7akW9J9n7x5r
         HxZokq5AaOzjYNLYiCVZjX9P/x7xEX5JYiaYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LL7WsDHbFm5E+eXFntbV7YAH3fSJ/uBWE2CxgYTPVj4=;
        b=6dzrMUM7cd8bw0B0t9aSSgiupSgXJ7VjZ+m/Rvr37OtpwQHAvbiCJMbwPkhdlbGDuS
         cGolpDWQLpf/+lqRF5C9LCFHBSiD6MpClRwd85TumtY6Iui4EhrFxIy3g8Cf/U+14KdK
         NVpA0DWWvIU5Ha6297P6A9FnV1bnj+aDhlFCnewtPVqj70Ry2Xl8kRZA/4TsoF1GRj/8
         BzhJGTRfuKzxKLZrHN0DQWVl900zyXzhJx5uweWORd29FSwydi5IeK1YGn5Y1bv0eJOC
         qd1M0g1qrHeQsghPusrp/N8UfN0UABSppKGa9Lr5LIVzofNCGUacNSGMK+yyJNVWhb3e
         Ctyg==
X-Gm-Message-State: ACgBeo15xJaAsVa7zk+ylVtgZ6Sw6qudsyRNM2WA/7QiyX+npJtssZj9
        SBc7ceuEuLJqP2EUrTAmJ8zCcQU8F6d06HbGUFc=
X-Google-Smtp-Source: AA6agR5qqqH8LnXpWVtvVvQfgyP2ByjU0L5LPFLFs9UJ1OkMtHsjI7QZOHxlWw79WV9RWnMbjlThzA==
X-Received: by 2002:a17:906:846f:b0:73d:710b:357e with SMTP id hx15-20020a170906846f00b0073d710b357emr3759454ejc.103.1661464458624;
        Thu, 25 Aug 2022 14:54:18 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id bc17-20020a056402205100b00445e1489313sm283717edb.94.2022.08.25.14.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:54:18 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3181264wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:54:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr9253819wmq.154.1661464457383; Thu, 25
 Aug 2022 14:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com> <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 14:54:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
Message-ID: <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 2:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Here I reworked your patch, so that test_bit_acquire is defined just like
> test_bit. There's some code duplication (in
> include/asm-generic/bitops/generic-non-atomic.h and in
> arch/x86/include/asm/bitops.h), but that duplication exists in the
> test_bit function too.

This looks fine to me, and I like how you fixed up buffer_uptodate()
while at it.

> I tested it on x86-64 and arm64. On x86-64 it generates the "bt"
> instruction for variable-bit test and "shr; and $1" for constant bit test.

That shr/and is almost certainly pessimal for small constant values at
least, and it's better done as "movq %rax" followed by "test %rax".
But I guess it depends on the bit value (and thus the constant size).

Doing a "testb $imm8" would likely be optimal, but you'll never get
that with smp_load_acquire() on x86 unless you use inline asm, because
of how we're doing it with a volatile pointer.

Anyway, you could try something like this:

  static __always_inline bool constant_test_bit(long nr, const
volatile unsigned long *addr)
  {
        bool oldbit;

        asm volatile("testb %2,%1"
                     CC_SET(nz)
                     : CC_OUT(nz) (oldbit)
                     : "m" (((unsigned char *)addr)[nr >> 3]),
                       "Ir" (1 << (nr & 7))
                      :"memory");
        return oldbit;
  }

for both the regular test_bit() and for the acquire (since all loads
are acquires on x86, and using an asm basically forces a memory load
so it just does that "volatile" part.

But that's a separate optimization and independent of the acquire thing.

> For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all
> (with or without this patch), so I only compile-tested it on arm64. I have
> to bisect it.

Hmm. I'm running it on real arm64 hardware (rc2+ - not your patch), so
I wonder what's up..

               Linus
