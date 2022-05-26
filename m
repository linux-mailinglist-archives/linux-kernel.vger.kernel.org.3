Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2C534936
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiEZDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiEZDP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:15:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6264DF82;
        Wed, 25 May 2022 20:15:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso1819843wms.0;
        Wed, 25 May 2022 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGeMotmHD5kcwokKadCBWqHPNlO0Qvs0CVZPqUnOIwU=;
        b=STPbaruw09QCXES5FDI15P7EnfhRJv83ICkhIygnvPTFFztNE3QMp+2HkzKr0MHCCL
         vA13P4G9M+1adv/QOdjA4zKguI6NfBb99Puhm/tqNrB5bbfpnVqbXcxKrH+kH32KOrFo
         HMFF7e4t//YJWSQez1Oune1sW8RhYrJZ1/DAvNr9nAFb5N2QrdmPgaD1/51V2R3Oc2M5
         4JSjqZQAsd+Ss3GDdMJoEPIuDNkdvFOzpc222fcM/EhXyoxrHdZl+bcrqKhb3IoHjjmk
         XQfHM6d95nts0V5Lo5/Zn7+uX+M0Qq1/53NK5LM62BqbRnif39q/O+EM7n0+iU8ahDcW
         4MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGeMotmHD5kcwokKadCBWqHPNlO0Qvs0CVZPqUnOIwU=;
        b=QHOvwGS03r3OU31I0zO8Lwd3rLzWWxQTD7dBWQEGSHANSe7kH5zxIcKymmrN8KOwJB
         kkKCBk/frplDg+ZUcPcBGBbXG0TwLzKl14WG13swVyImaILuCs14p1d3/xgX0dBlfa6y
         rSODZ79OBmfTk8sxjHy5E24IlaVGPVqkPArCNz+2XVsj/4CBajtky1o8DwWVdQ8IoaM4
         VNRCEs6oV+MuRtkiRUn5z9PCbLuYwGkymH/o+FNl75ZiyUJ3J4ol9di/ThSXzgXS5tKi
         /bZoYAvW+gAY9ntM+QPRyhVWdftoBloO+XdRArpXdKHs6OMWjmb3rRskcNVOxY+gEQnY
         pSWw==
X-Gm-Message-State: AOAM531OTBWNmUlbiQzUq8cgX4clumTGIn3iYpzEF6Z6WXhFLqkH3XHH
        /kE1Wtjw2qXkqCIG2oAAlZFAKRg54rnGJKVFjYY=
X-Google-Smtp-Source: ABdhPJxM/y4CWGrksx4gNScQ00GELDhe/3yND60YFdXQhe2SiNRzSPQjRttu0dMdsWj00S1f+XPDEvscDu7F5r9UUA0=
X-Received: by 2002:a05:600c:3843:b0:397:476f:ceb8 with SMTP id
 s3-20020a05600c384300b00397476fceb8mr234025wmr.200.1653534950360; Wed, 25 May
 2022 20:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210728010632.2633470-1-robdclark@gmail.com> <20210728010632.2633470-13-robdclark@gmail.com>
 <84e03c5f-a3af-6592-d19a-a2f5d20b92fb@linux.intel.com> <CAJs_Fx6Nc337LPNh=p2GT2d2yDTdLWH934o4Cof3urDGhUJB6A@mail.gmail.com>
 <904ae104-1c30-d130-129f-ccae381261d5@linux.intel.com> <CAF6AEGuVhXuX63Od+kcJ0QtfAZ2-wqZsN0KOuEzKbivJdouzog@mail.gmail.com>
 <1972f50b-d71a-9e2e-d10b-cc4f13bb208f@linux.intel.com>
In-Reply-To: <1972f50b-d71a-9e2e-d10b-cc4f13bb208f@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 25 May 2022 20:15:47 -0700
Message-ID: <CAF6AEGsvmQYjzoFgEMTer3oDmb62y2Hq_unDbq2UEoZ6CA3CSw@mail.gmail.com>
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

On Wed, May 25, 2022 at 9:11 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 24/05/2022 15:57, Rob Clark wrote:
> > On Tue, May 24, 2022 at 6:45 AM Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> >>
> >> On 23/05/2022 23:53, Rob Clark wrote:
> >>>
> >>> btw, one fun (but unrelated) issue I'm hitting with scheduler... I'm
> >>> trying to add an igt test to stress shrinker/eviction, similar to the
> >>> existing tests/i915/gem_shrink.c.  But we hit an unfortunate
> >>> combination of circumstances:
> >>> 1. Pinning memory happens in the synchronous part of the submit ioctl,
> >>> before enqueuing the job for the kthread to handle.
> >>> 2. The first run_job() callback incurs a slight delay (~1.5ms) while
> >>> resuming the GPU
> >>> 3. Because of that delay, userspace has a chance to queue up enough
> >>> more jobs to require locking/pinning more than the available system
> >>> RAM..
> >>
> >> Is that one or multiple threads submitting jobs?
> >
> > In this case multiple.. but I think it could also happen with a single
> > thread (provided it didn't stall on a fence, directly or indirectly,
> > from an earlier submit), because of how resume and actual job
> > submission happens from scheduler kthread.
> >
> >>> I'm not sure if we want a way to prevent userspace from getting *too*
> >>> far ahead of the kthread.  Or maybe at some point the shrinker should
> >>> sleep on non-idle buffers?
> >>
> >> On the direct reclaim path when invoked from the submit ioctl? In i915
> >> we only shrink idle objects on direct reclaim and leave active ones for
> >> the swapper. It depends on how your locking looks like whether you could
> >> do them, whether there would be coupling of locks and fs-reclaim context.
> >
> > I think the locking is more or less ok, although lockdep is unhappy
> > about one thing[1] which is I think a false warning (ie. not
> > recognizing that we'd already successfully acquired the obj lock via
> > trylock).  We can already reclaim idle bo's in this path.  But the
> > problem with a bunch of submits queued up in the scheduler, is that
> > they are already considered pinned and active.  So at some point we
> > need to sleep (hopefully interruptabley) until they are no longer
> > active, ie. to throttle userspace trying to shove in more submits
> > until some of the enqueued ones have a chance to run and complete.
>
> Odd I did not think trylock could trigger that. Looking at your code it
> indeed seems two trylocks. I am pretty sure we use the same trylock
> trick to avoid it. I am confused..

The sequence is,

1. kref_get_unless_zero()
2. trylock, which succeeds
3. attempt to evict or purge (which may or may not have succeeded)
4. unlock

 ... meanwhile this has raced with submit (aka execbuf) finishing and
retiring and dropping *other* remaining reference to bo...

5. drm_gem_object_put() which triggers drm_gem_object_free()
6. in our free path we acquire the obj lock again and then drop it.
Which arguably is unnecessary and only serves to satisfy some
GEM_WARN_ON(!msm_gem_is_locked(obj)) in code paths that are also used
elsewhere

lockdep doesn't realize the previously successful trylock+unlock
sequence so it assumes that the code that triggered recursion into
shrinker could be holding the objects lock.

>
> Otherwise if you can afford to sleep you can of course throttle
> organically via direct reclaim. Unless I am forgetting some key gotcha -
> it's been a while I've been active in this area.

So, one thing that is awkward about sleeping in this path is that
there is no way to propagate back -EINTR, so we end up doing an
uninterruptible sleep in something that could be called indirectly
from userspace syscall.. i915 seems to deal with this by limiting it
to shrinker being called from kswapd.  I think in the shrinker we want
to know whether it is ok to sleep (ie. not syscall trigggered
codepath, and whether we are under enough memory pressure to justify
sleeping).  For the syscall path, I'm playing with something that lets
me pass __GFP_RETRY_MAYFAIL | __GFP_NOWARN to
shmem_read_mapping_page_gfp(), and then stall after the shrinker has
failed, somewhere where we can make it interruptable.  Ofc, that
doesn't help with all the other random memory allocations which can
fail, so not sure if it will turn out to be a good approach or not.
But I guess pinning the GEM bo's is the single biggest potential
consumer of pages in the submit path, so maybe it will be better than
nothing.

BR,
-R

>
> Regards,
>
> Tvrtko
>
> >
> > BR,
> > -R
> >
> > [1] https://gitlab.freedesktop.org/drm/msm/-/issues/14
> >
