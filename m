Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1526E536396
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352824AbiE0Nw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiE0Nw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:52:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF895D5FE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:52:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so7025541lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYxRb+Vdjb6h7QtKyMpW1wUVocarnGCZDA40o8CZT2Y=;
        b=lBJHP5OkXxz7LxA+zDKjH29FUjfdsr7d5RuPw2v1IWvM9ZnqUComL4SHD+DQ65sYvp
         C1/8xdbrXi11egyi6nb9yIKg3uS9OD92juwfsxVMulluokBazhC9PGnXijyvFHESUUtH
         CMWVYwQyE6kU7EX54pmhbT0J8Y5JBQGbTUAbwvMchlxd/cX2o2TvjmFrnmuWeCu3iZ46
         d+ULSQA2srWNrYKex3uYFRT5lZlkLaNfEkjXNYALNSF+8YRJC2d+VfW0C24ztBGSynuG
         lPtiiQmRxSopFQ5uDiXbu0+6Po11/yoLKNJkA5lhKGztps66jAVgD8sjZxGD64um0ies
         IqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYxRb+Vdjb6h7QtKyMpW1wUVocarnGCZDA40o8CZT2Y=;
        b=KXab41fE33Fy3CxD8R9YhwJr62HypbrbyscEukrMnRYXsSTf+LBFDS/RB/6Go3son0
         G92KEHIv0iF6itji2VZhB45A+7GtjfoXV9U31XV/WZO6eIA78TOPUN6Xrk0DQT4KPW77
         YURrbqL6tbNf3flGWeFfs/O8kuCj31DHQ78vFcMFsUf6HZP+L0paaEwdSLlE76hSDtlW
         RYDG0FzVNBUC9DHQdyNItdjatWcbODSBkCN251aCBhSiCE5I+Ya/gSWa9aflDwqcedZ2
         5GYrPywcahsagr3CRmr2AsAvYE4s0tKLxH1bEYpyqsF9G8nzR8GWI60MQbPGjGm870xY
         Auxg==
X-Gm-Message-State: AOAM5322eP0rUlnYWHIXc35KL11Tu22i/hTTr1cJLNlXNnKBOzok0wcI
        4k8wykk/u6B6pjtXmGbRF/qIQOvv+AjSrENwndPGfw==
X-Google-Smtp-Source: ABdhPJwxk9PMk+9hwsBi1ZWF0lF/hjN2a00rAliSbqTj1snEE5SfzQUYFq04BJweBKaBd7MxJFm/1Ouy84JRh0FCiHE=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr29939142lfb.376.1653659543723; Fri, 27
 May 2022 06:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
 <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
 <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
 <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com> <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
In-Reply-To: <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 15:52:12 +0200
Message-ID: <CACT4Y+aH7LqDUqAyQ7+hkyeZTtkYnMHia73M7=EeAzMYzJ8pQg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
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

On Fri, 27 May 2022 at 15:27, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-05-27 at 15:18 +0200, Dmitry Vyukov wrote:
> > On Fri, 27 May 2022 at 15:15, Johannes Berg <johannes@sipsolutions.net> wrote:
> > >
> > > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > > > > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > > > > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > > > > rather than just showing the RCU callback used for that.
> > > >
> > > > KASAN is doing it for several years now, see e.g.:
> > > > https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ
> > > >
> > >
> > > Hm. It didn't for me:
> >
> > Please post a full report with line numbers and kernel version.
>
> That was basically it, apart from a few lines snipped from the stack
> traces. Kernel version was admittedly a little older - 5.18.0-rc1 + a
> few UML fixes + this KASAN patch (+ the fixes I pointed out earlier)
>
> I guess it doesn't really matter that much, just had to dig a bit to
> understand why it was freed.

Humm... I don't have any explanation based only on this info.
Generally call_rcu stacks are memorized and I see the call is still there:
https://elixir.bootlin.com/linux/v5.18/source/kernel/rcu/tree.c#L3595
It may be caused by some narrow races, depleted reserve memory in
stackdepot, or race with quarantine eviction.
