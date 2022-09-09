Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F75B2B19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIIA1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIIA1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:27:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5950B6D7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:27:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y82so420478yby.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=KtLw4C6VhVX+NvaGxIgELiy/zqMzxZXxqnnlbY2OKmo=;
        b=crQ36UMHUqt61smHrlkBEpUd9i45+PgLY5J9fqfxhS5xFt+dCvkP4on4PdtNki3lCz
         jM3i4We244MxzTcElsXWAr4ziy26d4HtGs1NYCrV4xa+QMChQpVMk4+s4kWhnDii1Pkq
         yYzeKV/nWRkdftx9rY3IB4MT+wQ9wCh094Kp0vVZXw/48yA0cwlfWhLtGuaSLY8c5re5
         9AGxg9RjHE2y5qcsqP3sIfonr94qxE4z65S4RNPfz7z+epLJQ9CDfp8pOawXS7ODD5Rs
         kWyWoTv5WYqA6M7n+wk8eECV/QUIZsewZkXxm5axMe5CRivTrrka1Y3sdLZZWgIumVtu
         oYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KtLw4C6VhVX+NvaGxIgELiy/zqMzxZXxqnnlbY2OKmo=;
        b=twjpj6MZt5aLANjzktRVQJrH5aKfcdY8ec+QAlTQ/TZjI575KK7KKByRNx6AU3oxJC
         2JVaNohJSKPa9Xgvmno6UBKUlR4CSWAVr/Wt5v0KsOFIe0xJhavVwEgF/ei4ISfhX7Z1
         fCCKngVq7LdvcoXxeBj4qmgbJ0ZgPoLE1HNvnGtdQVnM7YPfl4cngWKh86EkmdBucxVv
         4jLUfWVffBKYTJT1K6hWntYPsc8710gaHcXCXOl0avDqo6D1hOR0yfDI3Mdmv8w5Jd2E
         8gjyyFZlneufAKN4NxlAgLcywZq4LfuYGMmppDJdTaku1Y94PiUdM+NYmsd0P5nJOUoS
         A+Zw==
X-Gm-Message-State: ACgBeo3DotKjWBsdXmuzFdjH9MTPh79C+HOzLMKIsfkaZS4zIl+98nXZ
        n5j2Jr8RGocgUCeyC16NzpQVnBvYVEylv0oasQNoLA==
X-Google-Smtp-Source: AA6agR6FKEIXt4Le+vLLG6frjvQmxHhi7IpkWph1Sqqg5DDpP37KZzCFD7SHe2MzUi799BfLdccL/mK6LPn2rgcWHb8=
X-Received: by 2002:a05:6902:2d0:b0:694:d257:4c4b with SMTP id
 w16-20020a05690202d000b00694d2574c4bmr9751150ybh.316.1662683237776; Thu, 08
 Sep 2022 17:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-10-surenb@google.com>
 <98d5f462-c4dc-a967-0ab0-f24dd3e37dff@linux.ibm.com>
In-Reply-To: <98d5f462-c4dc-a967-0ab0-f24dd3e37dff@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Sep 2022 17:27:06 -0700
Message-ID: <CAJuCfpFoJmiGYXBLwOjW36iB302=V2_vvbRwQbftr_ix_92uuQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 09/28] mm/mempolicy: mark VMA as locked when
 changing protection policy
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 6, 2022 at 7:48 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > Protect VMA from concurrent page fault handler while performing VMA
> > protection policy changes.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mempolicy.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index b73d3248d976..6be1e5c75556 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -383,8 +383,10 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask=
_t *new)
> >       struct vm_area_struct *vma;
> >
> >       mmap_write_lock(mm);
> > -     for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> > +     for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +             vma_mark_locked(vma);
> >               mpol_rebind_policy(vma->vm_policy, new);
> > +     }
> >       mmap_write_unlock(mm);
> >  }
> >
> > @@ -632,6 +634,7 @@ unsigned long change_prot_numa(struct vm_area_struc=
t *vma,
> >       struct mmu_gather tlb;
> >       int nr_updated;
> >
> > +     vma_mark_locked(vma);
>
> If I understand that corretly, the VMA itself is not impacted, only the
> PMDs/PTEs, and they are protected using the page table locks.
>
> Am I missing something?

I thought we would not want pages faulting in the VMA for which we are
changing the protection. However I think what you are saying is that
page table locks would already provide a more granular synchronization
with page fault handlers, which makes sense to me. Sounds like we can
skip locking the VMA here as well. Nice!

>
> >       tlb_gather_mmu(&tlb, vma->vm_mm);
> >
> >       nr_updated =3D change_protection(&tlb, vma, addr, end, PAGE_NONE,
> > @@ -765,6 +768,7 @@ static int vma_replace_policy(struct vm_area_struct=
 *vma,
> >       if (IS_ERR(new))
> >               return PTR_ERR(new);
> >
> > +     vma_mark_locked(vma);
> >       if (vma->vm_ops && vma->vm_ops->set_policy) {
> >               err =3D vma->vm_ops->set_policy(vma, new);
> >               if (err)
>
