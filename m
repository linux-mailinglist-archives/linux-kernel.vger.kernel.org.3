Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D163F5019AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiDNRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbiDNRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:09:06 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C549F6EA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:57:52 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id j4so2258117vki.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZ6t4npj/dkDR/9Ph0VbUFeuQFB/dSviTTwGt9Fj5ZE=;
        b=iQ/9o9V2PaSGOd4AwoDp6pOl6zrejO/TBoa3Rpklnufwf10VjyN1OXXqA99M6M4Mkg
         Mgo+5saDuKAuzkymQaSwXoW3qo/rc4kk0z1jBFdRwsRfRP36WDzS/tpxmdgXmL+05jK7
         4e0RwLr0+fdYY9njr9aF3rVOnifpnPwU/B/B0Qfyvs4nWCCYeWiDqMIoEC4dE68VCblE
         VYJGNevkkuc2YmVv5g7CI5BHD0bK3OCa+E/qrUSzAP2cdUZsoqYFFlVgmALqsVN7OUzl
         SRDFp1glZi0YXbazQ5AxLRknV2A03euL/7ibjX69fHDFfkr5G0Efw6wIpCNT6XxfsKD+
         e/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZ6t4npj/dkDR/9Ph0VbUFeuQFB/dSviTTwGt9Fj5ZE=;
        b=cr86/I0AhCCBZG8vjCFUxc1PVItxtg35UCWPqSIICHEzfGDwfNe57sPQ2B56u0rg4B
         QGdabRMy7CDjrAgdiftT0W+Oo0dk655+wSucKuE4fQmjqXx8GcKsjOALKc1YwZJaSYKK
         77DEWwoUI4PXHEfm5cYaVhnZVWJpye94FOEgXQgbs1xkKULu+TXKrkkxJIKQIQ8lrLgr
         uIi9u7fPE8bFGrU7bqbwg7AYl1LAD22F1efXAMZN4PxqS9HkKugsazmxRJrHiuZgJtni
         OVoAhUJhn0efmF2JLMZJizmNZa/NTPHQ4kgt/Sn3kOYsaaWb9gKDtSaee0gsBYDLXGwA
         z4lw==
X-Gm-Message-State: AOAM531Afsq6nIHjhSo61MDVi0+st/D+mdyrDQstkc+tC7elyt7qIPQL
        8blcCVE7izFzwzvVixSeQDYu4pyxH2ytc719RRAqmA==
X-Google-Smtp-Source: ABdhPJx7VF6Nq+2eeFeNN4ggvB1JU9cuhQ4OyyJKiZB1z4/ZEoTrGYuQHfF7dBVk/FqJ5UD75YGAyHr5iMCMc507Hhc=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr1764779vkf.35.1649955471019; Thu, 14 Apr
 2022 09:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org> <20220414135706.rcn7zr36s2hcd5re@revolver>
In-Reply-To: <20220414135706.rcn7zr36s2hcd5re@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Apr 2022 10:57:15 -0600
Message-ID: <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Apr 14, 2022 at 7:57 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> > On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > > Please add this patch set to your branch.  They are based on v5.18-rc1.
> >
> > Do we get a nice [0/n] cover letter telling us all about this?
> >
> > I have that all merged up and it compiles.
> >
> > https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> > https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> > disabled for now.
> >
> >
> > Several patches were marked
> >
> > From: Liam
> > Signed-off-by: Matthew
> > Signed-off-by: Liam
> >
> > Which makes me wonder whether the attribution was correct.  Please
> > double-check.
>
> I'll have a look, thanks.
>
> >
> >
> >
> > I made a lame attempt to fix up mglru's get_next_vma(), and it probably
> > wants a revisit in the maple-tree world anyway.  Please check this and
> > send me a better version ;)
>
> What you have below will function, but there is probably a more maple
> way of doing things.  Happy to help get the sap flowing - it is that
> time of the year after all ;)

Thanks. Please let me know when the more maple way is ready. I'll test with it.

Also I noticed, for the end address to walk_page_range(), Matthew used
-1 and you used ULONG_MAX in the maple branch; Andrew used TASK_SIZE
below. Having a single value throughout would be great.

> > --- a/mm/vmscan.c~mglru-vs-maple-tree
> > +++ a/mm/vmscan.c
> > @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
> >
> >       while (walk->vma) {
> >               if (next >= walk->vma->vm_end) {
> > -                     walk->vma = walk->vma->vm_next;
> > +                     walk->vma = find_vma(walk->mm, walk->vma->vm_end);
> >                       continue;
> >               }
> >
> > @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
> >                       return false;
> >
> >               if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_end, walk)) {
> > -                     walk->vma = walk->vma->vm_next;
> > +                     walk->vma = find_vma(walk->mm, walk->vma->vm_end);
> >                       continue;
> >               }
> >
> > @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
> >               /* the caller might be holding the lock for write */
> >               if (mmap_read_trylock(mm)) {
> >                       unsigned long start = walk->next_addr;
> > -                     unsigned long end = mm->highest_vm_end;
> > +                     unsigned long end = TASK_SIZE;
> >
> >                       err = walk_page_range(mm, start, end, &mm_walk_ops, walk);
