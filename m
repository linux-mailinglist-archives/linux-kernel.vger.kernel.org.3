Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4A52EFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiETPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiETPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:52:49 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF915FE0F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:52:48 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id b81so4317211vkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tpdW7ecTraKhRbFvsmKOuE6oFJXwO3YExgfPm1rem6k=;
        b=iwOJDaYD3rkoWkWTQttkxXrc7bmfCiBueluPS4MvM/SUBPn/XmWiUP4nfjxIyirEyy
         r40MMADjDftUxIlayYfIh11OWDcRYd18Kq2bj3FOAGjHxrLKBhtCz0a2hehKSPHs6+In
         G8/0QMpR9YchPdTTDcAxLCqL5/wpRXKv8FJrplu7Gn4hVlpy6ULxDxQja191vcQfz/9r
         z2Z2WKug9WpP4QL1E1spbNRTcu/HE/VIKnXJCTA76y73Z3vjsrpel6bEm6T0cidcBtY9
         UgZTs9GoHMKRvSG+wcxwinB0aaJ3vUjdgHv+0G6E9FpiPS/aeMhIUPb4RJjE8Iy7Ausr
         i/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tpdW7ecTraKhRbFvsmKOuE6oFJXwO3YExgfPm1rem6k=;
        b=PVNIwTT91YsgBZpJygTDp00Vcc6hsdmk6CQvtO+DrOZoLCssNdPWsjem4N3YxCV90K
         rFRgZswf11pUwMZRtJC+IkKWSaQI4P4bua1c78jeCO7bA8RT2D6X9ALuogI7PENKH9wb
         isQcANjzlVV44IzNUjyIo4YksWYmgdB3twUZOL4PxNCpaXz5OxRkXZsLmV5iOYK5Cjf+
         LQAJqiBCOIzz2VHW3+m4jy6BgaqVzw6daRKne+0X2q41tE9Im7/PLSaZIkdWyFpOR53W
         +vl3NgVpeXl7Tv42N3qZKGWr7uKrOA3gSVblr7VX/DO5lRXDpT16BV+JGw+ydrtn6A99
         kDWA==
X-Gm-Message-State: AOAM531lE2t5F+skOKAxcmSI8DjjwwlJK54wvqP4y4lh0lVTDKPGlaMS
        SlJ81TSp67903M+K1lKkDq1Vb2mEvDfjmWO1vig=
X-Google-Smtp-Source: ABdhPJzkmCYAR3lHsKWTR4WJw3EHqbOIe/Gee4gEL4BAfCHI1FQm8jmDahubi6kfWk7b2fsJlMHMycZJU/sHEFJaZww=
X-Received: by 2002:a05:6122:1184:b0:356:f6f5:da0c with SMTP id
 x4-20020a056122118400b00356f6f5da0cmr4344329vkn.36.1653061968101; Fri, 20 May
 2022 08:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220516125405.1675-1-matenajakub@gmail.com> <20220516125405.1675-2-matenajakub@gmail.com>
 <20220520132800.hijytnlyjqeesjfj@box.shutemov.name>
In-Reply-To: <20220520132800.hijytnlyjqeesjfj@box.shutemov.name>
From:   =?UTF-8?Q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Date:   Fri, 20 May 2022 17:52:56 +0200
Message-ID: <CABsDya+_Q=JLF2igQ1ZghrCqSUcGokaPbN+VHsA=13Vd0N4igA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/6] [PATCH 1/6] mm: refactor of vma_merge()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 3:26 PM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Mon, May 16, 2022 at 02:54:00PM +0200, Jakub Mat=C4=9Bna wrote:
> > Refactor vma_merge() to make it shorter, more understandable and
> > suitable for tracing of successful merges that are made possible by
> > following patches in the series. Main change is the elimination of code
> > duplicity in the case of merge next check. This is done by first doing
> > checks and caching the results before executing the merge itself. Exit
> > paths are also unified.
> >
> > Signed-off-by: Jakub Mat=C4=9Bna <matenajakub@gmail.com>
>
> Okay, this looks good:
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> I would also consider renaming 'area' to 'vma'. 'area' feels wrong to me,
> but maybe it is only me.

Well, the 'area' is taken from the original code and the name is not
the only thing wrong about it. It is actually used for two purposes,
which is definitely wrong. First purpose is to store the middle VMA
between prev and next for the use of case 8. And the second purpose is
to store the resulting VMA which is passed to
khugepaged_enter_vma_merge() and also the return value of vma_merge().
So, to me it seems that the best approach is to split it into two
variables 'mid' for the first purpose and 'res' for the second one.

>
> --
>  Kirill A. Shutemov
