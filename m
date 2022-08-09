Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781458E3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiHIXhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHIXhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:37:15 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A77E834
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:37:14 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f2a4c51c45so15879921fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z5Q/Vd0bvorTg1UJJ9UjSWzoOc/6lKMWr30zDkTxbGM=;
        b=cauuIbnMYb0t0IZ8vtNA12Z2pp1XLEkD+3zMcWBcj3XXWpO7Vac/Y1r1tpT/dUYORa
         KLgIslpWC6NXY2M+ZGmOc+m6RKvgvkov7WVzujAZePhxxvZkJnfgCUWgcVLWUsy0IA9R
         F2CwQBezo/Qqyajm6NaO0mZNZ6gG2aWFwE0eLKHMCJfg0mzH8wlv+mwyGnB2u/VO/Tyd
         DqJ3Vwza0hBaCgM4k/zv/cfWD3uQVfoLRrZOcaLO2e0a/9qfQPt59/9vUQnkgtBLWmlH
         +zlBK9cjnEcP3nQSy8K4CKHrkD6jKoh+0O792QGPlNTaVORhv7/6BnQksxBmBJVBeqtg
         eJWw==
X-Gm-Message-State: ACgBeo23d4NyB30VZWRzQtKMJM76v9E8rkauLwDw3glbjcUM4oet/3/o
        AU5bzVqZqPx+g9ARsVKp6joZgVzUJPh3o7Fbs/c=
X-Google-Smtp-Source: AA6agR4R36WX5d1nO6m+yGNtXe+Oa8X6FoUbO9BOfBXsPz9nteqvQAK+zABiLqa4GlRO2JDbVncBKu5EqchWVWHy7w4=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr373346oaf.5.1660088233431; Tue, 09 Aug
 2022 16:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220808175956.592707-1-namhyung@kernel.org> <7b1c463c-c912-ba08-bac4-99d45e45f7e1@redhat.com>
 <CAM9d7ciPHi27JwcCbCWAkHnFBn-6PRbpRjBJ1U=cfDN-UcthjA@mail.gmail.com> <eb01385f-4860-6394-ade5-518e12f70287@redhat.com>
In-Reply-To: <eb01385f-4860-6394-ade5-518e12f70287@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 9 Aug 2022 16:37:02 -0700
Message-ID: <CAM9d7ch19LdYceFFmKEd3=tPU53xEMHtUiarv9CTXxaCLKHTtQ@mail.gmail.com>
Subject: Re: [PATCH] locking: Add __lockfunc to slow path functions
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 4:09 PM Waiman Long <longman@redhat.com> wrote:
>
> On 8/9/22 17:13, Namhyung Kim wrote:
> > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > @@ -36,7 +36,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
> >    *   rsi = lockval           (second argument)
> >    *   rdx = internal variable (set to 0)
> >    */
> > -asm    (".pushsection .text;"
> > +asm    (".pushsection .spinlock.text;"
> >          ".globl " PV_UNLOCK ";"
> >          ".type " PV_UNLOCK ", @function;"
> >          ".align 4,0x90;"
> >
> That is what I meant. However, you should also a comment saying that the
> use of .spinlock.text section is equivalent to the use of __lockfunc on
> an equivalent C function to make it clear. Also add the __lockfunc to
> the pseudo code in the comment section.

Thanks, will add!
Namhyung
