Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8D5234DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbiEKN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiEKN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:58:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266285B3EA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:58:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m62so1263695wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77v4RYcMq7aax9H9FDzzs8lK5wzwleytZfbm7VkvvC0=;
        b=tadDF5DcSmE9uDGxH9qcs8HjjNj0iw92i1CA28azLE8Q2oMCfzVBkKxy8j52akEaGP
         GtQ49ul4gYIONDupvZvqgywGCZJUZUozA5f2tCGVNF/qd+tY1ZT3ocq5jEqas+THXQuf
         fgktNfmGxxk5NONu67qrEnP2E74AwQmZIuf1AaybL0wiiVCtApn96xnrF8PFDCpb5mMe
         ME+8Sy1ItMaaSGwqPEr9wfexWJ3X2QI0v/qEVpUOHdwJR6OJGw+D3FcgIPyxs9VdfxwI
         Wu3HenBdOqPB9DLSyskeIet3n5gJAXDecdj8KOKV2P5j2CZVo4c52jGUvv/V82Ydt5p2
         pbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77v4RYcMq7aax9H9FDzzs8lK5wzwleytZfbm7VkvvC0=;
        b=q11b63d+6AiEuR9QXmg+piZ0N8bITI1RfizremVQfibfF5IgV3WBXmkDft1Jv0iv/Z
         eKs+FB49IceANuPsj2vtEPTb2gdh/5Mg0VCyeZheG0ZftOqWsoRSn6Zb+fhVAxjjlqWp
         +V96guyj8X0OrQFJltliJnlrBCzgKZ6Fo6TmFPyQjX5ck/YAhImN718+kRbwNDwJ3TEL
         uKqwOviKz0g5VHq+otqBLfIOaEAmJjIfYC2RP8Cu8cFPhtYNXP60cXyOOtRlvL0BwmZH
         2CdeQxbrzZCwSsjxEB2g/sLyt7A2MopYl8y9lvmo3tKIl7541LFn4BVhffGiZ8FFxhJU
         2qyw==
X-Gm-Message-State: AOAM533ffePAfIhFA3vUVf6PXa9cvwoKNqEGJYPIp80kIe7syXP5O96k
        36FmgBrC9MDEpWWoNO5oXqZzikYVSqlFv3xQtSTaqg==
X-Google-Smtp-Source: ABdhPJz7KH1U8JQWjEu+/IABq1JJfuhkgyKfHVVPP2SgIV5sm6x71azTPyyENwfnnQSIXhILwv4PvwAKxEB2vq6J0m8=
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr4960415wmo.115.1652277536373; Wed, 11
 May 2022 06:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com> <3f5f1075-49b3-3ba4-6392-cd0e6abf57d8@huawei.com>
In-Reply-To: <3f5f1075-49b3-3ba4-6392-cd0e6abf57d8@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 06:58:41 -0700
Message-ID: <CAP-5=fXxCSp7CJXpn-+SX3zTZej-ho=eyzJdkAwfovn9w=8Sww@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rewrite jevents program in python
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:13 AM John Garry <john.garry@huawei.com> wrote:
>
> On 11/05/2022 08:01, Ian Rogers wrote:
> > New architectures bring new complexity, such as Intel's hybrid
> > models. jevents provides an alternative to specifying events in the
> > kernel and exposing them through sysfs, however, it is difficult to
> > work with. For example, an error in the json input would yield an
> > error message but no json file or location. It is also a challenge to
> > update jsmn.c given its forked nature.
> >
> > The changes here switch from jevents.c to a rewrite in python called
> > jevents.py. This means there is a build time dependency on python, but
> > such a dependency already exists for asciidoc (used to generate perf's
> > man pages).
> >
>
> Hi Ian,
>
> This does not build for me:
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
>   GEN     pmu-events/pmu-events.c
>   CC      /home/john/acme/tools/perf/libbpf/staticobjs/libbpf.o
>   LINK    dlfilters/dlfilter-test-api-v0.so
>   CC      dlfilters/dlfilter-show-cycles.o
>   CC      builtin-bench.o
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 23, in <module>
>     def file_name_to_table_name(parents: list[str], dirname: str) -> str:
> TypeError: 'type' object is not subscriptable
> make[3]: *** [pmu-events/Build:15: pmu-events/pmu-events.c] Error 1
> make[2]: *** [Makefile.perf:662: pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
> What baseline do you use? It's always good to mention it I think.

You're right, sorry for that. I was testing with:
$ python3 --version
Python 3.9.10

From your output it looks like the newer type hints feature in python
is missing. I think the type hints help the code, but they aren't a
requirement for this change. I'll look into compatibility with older
pythons.

> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
>
> As you know (and have done), verifying no regression should be
> straightforward by diff'ing. For avoidance of doubt, which archs did you
> test? We also need to ensure those which don't use pmu-events (like
> arm32) work as before.

The test in:
https://lore.kernel.org/linux-perf-users/20220511070133.710721-6-irogers@google.com/
tests all architectures that exist in tools/perf/pmu-eeventss/arch:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch?h=perf/core

You're right that I've missed arm32 and other architectures that don't
have a directory there. Something to fix for v2.

Thanks,
Ian

> >
> > A difference in the python to the C approach is that the python loads
> > an entire json file in to memory, while the C code works from token to
> > token. In some cases the C approach was sensitive to the order of
> > dictionary items in the json file. To ensure matching output there are
> > two changes made to jevents.c to cause it to read all values before
> > creating output.
> >
> > The changes also found a bug in Ivytown's UNC_M_ACT_COUNT.RD event
> > encoding, as well as unnecessary whitespace introduced in Alderlake's
> > metrics. In these cases the json input is fixed.
>
> Thanks,
> John
