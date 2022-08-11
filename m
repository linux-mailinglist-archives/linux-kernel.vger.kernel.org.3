Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B9590798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiHKU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiHKU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:56:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382749B77;
        Thu, 11 Aug 2022 13:56:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so35554184ejg.6;
        Thu, 11 Aug 2022 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uE/Qj3AMUHQd04Dxh5p1/PwdcJtjMFZ+U3MfItoUeJQ=;
        b=N6gerAPUmhtN/1eqrOveKqdmlLg3ixq3w4Df7wThGtQ6/VIMQXi6A2E6VT7f68FwcU
         Oj6nqiFptgo0NmHHf+LPY0LYfJsY7sLTA7XLnkMFcJXj/Q0mZzkOxikfwvbcyB2dR73X
         vfV4fJc0k4RtLlfOAbb3Lip0QklmS6+KF+9QL6ySgBFdJq+Yr1ICTs23DNRVCZ38OHyJ
         KXQFh9VOQIqXPoHccDbqvj6R6SWYJhLWhj39QCQaQBpUOI4Wv/jNFzRNtUe6mbS5w/yh
         su8rkGKuYo5VYsQDE8CfAHMqT1g8qehvLTdGgWaE5MNryAViP5O4RaRz/pWboEm6udGe
         Xn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uE/Qj3AMUHQd04Dxh5p1/PwdcJtjMFZ+U3MfItoUeJQ=;
        b=qChWRJya20ym+5j2qSgr63zcqP2/a4nM1Z9slts4NdzVOxsQGD+k9nvWRuA0qmTXCJ
         ocqPtkiHhqZ0CTk8vhomirxBXyXlN6kXqMjR2fAABopkrIly0NXKMiNg4HMKGH9OgDfV
         +K9VkPdEjQoyYHZH7w2JttoNcwiRQKBlkH+zbwALw56AZw7MJFGbLTywDAu6BdfvUT5v
         gdkNWX74Y5gQ03Rj3Cqihiq+kf7h4AOsTmF5zYWRPZVamJfA7AWsraygo6xGCsSOOS1E
         eC2+5E2z2I51rHawXNJ7h4EIVo2domvbB5EZHtIEVjO1yWJCVcRohIo7U5Och1OIM2c5
         8c2A==
X-Gm-Message-State: ACgBeo2emXRQ+PD62kKEAZCgj6giGZecLx9HLVZ994XM6w2XOmboDjTs
        OcOcwUWCTHTz65b01vQv6d7TwFMhPRfLNDoYEEfcf1NFletR1g==
X-Google-Smtp-Source: AA6agR7PL90wgfQGprzftASErtgG4JShOzaaq90d5j9zZ6gJAJp5fUPtP+bGtog1nsAZcOh0tJ3p032g9/GL5AZDA8Q=
X-Received: by 2002:a17:906:858f:b0:730:87ff:b96 with SMTP id
 v15-20020a170906858f00b0073087ff0b96mr553222ejx.649.1660251364754; Thu, 11
 Aug 2022 13:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220811152446.281723-1-idryomov@gmail.com> <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
In-Reply-To: <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 11 Aug 2022 22:55:53 +0200
Message-ID: <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 11, 2022 at 8:25 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> >    [..] Several patches
> > touch files outside of our normal purview to set the stage for bringing
> > in Jeff's long awaited ceph+fscrypt series in the near future.  All of
> > them have appropriate acks and sat in linux-next for a while.
>
> What? No.
>
> I'm looking at the fs/dcache.c change, for example, and don't see the
> relevant maintainers having acked it at all.
>
> The mmdebug.h file similarly seems to not have the actual maintainer
> acks, and seems just plain stupid (why does it add that new folio
> warning macro, when the existing folio warning macro
> VM_WARN_ON_ONCE_FOLIO() is *better*?
>
> Those are some very core files, and while the changes seem harmless,
> they sure don't seem obviously ok.
>
> What's the point of warning about bogus folios more than once? That's
> a debug warning - if it hits even once, that's already "uhhuh,
> something is bad". Showing the warning more than once is likely just
> going to cause more problems, not give you more information.

Xiubo and Jeff used it to track down some issues between netfs library
and folio code that have been randomly plaguing our automated tests for
a couple of releases.  We already knew that there were issues in that
area and the actual occurrences mattered.  This was done in cooperation
with Willy and, since he was involved and this is a no-impact change,
I didn't think twice.

>
> And did somebody verify that d_same_name() is still inlined in the
> place that truly *matters*?  Because from my quick test, that patch
> broke it. Now __d_lookup() does a function call.
>
> And I _suspect_ it's all ok, because it turns out that
> __d_lookup_rcu() is the *really* hot case, and that one has inlined it
> all manually.
>
> But this kind of "we touch some *truly* core functionality, without
> the acks from the maintainers, and then we *claim* to have relevant
> acks" is really not even remotely ok.

I raised the lack of a formal Acked-by from Al on the dcache change
with Jeff a while ago and my understanding was that he reached out to
Al and got the ack (after some ghosting on Al's behalf).  I apologize
if I got that wrong -- all this happened in the middle of Jeff
transitioning his maintainership duties.

>
> I've pulled this because I suspect that d_same_name() thing is fine,
> and I think the VM_WARN_ON_FOLIO() addition is completely wrong but
> not horrendous.
>
> But you're on my tentative shit-list just for having claimed to have
> appropriate acks and having been found wanting.
>
> Just for your information: fs/dcache.c is some of the most optimized
> code in the kernel, and some of the subtlest. That RCU pathname lookup
> is serious business. You don't make changes to pathname lookup just
> willy nilly. There's a reason I start looking at individual patches
> when I see it in the diffstat.

Understood.

Thanks,

                Ilya
