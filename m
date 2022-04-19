Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4F507A74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356122AbiDSTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356090AbiDSTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:47:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE011A35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:45:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p10so31210778lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCKh9fKeNxfMXh4t1jTd2sRlnMvxlUGBQPDbUNeNRpQ=;
        b=HY8JOZ6iIKeHPspSmy2AgIRVE6CChfYXGxFCFhD41hKaTAIWq4QhUfdBoczr10gI8p
         rMAqOIhNxaIhPX5LGuCmeCKjXeW78TC+QX0KSoITDShfpmJNCAac3goF6R9nCxYdqK9P
         jiF0BvDBaJ+1dHWEucNx9JJxLHYivAoTSdPA1ZH4fs91Ib5qa3hVCAFktYtevFJHu/ZP
         MGiXoTVsqxMyMvbUvEnTOsFSs78L0r9z+hUUfHQpnT7MEm2NKvjyCr7EOUhJXaaVklPY
         2zl18NTmr+9s1aVO3YyrTFMQ1NoqpoiWv9ZIDnpxoqaeNoEyhDR8e/jNTTFXDRh1+ul9
         Lnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCKh9fKeNxfMXh4t1jTd2sRlnMvxlUGBQPDbUNeNRpQ=;
        b=Bl69z42IcCyeGc0ZTPDliEHrZYeByzpDGrFhVf1hTOisMrxqgj9O9ybJkWo/uu86Wu
         YCN1toisRa1WSDGGxPx+jyl6z+1gX6b314l46+ci5OuRRI81Dhggwzfn9E+9+FrPFP0I
         uv+qPwMn/gIwQcdpP5r0NaAHBlaxOLDAFQ7c4bj1U4DzQQbz9SyDw0IKHLSKptGySx25
         T0psATDlwvuMBrh84tX//vK8Xx0etDBQ51pLfLnf6X0lm9XUIacxoY25DOIKheyo47Dz
         5WHL/wym5S1RKfmomGljYmUtPxbeNPpJCjE26ul2gMZalbZtNkt687Hf8x5XfyMlQsK3
         LIcw==
X-Gm-Message-State: AOAM531KHmvWXZCYgQ9YiN3zF4WQOECnNkY4LJHYXQPN+LeNGzgb3BTV
        +hlmxTUUke7KV2pemkmoHIvb5kIBscvL1ZJG3fNYWA==
X-Google-Smtp-Source: ABdhPJyTu1wtQkzvSicUBK30muaN90aM6nc4lgz884iZvSPR4rlygBUpgktDX+IV/k7gWHfnhshOkSYJFtmXfdtNBDk=
X-Received: by 2002:a05:6512:1322:b0:44b:75d:ac8 with SMTP id
 x34-20020a056512132200b0044b075d0ac8mr11627642lfu.213.1650397508242; Tue, 19
 Apr 2022 12:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com> <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
 <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
In-Reply-To: <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Apr 2022 21:44:31 +0200
Message-ID: <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
Subject: Re: [PATCH] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 6:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Jann,
>
> On Tue, Apr 19, 2022 at 6:38 PM Jann Horn <jannh@google.com> wrote:
> > This is a bit of a weird API, because normally .poll is supposed to be
> > level-triggered rather than edge-triggered... and AFAIK things like
> > epoll also kinda assume that ->poll() doesn't modify state (but that
> > only _really_ matters in weird cases). But at the same time, it looks
> > like the existing proc_sys_poll() already goes against that? So I
> > don't know what the right thing to do there is...
>
> Doesn't the level vs edge distinction apply to POLLIN/POLLOUT events?

I don't see why it would be limited to that.

> In this case, the event generated is actually POLLERR. On one hand,
> this is sort of weird. On the other hand, it perhaps makes sense,
> since nothing changes respect to its readability/writeability. And it
> also happens to be how the sysctl poll() infrastructure was designed;
> I didn't need to change anything for this behavior, and it comes as a
> result of this rather trivial commit only. Looking at where else it's
> used, it appears to be the intended use case for changes to
> hostname/domainname. So while it's unusual, it also appears to be the
> usual way that sysctl poll() works. So perhaps we're quite lucky here
> in that sysctl poll() winds up being the correct interface for what we
> want?

AFAIK this also means that if you make an epoll watch for
/proc/sys/kernel/random/fork_event, and then call poll() *on the epoll
fd* for some reason, that will probably already consume the event; and
if you then try to actually receive the epoll event via epoll_wait(),
it'll already be gone (because epoll tries to re-poll the "ready"
files to figure out what state those files are at now). Similarly if
you try to create an epoll watch for an FD that already has an event
pending: Installing the watch will call the ->poll handler once,
resetting the file's state, and the following epoll_wait() will call
->poll again and think the event is already gone. See the call paths
to vfs_poll() in fs/eventpoll.c.

Maybe we don't care about such exotic usage, and are willing to accept
the UAPI inconsistency and slight epoll breakage of plumbing
edge-triggered polling through APIs designed for level-triggered
polling. IDK.
