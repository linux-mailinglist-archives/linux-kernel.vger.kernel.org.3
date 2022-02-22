Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171EA4BFD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiBVPoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:44:18 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13C836E09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:43:52 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id u12so28012461ybd.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqXD7typxRqGUARnaw7Pj7LwfkKcjOGLF1BV+v9Ov4A=;
        b=kMZdlDYteCJBNpP7EcodSyEFNNM33iTzouRYRZy4sNNvi8VL9QsFmswNh0yZFVFEka
         H1ljgT3YeKJwxPUeLB1K4HLbyoWYwaNtP99vdqN9PgWc95ewSWy2R3yWFAzO0+ryDjrc
         6ymKyHOrQy7YsjgJN19Hw1v9ZEoMVeY2ebjkmIU0C+neAlBxoGJ6tM7VyfzeYaLwo/BZ
         cZivrUi0SL6vZ4mgk0DL4umpMzIcnQAxNnL0BqXqKFJuAeykbT2iv9XptRpRGy029lAt
         8LCm6p606pKu3eaMboNMDBsb5Z0TQLMOwgCvg7hlimVYbONG9rLfsb/g8Y9KOuIHSq9P
         fH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqXD7typxRqGUARnaw7Pj7LwfkKcjOGLF1BV+v9Ov4A=;
        b=XVc+PylYRDL5Y25MEXNKz7SeM9qvY3pA3LR5xwgTDGgYIAoi+6u2AY1NwfxJLMaYv7
         m0hKoHMlVuoPTEPx8J8rWgSBbrBNoRHbkIn8B2c2DDz/ktVpbORLaNTb9JnB97KJP7Re
         pt7h63TJe/Gb3ztzIniZaDQND1BzpkphjYWgdZOMNgVt9UV2jr7C6V+0AMAK8hsXRvjS
         QHD5fCNHyOjrVB84mrEsisS1vaFcpmlSIYDiE2DIoPO5kEslPPABcMh2rOn66oALLoXb
         gln7Pxf3F5bS7Dt7aa4fD4d6ELcR6H73Ng1lpFj0csqMlQNkdfS4I80H8WMDNZqFvtkB
         9SZA==
X-Gm-Message-State: AOAM5310FNu2D6BT5WRbUsvjhEhFpAnmgZovadTgkr+T82/cNEJzdMLV
        4AHxAng3+RNH/kj4wEYsl4x+zyzrUYZpt3o+BhhxBg==
X-Google-Smtp-Source: ABdhPJy3N2oGtBnhBdp+zKpJljXWde4cxCC5OtRofJNJX4vcopfRezUgTy2sWe8nFNEYaQwaZhfaPsDeMZYnRh5bROg=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr23367040ybg.509.1645544631876;
 Tue, 22 Feb 2022 07:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <20220222054025.3412898-3-surenb@google.com>
 <YhSZhzUYlW6IAQT9@dhcp22.suse.cz>
In-Reply-To: <YhSZhzUYlW6IAQT9@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Feb 2022 07:43:40 -0800
Message-ID: <CAJuCfpELxJ=7uuurKL9oRn1E_=rfL3aN8Duhqvi4Z2c1xHAT2w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
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
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Tue, Feb 22, 2022 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-02-22 21:40:25, Suren Baghdasaryan wrote:
> > When adjacent vmas are being merged it can result in the vma that was
> > originally passed to madvise_update_vma being destroyed.  In the current
> > implementation, the name parameter passed to madvise_update_vma points
> > directly to vma->anon_name->name and it is used after the call to
> > vma_merge.  In the cases when vma_merge merges the original vma and
> > destroys it, this will result in use-after-free bug as shown below:
> >
> > madvise_vma_behavior << passes vma->anon_name->name as name param
> >   madvise_update_vma(name)
> >     vma_merge
> >       __vma_adjust
> >         vm_area_free <-- frees the vma
> >     replace_vma_anon_name(name) <-- UAF
>
> This seems to be stale because bare const char pointer is not passed in
> the call chain. In fact I am not even sure there is any actual UAF here
> after the rework.
> Could you be more specific in describing the scenario?

Yes, sorry, I need to update the part of the description talking about
passing vma->anon_name->name directly.
I think UAF is still there, it's just harder to reproduce (admittedly
I could not reproduce it with the previous reproducer). The scenario
would be when a vma with vma->anon_name->kref == 1 is being merged
with another one and freed in the process:

madvise_vma_behavior
   anon_name = vma_anon_name(vma) <-- does not increase refcount
   madvise_update_vma(anon_name)
     *prev = vma_merge <-- returns another vma
       __vma_adjust
         vm_area_free(vma)
           free_vma_anon_name
             anon_vma_name_put
               vma_anon_name_free <-- frees the vma->anon_name
     vma = *prev <-- original vma was freed
     replace_vma_anon_name(vma, >>anon_name<<) <-- UAF

Does this make sense or did I miss something?
Thanks,
Suren.

>
> > Fix this by raising the name refcount and stabilizing it.
> >
> > Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
> > ---
> > changes in v3:
> > - Reapplied the fix after code refactoring, per Michal Hocko
> >
> >  mm/madvise.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index a395884aeecb..00e8105430e9 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -140,6 +140,8 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
> >  /*
> >   * Update the vm_flags on region of a vma, splitting it or merging it as
> >   * necessary.  Must be called with mmap_sem held for writing;
> > + * Caller should ensure anon_name stability by raising its refcount even when
> > + * anon_name belongs to a valid vma because this function might free that vma.
> >   */
> >  static int madvise_update_vma(struct vm_area_struct *vma,
> >                             struct vm_area_struct **prev, unsigned long start,
> > @@ -1021,8 +1023,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >       }
> >
> >       anon_name = vma_anon_name(vma);
> > +     anon_vma_name_get(anon_name);
> >       error = madvise_update_vma(vma, prev, start, end, new_flags,
> >                                  anon_name);
> > +     anon_vma_name_put(anon_name);
> >
> >  out:
> >       /*
> > --
> > 2.35.1.473.g83b2b277ed-goog
>
> --
> Michal Hocko
> SUSE Labs
