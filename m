Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5B5335DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbiEYDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiEYDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:34:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4277F3E;
        Tue, 24 May 2022 20:34:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg25so11691336wmb.4;
        Tue, 24 May 2022 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghTmliHJ1zlOIVen0TpVTdOTHI7IMPCtAuqivGtm1FA=;
        b=oWCLnghgdcyq4yUMAGTUGBPNNhyUsHEd8v9IT7LaU8iNh83h1n6qtnoeG5i4iAKzXX
         ADgYJXmUjBQHeilPutKRVDOzX/Ur9kjRqW3sv/dxybsCh57tSMXrywI09VIHvGQD5TDn
         x2zerml7MJk1DqAu+ft4MRmpxbzH+2Lzrrc4pRN/uhCw9TAWiMANxVmYIosTletuge8Y
         Kto1z6wkrZRQ390+Wy+bOD420m9KFkSrDKYP3F8h6THa0w9zeVvsx66+mClDPNPgu4nt
         7+7M2nXdJyyPf53HdtgRc5OHubtbUJKm7yinnQuk2AlXwnCA8DCOjFD8cZ4HszbwYcYp
         aJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghTmliHJ1zlOIVen0TpVTdOTHI7IMPCtAuqivGtm1FA=;
        b=WmqDpXV9CXO7YkcLDwyhlprhUrNITpBXeorhUHsSvMawbinstm1G9cTgroSUe0O7G3
         +0Ft+nGMdIvbn7eOHSJlICuhMlk9cJe13FfNQa8EBdcPudSe0OeCePHKO9tldG/kOGCm
         NQg12/HTKhqQNZwBWJUGmGmBAYjr4qeidXoKTlVWIM5DczoNNewyJqmyNJk1hH63C0w0
         e44G6uPz4a4Dyy6LWwGJtufwHyw3X18DGPEDfM04qej6sjMbNZq8r3A7d4+bQLrmEbDE
         Pq+WEu2TbpI+Z9Qql+nhoxnRNHEelXOBdjgZosf53iuep+fyHb62lupddZRT99fbT5fu
         LQPg==
X-Gm-Message-State: AOAM532OOLkoUTVA9QbStApMoDHLSRKG08zuDx5NKWjS0h4lw/fMSp9S
        YDP5W5Uz7xtQcE8mfHue89NGWQKytgeaYMsSMgX4eb9Xc2c=
X-Google-Smtp-Source: ABdhPJzisWPnePa2pcOTpW4mbLLsATmmpWfUtubqktbreIbKFQYGNlX90hGJB2Ao8zFa1A9xPxXl0vM8cdAq2oSgXgo=
X-Received: by 2002:a05:600c:3d89:b0:397:104:b1c9 with SMTP id
 bi9-20020a05600c3d8900b003970104b1c9mr6395333wmb.84.1653449658207; Tue, 24
 May 2022 20:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210728010632.2633470-1-robdclark@gmail.com> <20210728010632.2633470-13-robdclark@gmail.com>
 <84e03c5f-a3af-6592-d19a-a2f5d20b92fb@linux.intel.com> <CAJs_Fx6Nc337LPNh=p2GT2d2yDTdLWH934o4Cof3urDGhUJB6A@mail.gmail.com>
 <904ae104-1c30-d130-129f-ccae381261d5@linux.intel.com> <CAF6AEGuVhXuX63Od+kcJ0QtfAZ2-wqZsN0KOuEzKbivJdouzog@mail.gmail.com>
In-Reply-To: <CAF6AEGuVhXuX63Od+kcJ0QtfAZ2-wqZsN0KOuEzKbivJdouzog@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 24 May 2022 20:34:15 -0700
Message-ID: <CAF6AEGvyiMGF-Him5VSHdBCufqoNF8kqMY5XhAic3mvpi_x75A@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] drm/msm: Utilize gpu scheduler priorities
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, May 24, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, May 24, 2022 at 6:45 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> >
> > On 23/05/2022 23:53, Rob Clark wrote:
> > >
> > > btw, one fun (but unrelated) issue I'm hitting with scheduler... I'm
> > > trying to add an igt test to stress shrinker/eviction, similar to the
> > > existing tests/i915/gem_shrink.c.  But we hit an unfortunate
> > > combination of circumstances:
> > > 1. Pinning memory happens in the synchronous part of the submit ioctl,
> > > before enqueuing the job for the kthread to handle.
> > > 2. The first run_job() callback incurs a slight delay (~1.5ms) while
> > > resuming the GPU
> > > 3. Because of that delay, userspace has a chance to queue up enough
> > > more jobs to require locking/pinning more than the available system
> > > RAM..
> >
> > Is that one or multiple threads submitting jobs?
>
> In this case multiple.. but I think it could also happen with a single
> thread (provided it didn't stall on a fence, directly or indirectly,
> from an earlier submit), because of how resume and actual job
> submission happens from scheduler kthread.
>
> > > I'm not sure if we want a way to prevent userspace from getting *too*
> > > far ahead of the kthread.  Or maybe at some point the shrinker should
> > > sleep on non-idle buffers?
> >
> > On the direct reclaim path when invoked from the submit ioctl? In i915
> > we only shrink idle objects on direct reclaim and leave active ones for
> > the swapper. It depends on how your locking looks like whether you could
> > do them, whether there would be coupling of locks and fs-reclaim context.
>
> I think the locking is more or less ok, although lockdep is unhappy
> about one thing[1] which is I think a false warning (ie. not
> recognizing that we'd already successfully acquired the obj lock via
> trylock).  We can already reclaim idle bo's in this path.  But the
> problem with a bunch of submits queued up in the scheduler, is that
> they are already considered pinned and active.  So at some point we
> need to sleep (hopefully interruptabley) until they are no longer
> active, ie. to throttle userspace trying to shove in more submits
> until some of the enqueued ones have a chance to run and complete.
>
> BR,
> -R
>
> [1] https://gitlab.freedesktop.org/drm/msm/-/issues/14
>

btw, one thing I'm thinking about is __GFP_RETRY_MAYFAIL for gem
bo's.. I'd need to think about the various code paths that could
trigger us to need to allocate pages, but short-circuiting the
out_of_memory() path deep in drm_gem_get_pages() ->
shmem_read_mapping_page() -> ... -> __alloc_pages_may_oom() and
letting the driver decide itself if there is queued work worth waiting
on (and if not, calling out_of_memory() directly itself) seems like a
possible solution.. that also untangles the interrupted-syscall case
so we don't end up having to block in a non-interruptible way.  Seems
like it might work?

BR,
-R
