Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2528152334D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbiEKMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiEKMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:40:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E7AE42
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:40:49 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f83983782fso19351147b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp3lhm6I7/WFq7x0bxvhvtc097Q4lEgO9v12y8HRSSU=;
        b=S27v30MAEKl2gRW92HsHbROcmmRFFYhqgryVDf65ZprFWbl71bcWESAXVOA4VyMTxZ
         w/KUSEakPtaqxo0JokHj/339QbglnH9QoH/lHS0HgbWcEGE+5+rGmkBEI0bFACas5ZAK
         ZCFz94qs/D2gTkJmLfqYkCCNDdfviye/htEplcLqB08CV0ho6AfClKI1dXJkDMER5Zy7
         GvddbhiqLixASTXS1qIssulhv9Poz56hMCN2qHUIJdJXDN28eiVTbVMe3iKl9k0SFE+y
         B60yGZcZjWK+tBuGPAFcVXKlOH3eymkHBUjjb5544nnu6mLadHdi64QIXNJJyJiS+n9s
         YCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp3lhm6I7/WFq7x0bxvhvtc097Q4lEgO9v12y8HRSSU=;
        b=O12xG+RQ/n0ZklECLgqmb7cUUg5rGjhXhp/dAn/zQFCY4LufHG/Bd/xkP4yljxOdiN
         Ar73TKn8uV4cauZN/9XfTJbZZReTILa4C4DSjY8DJXKniSmLi+IaCd3V/+u5fmWwsKmd
         07u/WLXqX/j/L09X9cIRRZz21uJjRr6788/sF6mPr7pCpAtIUF+DI37frc60V0C+MNmr
         CeqZiFBp/RY9h901pWxQApIc/7IjIQBdVn6vYzLTLucRP/45HgDuSpYKiKafHJHbYByE
         OjF6y6POLQJJaHF6iQbd7VUqsx3bh45ezu0O3/GiKG/ik6fDklfHTb7LJ1DEAZwKkOY4
         9zNg==
X-Gm-Message-State: AOAM5303QOkmT0MH0rJ4A4ogt5wzoeden7jxaFmKZnkJQf8EecIlbJm7
        EbLQBcK7VU44Nk+RA0178Uc53UGxZoxOp1W41eM=
X-Google-Smtp-Source: ABdhPJxz1xOLhDjVqiBWZ+++o569yEDiYYHGrguD1A8MEMbz5vqEmWKK0v8qTAJ/ZrdWZSbB/hwjaSpTdS+2PGkneNE=
X-Received: by 2002:a81:1e86:0:b0:2eb:66b9:3a93 with SMTP id
 e128-20020a811e86000000b002eb66b93a93mr24128895ywe.411.1652272848959; Wed, 11
 May 2022 05:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511072747.3960-1-jiangshanlai@gmail.com> <20220511072747.3960-3-jiangshanlai@gmail.com>
 <87h75wgycl.ffs@tglx>
In-Reply-To: <87h75wgycl.ffs@tglx>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 11 May 2022 20:40:38 +0800
Message-ID: <CAJhGHyCXCUDe_grNa9XdLXuCJYcX35G0m3KvjWnSvgYUApLbcA@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
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

On Wed, May 11, 2022 at 6:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, May 11 2022 at 15:27, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > These constants will be also used in C file.
> >
> > Move them to arch/x86/include/asm/processor-flags.h which already has
> > a kin X86_CR3_PTI_PCID_USER_BIT defined in it.
> >
> > Remove PTI_PGTABLE_SWITCH_BIT and replace it with PTI_USER_PGTABLE_BIT
> > since they are the same in meaning and value.
>
> Just from looking at the patch it's obvious that it breaks the 32bit
> CONFIG_PAGETABLE_ISOLATION=y build. Sigh.

Ahhh.
Thank you!

I'm sorry and I will move the "#ifdef CONFIG_X86_64" down a
little bit in arch/x86/include/asm/processor-flags.h.

Thanks
Lai
