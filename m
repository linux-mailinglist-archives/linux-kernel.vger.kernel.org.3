Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782BB516FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385099AbiEBMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiEBMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:52:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D3914000
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:49:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x33so25105199lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eFk3CzuDkxDpPniRqtaFxJeQbfsTLgh4mE837V0A8Y=;
        b=WHez4RIelBuHg8j+rO7kE5+U3jaMpBScFhklfdh/mMSyiHOkSwCSHua8oJR3fZuilp
         UNx5A1idSZuI/VD2IFaT07lwhXqGfPKDPNKN2B0Nry9WnVco6BZbwmprz+/IVgODHF6b
         iyPLFLyJXAtrUPaAVQPsuFk407AwgvJxuTXIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eFk3CzuDkxDpPniRqtaFxJeQbfsTLgh4mE837V0A8Y=;
        b=aCV6lA9xoTtklHa//SrEa3hVB15rLtksqA6FFkSAJdLlxBh1SvQcl/g7g4yeINsAmr
         Ssy82LEgF7baNiTaU0g0Sb/PvJCumrHejtPgDuUqVa3iByF/F9dw5aUc5kx+qzQgkqi7
         /wcZIbsWjadVLPoxSDk9wXSQFRsyKooPKuqmzsDu4YSczF2HS//CTiVQqttFShVJZJLw
         BBdYb6t/wKU8Y3ChbCdfgQLYHZxU8BEMZVuxr/dhnwaRDdRkOWtfy4x3a40eUKaezlLV
         +MDHcf/O2XCoZ4ZCxgf2DSD5t69PjVCfFOH7eBpI6csu3f8mzHaSNECq6vYRXpWYAuGu
         dZ8w==
X-Gm-Message-State: AOAM530YvVwXhOTmk51sDbDWTgrOGOa9a57czcH7BtV7rtVJuy1Lyny5
        qTuf/HAKsE+UyVkoKnCGxZFtjok02eKovxMoVCnHw+f8IUWMLg==
X-Google-Smtp-Source: ABdhPJwC48LIteEmIFffDIgQFbiDm1nyg16gxhvNkjnf1qCcDYEVv0/aL5RUw5H1f8h2H0D9jPwyBw2Gz6Lys4aLt/4=
X-Received: by 2002:a05:6512:1398:b0:448:bda0:99f2 with SMTP id
 p24-20020a056512139800b00448bda099f2mr8600628lfa.681.1651495751352; Mon, 02
 May 2022 05:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220429023113.74993-1-sargun@sargun.me> <20220429023113.74993-2-sargun@sargun.me>
 <CACaBj2bW8XkENHoLNXEprQ_d8=_aLT_XQdjCZtSOiPJis8G_pQ@mail.gmail.com>
 <20220429171437.GA1267404@ircssh-3.c.rugged-nimbus-611.internal> <202204291120.428EB85@keescook>
In-Reply-To: <202204291120.428EB85@keescook>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Mon, 2 May 2022 14:48:35 +0200
Message-ID: <CACaBj2bfJTgC1AW7XmG76iXa2-=5A2phi5bWfDmvd0PNRpe1OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 8:20 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Apr 29, 2022 at 05:14:37PM +0000, Sargun Dhillon wrote:
> > On Fri, Apr 29, 2022 at 11:42:15AM +0200, Rodrigo Campos wrote:
> > > On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > > the concept is searchable. If the notifying process is signaled prior
> > > > to the notification being received by the userspace agent, it will
> > > > be handled as normal.
> > >
> > > Why is that? Why not always handle in the same way (if wait killable
> > > is set, wait like that)
> > >
> >
> > The goal is to avoid two things:
> > 1. Unncessary work - Often times, we see workloads that implement techniques
> >    like hedging (Also known as request racing[1]). In fact, RFC3484
> >    (destination address selection) gets implemented where the DNS library
> >    will connect to many backend addresses and whichever one comes back first
> >    "wins".
> > 2. Side effects - We don't want a situation where a syscall is in progress
> >    that is non-trivial to rollback (mount), and from user space's perspective
> >    this syscall never completed.
> >
> > Blocking before the syscall even starts is excessive. When we looked at this
> > we found that with runtimes like Golang, they can get into a bad situation
> > if they have many (1000s) of threads that are in the middle of a syscall
> > because all of them need to elide prior to GC. In this case the runtime
> > prioritizes the liveness of GC vs. the syscalls.
> >
> > That being said, there may be some syscalls in a filter that need the suggested
> > behaviour. I can imagine introducing a new flag
> > (say SECCOMP_FILTER_FLAG_WAIT_KILLABLE) that applies to all states.
> > Alternatively, in one implementation, I put the behaviour in the data
> > field of the return from the BPF filter.

Makes sense, if we need to, we can implement that in the future too.

> I'd add something like the above to the commit log, just to have it
> around.

Yes, please. It was not obvious to me.
