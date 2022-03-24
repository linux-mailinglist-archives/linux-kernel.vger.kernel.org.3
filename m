Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857C4E60A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiCXIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349021AbiCXIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:51:59 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855A654BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:50:27 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so4292373fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJvvFanCuFstEBJXi7mU85Wroh06uJ+VOOWdDKxnZ5I=;
        b=p1BZOeWm4HvixzV2HVh7rhhvKA4PeCAdSHg61yUDDlvrE0YhLIEMk/zFjc+Bto6oMe
         OJaBxGMQvVVmYS4KmnKXSNh3gYmzz2UocUp/7aqKCTpbSwYCnxR1DRj4Iy7yzcxEWzJK
         j4m15w95FS9SlHsaMEocX0a+T+CCHiCyAOb1DYGYJIknYp5UconG4p37ucwp9EyBvt1m
         qc8Z8hO0sDrT9Y09xCa/3E8KSf9lQhGbROZKNMNPvHeXcgbm0v8b1RVXUH4hnBDSoYUw
         ji9GLbQ9NNQYAz3xbHVnpJwYZmNE+6nfNia86CK1p8rJZO/B9hSvU82LWRXaHldk5VXr
         u68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJvvFanCuFstEBJXi7mU85Wroh06uJ+VOOWdDKxnZ5I=;
        b=wSvyEn20ctR881y2JWHxfhImpBJzKFA5gfCFVigCgF9xp7hXOQnduVLxA64RsLUhri
         kkA6Ke2JkCJk5uGzDvwFKjYJpR/cu4cWSndVA+X65aXQoqxTqANEd4lIh1pkfrwf1Pnx
         UlhIK3dsU0IkUHX3IZD3sSVPKBliGurRKx/LRNyuiGvomR3cyUnML9xsHMWyCMPbjhpo
         PUojfAc5ZAupS53ig3qNYLyaOFMQHiygryKkx67A4PIdWJdKloUnIL9htzWhvtLIktut
         qF3AIKdXIzMau0+sJ7osbrPc+8YbyfJQbECPcwDdAFrYBA87MRMzRMIYG8lkqP2dr5qu
         PmfQ==
X-Gm-Message-State: AOAM533VOrvdRpUVRqD9oPa0EqhxBbTrMZYGa/dayVc5ROLHPWUzH1qn
        M57g2WwukoYjmuGNBug8L4ZWo7CMu4B8jSPQ5Az8IMkJ0OrFEA==
X-Google-Smtp-Source: ABdhPJxHo1cWxV3tneBHQX3C0hiqTH0ycLZDOrND1B5gNYL3V/dxlD7pzeFkL9SnWn2MB4KQOtaBb/4waIkuaUlQt+o=
X-Received: by 2002:a05:6870:9619:b0:d9:a25e:ed55 with SMTP id
 d25-20020a056870961900b000d9a25eed55mr1899508oaq.163.1648111826186; Thu, 24
 Mar 2022 01:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
 <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com> <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com>
In-Reply-To: <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Mar 2022 09:50:14 +0100
Message-ID: <CACT4Y+aQOziG8LGiTdyjTTHXJ4tNy2qxJ4yTPy-aUBG9CQB3_w@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 at 09:44, Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Mar 24, 2022 at 11:05 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > After this commit, the rules of dentry allocations changed.
> > > The dentry should be allocated by kmem_cache_alloc_lru()
> >
> > Yeah, I looked at that, but I can't find any way there could be other
> > allocations - not only are there strict rules how to initialize
> > everything, but the dentries are free'd using
> >
> >         kmem_cache_free(dentry_cache, dentry);
> >
> > and as a result if they were allocated any other way I would expect
> > things would go south very quickly.
> >
> > The only other thing I could come up with is some breakage in the
> > superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
> > problems, but again, this is *such* core code and not some unusual
> > path, that I would be very very surprised if it wouldn't have
> > triggered other issues long long ago.
> >
> > That's why I'd be more inclined to worry about the list_lru code being
> > somehow broken.
> >
>
> I also have the same concern.  I have been trying for a few hours to
> reproduce this issue, but it didn't oops on my test machine.  And I'll
> continue reproducing this.

syzbot triggered it 222 times in a day, so it's most likely real:
https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965

There are 2 reproducers, but they look completely different. May be a race.
You may also try to use syzbot's patch testing feature to get some
additional debug info.
