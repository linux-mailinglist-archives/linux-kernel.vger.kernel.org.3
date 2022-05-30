Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9334537437
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiE3FE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiE3FEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:04:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F549719C5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:04:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so18472758ejj.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XirfjVzzLTx46Nwwu3/b9HkXUr3i8KCBR76hKC0bJ0=;
        b=DGhV6BHo9SqfMyLJjJ3wu1Uvioz9+CdI8xcclct5k9zkFmC91TC/GcQFrLJtjk+3JK
         Fxl+U4K7mXsZnykWWVzdXkfszUw0iElQsMpT5qlzr2k73LsOyT04ud0ANyOPX9XWRX2L
         Z08pqCkTditNbugrDOtozQj72LnxxWQmacSinPdkdZu7eHp94yxT9a8xn3/zCzIwXg6F
         FHYwXtF5TpiQQ9tGpL9pjo2RYdsQksdw4Co538yxxUfxku3NxhuL3sp5O+RMxoxBzYCR
         ggMDQNmHPVKvbVt895CzU+hBFdgdCzjL36cZ8gCfSrqCS2Et46lAtoL+Fo1gekZbS/lh
         r6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XirfjVzzLTx46Nwwu3/b9HkXUr3i8KCBR76hKC0bJ0=;
        b=7qQ343/0V2bOsk+tqaME3Q1jBZGUw+fvIu/J//14Ea5oSJMOLA2LHrCBAU0rv2ALhl
         OgUPcUpFBoV7YPxlGpte0loFU5XMk9t5CqWFZTGybVlPsmwhJ59K2EJeAyHKbdTrGGuy
         xOrcrIA0X45MHtk0S7ibtrpxERCRDKbYRV4Pa2cuI4cxt6vbrNbQsXPfVI/vEr69Vru6
         39hnMG43FBQH5xO1UM8/GATt8zSHSe+W6rhNmnVux+5rmRmkq4XeRO7hekzPHAaZIlZ5
         qR2EF05PUUTqJJq5HtnI5ud9hsesleMM+I59V4Qs+mqet9vLp1RqeEjz9G/FNgmYCUsg
         MSHg==
X-Gm-Message-State: AOAM531t94KqfTvu74gV88Y3WzGDt8iRjFaKEImKFvPsl3Rvsl6OpcEr
        rxH+XgnhoXfYvrFmynk1ktB8BMhPvoehymHZNeKpUpGOpF47eg==
X-Google-Smtp-Source: ABdhPJxzcsWyiFUNFhiLW9ZBQqLkxaf3fKI1k4l28bbKdikEdXxdXZVuWKK+6Sq/Nt4qfH6wn4CQzCbctovuEx5Xndo=
X-Received: by 2002:a17:907:d17:b0:6ff:2f91:5b82 with SMTP id
 gn23-20020a1709070d1700b006ff2f915b82mr14190903ejc.192.1653887061641; Sun, 29
 May 2022 22:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220427175049.50057-1-sj@kernel.org> <20220529195411.102379-1-sj@kernel.org>
In-Reply-To: <20220529195411.102379-1-sj@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 30 May 2022 17:04:10 +1200
Message-ID: <CAGsJ_4y+w-i7OhE9Xk94W8p6srkMsVxTFxwb-+8g_ShGPEj5pw@mail.gmail.com>
Subject: Re: DAMON VA regions don't split on an large Android APP
To:     SeongJae Park <sj@kernel.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        xhao@linux.alibaba.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 7:54 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 27 Apr 2022 17:50:49 +0000 sj@kernel.org wrote:
>
> > Hello Rongwei and Barry,
> >
> > On Wed, 27 Apr 2022 19:44:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
> > > <rongwei.wang@linux.alibaba.com> wrote:
> > > >
> > > >
> > > >
> > > > On 4/27/22 7:19 AM, Barry Song wrote:
> [...]
> > >
> > > I guess the cause might be:
> > > in case a region is very big like 10GiB, we have only 1MiB hot pages
> > > in this large region.
> > > damon will randomly pick one page to sample, but the page has only
> > > 1MiB/10GiB, thus
> > > less than 1/10000 chance to hit the hot 1MiB. so probably we need
> > > 10000 sample periods
> > > to hit the hot 1MiB in order to split this large region?
> > >
> > > @SeongJae, please correct me if I am wrong.
> >
> > I think your theory makes sense.  There was a similar concern, so we made DAMON
> > to split regions into 3 sub-regions when we don't see advance[1].  My current
> > rough idea for improving DAMON accuracy is making it more aggressive while
> > keeping the monitoring overhead low.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/core.c?h=damon/next-2022-04-21-08-31-on-v5.18-rc3-mmots-2022-04-20-17-37#n1053
> >
> > >
> > > >
> > > > I'm not sure whether sets init_regions can deal with the above problem,
> > > > or dynamic choose one or limited number VMA to monitor.
> > > >
> > >
> > > I won't set a limited number of VMA as this will make the damon too hard to use
> > > as nobody wants to make such complex operations, especially an Android
> > > app might have more than 8000 VMAs.
> > >
> > > I agree init_regions might be the right place to enhance the situation.
> >
> > 'init_regions' has developed for the purpose, where user space knows some good
> > information for starting point of the regions adjustment, and thus want to hint
> > DAMON.  Nevertheless, it might not work as expected, because DAMON
> > automatically updates the target regions to cover all VMAs as much as it can.
> > I have posted a patchset for the use case yesterday[1].
> >
> > [1] https://lore.kernel.org/linux-mm/20220426231750.48822-1-sj@kernel.org/
>
> FWIW, the patchset for the fixed virtual address space ranges monitoring has
> merged in the mainline[1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98931dd95fd489fcbfa97da563505a6f071d7c77
>

nice to know that. Thanks, though it doesn't fix my problem as I am
looking for a solution to
collect precise monitoring data  automatically and economically.

>
> Thanks,
> SJ

Thanks
Barry
