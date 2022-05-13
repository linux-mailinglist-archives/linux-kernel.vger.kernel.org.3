Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25E52672A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381992AbiEMQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344683AbiEMQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:34:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CDBC89
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:34:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k126so5096557wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7MjpCbJuzCaBF33rM7i8bDmdLy/zgFnMvU0NghdjW4=;
        b=jaOdYnB5sK1d0IiJeXEU3+MLeEOtcluyGAgIYatubr2/3PuE2Q5rXspsbD3tFfqWtw
         BsVwESYmN5NGeSov+0gBFv+VrOfCMRu+HKXtk2DpfmePB/XAAL4CBbHw4SjT5a4+Ogcs
         Gq6y2LM818/o4UnXO2ez1x9padxBnu8RvFpZMqMxjmAauSRs6Dt01UuX1GMVrZGNICkq
         C0XotBSk7si9VKF+nSuO05iUKfmsAzs8WO/B2HrXnPMkwXJ0crJrh+XdUHnEKMWIZl4S
         Rbylbx0P26flpGN1OSoQiXUGPepf+dfljZH67dSyLToehSUcRnqE475kSpDL8DP8kpIy
         rBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7MjpCbJuzCaBF33rM7i8bDmdLy/zgFnMvU0NghdjW4=;
        b=rwvaTajcrSruis5eOdEpcDpxRngZ3FHlBkdiLz12BX6IlMBBTPHbwcrl9lUgOu2ZAw
         R7RnhChfowmyleBh1TR/ARGXT/dOt4tsmZ7USM24gk0hdNCxDrio03jQKtKFLIwrjbcA
         JIBQ9VSrJlXnY35yDV1wtOfoz3LvhEIvBJcelevyD3QDDrXKBLu7jpnuX/NPhRR9Ba4E
         KIvNrIJz6pHto55BiX4sw5US+0iVxf+BnI7E+ok8Qk72BClVpKQwkoCe/IT49XqX2orH
         yGhONErlCf92JrNtEezUv0amjlGdhftTlzaAfHlsdlqmwQMT/QagOumNn/ZmKIcgHB5M
         KUPQ==
X-Gm-Message-State: AOAM533jAWJa+ShorZemdmr80E4dQKzHJgBJhWK4XqLwnDv2hDfR+yIJ
        bsVI4AjKAObVfSzKByFBZihNuh5rpojhKXQPQ1otTw==
X-Google-Smtp-Source: ABdhPJyShbTqrNF2KQLd+GgcRX1iXNoLZ+oxAq+Bs7myKRFD4NSfMvEmbWYewPWIlFZBpzn4/F8ZvZemUKqCWKjz0aY=
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr15604314wmo.115.1652459681108; Fri, 13
 May 2022 09:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-2-irogers@google.com>
 <6341384c-b3e6-fbe5-f29f-e0db114bd439@huawei.com> <CAP-5=fX+PfnyHRc=-sQMo1_mGLzCJ77pSfzXXHVUEOHtVFGwxA@mail.gmail.com>
 <b6e28614-e348-b490-bf33-af5810a60722@huawei.com>
In-Reply-To: <b6e28614-e348-b490-bf33-af5810a60722@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:34:27 -0700
Message-ID: <CAP-5=fVA+x_sNuWCOMj9ASBpFanms8DkAvLkbs5URDvcBW1itg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf test: Skip reason for suites with 1 test
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, May 13, 2022 at 9:26 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/05/2022 16:42, Ian Rogers wrote:
> >> I was not sure which suite has a single tastcase, so I experimented for
> >> libpfm4 by deleting a testcase so it has only 1x remaining, I get:
> >>
> >> before your change:
> >> john@localhost:~/acme/tools/perf> sudo ./perf test 63
> >> 63: Test libpfm4 support : Skip
> >>
> >> after:
> >>
> >> john@localhost:~/acme/tools/perf> sudo ./perf test 63
> >> 63: Test libpfm4 support : Skip (not compiled in)
> >>
> >> Although it is odd to have a single sub-test, is there a reason for
> >> which we don't print its name? We print the name when there are multiple
> >> sub-tests.
> > The reason was to replicate the existing "perf test" behavior before
> > the kunit style transition. The main place we get tests with a single
> > sub-test is from the DEFINE_SUITE macro:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/tests.h?h=perf/core#n67
> > I agree it looks kind of weird and was inheriting the data structures
> > from kunit and the format of the output from perf test.
>
> Out of curiosity, which suite is this that you find only has a single
> subtest? Does it possibly only have a single subtest as some others may
> be compiled out?

I was getting it when I added a skip message to the openat syscall
tests in patch 3:
https://lore.kernel.org/lkml/20220513040519.1499333-4-irogers@google.com/

I didn't see any changes with any existing tests.

Thanks,
Ian

> Thanks,
> John
