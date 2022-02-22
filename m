Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0E4BFDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiBVP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBVP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:57:31 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEABF52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:57:05 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so42102076ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iDZ9H8inY+NDZ0HYQKmVnQ5HPOpNxH9x5TSVqE2tPM=;
        b=QSq82TnQ0nQE6N8kyjOuBwFCSTCmC32PZVhG9xE5SXdbwJuXbp8Q5uVYD/zKSnlfbL
         e+atEsS1GffladQeVh1ubCQ5owgNiqkgzMeRSr2NLa6BxM2AIARh7B7IAw5pFty4wwSd
         nEanN79Fi42rtZnhSwUUnGbO5qXAn0Pi0870dO6q42s60xze1hlXSBQN3jaYvZhub4kO
         M0ZZ20Yx8gF69hEqMNzge1OyOKf6pNtuokqTZ/fXZNGpH19nFH8OMdjSpH1EX+HXFG7n
         SFPbkFBXIS5ulX+AbygzCntKyYtHZJnsWRfgWWluXmdSxC/GqdUsyih3fDwZAMTZpZbR
         TNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iDZ9H8inY+NDZ0HYQKmVnQ5HPOpNxH9x5TSVqE2tPM=;
        b=Kap1SMjVmIOSUReSiqo/k0fsR3WaIXGMK1+l9KXB9HcklsBbTuKvucHwO0Nua5tb2X
         vD5cvl3+Lw2PljFrBgc/01MGNMysfXd/59GcFG4X90AtaL2L03Dc9Nnw02SY7rMpM1N2
         X8zViRy46oXb/kHflF9grsQIZmV6BspF/KFmC85yvrkrZfoaPJqrOWuDE29H4YqDvkM5
         oUvUuZk461g8cpLTAeRGLtDeXH8vQ9Xaq3cR69AhJHRJGlrWNSm61ZY7vJIO+ic1ko1E
         7KdMVFNk1GMi2FqNE7FaKfeecL6pighX+MltHxafk7Q8DkwJtfkidT5hnGTKbjO8VuNk
         cvRw==
X-Gm-Message-State: AOAM532LCJ7sOq6FY5OeuR6EdSHdXs4CCUxVU8VqCEA59wyf6f1S7T8f
        Pe0a5GrvlWGAhLdr3T/tdwiVWDrBG2LwvJOAWhkg3A==
X-Google-Smtp-Source: ABdhPJzsG2l5hbH/rvKMzmec8uK19VoBN6hBM7s2DgZKr/9BsfAxIoyNXShwzMmISOUmqF/VOKKxsrcDrM5jrEgLCY8=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr17039255ybm.348.1645545424324; Tue, 22
 Feb 2022 07:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <20220222054025.3412898-2-surenb@google.com>
 <YhSqDvSTN7nbz4C9@dhcp22.suse.cz>
In-Reply-To: <YhSqDvSTN7nbz4C9@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Feb 2022 07:56:53 -0800
Message-ID: <CAJuCfpHr78By6p5sMhJZ3UohKXXSeA7Dxm_q-OA4y6KYL0L_pQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: prevent vm_area_struct::anon_name refcount saturation
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Feb 22, 2022 at 1:17 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-02-22 21:40:24, Suren Baghdasaryan wrote:
> > A deep process chain with many vmas could grow really high.
>
> This would really benefit from some numbers. With default
> sysctl_max_map_count (64k) and default pid_max (32k) the INT_MAX could
> be theoretically reached but I find it impractical because not all vmas
> can be anonymous same as all available pids can be consumed for a
> theoretical attack (if my counting is proper).
> On the other hand any non-default configuration with any of the values
> increased could hit this theoretically.

re: This would really benefit from some numbers
Should I just add the details you provided above into the description?
Would that suffice?

>
> > kref
> > refcounting interface used in anon_vma_name structure will detect
> > a counter overflow when it reaches REFCOUNT_SATURATED value but will
> > only generate a warning about broken refcounting.
> > To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
> > sharing when the refcount reaches INT_MAX, which still leaves INT_MAX/2
> > values before the counter reaches REFCOUNT_SATURATED. This should provide
> > enough headroom for raising the refcounts temporarily.
> >
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm_inline.h | 18 ++++++++++++++----
> >  mm/madvise.c              |  3 +--
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 70b619442d56..b189e2638843 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -156,15 +156,25 @@ static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
> >
> >  extern void anon_vma_name_put(struct anon_vma_name *anon_name);
> >
> > +static inline
> > +struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
> > +{
> > +     /* Prevent anon_name refcount saturation early on */
> > +     if (kref_read(&anon_name->kref) < INT_MAX) {
>
> REFCOUNT_MAX seems to be defined by the kref framework.

Ah, indeed. I missed that. Will change to use it.

>
> Other than that looks good to me.

Thanks for the review!

>
> > +             anon_vma_name_get(anon_name);
> > +             return anon_name;
> > +
> > +     }
> > +     return anon_vma_name_alloc(anon_name->name);
> > +}
> > +
> >  static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> >                                    struct vm_area_struct *new_vma)
> >  {
> >       struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
> >
> > -     if (anon_name) {
> > -             anon_vma_name_get(anon_name);
> > -             new_vma->anon_name = anon_name;
> > -     }
> > +     if (anon_name)
> > +             new_vma->anon_name = anon_vma_name_reuse(anon_name);
> >  }
> >
> >  static inline void free_vma_anon_name(struct vm_area_struct *vma)
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f81d62d8ce9b..a395884aeecb 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -122,8 +122,7 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
> >       if (anon_vma_name_eq(orig_name, anon_name))
> >               return 0;
> >
> > -     anon_vma_name_get(anon_name);
> > -     vma->anon_name = anon_name;
> > +     vma->anon_name = anon_vma_name_reuse(anon_name);
> >       anon_vma_name_put(orig_name);
> >
> >       return 0;
> > --
> > 2.35.1.473.g83b2b277ed-goog
>
> --
> Michal Hocko
> SUSE Labs
