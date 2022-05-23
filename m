Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA92531CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiEWU44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEWU4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:56:51 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABD24090
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:56:49 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id x11so7155938vkn.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzdR40l4t49BhcKjBeDt6RD1hRuvcftxidhZX+LxdXA=;
        b=DZdJON7t3PwgCrrmoucnoFvSfX5CB986DtveajogrvKr6pbaUxLeSsuyQgxal0XNhS
         KtUMABkOtZddGLrKTjmkE65iB7IBOMFLTOkO0T+JtTANcIxtK2pw75L4/fulZM/sIv3h
         9w7OjUket0wgm0eyX2hnQquy+pbw3X7FBf0cdOz4/mr3FAKvSrbXpXxx4Px8rX0wzKxu
         FK6Jc3VfmpkY39qs5xYc4jSO+jajCnvH6nUZ8z49/7le/3VS/Ut/yN2jQrVCSxGc1Eo/
         u/QcFtp7hLmI/TtYQlEYEIeQLjQExhL4r5PyZsLRMj4OYJECPC3Edhqg9azGHa3WKDLS
         wRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzdR40l4t49BhcKjBeDt6RD1hRuvcftxidhZX+LxdXA=;
        b=jSp03P+iX2betISUQC3tz76bVfhYPV0yy6Mkkz5gE5wNi8Vcjvsvt3LgN6Zev3OSiL
         Rtdat3FugBdvLud6nbLsvNB0TyPE2by49BzpwTimnm/Bn46ypPFpG8TK46hOA5rYuKYC
         qTnm8ZTbi/9n4k9Hce8mCfeQJwf/fx9+fx+00ac/pfOa9Ega2YmKGMAlilMyr+vGuy3m
         fuRsYF9VLnYFjpsMYvV0j5Vl1QBNoODZCh707ibzEIkbQw3ZlEs+F8NYXS6iY6pnr1NP
         BR1yNkxu8+ga0+vKeJgF/oKWA22NUaJtEz+rWDbi5fHc6LOk2wNsOyy6BCZ8XkuSs19v
         gNug==
X-Gm-Message-State: AOAM532p+Gct4+oIPZnvGlu0WWiw7Fa9miHo1E7pLpof8XZzg6Mq4+Rg
        a0sIuYfnbYOJN0hi45NVIk1hUCZexk6HvVSGo0r1Sw==
X-Google-Smtp-Source: ABdhPJwGoP2jfrDhtWQgFx4bSOEJyIfQRib61SYaE0aRLL2I/I+lfsoRwqrX0NDaMtQIQfBFPy0Uz3uIFeL9+8Ja5x8=
X-Received: by 2002:a1f:ec45:0:b0:34e:6cdc:334e with SMTP id
 k66-20020a1fec45000000b0034e6cdc334emr8914633vkh.26.1653339408905; Mon, 23
 May 2022 13:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <YnWRVd5slCy5H0fC@creeky> <20220507015646.5377-1-hdanton@sina.com>
 <CAOUHufY=xAvDKSaV8vybgObXPBEsPqqS7R3+T_-6ix7bUvQc6w@mail.gmail.com> <YnweYF9E5mt2HIwV@creeky>
In-Reply-To: <YnweYF9E5mt2HIwV@creeky>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 23 May 2022 14:56:12 -0600
Message-ID: <CAOUHufZ_kBF+f3_RE9p8itJ8YN86cbEq9oXHCt+e1qw2Q-b8Zw@mail.gmail.com>
Subject: Re: Alpha: rare random memory corruption/segfault in user space bisected
To:     Michael Cree <mcree@orcon.net.nz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
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

On Wed, May 11, 2022 at 2:37 PM Michael Cree <mcree@orcon.net.nz> wrote:
>
> On Sat, May 07, 2022 at 11:27:15AM -0700, Yu Zhao wrote:
> > On Fri, May 6, 2022 at 6:57 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Sat, 7 May 2022 09:21:25 +1200 Michael Cree wrote:
> > > > Alpha kernel has been exhibiting rare and random memory
> > > > corruptions/segaults in user space since the 5.9.y kernel.  First seen
> > > > on the Debian Ports build daemon when running 5.10.y kernel resulting
> > > > in the occasional (one or two a day) build failures with gcc ICEs either
> > > > due to self detected corrupt memory structures or segfaults.  Have been
> > > > running 5.8.y kernel without such problems for over six months.
> > > >
> > > > Tried bisecting last year but went off track with incorrect good/bad
> > > > determinations due to rare nature of bug.  After trying a 5.16.y kernel
> > > > early this year and seen the bug is still present retried the bisection
> > > > and have got to:
> > > >
> > > > aae466b0052e1888edd1d7f473d4310d64936196 is the first bad commit
> > > > commit aae466b0052e1888edd1d7f473d4310d64936196
> > > > Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > Date:   Tue Aug 11 18:30:50 2020 -0700
> > > >
> > > >     mm/swap: implement workingset detection for anonymous LRU
> >
> > This commit seems innocent to me. While not ruling out anything, i.e.,
> > this commit, compiler, qemu, userspace itself, etc., my wild guess is
> > the problem is memory barrier related. Two lock/unlock pairs, which
> > imply two full barriers, were removed. This is not a small deal on
> > Alpha, since it imposes no constraints on cache coherency, AFAIK.
> >
> > Can you please try the attached patch on top of this commit? Thanks!
>
> Thanks, I have that running now for a day without any problem showing
> up, but that's not long enough to be sure it has fixed the problem. Will
> get back to you after another day or two of testing.

Any luck? Thanks!
