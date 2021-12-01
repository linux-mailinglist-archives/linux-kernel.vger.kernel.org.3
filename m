Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A4465600
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351880AbhLATHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:07:40 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46744 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhLATHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:07:36 -0500
Received: by mail-ot1-f42.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so6368559oto.13;
        Wed, 01 Dec 2021 11:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXOpIccpsM1xV4j3I4ZBrPV6IQID71PePtRAf33/2Rc=;
        b=nOpzLfr/HiJNeFuLH4/11bxp5T19Yu3fUD/WqBH3WauM6W1nXDx8+9VOAQSQF3EZyn
         +UWQ5VGkJffQziXicq9qZ7mDg0fQUUHoQkgTA+7Ndd7ea43ScaSaaiYLlpY+n4Xqtwi4
         gI1qn84CqTt8/FjqqMP4lbu62qPtE6J+xpLRdxZ8jbAfFLvtMbUc4XbUCIYXkaAv2IqW
         m7nsGqmAsTLgvnMBFjLvIzFju7lCqMOdW7cok2BQkRGIyzN6DMk5u97Wk0F/StW05een
         6qSq4hQvYMUxeMQ6zCA+gQRmrcpGsN369lHkgfu4LLFy6gz4ZSQd8Kn9Pu68VqXcuLaK
         Rm0g==
X-Gm-Message-State: AOAM532f22l5weqSVk4YBSY39YadaW/EucMcmF35SXKHIiTMMNbhhXmC
        Ui1uWka5JtK0BvW1F3WlVCV3FJAoGdV5Yzy0dj4=
X-Google-Smtp-Source: ABdhPJw1YfGGYYwx1+loOW9w5nC4XINsp9fsj7CRMK5dRriZXo7+i/joPN4ikcDi+O7lWtw9F23LkkFVbLAfpsjukbA=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr7378988otf.198.1638385454922;
 Wed, 01 Dec 2021 11:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20211201074021.18097-1-tangyizhou@huawei.com> <20211201074021.18097-2-tangyizhou@huawei.com>
 <20211201071937.e6uso2qwzgtbfest@vireshk-i7>
In-Reply-To: <20211201071937.e6uso2qwzgtbfest@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 20:04:04 +0100
Message-ID: <CAJZ5v0i4ursRcPs0FOyuY5iCZZySxoQhz=9Pnbcw+xXRPHjz3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Fix a comment in cpufreq_policy_free
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tang Yizhou <tangyizhou@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-12-21, 15:40, Tang Yizhou wrote:
> > Make the comment of blocking_notifier_call_chain() easier to
> > understand.
> >
> > Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e338d2f010fe..db0b4b4258d5 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1296,8 +1296,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >
> >       if (policy->max_freq_req) {
> >               /*
> > -              * CPUFREQ_CREATE_POLICY notification is sent only after
> > -              * successfully adding max_freq_req request.
> > +              * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> > +              * notification, since CPUFREQ_CREATE_POLICY notification was
> > +              * sent after adding max_freq_req earlier.
> >                */
> >               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> >                                            CPUFREQ_REMOVE_POLICY, policy);
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.16-rc material along with the [2/2[, thanks!
