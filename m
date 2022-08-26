Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCE5A2CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbiHZQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbiHZQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:51:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA995D0CD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:51:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so2711949lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AzcQtJHhCq1M9HHqJyBU8jps37qkhWyg9JcbI9atrX0=;
        b=clP+YjSRMv2aMSc6s6pfkGuBwb18hbcN4LMP8FIL90suqd9UEviO5jlvsEMFMhPKrc
         SvpI9lj7ObC223xski6/wogooTIqPf19hTqQu36LKAy8yovElPte2v6C7NYnhvAG9OvP
         Zljm4DmKwu9XwUkI6wpFhtr1vIBosEYEvZ//0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AzcQtJHhCq1M9HHqJyBU8jps37qkhWyg9JcbI9atrX0=;
        b=rbcpwtiGf+5a5jXpj6nnuW6uyeWC6HOcWmVCeD10LXgEPnxqO2fSpd+Hvzq7ynbetg
         rAgGzFDGNhhGGWJUsVnYsruebHHB3Id1E+srcJI3sG2gFCURgBiPeisQjGBpw7kExrRl
         NltNRS/6GFes2ADp+znE8DC8ou8PyrrxHGOaF9jFHGNOs/vzZmmF80eX0jYHCsF/MZIJ
         yv+kT6aIAvOPVwFzLjIZfMof3bIn58y53GRC8pKfnpWcjdHay7BU7W3cjMGzU9k6MIeD
         mMujigeXrFZsRGaMGBNrWt4ltGAri2RzfwlH2GzuC1oUfVZtwWTuSDwXp3vu0QLglc10
         yY5g==
X-Gm-Message-State: ACgBeo0G3oAJSWvgG3lVwLK9ADB7IIHoxJAaMf/LI5FMawKs5AMjAdAO
        qcl3fjio+fSvuX6b35Dyxp9RqE/uZ3IoaJK4vDQ=
X-Google-Smtp-Source: AA6agR55kD9lilHJUVGiRr1mPzPqucxZIsx+tNz4sWOZAoHbAQtkWwD0tkEAICXAE/69A+qGFNsnjQ==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr3107542lfb.554.1661532672790;
        Fri, 26 Aug 2022 09:51:12 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b00492e5219874sm417285lfr.258.2022.08.26.09.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:51:12 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k22so2149109ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:51:12 -0700 (PDT)
X-Received: by 2002:a05:6000:136f:b0:225:2fad:dde7 with SMTP id
 q15-20020a056000136f00b002252faddde7mr311126wrz.274.1661532364193; Fri, 26
 Aug 2022 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 09:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
Message-ID: <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
Subject: Re: [PATCH v3] wait_on_bit: add an acquire memory barrier
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 6:17 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I wouldn't do this for regular test_bit because if you read memory with
> different size/alignment from what you wrote, various CPUs suffer from
> store->load forwarding penalties.

All of the half-way modern CPU's do ok with store->load forwarding as
long as the load is fully contained in the store, so I suspect the
'testb' model is pretty much universally better than loading a word
into a register and testing it there.

So narrowing the load is fine (but you generally never want to narrow
a *store*, because that results in huge problems with subsequent wider
loads).

But it's not a huge deal, and this way if somebody actually runs the
numbers and does any comparisons, we have both versions, and if the
'testb' is better, we can just rename the x86
constant_test_bit_acquire() to just constant_test_bit() and use it for
both cases.

> But for test_bit_acqure this optimization is likely harmless because the
> bit will not be tested a few instructions after writing it.

Note that if we really do that, then we've already lost because of the
volatile access, ie if we cared about a "write bit, test bit" pattern,
we should use other operations.

Now, the new "const_test_bit()" logic (commits bb7379bfa680 "bitops:
define const_*() versions of the non-atomics" and 0e862838f290
"bitops: unify non-atomic bitops prototypes across architectures")
means that as long as you are setting and testing a bit in a local
variable, it gets elided entirely. But in general use you're going to
see that load from memory, and then the wider load is likely worse
(because bigger constants, and because it requries a register).

So maybe there is room to tweak it further, but this version of the
patch looks good to me, and I've applied it.

Thanks,
                Linus
