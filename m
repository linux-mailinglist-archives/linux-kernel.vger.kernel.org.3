Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE42D53AFDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiFAWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiFAWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:43:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454F272292
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:43:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so2846682wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueFC+LvqFygOP10zEfNVhZImk5CYtklcaahJeEGQyww=;
        b=s/fgii38Q2RsuREY8SfMqmJzcjK7/LZ3uGL30SZPtTAzk0e8YtfF67J0SI/e0RGvks
         F0pNBtNOYDfIDWKqQ/+9LVtzY22bdQPDS3996v6Ry2B4fX7QHs+hVOQ6VUMtQFKlTjtI
         hV3i0Mcobwj2CoKFdFLo7VUx7theyqzdLfh/e6cOaQQtroxsXWjbD5o5c7xzwiewxnIK
         e5N4ryNnniZ3xqyLyuVcy0AAxherlU46uudB1jbD6c4CJkcODhrBnlwFoONvTUU4ZaP/
         wVpAQAmpccH1FX+PF3zXBuMF+5WQmfXLoLRmHE6LigtM6Hry8bcbn0aQb4C1JwiguKyi
         5e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueFC+LvqFygOP10zEfNVhZImk5CYtklcaahJeEGQyww=;
        b=njMopiF2G1b3HcKZlFhYlaeLFyPy4sF0S1hLB2bwU7uQn+dr066JYryU+OuNtpXHSl
         CRDaAqTcSgRwX2tmcqBeW7ovvf/RrEnhpCTKkzGpGznxOpjh7q/Yk4Rs65NmVaXSlraY
         4zZfCmPqUpzGcvooHdpS1Kjq/7bwZ825zQyKvDzcYTztx4EAi/P1ctxPSLIhFYysPmeF
         4Q4Z0/AodFYYrS/FkDXAy24FHrDuDeirm5a2RV3qLhC07IIibdLRyZpHPGwDEvMAi/G1
         HDNVn0weRsz6/JeJXPY7Xkt4bK+kGEtbx1qRHMPfRwq3jHXO1b6ksOL7p1bhc5a+JsFi
         B22g==
X-Gm-Message-State: AOAM533LgamVg7nt+Z5V0z8l/iQPqxg5emWSsShXbpQuyeptOnM9EcIk
        TiM5lr0f0P173Y38tX69m8LolIvT3zi24ov68nTINw==
X-Google-Smtp-Source: ABdhPJz7qOR70i7hJV0S8+GOTJYwbj1cA/fCmO1+VHTcagC4lWJh2umRmEfdqXDnbeQxSroNXKhhefMCFjFWpZ9yVN0=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr29951063wmo.115.1654123395989; Wed, 01
 Jun 2022 15:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185426.240235-1-irogers@google.com> <d9056bc2-f640-f676-2599-c283479376a4@huawei.com>
In-Reply-To: <d9056bc2-f640-f676-2599-c283479376a4@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 15:43:03 -0700
Message-ID: <CAP-5=fU8Wn8wV0whYOraU+5tGf+kKUk73gSwOg+LHp19vzua3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Rewrite jevents program in python
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 9:17 AM John Garry <john.garry@huawei.com> wrote:
>
> On 27/05/2022 19:54, Ian Rogers wrote:
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
> > man pages). If the build detects that python isn't present or is older
> > than version 3.6 (released Dec. 2016) then an empty file is
> > substituted for the generated one.
> >
> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
> >
>
> Hi Ian,
>
> I still see this:
>
> ...
> Makefile.config:906: Python interpreter too old (older than 3.6)
> disabling jevent generation
> Makefile.config:939: Old version of libbfd/binutils things like PE
> executable profiling will not be available
> Makefile.config:1127: No openjdk development package found, please
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
>
> I need to figure out what is going wrong...

Thanks for testing John! Could you try adding something like this:
```
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9538d737d655..c23f39e21a70 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -901,6 +901,8 @@ ifneq ($(NO_JEVENTS),1)
    NO_JEVENTS := 1
  else
    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
+    PYTHON_VERSION=$(shell $(PYTHON) -c 'import sys;print(sys.version_info)')
+    $(error $(PYTHON_VERSION))
    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1"
if(sys.version_info.major >=
3 and sys.version_info.minor >= 6) else "0")')
    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
      $(warning Python interpreter too old (older than 3.6) disabling
jevent generation)
```
You can also specify which python you want on the make command line,
for example adding PYTHON=`which python` at the end of your make
command.

Thanks,
Ian

> Thanks,
> John
>
> > v3. Updates the patches for merged changes (on
> >      acme/tmp.perf/core). Re-runs all comparisons to make sure the
> >      generated pmu-events.c isn't altered at all by this change. Adds
> >      the jevents.c ExtSel fix in:
> >      https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
> >      Bumps the python version from 3.5 to 3.6, as f-strings weren't
> >      introduced until 3.6.
> >
> > v2. Fixes the build for architectures that don't have pmu-events json
> >      (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
> >      build for python not being present or too old (Suggested-by: Peter
> >      Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> >
> > Ian Rogers (3):
> >    perf jevents: Add python converter script
> >    perf jevents: Switch build to use jevents.py
> >    perf jevents: Remove jevents.c
> >
> >   tools/perf/Makefile.config               |   19 +
> >   tools/perf/Makefile.perf                 |   16 +-
> >   tools/perf/pmu-events/Build              |   15 +-
> >   tools/perf/pmu-events/empty-pmu-events.c |   21 +
> >   tools/perf/pmu-events/jevents.c          | 1342 ----------------------
> >   tools/perf/pmu-events/jevents.py         |  392 +++++++
> >   tools/perf/pmu-events/jsmn.h             |   68 --
> >   tools/perf/pmu-events/json.c             |  162 ---
> >   tools/perf/pmu-events/json.h             |   39 -
> >   9 files changed, 444 insertions(+), 1630 deletions(-)
> >   create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
> >   delete mode 100644 tools/perf/pmu-events/jevents.c
> >   create mode 100755 tools/perf/pmu-events/jevents.py
> >   delete mode 100644 tools/perf/pmu-events/jsmn.h
> >   delete mode 100644 tools/perf/pmu-events/json.c
> >   delete mode 100644 tools/perf/pmu-events/json.h
> >
>
