Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7912A49C4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiAZIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiAZIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:05:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D09C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:05:11 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id r65so65396713ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foarPWstnqecVutxOFimxf2djiTBSA+fwdzyLI4AMhY=;
        b=MP7X8j0220ckd7ioqLPwVWazTygw6YKb48hBqEeUHkG9GO2xY3pK2T9Jb8I1RKYQ17
         IRHKHKOaKnjWrs90cBaHyVq5PrLcPuPPqCbtdt9pmBlpu89UVafuEV0iRh85cRmZiZQW
         yT5EThXelesaDDlv6D9ICgf0FdPHL2P48B1lpdihdp+MbBAkpEwsoMQ45G6gwfyRPszf
         HUZ+2An2mfU0hVtAOwFhci8hL/6k/NvkHOyeNYFUr/Sow0NbXsmyIa7a6sRlLVTTef3K
         0WDK+p0TRhFn1SpqhqksVXZzxrjNWDXBE09qD2J8EX7mClRAEsr5wvWQwD+790ZB4Eok
         IBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foarPWstnqecVutxOFimxf2djiTBSA+fwdzyLI4AMhY=;
        b=aUqiroFYdXMqONEyqBE6HzVtCeIho160+zZrTkCkx9w4eVH4PLTUQgVnplMlOJkdRp
         rH62qAc2s/BXmU9gTwn1LtluLkeFB5aR6sVCJ01uLhAbP6etojetALo0jNNhUcoa7U8F
         drvyLRdcI8+m9H33F9P1/xLt2o1WfMM8CUtx2219Ns1IhUIp1lSB9EK3Sun9ioZGlsNZ
         SEXE1OzIW333GnUvOpjkBxc1udO7eeE5GCspEsuAwxmriGJsw95T+naaPc45+3mg2g4K
         1RikVhXSKhq6Y2XJmcFlsvj/B/s12bOQyIOUD+yReGp/TfcsM3F4OCUirya6PHTyLwGo
         /uVA==
X-Gm-Message-State: AOAM532heJGhArdTU6ll4jEdH0x3+yXVlLUgoekXfR3NTAFCZUhw2cAM
        jEjMyHuDThDYWI4g4UYLvDCzI53n9tGRT0E2r+D7YA==
X-Google-Smtp-Source: ABdhPJwt0xr0K/+J9LSkfF8BUNdmg89+s1e4+T5E+c6ZNrBdsj2qnnda3rn3u8u8qyZVyRfYygNmGsEQcXkG4IBvxmM=
X-Received: by 2002:a25:af4b:: with SMTP id c11mr34418179ybj.49.1643184310524;
 Wed, 26 Jan 2022 00:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
 <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com> <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
 <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com> <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org>
In-Reply-To: <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Jan 2022 16:04:34 +0800
Message-ID: <CAMZfGtW+DoKp_gCcPSy33Urc86A58rRp8HJ+-GOuW9vFP-BwxQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:09 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 22 Nov 2021 12:21:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > >
> > > > On 11/8/21 12:16 AM, Muchun Song wrote:
> > > > > On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >>
> > > > >> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> > > > >> significantly. It further reduces the overhead of struct page by 12.5% for
> > > > >> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> > > > >> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> > > > >>
> > > > >
> > > > > Hi,
> > > > >
> > > > > Ping guys. Does anyone have any comments or suggestions
> > > > > on this series?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > I did look over the series earlier.  I have no issue with the hugetlb and
> > > > vmemmap modifications as they are enhancements to the existing
> > > > optimizations.  My primary concern is the (small) increased overhead
> > > > for the helpers as outlined in your cover letter.  Since these helpers
> > > > are not limited to hugetlb and used throughout the kernel, I would
> > > > really like to get comments from others with a better understanding of
> > > > the potential impact.
> > >
> > > Thanks Mike. I'd like to hear others' comments about this as well.
> > > From my point of view, maybe the (small) overhead is acceptable
> > > since it only affects the head page, however Matthew Wilcox's folio
> > > series could reduce this situation as well.
>
> I think Mike was inviting you to run some tests to quantify the
> overhead ;)

Hi Andrew,

Sorry for the late reply.

Specific overhead figures are already in the cover letter. Also,
I did some other tests, e.g. kernel compilation, sysbench. I didn't
see any regressions.

>
> > Ping guys.
> >
> > Hi Andrew,
> >
> > Do you have any suggestions on this series to move it on?
> >
>
> I tossed it in there for some testing but yes please, additional
> reviewing?

It's already been in the next-tree (also in our ByteDance servers)
for several months, and I didn't receive any negative feedback.

Do you think it is ready for 5.17?

Thanks.
