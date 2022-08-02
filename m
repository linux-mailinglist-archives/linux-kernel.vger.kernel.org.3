Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8697587A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiHBJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHBJtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:49:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF5DF67
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:49:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s204so15957877oif.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rd/MnnpubSXpiz2m3mizA1wFblV70cbg5nXLpi9fPUU=;
        b=LrhdbfLNPTzm+rQRir/KlWFTOP5w7dp2DeTugPU44Q7w9F+j2YfnKpe5cfHrw8ralE
         bKy5BBnIk/1WWdF3dgQ/lWnyvcFT5+dRorBjdP3noyEpgfJqKe3is9ZiFbMNycb6g6v4
         0MRYwfSDsPLWug/dc57YhUVLFQrhQPoRYD1AivLL9QUs4VTOvsIGmHWbj9nPBlkXwueu
         xbaByWeHnH7xrusROFoxFuJRrdZmKdaGTgZXL5zmSyG2yv642dN+zwJTVYzJLHRddndm
         CxXNmEiUPl7zFls9hvBpssresB7hZSjkLKunn8joVhzt1eroMR4WxIf8rps0sGG1CyLi
         54sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd/MnnpubSXpiz2m3mizA1wFblV70cbg5nXLpi9fPUU=;
        b=yl2NCi0PjNoZlVeYEXpes0ar5iiW9lijWPyrCQbRLzUUIK6L3M1qp+Lnk/ICAGVJnP
         QicV8e9NiWVxHd7s3DS6LygN2WTb9gl6fe3ititkbJASPQfbLugbF1nK2lwEEaApwiQj
         IBr286t368nGy37bIXF3fILhplv9j8/hdQEkWAxxV3LwDqh6A8YESjDGn//I2Qh8urCp
         28UVB2Q8ws7oXlpsyGtr27LeYxGesyYmvNqSe+fHdJbM9pTzQfPLM77owPXVQfgiLIkn
         X/ndBpkq3WcI5nVsmNeg7JLfmB5dvitc3C9U9kZSyFE+vumig8ZoWKtJvtwnn09KMtox
         x5Rw==
X-Gm-Message-State: AJIora8ZCjqk5GhD5w1KMWlyTW42zlOZbQltW1ZHcA4Uv2EdIos8cdSh
        mgEq6a1EVfT9No9KP2+2YvfZITpULJWUC3IA6GWuiQ==
X-Google-Smtp-Source: AGRyM1vYxPJcIwe5cHDHLSAcsh31y1ZP8mbEtq/TG7pxpHeW2mhAu3KJQQ6G4OsCSeCIaJ4nIBs3Y1UcxGw0e5uU3tU=
X-Received: by 2002:a05:6808:1446:b0:33a:c7e0:e88d with SMTP id
 x6-20020a056808144600b0033ac7e0e88dmr7690868oiv.123.1659433749236; Tue, 02
 Aug 2022 02:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220801210946.3069083-1-zokeefe@google.com> <YujpzGKImMQsn8SM@dhcp22.suse.cz>
In-Reply-To: <YujpzGKImMQsn8SM@dhcp22.suse.cz>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 2 Aug 2022 02:48:33 -0700
Message-ID: <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:09 AM Michal Hocko <mhocko@suse.com> wrote:
>
> Hasn't this been discussed during the MADV_COLLAPSE submission? What has
> changed? Does this need more time to settle with the consensus?
>
> On Mon 01-08-22 14:09:46, Zach O'Keefe wrote:
> > process_madvise(MADV_COLLAPSE) currently requires CAP_SYS_ADMIN when not
> > acting on the caller's own mm.  This is maximally restrictive, and
> > perpetuates existing issues with CAP_SYS_ADMIN.  Remove this requirement.
> >
> > When acting on an external process' memory, the biggest concerns for
> > process_madvise(MADV_COLLAPSE) are (1) being able to influence process
> > performance by moving memory, possibly between nodes, that is mapped
> > into the address space of external process(es), (2) defeat of
> > address-space-layout randomization, and (3), being able to increase
> > process RSS and memcg usage, possibly causing memcg OOM.
> >
> > process_madvise(2) already enforces CAP_SYS_NICE and PTRACE_MODE_READ (in
> > PTRACE_MODE_FSCREDS mode).  A process with these credentials can already
> > accomplish (1) and (2) via move_pages(MPOL_MF_MOVE_ALL), and (3) via
> > process_madvise(MADV_WILLNEED).
> >
> > process_madvise(MADV_COLLAPSE) may also circumvent sysfs THP settings.
> > When acting on one's own memory (which is equivalent to
> > madvise(MADV_COLLAPSE)), this is deemed acceptable, since aside from the
> > possibility of hoarding available hugepages (which is currently already
> > possible) no harm to the system can be done.  When acting on an external
> > process' memory, circumventing sysfs THP settings should provide no
> > additional threat compared to the ones listed.  As such, imposing
> > additional capabilities (such as CAP_SETUID, as a way to ensure the
> > caller could have just altered the sysfs THP settings themselves)
> > provides no extra protection.
> >
> > Fixes: 7ec952341312 ("mm/madvise: add MADV_COLLAPSE to process_madvise()")
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > ---
> >  mm/madvise.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f9e11b6c9916..af97100a0727 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1170,16 +1170,14 @@ madvise_behavior_valid(int behavior)
> >       }
> >  }
> >
> > -static bool
> > -process_madvise_behavior_valid(int behavior, struct task_struct *task)
> > +static bool process_madvise_behavior_valid(int behavior)
> >  {
> >       switch (behavior) {
> >       case MADV_COLD:
> >       case MADV_PAGEOUT:
> >       case MADV_WILLNEED:
> > -             return true;
> >       case MADV_COLLAPSE:
> > -             return task == current || capable(CAP_SYS_ADMIN);
> > +             return true;
> >       default:
> >               return false;
> >       }
> > @@ -1457,7 +1455,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >               goto free_iov;
> >       }
> >
> > -     if (!process_madvise_behavior_valid(behavior, task)) {
> > +     if (!process_madvise_behavior_valid(behavior)) {
> >               ret = -EINVAL;
> >               goto release_task;
> >       }
> > --
> > 2.37.1.455.g008518b4e5-goog
>
> --
> Michal Hocko
> SUSE Labs

Hey Michal,

Thanks for taking the time to take a look at this.

"mm/madvise: add MADV_COLLAPSE to process_madvise()" in the v7 series
ended with me mentioning a couple options, but ultimately I didn't
present a solution, and no consensus was reached[1]. After taking a
closer look, this is my proposal for what I believe to be the best
path forward. It should be squashed into the original patch. What do you think?

Thanks again,
Zach

[1] https://lore.kernel.org/linux-mm/Ys4aTRqWIbjNs1mI@google.com/
