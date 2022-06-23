Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A4558A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFWVKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:10:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE93702C;
        Thu, 23 Jun 2022 14:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC48BB82552;
        Thu, 23 Jun 2022 21:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4E3C341CA;
        Thu, 23 Jun 2022 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656018646;
        bh=r/T1i7uSjy/kvl4qEG+UmoIxiLk85BbSD01Xc5GDApE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZTECbU+rF4/LujLr008VCc0+ZuOWuK/v13eYwV7fXwms/W3jJY6KJk2Mzwkjlk+tP
         MyVvQ5vGad/iH++jhmNQbwt8Ft44YZjwOynm0QW7q88LQHlAhvS7dMoeXA0yZAixfI
         1K6qeYJhHOwQmhv9KzcYOj4W6/Wphwc2TMtFnDYgPPY4z+8DprPxTh3I2A3GIWqV0p
         fdE3+QlC8C2i6S++mrdVw8JXh83v4bS6I80Dm+ILseOH6YKtv0u3KZ6pgFC/DZ7niU
         1Vvhwv3F0SbubfiflddDLLqv3EsYJxlxCqP1vsts39FMPeMPgQiDo0O11xJxLot2xM
         0wycDe5leqSgg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3178acf2a92so6589787b3.6;
        Thu, 23 Jun 2022 14:10:46 -0700 (PDT)
X-Gm-Message-State: AJIora+sw4rheiruxzO70DeXY1gsPnPmA4R3/MPI3eiGK6T5KV8hg7ch
        hl51VuErvvuhamkcw4qN9dxmzXL6+w8gMnZhoyc=
X-Google-Smtp-Source: AGRyM1sEMLychXrRpbFJTmnKuJNT329ZQQW+NKikrnKFu9k7PM/zI/bpamACz6qcjiiifsMT9ULrYzqIp6aEaayO7So=
X-Received: by 2002:a81:8004:0:b0:318:7e2d:5bd5 with SMTP id
 q4-20020a818004000000b003187e2d5bd5mr4055817ywf.211.1656018645405; Thu, 23
 Jun 2022 14:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655368610.git.bristot@kernel.org> <CAPhsuW4eDhVs2iu0y40LiFyKweJ+3d82-748kavGg5KXWsRuZg@mail.gmail.com>
 <850ef2bc-f70d-afb2-a12f-8cc4c795dac8@kernel.org> <CAPhsuW67decxVH4n4YitkW40OmUqq2LRX7Ry4jqdjrgXSAgknA@mail.gmail.com>
 <d0f37c76-9211-da12-20e8-a7dde9c220ef@kernel.org>
In-Reply-To: <d0f37c76-9211-da12-20e8-a7dde9c220ef@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 23 Jun 2022 14:10:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7gt2fWj6KkHEsuVO6q9kSpU12nPTFq_DM8bffRk9=DFA@mail.gmail.com>
Message-ID: <CAPhsuW7gt2fWj6KkHEsuVO6q9kSpU12nPTFq_DM8bffRk9=DFA@mail.gmail.com>
Subject: Re: [PATCH V4 00/20] The Runtime Verification (RV) interface
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 1:29 PM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
[...]
> >>
> >> The point is that there are use-cases in which the users need the code in
> >> C. One of those is the work being done in the Linux Foundation Elisa group.
> >> There will be more formalism, like timed automata... which will require
> >> infra-structure that is easily accessible in C... including synchronization,
> >> and reactors that are available only in C on "per use-cases" basis - for
> >> example on embedded devices.
> >
> > Where can I find more information about the constraints of these use cases?
>
> Check the LF elisa workgroup.

Thanks for the information. It looks interesting.

>
> > I am asking because there are multiple ways to load a BPF program to the
> > system. If the constraint is that we cannot have bpftrace or bcc in the system,
> > maybe it is ok to run a standalone binary (written in C, compiled on a different
> > system).
>
> as I said... *I am aware of that*. I do like BPF! I was already convinced I will having
> things in BPF :-)
>
> dot2bpf does stand alone application, C + libbpf (and I did it this way to
> have the most of flexibility), it works (for the things that are possible in BPF).
> It shares most of the work in C/kernel, I will add it in the second patch series.

This is great! Looking forward to trying it out. :)

Thanks,
Song
