Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E604B26AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350384AbiBKNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:05:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBKNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:05:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0705F05;
        Fri, 11 Feb 2022 05:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82A1AB829B2;
        Fri, 11 Feb 2022 13:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024E5C340E9;
        Fri, 11 Feb 2022 13:05:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pc7shhSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644584704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5bH4yRSErAHTyTogfKwRhDOjbKYisKUfbK7nzwFk70=;
        b=pc7shhSf1vSYi2ObG6HYFmbWvku1fUqKiy6VfwoBb8DKvv4j65ZOEyp02XjPngB6FE839d
        dX9OPH+SHAH6unqqo1NbVmIfhzdr/sj03Tdd9zTfR50c8nd6At1yBu9bOW2ck4vC9EoaCE
        XBxa8G2Q5oDVWgKcuD0zRK8Jvm+7m2k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 52f66d09 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 13:05:04 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id j12so2460902ybh.8;
        Fri, 11 Feb 2022 05:05:03 -0800 (PST)
X-Gm-Message-State: AOAM533/hmaxvqBOTDopvvMqD6i6Ngsetk2nH6PG9krYVrGIfdPTnKo5
        vwcNuLGpRISpZM5VMxbNVV9aXZHzeB0kAmHOJnU=
X-Google-Smtp-Source: ABdhPJw/0yDlzuSloZQRIcNJwo12AyqZiLlUxiF6abeTLLWDVDDblgjaXi816jLxbsQ319rkA/XawfxMamguvdrWOuE=
X-Received: by 2002:a25:c006:: with SMTP id c6mr1116118ybf.457.1644584703323;
 Fri, 11 Feb 2022 05:05:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
 <20220211011446.392673-1-Jason@zx2c4.com> <YgYbRa+5cC0ivWrK@linutronix.de>
In-Reply-To: <YgYbRa+5cC0ivWrK@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 14:04:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9pPF=1KE9-mhefvtnkMo_9JibVrzyitmQ7_RKBZgjH7sg@mail.gmail.com>
Message-ID: <CAHmME9pPF=1KE9-mhefvtnkMo_9JibVrzyitmQ7_RKBZgjH7sg@mail.gmail.com>
Subject: Re: [PATCH] random: ensure mix_interrupt_randomness() is consistent
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, missed this in your last email:

On Fri, Feb 11, 2022 at 9:16 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > +     do {
> > +             count_snapshot = (unsigned int)atomic_read(&fast_pool->count);
> > +             for (i = 0; i < ARRAY_SIZE(pool); ++i)
> > +                     pool[i] = READ_ONCE(fast_pool->pool_long[i]);
>
> Why do you avoid memcpy()? Since it is a small memcpy, I'm sure the
> compile will inline the register moves.

Because the compiler will otherwise reorder it to be after the two
counter reads. I checked. And a barrier() is too heavy as it flushes
the writes to the stack instead of keeping them read into registers.
READ_ONCE() is the exact semantics we care about here.

Jason
