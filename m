Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5B507AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348895AbiDSUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354580AbiDSUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:17:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB27650;
        Tue, 19 Apr 2022 13:15:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t11so35142096eju.13;
        Tue, 19 Apr 2022 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HGzzr2HHaisSceOh/AMWaOfiAuPvIVMh7w0WX7B5no=;
        b=ZmHYt7GD2+alkil4QEVPhPV3+tPVOx62sAQvqq0grr+A8PNSTTwRrNQQ+qtR2LP+is
         kkXrhWyIsWx8Xr4JteJuYjExSoceb5Ix3JmW1sKTIHlqN6DmDz0YfJVvwAl2xcUIjfEU
         +LHlpaoSp3y03ExycV+9qdSB4DafRkrPx5BgYgjhLe+ATk+yF3Wv0sWDlGYnB8JJbSdD
         WQms7ceu8k0K7jKh6Ecu9d8msNlQ2VlZh18P7tCa9ny4psV3BXzPN7vvQRoU+RLvJnyj
         9bVWhWMdxr22j4j1y8H4+mc1rVC1970rBg+IH/zTu14EVZu0AgCkIfql/a6X59uI1fh8
         ugvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HGzzr2HHaisSceOh/AMWaOfiAuPvIVMh7w0WX7B5no=;
        b=UiaRZOQOW60awtQxq3mJQ9JVdHiiTKqInw2v1CbI3D7pysGMOz0fV5NlLy1mlal9rN
         ECpZ3YNukds4JNRvPDugbDzGfm/xz0oEJCOnN3sVkrlRSEmbHSSdYhMVFXxA+TZPmXci
         Ewh6bV1qUI9nKfaUQlw6PmEWuQ+ogxSV7tidRNfHZ0Km5aNlPRxV8Rnsgoc9hDlO1ndC
         Eu8Yb+IgMfBjl8AHsDOmjem5XlqiAk6gZJ/kim9K7SC34HdBGzAq3rXFW62rhUy26zyj
         RsojgWP1QQn8kt+R8feLYfpmV5pZA5wCPwKH4Tr4qIDlYQd1F4SZVXsSHMCcjh2wAe4M
         0ZKw==
X-Gm-Message-State: AOAM530cmUhjyFKj5PeKb+TU7v5cxJCxy1Mip59ZTCGOv7Mc3g51/Hc1
        IbwZMqwKyRaZuPVPO8O3p8I=
X-Google-Smtp-Source: ABdhPJw/dz59AB6QDCBQbugkMngVnNl0wLjvKrZCE13hM+Ww2ACQhWMLLIqR2y/j7ZHs21Q/aFvukw==
X-Received: by 2002:a17:906:3707:b0:6e8:6bfe:da0e with SMTP id d7-20020a170906370700b006e86bfeda0emr15436465ejc.78.1650399312162;
        Tue, 19 Apr 2022 13:15:12 -0700 (PDT)
Received: from krava ([95.82.134.228])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm6014525ejo.191.2022.04.19.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:15:11 -0700 (PDT)
Date:   Tue, 19 Apr 2022 22:15:09 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Message-ID: <Yl8YTSXiC0yP4N3+@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <YkRgDdI8PKH5C7lV@krava>
 <OSBPR01MB460012B9516B2E67CBEEF0B1F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB460012B9516B2E67CBEEF0B1F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:23:54AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi jirka
> 
> Sorry for the late reply.
> 
> > >
> > > Shunsuke Nakamura (7):
> > >   libperf tests: Fix typo in the error message
> > >   libperf: Move 'open_flags' from tools/perf to evsel::open_flags
> > >   libperf: Add perf_evsel__{refresh, period}() functions
> > >   libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
> > >     struct opts
> > >   libperf: Add perf_evsel__check_overflow() functions
> > >   libperf test: Add test_stat_overflow()
> > >   libperf test: Add test_stat_overflow_event()
> > 
> > I'm getting:
> > 
> > [root@krava perf]# make tests
> > running static:
> > - running tests/test-cpumap.c...OK
> > - running tests/test-threadmap.c...OK
> > - running tests/test-evlist.c...OK
> > - running tests/test-evsel.c...FAILED tests/test-evsel.c:286 failed to overflow
> > count FAILED tests/test-evsel.c:286 failed to overflow count
> >   FAILED (2)
> > FAILED tests/main.c:13 test evsel
> > make: *** [Makefile:162: tests] Error 255
> > 
> Thanks for telling me.
> However, we could not reproduce the test failure in our environment.
> Could you please tell me the results of your test with the addition of V=1?

sorry, forgot to answer this one..

[root@krava perf]# LD_LIBRARY_PATH=. ./tests-shared -v
- running tests/test-cpumap.c...OK
- running tests/test-threadmap.c...OK
- running tests/test-evlist.c...
Event  0 -- Raw count = 231217013, run = 10196083, enable = 22183091
         Scaled count = 503046909 (45.96%, 10196083/22183091)
Event  1 -- Raw count = 247219790, run = 10946246, enable = 22182044
         Scaled count = 500979080 (49.35%, 10946246/22182044)
Event  2 -- Raw count = 268999685, run = 11943490, enable = 22180868
         Scaled count = 499573115 (53.85%, 11943490/22180868)
Event  3 -- Raw count = 291383974, run = 12941069, enable = 22179798
         Scaled count = 499405241 (58.35%, 12941069/22179798)
Event  4 -- Raw count = 314293846, run = 13938576, enable = 22178649
         Scaled count = 500095052 (62.85%, 13938576/22178649)
Event  5 -- Raw count = 337393782, run = 14935798, enable = 22177192
         Scaled count = 500974014 (67.35%, 14935798/22177192)
Event  6 -- Raw count = 360218294, run = 15933314, enable = 22175507
         Scaled count = 501340982 (71.85%, 15933314/22175507)
Event  7 -- Raw count = 365516630, run = 16179860, enable = 22173686
         Scaled count = 500922194 (72.97%, 16179860/22173686)
Event  8 -- Raw count = 365180177, run = 16178058, enable = 22171705
         Scaled count = 500472130 (72.97%, 16178058/22171705)
Event  9 -- Raw count = 341205844, run = 15233252, enable = 22169603
         Scaled count = 496571454 (68.71%, 15233252/22169603)
Event 10 -- Raw count = 318204949, run = 14234754, enable = 22167081
         Scaled count = 495524887 (64.22%, 14234754/22167081)
Event 11 -- Raw count = 296671131, run = 13236210, enable = 22164791
         Scaled count = 496792783 (59.72%, 13236210/22164791)
Event 12 -- Raw count = 276639189, run = 12237128, enable = 22162629
         Scaled count = 501020477 (55.22%, 12237128/22162629)
Event 13 -- Raw count = 255437518, run = 11238588, enable = 22160497
         Scaled count = 503677361 (50.71%, 11238588/22160497)
Event 14 -- Raw count = 232427791, run = 10239844, enable = 22158353
         Scaled count = 502958545 (46.21%, 10239844/22158353)
   Expected: 500221918
   High: 503677361   Low:  231217013   Average:  500223614
   Average Error = 0.00%
Event  0 -- overflow flag = 0x1, POLL_UP = 1, other signal event = 0
Event  1 -- overflow flag = 0x2, POLL_UP = 1, other signal event = 0
Event  2 -- overflow flag = 0x4, POLL_UP = 1, other signal event = 0
Event  3 -- overflow flag = 0x8, POLL_UP = 1, other signal event = 0
OK
- running tests/test-evsel.c...
        loop = 65536, count = 328183
        loop = 131072, count = 655863
        loop = 262144, count = 1320613
        loop = 524288, count = 2621943
        loop = 1048576, count = 5243383
        loop = 65536, count = 66349
        loop = 131072, count = 131789
        loop = 262144, count = 264697
        loop = 524288, count = 528484
        loop = 1048576, count = 1056485
        period = 1000000
        overflow limit = 3, overflow count = 2, POLL_IN = 2, POLL_UP = 0, other signal event = 0
FAILED tests/test-evsel.c:286 failed to overflow count
        period = 1000000
        overflow limit = 3, overflow count = 5, POLL_IN = 4, POLL_UP = 1, other signal event = 0
FAILED tests/test-evsel.c:286 failed to overflow count
  FAILED (2)
FAILED tests/main.c:13 test evsel


jirka
