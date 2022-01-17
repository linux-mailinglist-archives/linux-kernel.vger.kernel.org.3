Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E60490C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiAQQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbiAQQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:28:21 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:28:21 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id a12so17326961iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKuvwksI9n1D5eeZK/jbIF9ogu2ww7rREgxcqTgZGeI=;
        b=nAl0JX0XnfUvDUPXDdh1iHLGq3wdf7wV9/LL4pUDu+twKRqjsXcp1AWzBjAFNdncQh
         qWiRBJGxtWuKgSEkkE8uu44o8gQL7gZWM4inggeEkJnw1jOMSnBFSBtzZr0R1DFEXsre
         kHIwcNGp+4OOR3qHrWvmxzLH8FnOuqsIR3bmv3s/3mALN18EasUgsWUyehsrDLE1/EqV
         69xSBOCFDW3zxrx/HRS2S1bMIIZJ1uaYA7erczDjD29CDR/X4+V2UpU1+0/9lyF/92Ng
         fPkjOn+5d6z4A6EVw0R0imOyC8/rLDpJZ+EGS6nRoCCWBeQA1ACx0KZGt2J4jk5HMx+k
         f1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKuvwksI9n1D5eeZK/jbIF9ogu2ww7rREgxcqTgZGeI=;
        b=L6jMLQayzmqpofUZyANgpXD/UDmTBvxNsx59pu1QjXMAxxMGZLGwopmhMsCRV9Fu+P
         mWBjQybqd2LeOaqK0OvMJKAm3wze9cJAN+azrpfd6cdgtKWAeRJoXC60HYkB9m9B45vV
         byt2i4u8Z2nH9jYTeAPmXN8LhB3OLEgxP6nDsl2dVOPgojzKNKxU1nGldJVXzJDeOtjk
         l2Zeg79Nr5d3xVGpRNo9S/7zpoYK/oXStKSidECdaqW+dCts3ybxtI2W8gpe/cjSizZR
         J2pAm1sj5NPhQmTUsaBAogLjHuizpogxtoesOqNYl4H3km7WMT4LvzIq8jcLwLFePXaI
         B2oQ==
X-Gm-Message-State: AOAM532C6yqtdgEgIJLFWAvDL181BNdcn/tHER6taxxdgsr3JyAPIZd0
        NrK05R8HmE5Rrk7mfRtvXS4xxv3G37efmmEhLrNNKA==
X-Google-Smtp-Source: ABdhPJz6axRt7fn2ICl2LmGSHcYtuXt4UvPLKyBS1KE9e+92tT0xCZpbgOIajylVskNZBzDe+OtAkMdljyc5yTHfy20=
X-Received: by 2002:a5e:890e:: with SMTP id k14mr2343801ioj.151.1642436900085;
 Mon, 17 Jan 2022 08:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20220114212102.179209-1-german.gomez@arm.com> <c2b960eb-a25e-7ce7-ee4b-2be557d8a213@arm.com>
 <35a4f70f-d7ef-6e3c-dc79-aa09d87f0271@arm.com>
In-Reply-To: <35a4f70f-d7ef-6e3c-dc79-aa09d87f0271@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:28:07 -0800
Message-ID: <CAP-5=fUHT29Z8Y5pMdTWK4mLKAXrNTtC5RBpet6UsAy4TLDfDw@mail.gmail.com>
Subject: Re: [PATCH] perf record/arm-spe: Override attr->sample_period for
 non-libpfm4 events
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Chase Conklin <chase.conklin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, "acme@kernel.org" <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 2:27 AM German Gomez <german.gomez@arm.com> wrote:
>
> Hi James,
>
> On 17/01/2022 09:59, James Clark wrote:
> >
> > On 14/01/2022 21:21, German Gomez wrote:
> >> A previous commit preventing attr->sample_period values from being
> >> overridden in pfm events changed a related behaviour in arm_spe.
> >>
> >> Before this patch:
> >> perf record -c 10000 -e arm_spe_0// -- sleep 1
> >>
> >> Would not yield an SPE event with period=10000, because the arm-spe code
> > Just to clarify, this seems like it should say "Would yield", not "Would not yield",
> > as in it was previously working?
>
> "this patch" refers to the patch I'm sending, not the one it's fixing.
> I might have to rewrite this to make it more clear. How about:
>
> ===
> A previous patch preventing "attr->sample_period" values from being
> overridden in pfm events changed a related behaviour in arm-spe.
>
> Before said patch:
> perf record -c 10000 -e arm_spe_0// -- sleep 1
>
> Would yield an SPE event with period=10000. After the patch, the period
> in "-c 10000" was being ignored because the arm-spe code initializes
> sample_period to a non-zero value.
>
> This patch restores the previous behaviour for non-libpfm4 events.
> ===

Thanks for fixing this, I can add an acked-by for the v2 patch. Could
we add a test for this to avoid future regressions? There are similar
tests for frequency like:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/attr/test-record-freq
based on the attr.py test:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/attr.py
The test specifies a base type of event attribute and then what is
modified by the test. It takes a little to get your head around but
having a test for this would be a welcome addition.

Thanks!
Ian

> Thanks for the review,
> German
