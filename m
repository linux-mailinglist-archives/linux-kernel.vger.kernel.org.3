Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D045241E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiELBPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349810AbiELBPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:15:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9976291
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:15:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so2131366wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2A0EBKn71mKby0gJZVmQ9LYT/Q3ibTennNPxPhFKz4=;
        b=BhsNfnjMuykg2rURTpjphNVbp0mbBupv+C7OqP7Vj4RURQ0i0JS2M2qvTXYveHfc9d
         REq3DhhkgUB7dMO61c3hXm8NYbNFkFHOhMWjZqw5UFpRUm9Hvd6FV0aehpWYcuml7zeK
         agQ7uygQ8AllM7IIHh+de0M7Cv+1Na5rTv0GCbqiMT02HwRhJk+HOXZBZXTvh5Y7zKY3
         YW9W7+qVpS3VSfuD85xgCSXipgQBL1jkHeroBTmPMclUVY30U4NYPXnAZtOkjtFZEB3E
         UgkT9ioKvvWRKBcTsbvPBLwo22PqFYXLdQBCU1N2irg4Aa8zDBbNt0+5oBMbk4RRZvrN
         8yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2A0EBKn71mKby0gJZVmQ9LYT/Q3ibTennNPxPhFKz4=;
        b=Ub83zTtm6OXPxqmNBqmn0Hy0EYVWNYiSO3GcCEv+QIF57BgKlcheXTN/C2Owu+CvS5
         0fEeDSUkq+KD5L503phamuz2TZBYLig6UQeErvJljO3ycQiicBmnsnhoHDITxgzKC5Qh
         yPavbsFGTdG92kfC5TwEqCliWJh+dc9dOMTIq0n9V4aci6E1dMWGGfSaI1IWqHSfeWAO
         hI6lD7xh4F79V8ehrL5DmGfeGqTzppCExOAdNie16JhzTtUmpRHXUu+XyqVSZ3UcoXxZ
         5dQ/Tqm5kAfJzvZwQIyLzqU/+IeK/1fXkEBTf61ij5B3wKgSgnFaA407ZehTnVw3tdqd
         gaDg==
X-Gm-Message-State: AOAM532fRtzCeeF/E9pokCbGgegqGuDQBdbzBJ8lut/9OkBB1pfbEJwG
        XxmRqS6byy4QW6kQQKPJJCv6DbKQIC1kX/2Nn0KjJjn5qGjDxw==
X-Google-Smtp-Source: ABdhPJy7UDUuVaNfoFpYjbdNMJfbbAZ8dx+pDby5a3aABdQb9g97tsYsKyiDviy1vULG5cN2+2xA9htqI5Kf602Ppt0=
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id
 184-20020a1c19c1000000b00393a19f8f95mr7508353wmz.149.1652318128439; Wed, 11
 May 2022 18:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com> <20220511211526.1021908-6-irogers@google.com>
 <96ad6825-7607-92ef-566c-3e7a54c397bb@linux.intel.com>
In-Reply-To: <96ad6825-7607-92ef-566c-3e7a54c397bb@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 18:15:13 -0700
Message-ID: <CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf jevents: Add python converter script
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 2:47 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/11/2022 2:15 PM, Ian Rogers wrote:
> > jevents.c is large, has a dependency on an old forked version of jsmn,
> > and is challenging to work upon. A lot of jevents.c's complexity comes
> > from needing to write json and csv parsing from first principles. In
> > contrast python has this functionality in standard libraries and is
> > already a build pre-requisite for tools like asciidoc (that builds all
> > of the perf man pages).
>
>
> Well I was still hoping at some point we could have run time loading of
> events. But yes if that's not
>
> happening then this probably the right approach.

Thanks Andi, some thinking out loud below:

The perf tool already discovers events from sysfs, so could we have
runtime loading by turning the sysfs mount point into a list of
directories?

I'm thinking that for consistency the jevents API inside of the perf
code should look more like sysfs. There's then a question of how we
resolve events, perhaps we can have a config value something like
"sysfs,runtime=/home/me/my-events,jevents" where we treat the list as
setting up something like a unionfs in the tool. So if you ask for
instructions.retired, the tool would first check sysfs, then any
runtime events specified sysfs like directories, then jevents (or a
different order if you set a different config value). If the event is
defined more than once for the same PMU then the ordering says which
one has priority. If a PMU isn't specified for an event then we search
all PMUs and for jevents you'd only see PMUs relevant to the cpuid(s).

I'm hoping something like this will allow hybrid to work without all
the "if...hybrid" code that's getting added, and with a behavior
that's obvious and will allow us to debug errors. Maybe a runtime
sysfs like directory implies too many files so we could make a json
file to replace that directory, or use a zip file, etc. I'd prefer it
if the mappings were as 1-to-1 as possible (ie have a new json format
whose structure matches sysfs) and so I wouldn't like to use the
current jevents.c code for it.

Thanks,
Ian

> -Andi
>
>
