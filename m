Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6125B4B778C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbiBOUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiBOUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:47:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58B1106
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:47:09 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v63so32749104ybv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T41ePHFV0yFOOsXNClLAtA/x+o8KEy6AoDggp2srYzE=;
        b=fr6oWxoTzDtbYvaxIXq0fUxpvVr0x04DUX5wLQBL8LKzXgQVWGbjoar2jjdjM5S1DV
         1urfngwM9WhtMp3MY6OKMFOt6Jo2o0gZx6M32xFP8vkPMdtbyN9ggBMfIarNp+JgPFUg
         qWOq0wn8fOMEv15+6TItR2l2a83yNtoGiWl5M8ceFQsEB9Rlearzj25BbwVcYKEZHQAh
         +m/MIN5TkqRXbquBnmVjQot2oXFVaFCpQjQWFYIZffzxrPF+N/DKFyiIRLnHadLWes7Y
         zxm+yrUYvmVyrzBotDtotfADyjAF43d2qPAYPrliG1q/RQOf+PQOJ/nmxg3lTPexDb5e
         voAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T41ePHFV0yFOOsXNClLAtA/x+o8KEy6AoDggp2srYzE=;
        b=QHF7BBOBOufG4/IoO1fisl8Jr0i0PUE4DLEYIpWx2q7gDfURvhNZAhXUpsFGzQSE1w
         cxbJkYoWvnvBG61mzpgkGl6m8hUkmoVUNZmkeOM46HSAz+StAFxc/8NOdMbxgVqm0IQK
         B3p7KohRybM/n4LuD0WoAwT91H9Zq1qc97TOIUTwA9LMOWMV/JJkfl4dW2i4O7ou6jxg
         aTkOtEX+sKYZVDpkyV6p6jdE2Z5BiCHDDx4aDJT3hDV24KXIpRbkkxWEVk6axZDmC5Tp
         Kv77RHbxhP2bBUH0X3t1v/diYmmJsc5fDZ2CBghCYZBq2dXbrzK97ivPaqN3tsS/7bik
         GBoQ==
X-Gm-Message-State: AOAM532Pg5af7ToMzYe7CwD7/dF3xRvn5vPIoGI3SW9CmmavRB3M1ifS
        ip0z8wk4aFbLgz1ihYOvfWzQUvYuRlpP3bf8vlxBlA==
X-Google-Smtp-Source: ABdhPJwmdsuGjYfrOBPnDQhg/eRtU1Bu9W51ZB3QJAQWKMXfxyjW5ctW4UNISdKp6Akvl97iJFnpc7j/a/gdYJyxd2U=
X-Received: by 2002:a25:d212:: with SMTP id j18mr720145ybg.243.1644958028195;
 Tue, 15 Feb 2022 12:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <20220215123741.8e757b337e1f2d32a1766d42@linux-foundation.org>
 <CAJuCfpHwHRodo00gR=5=p+gvp60T+s04=5XBnCc9xsTOZCSE1Q@mail.gmail.com>
In-Reply-To: <CAJuCfpHwHRodo00gR=5=p+gvp60T+s04=5XBnCc9xsTOZCSE1Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 12:46:57 -0800
Message-ID: <CAJuCfpE6sFMmfzjeMVDRp35eUro1dbOhHS86gj6Xce7mwuYeEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
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

On Tue, Feb 15, 2022 at 12:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Feb 15, 2022 at 12:37 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > > otherwise it points to a vma that was freed and when reused leads to
> > > a use-after-free bug.
> > >
> > > ...
> > >
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > >               vma = remove_vma(vma);
> > >               cond_resched();
> > >       }
> > > +     mm->mmap = NULL;
> > >       mmap_write_unlock(mm);
> > >       vm_unacct_memory(nr_accounted);
> > >  }
> >
> > https://lore.kernel.org/all/00000000000072ef2c05d7f81950@google.com/
> >
> > It would be nice to have a Fixes: for this.
>
> Oh, right. Should be:
>
> Fixes: 64591e8605d6 ("mm: protect free_pgtables with mmap_lock write
> lock in exit_mmap")

Andrew, do you want me to post another version with Fixes:
64591e8605d6 ("mm: protect free_pgtables with mmap_lock write lock in
exit_mmap") added or you can add it directly?


>
> >
> > Is it specific to process_mrelease(), or should we backport further?
>
> The broken change is recent and was introduced in v5.17-rc1.
