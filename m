Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492AB52B19A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiEREiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEREiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:38:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF7BF46
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:38:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r23so935665wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRzf4o3j3p6GE9ok9UjKci6UUosoBdJH+R8gXtS/sMo=;
        b=IQNCaBIJdHcM5HtQWBdGF+DwM1G99rX1X3ZdEbUEWuQyKNeaoFxWs5No54ZhbeOwFG
         5xZzvWkr+3zHTcS8WqJ5uLJKKO0XoXwQz1YIZzK3yhlUTuLJXbe71Je21E/JbEIGjqCW
         bLgaRVlAlxF7lgY5aj50Ai60FwCorxoLeRToLq25n9WljTUUcpeQVn5MbhIRNhL97njH
         UJgd9P24WjSWBkw1li4P9j8qAEWAfsWtOjpkqEm1zXKbDfm3d7sSzRz2e/VFEdzswDL+
         5kQ6qwkDOGu4UE2i50mROS0rteKR14i57v4deZoP7d9n10bJsXZNHcgf7SFn0rDDUoUy
         Y+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRzf4o3j3p6GE9ok9UjKci6UUosoBdJH+R8gXtS/sMo=;
        b=o/EbXX7FfwxBFaCeFQE319kin2Wt1u9NQA3/PXF4/j6/5cvKhvfMkp98S1KttcW4ZA
         AeZGVLKWR71nrUbc4vpC0Sc+FkC/nr5+A65BihyNHUcnH+oVKxsqF3FnMTwjgn029kFN
         XZnzPA+SpxyD6dWIvWFDlvJ1YryjEgCq9gpAEd9lEf2G7hh4XDdc9Cpy+yXBxT34LYob
         k2HhAeLsY8u+C8DOhcTF1RhSHja9DuAV1v1nFrbZGAZd+EtOPvLWJuF+WO0nDz5JaQUX
         bDoEqnyNPIdimvbQ1XV9wG6gA9WGq4D9dsz2YCLeLtc2H3yBtY9dmw/vNYwBsbAc0oWZ
         vqlw==
X-Gm-Message-State: AOAM532+joNa9X/grDhQZTNnqnxlzy4fPrXnO7msjnAiGk/tHJfZWwhN
        QziU9D/I6RWQxtqhfZSQwvu0EyHqJqx/usiNwLZpVA==
X-Google-Smtp-Source: ABdhPJzzcqS4cPpVWW6ZhR/6pBwyMnzJwVjDnGXrffEUg06+M+mRl47JQWgHrMhFruh9XtzE5+gPMadhHLDOcELTDXo=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr12363014wrq.654.1652848681060; Tue, 17
 May 2022 21:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com> <20220511211526.1021908-7-irogers@google.com>
 <d08b3d43-b02a-5aeb-e05e-f2f91d6a8f7a@huawei.com> <CAP-5=fUAXLL0CXrfrzYV2TT_31kouvJV-FWrZsipR27tT3i+uQ@mail.gmail.com>
 <1e9d2bce-b967-dccb-e6af-241830e5b38e@huawei.com>
In-Reply-To: <1e9d2bce-b967-dccb-e6af-241830e5b38e@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 May 2022 21:37:49 -0700
Message-ID: <CAP-5=fVfS-7WsyAjPZ96AZrX1Y68Q9BESx9Rw2QoQWjs+_J=_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] perf jevents: Switch build to use jevents.py
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 3:32 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/05/2022 16:58, Ian Rogers wrote:
> > On Fri, May 13, 2022 at 8:38 AM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 11/05/2022 22:15, Ian Rogers wrote:
> >>>     # jevents.py uses os.scandir and type hints present in Python 3.5 released in Sept. 2015.
> >>> +    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 5) else "0")')
> >>
> >> I think that many - like me - will have python 2.7, so now will find no
> >> pmu-events generated any longer after missing this message in the build :(
> >>
> >> Maybe many will have python >= 3.5 - but I don't know...
> >
> > So Python 2 has been end-of-life for over 2 years now:
> > https://www.python.org/doc/sunset-python-2/
> > There have been a number of LKML patches upgrading python to version 3.
> >
> > Python 3.5 has some very nice features of os.scandir and type hints,
> > so if I set the bar lower than this it hurts the code quality. It is
> > also at least 6 years old at this point, and so hopefully not
> > unreasonable for a distribution to have picked it up :-) Looking at
> > the change to C11 thread:
> > https://lore.kernel.org/lkml/20220228103142.3301082-1-arnd@kernel.org/
> > It seems the motivation for picking a language version is the features
> > it provides and compatibility. If we choose pre-Python 3.5 we get more
> > compatibility but we lose language features.
> >
> > My feeling is that we shouldn't need to support things that are no
> > longer maintained (like Python 2) but I'm less clear if Python 3.5 is
> > sufficiently compatible for everyone's needs. I kind of hope so, hence
> > making the patches this way.
>
> Fine, I just think that you need to make this transition as seamless as
> possible, otherwise it can be judged as a regression.

Agreed.

> For example, I have now python 3.6 (default) and 2.7 but it still
> doesn't seem to work:
>
> john@localhost:~/acme/tools/perf> make
>    BUILD:   Doing 'make -j4' parallel build
> Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
> differs from latest version at 'include/linux/coresight-pmu.h'
> diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
> Makefile.config:593: No sys/sdt.h found, no SDT events are defined,
> please install systemtap-sdt-devel or systemtap-sdt-dev
> Makefile.config:871: Python interpreter too old (older than 3.5)
> disabling jevent generation
> Makefile.config:904: Old version of libbfd/binutils things like PE
> executable profiling will not be available
> Makefile.config:1092: No openjdk development package found, please
> install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                        libbfd: [ OFF ]
> ...                libbfd-buildid: [ OFF ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
>
>
> make[3]: Nothing to be done for 'install_headers'.
> john@localhost:~/acme/tools/perf> python --version
> Python 3.6.12
> john@localhost:~/acme/tools/perf>
>
> which I need to figure out...

Yep, I can't explain that :-) You could try something like adding a
$(warning ... or similar to the build and running:
python3 -c 'import sys; print(sys.version_info)'

the jevents.py uses f-strings and so I'll need to bump the version
from 3.5 to 3.6 in v2. Python 3.6 was released in December 2016.

Thanks,
Ian


> >
> >>   > + ifneq ($(JEVENTS_PYTHON_GOOD), 1)
> >>   > + $(warning Python interpreter too old (older than 3.5) disabling
> >> jevent generation)
> >>   > + NO_JEVENTS := 1
> >>
> >> It is possible to flip NO_JEVENTS to be JEVENTS, i.e. no
> >> double-negatives, like NO_JEVENTS := 0
> >
> > Agreed that double negatives are bad. The NO_... pattern is kind of
> > throughout the make files and build files. I preferred the NO_... for
> > consistency but if there's a consensus I'm happy to change.
> >
>
> I have no strong preference. I just find that double negatives boggle
> the mind.
>
> Thanks,
> john
