Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBE577F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiGRK1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiGRK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:27:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C831C10E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:27:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ef5380669cso101748597b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtTfWY8c2tHupXV3NJhc/gA4bCCzcVUbrwexbM78YIw=;
        b=ythMXru89Hf7UyefmokxpYASilm2VullfX2yexXcOsyEwShbYLqJOcSz3m61EmwD5R
         gL1qYKqpc+9/ki70yjMndzttvMevsIEsqqYp7fpPuvHkpPGNlJx4d+Rh8CAg2pleex7f
         7T5nGf22oxaSR9GZ1dYlPrCrAQZXYcTG98Kp/SpZ/c6TLLLVvgAVBz9BUgCpGlc96f/j
         I9eiTiuFxyqX2bdE1f6mUBoNIFNe+AGitPqQtIXZx64UQSCK7YkCpYEOCutVBdFBs2kZ
         AbPwz28hWX/s4CELmfBvPE+NTLbphO0n8XVYwQ33d1n4JU7ivLRVfKf2xnueV0GEP6Lu
         xBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtTfWY8c2tHupXV3NJhc/gA4bCCzcVUbrwexbM78YIw=;
        b=sY1SKUqwE9Zp/JErgGNRjCmYpetrOVf/Nx7j65FBi1bUeHGy5sbU0kp2rUaS7q9yBU
         enAvpidSogI8+TyJzoNz/8KlDZ9gWR5pk8ceeGKJF3EIY0fkmrpyCurl0LAEwf5yakYP
         y690pF0H8p2rabR94eh1lV0Fcn2sUb/LrxfyaTj8RPADv4EDTSeWO1NSHT0IGkc2R5Pz
         rjAAku9ozUQBjPo1jbcoCFc6BowzvLhUSdFovPuWU0KU2f1SvtUX0WEWOp4vrulxDkMU
         rnMaR4B2vUf1/CLeb+dU32cBj7YWJm/0wCRWjtiQcBrnrTd8t8Q2mZt48pvFKNUS/rq3
         mLiw==
X-Gm-Message-State: AJIora+T5qw+Ig6hQB5+A8zUPTbK8m7HA2eHUHWW73XM/CCdk3qvKQYJ
        NWKFSzLOdnSC+Ug/pP3OD91VzX3JXqqG9f3PZFX37A==
X-Google-Smtp-Source: AGRyM1tm3rRMamxfmX7xoNf9d4feXOYYJ6Vcz3kPJl/j25M2erXDAz4TZXRHBwn4g4u2tzr5Bd9oqj7UZZYuT0Jayao=
X-Received: by 2002:a81:e0a:0:b0:31e:2180:2b39 with SMTP id
 10-20020a810e0a000000b0031e21802b39mr5941152ywo.319.1658140036420; Mon, 18
 Jul 2022 03:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <7CD2EF28-F810-4733-8246-28D9821C180B@getmailspring.com> <F1E08DFA-40E8-447E-B37A-DEE651E87F80@getmailspring.com>
In-Reply-To: <F1E08DFA-40E8-447E-B37A-DEE651E87F80@getmailspring.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jul 2022 12:27:05 +0200
Message-ID: <CAKfTPtBHechB1KkBeh-m-bzJ+ABJUgEi=bPwCq_uactrjmKMjQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: simplify load_sum assignment code in attach_entity_load_avg()
To:     Zackary Liu <zackary.liu.pro@gmail.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "kuyo.chang@mediatek.com" <kuyo.chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 16:33, Zackary Liu <zackary.liu.pro@gmail.com> wrote:
>
>
>
> On Jun 22 2022, at 11:49 pm, Zackary Liu <zackary.liu.pro@gmail.com> wrote:
>
> > On Jun 22 2022, at 11:20 pm, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >
> >> On Tue, 21 Jun 2022 at 17:45, Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
> >>>
> >>> In commit 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg()
> >>> corner case"),
> >>> these code was committed:
> >>>         if (se_weight(se) < se->avg.load_sum)
> >>>                 se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
> >>>         else
> >>>                 se->avg.load_sum = 1;
> >>>
> >>> they could be replace with:
> >>>         se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se))
> >>> ?: 1;
> >>>
> >>> to make the code cleaner.
> >>
> >> This quite subjective as I consider current version cleaner than your proposal
> >
> > Thanks for your reply, vincent
> >
> > Perhaps, this code is more concise, and this form can exist in many
> > places in the kernel, and can be searched with 'grep "?: 1;" -nR kernel'

As said, the current code is cleaner and easier to read and I don't
see any benefit from this patch.
So it's a NAK


> >
> > --
> > zackary
>
> I have sent a patch couple days ago but still i don't get the reply,
> I am looking forward to your reply,
> thank you
>
> --
> zackary
