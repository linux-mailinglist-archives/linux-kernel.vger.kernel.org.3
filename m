Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4257B935
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiGTPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiGTPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:10:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61856B84
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:10:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so1559256wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWDeKfuhQeqBTNEdFLuO0VKc5GBQc44071+voXhaV/0=;
        b=kRENxg0s227zlckuCwTrZbl1CjQZk+Py9cqyB+mVr+3cizzIbNfUVUFBw1NOa753TO
         JiE0mWHxiG2evp1TpS5ZyME++M2ZWqok3qjzeu66t/sQber0KOwfk/neYjwLhdxWbHpU
         GtNAJEIpS6+DEXwWesmm0dRqEamIovT3djRd7CNrrUqHZPWLhMxP23upbpRI2XknlZ8r
         xq5lhNH7WhpXVLUh22HCPUAcBglmS4ubvTEMSce0DmrSmGiosu/ePnsksVbl0xLQ9BDV
         C8xkMnZXZmd/8Z5AGfLTGNT1/wy3BdZm7q5dPyNMQME3NuX+HDlnIHxDoSUkhtHpC+NZ
         8WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWDeKfuhQeqBTNEdFLuO0VKc5GBQc44071+voXhaV/0=;
        b=cAtj8iV8kd0j6ui7RJsXLhah70dPAmNnQwzptA/7mu6sU6gbKpD0rQ6LQUoM3XiMc3
         0qrQy5YgDvcbv/oPtiVJRdt1XzK3n43jdAOzlYYek6WgesR5QxD5srczzGjB55xFdpOO
         xHPRopJ3XXdAQu1y+sqUnf1mDdsD0zjoh8B7YZGUWRoKnjehuR3bLmSfxuzIz7IfreDt
         ZY0FT2ctSHhmXJhPWTIPKw/AG24PVYLLhUjjccAt97xAUNMV4Adj+c9i9Uls9o16EKCc
         wcjVJ5+/6dl7+RWuSEK3yvJDfd5MW1rqRS/L7EJN00wGvVBGVKyNFWc9jYyPZZEAinnD
         MUHQ==
X-Gm-Message-State: AJIora8wKTWDt4UqfRq3ihq7KE5tt2V11XX2mjduB5U3JxDG+5NbnQc7
        ANAA7vwYKVqcGBJL6wJKdFsoHn0lqXwPqTLrW8NRgg==
X-Google-Smtp-Source: AGRyM1s/WLa1ybrSkaUpUHrng9eyqNR75+67EtfVaxMtLS4ZAd9QEs4dwUdo+oB6YRkfOS2KTJc1mVpsO6HcN+EJS0w=
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id
 u18-20020a05600c19d200b003a32cdbcc02mr1824874wmq.182.1658329802240; Wed, 20
 Jul 2022 08:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220719223946.176299-1-irogers@google.com> <20220719223946.176299-4-irogers@google.com>
 <b17c9045-80be-f658-d362-f13040ac9484@maine.edu>
In-Reply-To: <b17c9045-80be-f658-d362-f13040ac9484@maine.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:09:50 -0700
Message-ID: <CAP-5=fWFCtXmGukRg2ZDd5Rtf2mzKQ_+fgOrRnOXjD-K13bm0A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf test: Add user space counter reading tests
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 7:57 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> On Tue, 19 Jul 2022, Ian Rogers wrote:
>
> > These tests are based on test_stat_user_read in
> > tools/lib/perf/tests/test-evsel.c. The tests are modified to skip if
> > perf_event_open fails or rdpmc isn't supported.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > +             .type   = PERF_TYPE_HARDWARE,
> > +             .config = event,
> > +#ifdef __aarch64__
> > +             .config1 = 0x2,         /* Request user access */
> > +#endif
>
> should this value have a name rather than being a "magic constant"?

Thanks! Firstly, this is just moving code around and so not a
regression introduced by this code:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/tests/test-evsel.c?h=perf/core#n134
I don't believe there is an existing constant for this purpose. The
kernel isn't using one either:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/perf_event.c#n309

So I agree with you and hopefully this is something ARM will clean up.

Thanks,
Ian

> Vince
