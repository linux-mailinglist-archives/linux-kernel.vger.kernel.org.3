Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE30507D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358459AbiDTASz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbiDTASt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:18:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69A24F18;
        Tue, 19 Apr 2022 17:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B155DB815A3;
        Wed, 20 Apr 2022 00:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5DDC385AB;
        Wed, 20 Apr 2022 00:16:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L+9XBwP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650413758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UYx+8vgHYYbBz/GEqXcU/jKRA0n6JzTFCxnZ5uZ49b0=;
        b=L+9XBwP8ADwRXUpfaI41DqkMjJL5FVS5fP2e2CGN32RFIgl/pbntyqZUGh21aCsmGb/XMb
        TYZwRNxoWp4uzuRYOUSWLEge+sOD8p00wMDEtli1MACJgvLBeLJ7C4iZJDDsSO3wj8xBxI
        SndXeRNz8rpHIRoUdAxm1F35qLaTIQg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54bdc775 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Apr 2022 00:15:58 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id p65so31862ybp.9;
        Tue, 19 Apr 2022 17:15:57 -0700 (PDT)
X-Gm-Message-State: AOAM531zw1J8v2dDculXjVxEskWIat8B2vRHEfI7WUtUS7psYwe2WIYT
        Mh6TtddB7D1rTH+7l4oXxVmCTiH2ql+8Xt/d67I=
X-Google-Smtp-Source: ABdhPJyKmzHpgml4b2/70chA1ertzgkMdR1iPqBXnX+lzTkitHamRxGNG77ff6llGW5G3Bb0wx/FhHHBqbQkVs9ZKxM=
X-Received: by 2002:a25:d88c:0:b0:645:570:72d2 with SMTP id
 p134-20020a25d88c000000b00645057072d2mr12340966ybg.373.1650413756667; Tue, 19
 Apr 2022 17:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com> <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
 <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com> <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
In-Reply-To: <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 20 Apr 2022 02:15:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com>
Message-ID: <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com>
Subject: Re: [PATCH] random: add fork_event sysctl for polling VM forks
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>
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

Hi Jann,

On Tue, Apr 19, 2022 at 9:45 PM Jann Horn <jannh@google.com> wrote:
> AFAIK this also means that if you make an epoll watch for
> /proc/sys/kernel/random/fork_event, and then call poll() *on the epoll
> fd* for some reason, that will probably already consume the event; and
> if you then try to actually receive the epoll event via epoll_wait(),
> it'll already be gone (because epoll tries to re-poll the "ready"
> files to figure out what state those files are at now). Similarly if
> you try to create an epoll watch for an FD that already has an event
> pending: Installing the watch will call the ->poll handler once,
> resetting the file's state, and the following epoll_wait() will call
> ->poll again and think the event is already gone. See the call paths
> to vfs_poll() in fs/eventpoll.c.
>
> Maybe we don't care about such exotic usage, and are willing to accept
> the UAPI inconsistency and slight epoll breakage of plumbing
> edge-triggered polling through APIs designed for level-triggered
> polling. IDK.

Hmm, I see. The thing is, this is _already_ what's done for
domainname/hostname. It's how the sysctl poll handler was "designed".
So our options here are:

a) Remove this quirky behavior from domainname/hostname and start
over. This would potentially break userspace, but maybe nobody uses
this? No idea, but sounds risky.

b) Apply this commit as-is, because it's using the API as the API was
designed, and call it a day.

c) Apply this commit as-is, because it's using the API as the API was
designed, and then later try to fix up the epoll behavior on this.

Of these, (a) seems like a non-starter. (c) is most appealing, but it
sounds like it might not actually be possible?

Jason
