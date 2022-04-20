Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F2508AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379636AbiDTO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379597AbiDTO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:26:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657E444759
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:23:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w1so3287715lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L9wlYfoTTVlFWQO6Q+aBUFZaMt8eiBvRHdomsCb/gQ=;
        b=Z010qGorZkVwJPQFregA0TEII538tSkI9PcrpH33C3ttbmgCLOXe4POQcpAGi7IG5t
         YLbO2w5gQ4z3tUpveaBuExKl3mKgtCbc8yCRysHk2Z7Mb1rHXVj3TqwIxWO6tH9yIAJa
         nC+6COmPpwyjE5ubuwLEZrOTWeoeu7jIB6nOHOu2PijtkrzgkkDFCNze04zzqTi3Ysda
         w/iyEAfryfJId4pQ6moJHVEELHHAZZ+zbtmfhqYDVWwqABWJY0u+MPRoiH7zVzJF1iDz
         frq0+UneHHv5GJmDgsDiJV4ywAtbIol/M1BcbkZCthUOeDPTMQ0eKbz0YceQKPkQkSvA
         PALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L9wlYfoTTVlFWQO6Q+aBUFZaMt8eiBvRHdomsCb/gQ=;
        b=DHIjEz6JO64jROSIOehbf3qZToCsiFjq3GrsfBCD3jjZA+bYDcuiHiX+G2L5I2j/SU
         u47lzOg/O1g9Zaa3PBY4KzH5yiWhFLoWS4AKpWJwPtk0Z4GKFTruudZU5aSqHV3JZcCV
         T1C0DO0/2IbrVoDpZTbL+r71llcQ1u+imKDwhO8Gef/u7SHhsRFcEUbcV+opDQNpx++1
         +Oppns9BUltd7IwSBVfa3uN0TjFK3KB46RgJqimeBiriQvyjJLiqjQ6Ip582blmwIO6f
         B/NVZMhbb7yFSS1NIswIyISicDwqcps28ULrmEQXlz946rwyKCgv/VbOqwcwWyEo2iDa
         U7LA==
X-Gm-Message-State: AOAM533eVyFuNY5avK+wXUKM1rVNlW00aDvnRHWNq0EH+mPdLTUp0ayl
        aiQ6IKN2ev/phL+I7faOp7NgxIUXohvtAXyVhscTIK46cDjl+g==
X-Google-Smtp-Source: ABdhPJwORr+u06BVupqHEdr6+9bVLS7u6YOpv7Z8575GAnbbRW403yo6Hg6y84QtAeNyMBVdvSJxpYjNcFB0Jyc9k4U=
X-Received: by 2002:ac2:43b1:0:b0:46d:c52d:bae1 with SMTP id
 t17-20020ac243b1000000b0046dc52dbae1mr14831663lfl.315.1650464618375; Wed, 20
 Apr 2022 07:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com> <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
 <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
 <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
 <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com> <YmAJoGtqA3PMrZmD@zx2c4.com>
In-Reply-To: <YmAJoGtqA3PMrZmD@zx2c4.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Apr 2022 16:23:02 +0200
Message-ID: <CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey again,
>
> On Wed, Apr 20, 2022 at 02:15:45AM +0200, Jason A. Donenfeld wrote:
> > Hi Jann,
> >
> > On Tue, Apr 19, 2022 at 9:45 PM Jann Horn <jannh@google.com> wrote:
> > > AFAIK this also means that if you make an epoll watch for
> > > /proc/sys/kernel/random/fork_event, and then call poll() *on the epoll
> > > fd* for some reason, that will probably already consume the event; and
> > > if you then try to actually receive the epoll event via epoll_wait(),
> > > it'll already be gone (because epoll tries to re-poll the "ready"
> > > files to figure out what state those files are at now). Similarly if
> > > you try to create an epoll watch for an FD that already has an event
> > > pending: Installing the watch will call the ->poll handler once,
> > > resetting the file's state, and the following epoll_wait() will call
> > > ->poll again and think the event is already gone. See the call paths
> > > to vfs_poll() in fs/eventpoll.c.
> > >
> > > Maybe we don't care about such exotic usage, and are willing to accept
> > > the UAPI inconsistency and slight epoll breakage of plumbing
> > > edge-triggered polling through APIs designed for level-triggered
> > > polling. IDK.
> >
> > Hmm, I see. The thing is, this is _already_ what's done for
> > domainname/hostname. It's how the sysctl poll handler was "designed".
> > So our options here are:
> >
> > a) Remove this quirky behavior from domainname/hostname and start
> > over. This would potentially break userspace, but maybe nobody uses
> > this? No idea, but sounds risky.
> >
> > b) Apply this commit as-is, because it's using the API as the API was
> > designed, and call it a day.
> >
> > c) Apply this commit as-is, because it's using the API as the API was
> > designed, and then later try to fix up the epoll behavior on this.
> >
> > Of these, (a) seems like a non-starter. (c) is most appealing, but it
> > sounds like it might not actually be possible?
> >
> > Jason
>
> I actually tried to verify your concern but didn't have success doing
> so.

My point is that when you run this code:

$ cat edgepoll.c
#include <time.h>
#include <stdio.h>
#include <fcntl.h>
#include <err.h>
#include <unistd.h>
#include <poll.h>
#include <sys/epoll.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int epfd = SYSCHK(epoll_create1(0));
  int hostname_fd = SYSCHK(open("/proc/sys/kernel/hostname", O_RDONLY));
  struct epoll_event event = { .events = EPOLLERR, .data = { .u32 = 1234 } };
  SYSCHK(epoll_ctl(epfd, EPOLL_CTL_ADD, hostname_fd, &event));

  while (1) {
    struct pollfd pollfds[1] = { { .fd = epfd, .events = POLLIN } };
    int poll_res = poll(pollfds, 1, -1);
    if (poll_res == -1) {
      perror("poll() error");
      continue;
    }
    if (poll_res == 0) {
      printf("poll(): no events ready (can't happen, we're using
timeout=-1)\n");
      continue;
    }
    struct epoll_event events[1];
    int epoll_res = epoll_wait(epfd, events, 1, 0);
    if (epoll_res == -1) {
      perror("epoll error");
      continue;
    }
    if (epoll_res == 0) {
      printf("spurious epoll readiness\n");
      continue;
    }
    printf("got epoll fd readiness: events=0x%x, u32=%u\n",
events[0].events, events[0].data.u32);
  }
}
$ gcc -o edgepoll edgepoll.c
$ ./edgepoll

and then change the hostname, you'll just get "spurious epoll
readiness" logged - simply calling poll() on the epoll FD resets the
state of the hostname file that is being polled, so when we then try
to receive the epoll event with epoll_wait(), the event is gone.


And the other case is this:

$ cat edgepoll2.c
#include <time.h>
#include <stdio.h>
#include <fcntl.h>
#include <err.h>
#include <unistd.h>
#include <poll.h>
#include <sys/epoll.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int epfd = SYSCHK(epoll_create1(0));
  int hostname_fd = SYSCHK(open("/proc/sys/kernel/hostname", O_RDONLY));
  printf("opened hostname fd, sleeping\n");
  sleep(10);
  printf("done sleeping\n");
  struct epoll_event event = { .events = EPOLLERR, .data = { .u32 = 1234 } };
  SYSCHK(epoll_ctl(epfd, EPOLL_CTL_ADD, hostname_fd, &event));

  struct epoll_event events[1];
  int epoll_res = SYSCHK(epoll_wait(epfd, events, 1, 0));
  if (epoll_res == 0)
    errx(1, "no epoll events ready");
  printf("got epoll fd readiness: events=0x%x, u32=%u\n",
events[0].events, events[0].data.u32);
}
$ gcc -o edgepoll2 edgepoll2.c
$ ./edgepoll2
opened hostname fd, sleeping
done sleeping
edgepoll2: no epoll events ready
$

If you change the hostname when "opened hostname fd, sleeping" is
printed, it'll still say "edgepoll2: no epoll events ready", because
the EPOLL_CTL_ADD basically consumed the event.
