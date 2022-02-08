Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E54ACD98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiBHBH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbiBHANJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:13:09 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D4C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:13:08 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v186so45159495ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzy131isDHXr2lMw39S2jrdc5VN4ofTxUYoaMYMBfhk=;
        b=K80fsiJRp6Np0gIneO3TWLn4lfecosoO6JftYMFHfctEstDMkVHKd4Qdq5vG7m8o5E
         iMMtOrPXbdciKRiRODxnJlz1ngNQBWATrmcPdGe2MITvB/em8x4QtPfQijLzBdINhDIV
         y+4DWDEeae/tX9vWP/Jwqg8SJPU8Pl751CldEMdJ343rquQAkeDd8YI9zV08xIpElX6Z
         rF1dNfIihKGNK8EUbywjuIm3QHZjxWYaMD+jJHI3sy7SfPmrn9FUJB44jDdX8MQXCZZD
         +qYezEpwIzhzhKfAo9+nNGmy2GEqtsBQxmeNgDaTxu6D21xaZXDHq6Q2ZxaVilk9nVA+
         gKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzy131isDHXr2lMw39S2jrdc5VN4ofTxUYoaMYMBfhk=;
        b=78/zs/43qKVNa5z7ztymPhyTWG/0eysafFPR1bCB0WzUqyMqAIilJV5BoOwXOuVUEI
         MhFn8ywtNTJn0BWdchRrvbizMLu+UbfnqU+kbUTcEWkqxyiIm5HozVVr6SWsLyz7/A5h
         yrWy3XNyb2ECuTDa1cJMvtRGCy1cfbrSIKj4GrDgcYVPn2y9VlM4utdIpcvqr6oxNFJe
         zsOoRIUaUtqvedCucitj6/yzVyy4enem+KxIV66QrOUgXfvXiykJ75MjDKYH2CqE8vV+
         bJmUNJRfewroW2RVZMqjlYhgkM7TCSzuZhsJ4n8/r9jv00pB5zzMDn6nIH7PJgVh8dsb
         jd4A==
X-Gm-Message-State: AOAM5332UJISrHgwUvHWfYyzgGhAfwlfVadZ+x0007ikL2Av7wXV5sGO
        mYxM3VnPhGvTgBSQz0tCapl1UqKajyRllHgoihAJ4g==
X-Google-Smtp-Source: ABdhPJw24FfhVAJzebwy7HxWzMMtXDA91fKfvXjLXfJBvyTgrgYFeAZGlM9s290mZVoucruvFx4MWwLX3BcCDmsMdPs=
X-Received: by 2002:a05:6902:1548:: with SMTP id r8mr2560591ybu.374.1644279187380;
 Mon, 07 Feb 2022 16:13:07 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com> <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com>
In-Reply-To: <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 01:12:56 +0100
Message-ID: <CANpmjNM=9A+wr_rF9RBy1esVjR+kAH8x3R0cWhZ8bSkL3r=5Hw@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Jann Horn <jannh@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, pmenzel@molgen.mpg.de,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 at 01:10, Marco Elver <elver@google.com> wrote:
>
> On Mon, 7 Feb 2022 at 22:49, Jann Horn <jannh@google.com> wrote:
> > +KCSAN people
> >
> > On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > Thanks for the report. I assume that this is actually an old bug. Do
> > > you have a vmlinux or a random.o from this kernel you could send me to
> > > double check? Without that, my best guess, which I'd say I have
> > > relatively high confidence about,
> >
> > Maybe KCSAN should go through the same instruction-bytes-dumping thing
> > as normal BUG() does? That might be helpful for cases like this...
>
> A BUG() on x86 actually generates a ud2, and somewhere along the way
> it uses pt_regs in show_opcodes(). Generating KCSAN stack traces is
> very different, and there's no pt_regs because it's going through
> compiler instrumentation.
>
> In general, I wouldn't spend much time on one-sided non-symbolized
> KCSAN reports, unless it's obvious what's going on. I've been thinking
> of making CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n the default, because

(That should have been KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n ... copy-paste error.)

> the one-sided race reports are not very useful. We need to see what
> we're racing against. With the normal reports where both threads'
> stack traces are shown it's usually much easier to narrow down what's
> happening even in the absence of symbolized stack traces.
>
> My suggestion would be to try and get a normal "2-sided" data race report.
>
> I also haven't found something similar in my pile of data race reports
> sitting in syzbot moderation.
>
> Jason - if you're interested in KCSAN data race reports in some
> subsystems you maintain (I see a few in Wireguard), let me know, and
> I'll release them from syzbot's moderation queue. The way we're trying
> to do it with KCSAN is that we pre-moderate and ask maintainers if
> they're happy to be forwarded all reports that syzbot finds (currently
> some Networking and RCU, though the latter finds almost all data races
> via KCSAN-enabled rcutorture).
>
> Thanks,
> -- Marco
