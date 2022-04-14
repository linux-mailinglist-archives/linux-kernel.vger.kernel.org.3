Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC360500777
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiDNHox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbiDNHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:42:50 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A7205E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:40:26 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id w21so1444035uan.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+yelAQ9lNFMI5hOufKWMSWgyc6a2oTLMaNPif+dSo4=;
        b=Ijl0UlJLuQJNxeS+00+kEK00vT7ArQW3/qBUuWGouccrXcnwKXAWw0Bf/7Eh7QqqNl
         D9EqRcrZPWLUghmFk7OiLXimrH+3hNIl3Nz6tMFqxCoU4NG/2Cca8TRQJoEinJjqrPVN
         BNhVX8kqdEbC/l/gXB5MLjfZLSZE26oc/XdL5Gaw+YSUNUKXIfz92WIE/2WS6TilxEn3
         d93AMeRD/WQjDbeEGPLL2MyJeEpnV5oLnlnyn8hfNxgms2NWblSSh4LFMyYDaCBCZDPu
         wyIv8asE4KzL4NwYWC+49wpSHFnOalpjBQu4vyHiDXzPal4tRoAVp+PTCi5fSm/rbxcB
         j/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+yelAQ9lNFMI5hOufKWMSWgyc6a2oTLMaNPif+dSo4=;
        b=NRmkUm1fW1KAtV7E6sJlyqGBsZ609T63VeEwjRPFHwGXGgrUBt8yFJRjcQnTdK4ikP
         SVKFkBT7ViyQBsJ8+97IiBCMYooPG521CF//Vr/bkSbOd2rU0+xy4FqunhQzp/q0r5wV
         SCzlJGm/dTQ8YGFBK7z8kt9l7nR6ty39mDUUuJJUOzcZp2WQPGg7lja3T8FwvmmAi7s1
         srMpmYrvV6TrNimwCih7ZHgFiJWKETXPdIvv/Ws/GZKIQgA3adNJHdDeZwggS2FkJcPQ
         gpCN27Hz7LnD/z1U7YZqnZicEhDNvL1AfGWNIn5arA/+xXO/4oL2fEdUrGzA4TtcqWfg
         /Fsg==
X-Gm-Message-State: AOAM533xxPKl/qd0LXZEZrHQt6qIwMV4iPZsxe2WDSXSRFtow7Fvm7yG
        NHBsAltNwogWJCOLNC+AkWE5RTeUGRcTy6OL24EUjK+fXAXfog==
X-Google-Smtp-Source: ABdhPJwsuKEakZkW6AxrgqVK3TOMuqurXvhoD6CAwsnkFCY887FYnTbTSEXVRqQWTzwHH0e4AL4Fl1q1VwslrqlmPWo=
X-Received: by 2002:ab0:77d5:0:b0:352:42d7:88c2 with SMTP id
 y21-20020ab077d5000000b0035242d788c2mr450693uar.1.1649922025781; Thu, 14 Apr
 2022 00:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com> <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
In-Reply-To: <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Apr 2022 01:39:49 -0600
Message-ID: <CAOUHufYWq2atD7wqx9rDpHZxpjZN+zP12+ivNBANvCgVUrtxsw@mail.gmail.com>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
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

On Thu, Apr 14, 2022 at 12:50 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
>
> > Please add this patch set to your branch.  They are based on v5.18-rc1.
>
> Do we get a nice [0/n] cover letter telling us all about this?
>
> I have that all merged up and it compiles.
>
> https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> disabled for now.
>
> Several patches were marked
>
> From: Liam
> Signed-off-by: Matthew
> Signed-off-by: Liam
>
> Which makes me wonder whether the attribution was correct.  Please
> double-check.
>
> I made a lame attempt to fix up mglru's get_next_vma(), and it probably
> wants a revisit in the maple-tree world anyway.  Please check this and
> send me a better version ;)

Thanks. This looks good to me.

> --- a/mm/vmscan.c~mglru-vs-maple-tree
> +++ a/mm/vmscan.c
> @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
>
>         while (walk->vma) {
>                 if (next >= walk->vma->vm_end) {
> -                       walk->vma = walk->vma->vm_next;
> +                       walk->vma = find_vma(walk->mm, walk->vma->vm_end);
>                         continue;
>                 }
>
> @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
>                         return false;
>
>                 if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_end, walk)) {
> -                       walk->vma = walk->vma->vm_next;
> +                       walk->vma = find_vma(walk->mm, walk->vma->vm_end);
>                         continue;
>                 }
>
> @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
>                 /* the caller might be holding the lock for write */
>                 if (mmap_read_trylock(mm)) {
>                         unsigned long start = walk->next_addr;
> -                       unsigned long end = mm->highest_vm_end;
> +                       unsigned long end = TASK_SIZE;
>
>                         err = walk_page_range(mm, start, end, &mm_walk_ops, walk);
>
>
> I flung a tree up at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mmtemp containing
> mglru and mapletree and a few other things.  Could the mglru and
> mapletree people please runtime test it, send any fixes?

Will do.
