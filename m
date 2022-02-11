Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313764B1B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbiBKBdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:33:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiBKBdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:33:12 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE35582
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:33:12 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so20832260ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GxQrdaGBPDuxmmmn6awLxXmdKGbQSbctZ4L8eSniqE=;
        b=XVBbuIogdAtT2RcD3LdyEwqn+DMMAVTKAlHtjcPSagoYO2bQpF5/3Pwt9jSh7iDEpq
         CG3ZUDgCxDMTbYEn+Mx3k0qmo3HtAqy1U0BuzGA7qH5XGbiq6StWARdccws83om0fnqR
         OVE9zuCt5OMNnNWm5czlswjzSkQgsPkbPCc7lVzDj/9hKoJ9axlyEy7HmkRhd+dsVK5I
         Z3sCjcEsr91KtepWjHP2hGyEHJrQ6wWXJnC4UQGsm8ITDmgQaSz1BpnB1NC/3DXTw3lw
         1mybzWR8ABWJ+mWbrBQz15V5H5U0rWlG+dyE42fXAerDaIUJ+8C5sXUkXGBlzHx72EMB
         Iiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GxQrdaGBPDuxmmmn6awLxXmdKGbQSbctZ4L8eSniqE=;
        b=0YIHhO7Ua/ySCW0xnpXGSX87kKlXB3vozustL48uDZ5LnyBj1nTRoc0SzYLnnW9lRu
         gmZu512DVKsdgiAmsVRqyf3x5LM8nUmCq2azgBTPpSZ3jQf1c7CD1n+jsDgWeFTWyDbv
         RkwdbZhShinoE9HzSCHsMCJbULyWGpg9JuifRUm0upNsYckAc56eG2UtGeSjCuilfeMQ
         T7khHo+n0ZTUpdI3eKt0t+rO8ScQ7arXWGgD+hUWlYqYpfNeR/8pB3yFZc7SLWBqD9Ye
         kNewQb6Pgp5sdmmaQdd1gPuKXdUX2tVROrjKMMn6kPgPXAMLZDZcHLEkytnNh4QXCLjV
         Mvcw==
X-Gm-Message-State: AOAM533sl4BI9OsrNyAveZn/qXvMD0x5Zb5Jd2QHOzLOP0O95u8cERAz
        BmWEiDcI/Hvf1r/2wZYT9lxI1iVBmhdZK6GL0IOjFA==
X-Google-Smtp-Source: ABdhPJwjq+GwW3DeD2qB1rO02A6XTTi8Mv9CAwCoEolQhjbTPfAnZ6ISJx8L8JI/dPtRihoxgfO9gb/FtAhfeKf0xcQ=
X-Received: by 2002:a25:6a55:: with SMTP id f82mr9393142ybc.1.1644543191406;
 Thu, 10 Feb 2022 17:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20220210043215.42794-1-surenb@google.com> <YgUHzSqltDp2dr70@dhcp22.suse.cz>
 <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com>
 <YgUu0prRt3iu1Cpy@casper.infradead.org> <CAJuCfpHPZNbK2rd95pZAWr0d3vACGzHdiAFv=bM-G8nC+YdYwg@mail.gmail.com>
 <YgVo5HrAhoeoix7a@casper.infradead.org> <CAJuCfpHX22MaU8S0otoRiq8EdLGcdnYFNyxDmp4FZB_eM_+hdg@mail.gmail.com>
In-Reply-To: <CAJuCfpHX22MaU8S0otoRiq8EdLGcdnYFNyxDmp4FZB_eM_+hdg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Feb 2022 17:33:00 -0800
Message-ID: <CAJuCfpHFMJR=X=HY-=go6W85jXgKzaL5+A+gQh_sDBxYJ7J69g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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

On Thu, Feb 10, 2022 at 11:52 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Feb 10, 2022 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 10, 2022 at 08:00:15AM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Feb 10, 2022 at 7:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Thu, Feb 10, 2022 at 07:18:24AM -0800, Suren Baghdasaryan wrote:
> > > > > On Thu, Feb 10, 2022 at 4:40 AM 'Michal Hocko' via kernel-team
> > > > > <kernel-team@android.com> wrote:
> > > > > >
> > > > > > On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> > > > > > > When adjacent vmas are being merged it can result in the vma that was
> > > > > > > originally passed to madvise_update_vma being destroyed. In the current
> > > > > > > implementation, the name parameter passed to madvise_update_vma points
> > > > > > > directly to vma->anon_name->name and it is used after the call to
> > > > > > > vma_merge. In the cases when vma_merge merges the original vma and
> > > > > > > destroys it, this will result in use-after-free bug as shown below:
> > > > > > >
> > > > > > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > > > > > >   madvise_update_vma(name)
> > > > > > >     vma_merge
> > > > > > >       __vma_adjust
> > > > > > >         vm_area_free <-- frees the vma
> > > > > > >     replace_vma_anon_name(name) <-- UAF
> > > > > > >
> > > > > > > Fix this by raising the name refcount and stabilizing it. Introduce
> > > > > > > vma_anon_name_{get/put} API for this purpose.
> > > > > >
> > > > > > What is the reason that madvise_update_vma uses the naked name rather
> > > > > > than the encapsulated anon_vma_name? This really just begs for problems.
> > > > >
> > > > > The reason for that is the second place it's being used from the prctl syscall:
> > > > >
> > > > > prctl_set_vma
> > > > >   madvise_set_anon_name
> > > > >     madvise_vma_anon_name
> > > > >       madvise_update_vma
> > > > >
> > > > > In that case the name parameter is not part of any anon_vma_name
> > > > > struct and therefore is stable. I can add a comment to
> > > > > madvise_update_vma indicating that the name parameter has to be stable
> > > > > if that helps.
> > > >
> > > > Seems to me it'd simplify things if replace_vma_anon_name() and
> > > > madvise_vma_anon_name() took a struct anon_vma_name instead of
> > > > a bare char *.  You could construct it in madvise_set_anon_name().
> > >
> > > Ok, this can be done. However I don't think changing
> > > replace_vma_anon_name() to accept a struct anon_vma_name would be a
> > > good idea. Reader might think that the object being passed will become
> > > the vma->anon_name of the vma, while in reality that's not the case.
> >
> > Why woud we not want that to be the case?  It's a refcounted name.
> > I don't see why it shouldn't be shared between multiple VMAs that
> > have the same name?
>
> You are right. After I reworked the code it became apparent that
> replace_vma_anon_name() should use anon_vma_name. I have made that
> change and am testing it now. Hopefully no new surprises pop up.

v3 is posted at
https://lore.kernel.org/all/20220211013032.623763-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
