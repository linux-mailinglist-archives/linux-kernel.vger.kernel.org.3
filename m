Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF84B1AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiBKAnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:43:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244965AbiBKAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:43:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3CE6C;
        Thu, 10 Feb 2022 16:43:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B29B826B4;
        Fri, 11 Feb 2022 00:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0550FC340EE;
        Fri, 11 Feb 2022 00:43:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hNeMakxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644540189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0vKcGurM+seOaod8eYMcPboMMWynI7lYU57RwZ9U9w=;
        b=hNeMakxO3qh+47cF2Lt1mr8EFmSRDNSzovhavybEyrc2JnC4Ot1MbLjakT3U80Lqzg+siX
        smsBhRhrqBemk8QIIA4DI3qoC/qXYbsIIH3BtQOzaapg2WVXiAuVKB9gA6m+P7GqZx/mlf
        FnUruW7OH71CxCfklgQYKLG4XH0uNuo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 60a78fe7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 00:43:08 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id c6so20424965ybk.3;
        Thu, 10 Feb 2022 16:43:08 -0800 (PST)
X-Gm-Message-State: AOAM533q6bFD1PK5M8COLCaWrN/mm/2HR67LEPSftHCjoqvDTh/tiqNK
        bbdl/flaZa8HvFRo15IOF+Sh4VFZ1sBdwgiI4Dc=
X-Google-Smtp-Source: ABdhPJy+q+S9ihMnQbr0OcXt7j1ox96Pf685juOhgcRrRAcDLlxCLjLCTTi4D7406d/jjL8Vj3n0zzCRhJquE2YYWnE=
X-Received: by 2002:a0d:f244:: with SMTP id b65mr9919257ywf.2.1644540187689;
 Thu, 10 Feb 2022 16:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20220209125644.533876-1-Jason@zx2c4.com> <20220209125644.533876-3-Jason@zx2c4.com>
 <YgVTpI/sYLecyWa3@linutronix.de>
In-Reply-To: <YgVTpI/sYLecyWa3@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 01:42:56 +0100
X-Gmail-Original-Message-ID: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
Message-ID: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Feb 10, 2022 at 7:04 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> So.
> - CPU1 schedules a worker
> - CPU1 goes offline before the gets on the CPU.
> - The worker runs CPU2
> - CPU2 is back online
> - and now
>    CPU1                                         CPU2
>    new_count =3D ++fast_pool->count;
>     reg =3D fast_pool->count (FAST_POOL_MIX_INFLIGHT | 64)
>     incl reg (FAST_POOL_MIX_INFLIGHT | 65)
>                                                 WRITE_ONCE(fast_pool->cou=
nt, 0);
>     fast_pool->count =3D reg ((FAST_POOL_MIX_INFLIGHT | 65)
>
> So we lost the WRITE_ONCE(, 0), FAST_POOL_MIX_INFLIGHT is still set and
> worker is not scheduled. Not easy to trigger, not by an ordinary user.
> Just wanted to mention=E2=80=A6

Thanks for pointing this out. I'll actually fix this using atomics,
and fix another minor issue at the same time the same way, and move to
making sure the worker is running on the right CPU like we originally
discussed. I'm going to send that as an additional patch so that we
can narrow in on the issue there. It's a little bit involved but not
too bad. I'll have that for you shortly.

> crng_fast_load() does spin_trylock_irqsave() in hardirq context. It does
> not produce any warning on RT but is still wrong IMHO:
> If we just could move this, too.
> I don't know how timing critical this is but the first backtrace from
> crng_fast_load() came (to my surprise) from hwrng_fillfn() (a kthread)
> and added 64bytes in one go.

I'll look into seeing if I can do it. On my first pass a few days ago,
it seemed a bit too tricky, but I'll revisit after this part here
settles. Thanks for your benchmarks, by the way. That's useful.

Jason
