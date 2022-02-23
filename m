Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1934C09D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiBWDC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiBWDCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:02:47 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9984198A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:02:20 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v186so45286277ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3dhHi9t8HBjtBlHg2OtAeNoMJdDzLs31EyU7LsN2Xo=;
        b=YkhxkNc1YtwscsTW86DVOSr9MuvVovvaRIQhTfomX0gsLgtKjkM2QEdVmQ2N3ZWTpg
         YCaaaijoQZsOPxYSC33IovBSRfFWapVKkgsCuYVEF8jre0tGThGtCCryN2MDNTNQ9qxM
         ZXe2Y0+zI1NLB6d4v6tDAK3CbjNJJtD3A/OwQkHa8G3AvqIHBXFssOEXjNJVRkNXOW8I
         IUG+wTH6awpg9Ecej60wlLM5NvukbQGh3CyCSboGE//onpkTEQF6YrthfTah6tjBs0t5
         pjVR3gjA695MnDaYtgnI+GWBlCDrf3ohf/auzYmPalpbGfJWoM7ms6NuO13hux5jDlIw
         0hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3dhHi9t8HBjtBlHg2OtAeNoMJdDzLs31EyU7LsN2Xo=;
        b=7t/+QFpCEN5xSHii6a1Qw3sxPsWm0lcJ6+KoKfzJqtGeLqbBqVIqUOcICSQCI5XAW1
         nyvFwqrYSOTW45KAt52oL06AlQ1/EA2xCR1lInteBgWaVBT14rzNbSrsxu/qXzdJ9Uif
         cOne2H3BTbVxPHH+hhkbxiGvFcL3AslPwpqR8m56Vw4eruGONAGLyMAGFA0lhknSw8It
         wbxXcdG/dNWYfSHhlO1uMHo9PSHTJzJ1fgzJfZeXF3q+8FOUxscHQNBkiR+I5/6QjYsh
         6C+jTQcj4y2gguydu2lcoTlFZt6l5bC37ldxm5WtlaS4qnOpmYqdIL8CY+S2PihsVEAt
         IhzQ==
X-Gm-Message-State: AOAM533FNW+iQBxbYlPk9OxMKI7AbrhejIkK7PXgTjiqy7QUUddzXz4M
        uaoVQelyeM3jNjXRfpGXUkiBz60VEkmkf7wZnHhx/Q==
X-Google-Smtp-Source: ABdhPJyrRtAgfBrnIRae0Z5tJg6jdr50fW+RSI2quI4+iL7VhCHvyOFfeexPvlHR6geAie0W3sT9W7CH8Ob/QjY+oUM=
X-Received: by 2002:a25:da47:0:b0:61d:9af4:c834 with SMTP id
 n68-20020a25da47000000b0061d9af4c834mr26964665ybf.441.1645585339250; Tue, 22
 Feb 2022 19:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <20220222054025.3412898-2-surenb@google.com>
 <YhSqDvSTN7nbz4C9@dhcp22.suse.cz> <CAJuCfpHr78By6p5sMhJZ3UohKXXSeA7Dxm_q-OA4y6KYL0L_pQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHr78By6p5sMhJZ3UohKXXSeA7Dxm_q-OA4y6KYL0L_pQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Feb 2022 19:02:08 -0800
Message-ID: <CAJuCfpFkwZAw-qcD6E5SchHNXf8MmzyWtuWaHOpFhid3m5bg8A@mail.gmail.com>
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

On Tue, Feb 22, 2022 at 7:56 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Feb 22, 2022 at 1:17 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 21-02-22 21:40:24, Suren Baghdasaryan wrote:
> > > A deep process chain with many vmas could grow really high.
> >
> > This would really benefit from some numbers. With default
> > sysctl_max_map_count (64k) and default pid_max (32k) the INT_MAX could
> > be theoretically reached but I find it impractical because not all vmas
> > can be anonymous same as all available pids can be consumed for a
> > theoretical attack (if my counting is proper).
> > On the other hand any non-default configuration with any of the values
> > increased could hit this theoretically.
>
> re: This would really benefit from some numbers
> Should I just add the details you provided above into the description?
> Would that suffice?

Hmm. According to the defaults you posted, with max number of
processes being 32k and max number of vmas per process 64k, the max
number of vmas in the system is 2147450880. That's 32767 less than
REFCOUNT_MAX=INT_MAX (2147483647) and 1073774592 less than
REFCOUNT_SATURATED (3221225472). So with those defaults we should
never hit these limits. Are we adding this protection for systems that
set non-default higher limits or am I miscalculating something?

>
> >
> > > kref
> > > refcounting interface used in anon_vma_name structure will detect
> > > a counter overflow when it reaches REFCOUNT_SATURATED value but will
> > > only generate a warning about broken refcounting.
> > > To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
> > > sharing when the refcount reaches INT_MAX, which still leaves INT_MAX/2
> > > values before the counter reaches REFCOUNT_SATURATED. This should provide
> > > enough headroom for raising the refcounts temporarily.
> > >
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/mm_inline.h | 18 ++++++++++++++----
> > >  mm/madvise.c              |  3 +--
> > >  2 files changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index 70b619442d56..b189e2638843 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -156,15 +156,25 @@ static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
> > >
> > >  extern void anon_vma_name_put(struct anon_vma_name *anon_name);
> > >
> > > +static inline
> > > +struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
> > > +{
> > > +     /* Prevent anon_name refcount saturation early on */
> > > +     if (kref_read(&anon_name->kref) < INT_MAX) {
> >
> > REFCOUNT_MAX seems to be defined by the kref framework.
>
> Ah, indeed. I missed that. Will change to use it.
>
> >
> > Other than that looks good to me.
>
> Thanks for the review!
>
> >
> > > +             anon_vma_name_get(anon_name);
> > > +             return anon_name;
> > > +
> > > +     }
> > > +     return anon_vma_name_alloc(anon_name->name);
> > > +}
> > > +
> > >  static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> > >                                    struct vm_area_struct *new_vma)
> > >  {
> > >       struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
> > >
> > > -     if (anon_name) {
> > > -             anon_vma_name_get(anon_name);
> > > -             new_vma->anon_name = anon_name;
> > > -     }
> > > +     if (anon_name)
> > > +             new_vma->anon_name = anon_vma_name_reuse(anon_name);
> > >  }
> > >
> > >  static inline void free_vma_anon_name(struct vm_area_struct *vma)
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index f81d62d8ce9b..a395884aeecb 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -122,8 +122,7 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
> > >       if (anon_vma_name_eq(orig_name, anon_name))
> > >               return 0;
> > >
> > > -     anon_vma_name_get(anon_name);
> > > -     vma->anon_name = anon_name;
> > > +     vma->anon_name = anon_vma_name_reuse(anon_name);
> > >       anon_vma_name_put(orig_name);
> > >
> > >       return 0;
> > > --
> > > 2.35.1.473.g83b2b277ed-goog
> >
> > --
> > Michal Hocko
> > SUSE Labs
