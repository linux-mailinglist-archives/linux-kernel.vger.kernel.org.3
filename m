Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0B59C4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiHVRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHVRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:09:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F80C422FC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:09:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ca13so11255349ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FBSmStkotiGF5Og7ExawLkOys7P/24UjQfsLmwYIr/M=;
        b=a1uslqfzoUrzXGd0AtZpa/7qVFuOyaBocH8utbCHMh+IkSOo3bi2iA+PM0xZRNUJXv
         t1cspoXmBEBzEkIS9Wllb9Qh/U1c5tYnnJ4nHm80ZZthOK6BkFbBx1u7VhL2Ep9q2HGo
         sz1FnS+mb8UOtjAbiizHgEwMu4Gfjzk0Cl1cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FBSmStkotiGF5Og7ExawLkOys7P/24UjQfsLmwYIr/M=;
        b=Ztgs2yfOZgeYw7MoQ9unVl16Gm9bCs8SOGrhl8Pzx/D4MvXKssZ3aZTCJM1o/aly7d
         xCdX9d1dlxdAFxsv0t4rDtTNVIhrC5CjuRypAgDh0zEmommFHwR2wMWwJvfdVD2f0eR2
         h/XOp3vKZKwCieur+Nxm4OUZ0NSN6ch6d6jbjE7MVRtWoKjagXViwuKbpCxuGUa6aziu
         tB48QYV8JtTNdd2mdcTzzpSVtVCK3cmsXg4xFRX89jQ1B01+6V/huQig8ckOLIkWxaXd
         SUX2FvN1N6MB7Z3nBq+7HJiBSUc8oveODDTH55csM4EXR56gsmMsoraz8eGpZEL4fPwv
         AXhA==
X-Gm-Message-State: ACgBeo1varbUimvS2+1s5D+QMtaS8Edjq68jgggyHQzKsmmKJSomt8Ch
        tjVkGXiyj1KAdTFBhe/Yx0/LAaQlu6uWVj2l
X-Google-Smtp-Source: AA6agR7fM49rkpjBt7Is6pFsXAkbGNnn583eCSC3MqCuOskDElTIM0ivCcfUSb83yy37klL0roOdHA==
X-Received: by 2002:a17:906:9bd8:b0:73d:83d1:2222 with SMTP id de24-20020a1709069bd800b0073d83d12222mr3250852ejc.557.1661188146313;
        Mon, 22 Aug 2022 10:09:06 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0073306218484sm6405339eju.26.2022.08.22.10.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:09:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so4008900wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:09:05 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr15334285wmm.68.1661188144843; Mon, 22
 Aug 2022 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 10:08:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
Message-ID: <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 2:39 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I'd like to ask what do you think about this patch?

I really don't like it. It adds a pointless read barrier only because
you didn't want to do it properly.

On x86, it doesn't matter, since rmb is a no-op and only a scheduling
barrier (and not noticeable in this case anyway).

On other architectures, it might.

But on all architectures it's just ugly.

I suggested in an earlier thread that you just do it right with an
explicit smp_load_acquire() and a manual bit test.

So why don't we just create a "test_bit_acquire()" and be done with
it? We literally created clear_bit_unlock() for the opposite reason,
and your comments about the new barrier hack even point to it.

Why is "clear_bit_unlock()" worthy of a real helper, but
"test_bit_acquire()" is not and people who want it have to use this
horrendous hack?

Please stop adding random barriers already. Just do it right. I've
said this before, why do you then keep doing this and asking for
comments?

My reply will remain the same: JUST DO IT RIGHT.

                Linus
