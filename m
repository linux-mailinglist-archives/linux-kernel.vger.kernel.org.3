Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49944B0416
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiBJDsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:48:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBJDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:48:09 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B223BEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:48:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p5so11602888ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 19:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26LO++sGAEnTrwKspX8n5Js8aWWNBWjvhQH2G4UOuEk=;
        b=IWeHuyEeM7OuKImnXneHzgU17gcnqFrU5iCu5eOISxvZLLBhV10wT7a1MePqcRlmjK
         SwuqjEskw7pxo2CSZl25lFYMm+0s/Ys86uSty58yyVvoXrNahwbsZ1ZGzjjz0tE2IHVr
         4tlXhC+4EVRVCNS5yptxw7/W9QUlF0yi9KNy40Cd5ux9eOHz+BLvzpptdjuDtsfSNUgy
         MRHYJKUXENVm2l1UKDZaP3aU3D3jXZA7hmYVX1nYTHmMHZWrVejicsICXXeuSwTQZ6+B
         pEJWrTxXpw2BzdvF9+EjGKoLT+zhaH5RmY82EkjmtBl6QMxqzKUiXu0ycO+D2zxq0j5C
         ENDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26LO++sGAEnTrwKspX8n5Js8aWWNBWjvhQH2G4UOuEk=;
        b=3z6QtOuE4pZLu53Hz68A8fBwq7IX9Ihc6evEl3kHxl3DawuBUbcwH6g6uD+ETzPBih
         xP0BBYyguumxEsGnicUc5+P4ScgXJPZSrj/oNcrU3jAemu3Wx/+na6xTWUu/ZKeVjlvk
         kDPlBV2D9YughTNg/eYXuHDgc/W7HIbME7ZVsnFrsnvv3ZgdnWe+Iq+ehEJyZVrYMuwX
         imK+lyL/8CKwMUbNPvglJDFD20C2HL81J7Gnu5MLCy0OZLN/lCv0ze6bUyOxiUZTFwEe
         9HFMFDmfNHyd5M85j08zGaaZ4YTEM0+lCShNcoX0LtAIOx4Apikk9DuKdon/uYC68cgd
         Acuw==
X-Gm-Message-State: AOAM531EDPzLJ7AkY0TSwPWx1T5UEsKBY0DPaWGoGRctj1AbLJ1f4KoQ
        hqtlKmV+9w4ESh414td1pZGtc+xqLhTCEr1/kkezKQ==
X-Google-Smtp-Source: ABdhPJyhUAlXJoHLTcBJeZuXXmfwkIZnZvG4WVjC5LGwQnh+ocuYXOT6N3BMEltPCn7e4kZ43QvPOgO50id2WDMrNys=
X-Received: by 2002:a25:cb02:: with SMTP id b2mr5508689ybg.243.1644464890859;
 Wed, 09 Feb 2022 19:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20220210001801.15413-1-surenb@google.com> <20220209163324.bbf26e7462b217d453c5a34f@linux-foundation.org>
 <CAJuCfpGen2Rr1j20ROhh41_znhs40iJJzJ20BvXm0bqD2MOx9g@mail.gmail.com>
In-Reply-To: <CAJuCfpGen2Rr1j20ROhh41_znhs40iJJzJ20BvXm0bqD2MOx9g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Feb 2022 19:48:00 -0800
Message-ID: <CAJuCfpHLPLRYnhomHwPNk8X83dYOnRyE1aQjt6tf6BTGoEqTxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: Fix UAF when anon vma name is used after vma is freed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
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

. .

On Wed, Feb 9, 2022 at 5:02 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Feb 9, 2022 at 4:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  9 Feb 2022 16:18:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > When adjacent vmas are being merged it can result in the vma that was
> > > originally passed to madvise_update_vma being destroyed. In the current
> > > implementation, the name parameter passed to madvise_update_vma points
> > > directly to vma->anon_name->name and it is used after the call to
> > > vma_merge. In the cases when vma_merge merges the original vma and
> > > destroys it, this will result in use-after-free bug as shown below:
> > >
> > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > >   madvise_update_vma(name)
> > >     vma_merge
> > >       __vma_adjust
> > >         vm_area_free <-- frees the vma
> > >     replace_vma_anon_name(name) <-- UAF
> > >
> > > Fix this by passing madvise_update_vma a copy of the name.
> > >
> > > ...
> > >
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -2263,7 +2263,6 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > >
> > >  #ifdef CONFIG_ANON_VMA_NAME
> > >
> > > -#define ANON_VMA_NAME_MAX_LEN                80
> > >  #define ANON_VMA_NAME_INVALID_CHARS  "\\`$[]"
> > >
> > >  static inline bool is_valid_name_char(char ch)
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 5604064df464..f36a5a9942d8 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -976,6 +976,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> > >  {
> > >       int error;
> > >       unsigned long new_flags = vma->vm_flags;
> > > +     char name_buf[ANON_VMA_NAME_MAX_LEN];
> > > +     const char *anon_name;
> > >
> > >       switch (behavior) {
> > >       case MADV_REMOVE:
> > > @@ -1040,8 +1042,18 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> > >               break;
> > >       }
> > >
> > > +     anon_name = vma_anon_name(vma);
> > > +     if (anon_name) {
> > > +             /*
> > > +              * Make a copy of the name because vma might be destroyed when
> > > +              * merged with another one and the name parameter might be used
> > > +              * after that.
> > > +              */
> > > +             strcpy(name_buf, anon_name);
> > > +             anon_name = name_buf;
> > > +     }
> > >       error = madvise_update_vma(vma, prev, start, end, new_flags,
> > > -                                vma_anon_name(vma));
> > > +                                anon_name);
> >
> > anon_name is refcounted.  Why not use kref_get()/kref_put() instead of
> > taking a copy?
>
> Yes, I considered that. It would require new get/put APIs for
> anon_name and I thought I better keep it simple. This path is used
> only by madvise() syscall, so the copy overhead should not be
> critical. But if you think refcounting is more appropriate here I'll
> happily rework it. It should still be quite simple. Please let me
> know.

On second thought, we might have more places in the future we need to
stabilize anon_name, so put/get API can be useful. After prototyping
the refcounting approach it looks simple enough to use instead of
copying. Let me test it a bit and I'll post a replacement patch for
this one tomorrow.
Thanks,
Suren.

>
> >
