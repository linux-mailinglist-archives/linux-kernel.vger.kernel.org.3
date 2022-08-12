Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4870E590DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiHLJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiHLJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:12:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C8A8314
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:12:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 123so559903ybv.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=45DlX2m161o/Gwf6jjpL+rTtdDNcNUjOyYHwEltA6sE=;
        b=DfJqfQf13dFDfKDEBILnoPos4S3eOqD4I/J5F0zBPLSWIzTKWdjLN86L6n05rKvBIA
         6nzFtmLGA9n/mjTr7mEbV1tjkrqS86Xz6kpNyhYtmQjw1pVpsk4xEt1w3Wci+EZtWFWz
         bzQ1keEBFA5Rar2W7y+RhomQt2lo8yqGo4fq+Q8VOW75secAgbaoTQi4WfwJzscLHyGW
         VMq18SI4bB763CBJl/7WU74jho+zmpU8VrR0qvcbuC5YMk68ElkfsRWq9s4R7oqwz10d
         dK5EnuzyTko5Zx3q8acpRKqG8Z9DbeR5JImhe75xgx3AGfxv5iiX21EpM6vmrAcdd0JX
         PZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=45DlX2m161o/Gwf6jjpL+rTtdDNcNUjOyYHwEltA6sE=;
        b=J0MJrpc8dW3Yh2SpF2LdHiOuTsrXVp+eLfWjc2mUNXr3SxrhAlNjY/HWywjkAsNOu7
         hgyrcOnm1ql9piGhBCxQoy3HMHnE9gKZj5l6YH0u/lTpDGqtzpVlcnZWi0xkyU3j/zrf
         jgwn/FsgG//J0Lolrwjrh3i7vZG8yLjw9OWSABmIrAMtfotSVEQoga1IyI4oSOHaVQBA
         BTL1UH9oUkhP3bhOt+WKnj1eiAX5xlyA7qJeZ6OYrBufHJBIvd5LqG/KtsjW8CqbyGHz
         HJDcPqLhN3uzpoR4KImJhIf+NFszUalRzeuQR+0SRZM9G1WlilcKlWRBKR7SPk2zoFDZ
         T4yg==
X-Gm-Message-State: ACgBeo130esjy1/Y9d6gOk6yIRG/3brOh3CV0MYkXuUgeHdq+WGUAt7g
        DCxbYyFqHEhXzmi9EHEobYIzVLTI8lCx5Gzr5xqOIA==
X-Google-Smtp-Source: AA6agR5shmgfDFtyuhUnV9CdH97dw/PbRq+Tofnexu1JDcDhkSkYb809/N5LdCRu5dVicBeuNaAcimvAobV8oKzMI0A=
X-Received: by 2002:a25:ad16:0:b0:671:75d9:6aad with SMTP id
 y22-20020a25ad16000000b0067175d96aadmr2562613ybi.143.1660295539457; Fri, 12
 Aug 2022 02:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
 <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz> <CANpmjNMYwxbkOc+LxLfZ--163yfXpQj69oOfEFkSwq7JZurbdA@mail.gmail.com>
 <6b41bb2c-6305-2bf4-1949-84ba08fdbd72@suse.cz> <CANpmjNNC3F88_Jr24DuFyubvQR2Huz6i3BGXgDgi5o_Gs0Znmg@mail.gmail.com>
 <26acafb0-9528-9b29-0b5d-738890853fca@oracle.com>
In-Reply-To: <26acafb0-9528-9b29-0b5d-738890853fca@oracle.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 12 Aug 2022 11:11:43 +0200
Message-ID: <CANpmjNOCFqHdNUQQJ_zzug06Miwqg6kQpCqM0ckhy6jXzX-bLQ@mail.gmail.com>
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     vbabka@suse.cz, glider@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
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

On Thu, 11 Aug 2022 at 17:10, Imran Khan <imran.f.khan@oracle.com> wrote:
>
> Hello Marco,
>
> On 11/8/22 11:21 pm, Marco Elver wrote:
> > On Thu, 11 Aug 2022 at 12:07, <vbabka@suse.cz> wrote:
> > [...]
> >>> new flag SLAB_SKIP_KFENCE, it also can serve a dual purpose, where
> >>> someone might want to explicitly opt out by default and pass it to
> >>> kmem_cache_create() (for whatever reason; not that we'd encourage
> >>> that).
> >>
> >> Right, not be able to do that would be a downside (although it should be
> >> possible even with opt-in to add an opt-out cache flag that would just make
> >> sure the opt-in flag is not set even if eligible by global defaults).
> >
> > True, but I'd avoid all this unnecessary complexity if possible.
> >
> >>> I feel that the real use cases for selectively enabling caches for
> >>> KFENCE are very narrow, and a design that introduces lots of
> >>> complexity elsewhere, just to support this feature cannot be justified
> >>> (which is why I suggested the simpler design here back in
> >>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/CANpmjNNmD9z7oRqSaP72m90kWL7jYH*cxNAZEGpJP8oLrDV-vw@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!Oh4PBJ1NoN9mEgqGqdaNcWuKtJiC6TS_rIbALuqZadQoo93jpVJaFFmXUpOTuzRUdCwcRJWE6uJ4pe0$
> >>> )
> >>
> >> I don't mind strongly either way, just a suggestion to consider.
> >
> > While switching the semantics of the flag from opt-out to opt-in is
> > just as valid, I'm more comfortable with the opt-out flag: the rest of
> > the logic can stay the same, and we're aware of the fact that changing
> > cache coverage by KFENCE shouldn't be something that needs to be done
> > manually.
> >
> > My main point is that opting out or in to only a few select caches
> > should be a rarely used feature, and accordingly it should be as
> > simple as possible. Honestly, I still don't quite see the point of it,
> > and my solution would be to just increase the KFENCE pool, increase
> > sample rate, or decrease the "skip covered threshold%". But in the
> > case described by Imran, perhaps a running machine is having trouble
> > and limiting the caches to be analyzed by KFENCE might be worthwhile
> > if a more aggressive configuration doesn't yield anything (and then
> > there's of course KASAN, but I recognize it's not always possible to
> > switch kernel and run the same workload with it).
> >
> > The use case for the proposed change is definitely when an admin or
> > kernel dev is starting to debug a problem. KFENCE wasn't designed for
> > that (vs. deployment at scale, discovery of bugs). As such I'm having
> > a hard time admitting how useful this feature will really be, but
> > given the current implementation is simple, having it might actually
> > help a few people.
> >
> > Imran, just to make sure my assumptions here are right, have you had
> > success debugging an issue in this way? Can you elaborate on what
> > "certain debugging scenarios" you mean (admin debugging something, or
> > a kernel dev, production fleet, or test machine)?
> >
>
> I have not used kfence in this way because as of now we don't have such newer
> kernels in production fleet but I can cite a couple of instances where using
> slub_debug for few selected slabs helped me in locating the issue on a
> production system where KASAN or even full slub_debug were not feasible.
> Apologies in advance if I am elaborating more than you asked for :).

This is very useful to understand the use case.

> In one case a freed struct mutex was being used later on and by that time same
> address had been given to a kmalloc-32 object. The issue was appearing more
> frequently if one would enforce some cgroup memory limitation resulting in fork
> of a task exiting prematurely. From the vmcore we could see that mutex or more
> specifically task_struct.futex_exit_mutex was in bad shape and eventually using
> slub_debug for kmalloc-32 pointed to issue.
>
> Another case involved a mem_cgroup corruption which was causing system crash but
> was giving list corruption warnings beforehand. Since list corruption warnings
> were coming from cgroup subsystem, corresponding objects were in doubt.
> Enabling slub_debug for kmalloc-4k helped in locating the actual corruption.
>
> Admittedly both of the above issues were result of backporting mistakes but
> nonetheless they happened in production systems where very few debugging options
> were available.
>
> By "certain debugging scenarios" I meant such cases where some initial data
> (from production fleet) like vmcore or kernel debug messages can give some
> pointer towards which slab objects could be wrong and then we would use this
> feature (along with further tuning like increasing sampling frequency, pool size
> if needed/possible) to pinpoint the actual issue. The idea is that limiting
> KFENCE to few slabs will increase the probablity of catching the issue even if
> we are not able to tweak pool size.
>
> Please let me know if it sounds reasonable or if I missed something from your
> query.

Thanks for the elaboration on use cases - agreed that in few scenarios
this feature can help increase the probability of debugging an issue.

Reviewed-by: Marco Elver <elver@google.com>

With minor suggestions:

> +SLAB_ATTR(skip_kfence);
> +

^ Unnecessary space between SLAB_ATTR and #endif.

> +#endif
> +

And the patch title should be something like "kfence: add sysfs
interface to disable kfence for selected slabs" (to follow format
"<subsys>: <thing changed>").
