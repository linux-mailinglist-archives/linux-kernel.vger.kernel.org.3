Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5D53AADC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356051AbiFAQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiFAQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:17:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7357175;
        Wed,  1 Jun 2022 09:17:47 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCvNZ3Xdqz67ZHP;
        Thu,  2 Jun 2022 00:14:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:17:44 +0200
Received: from [10.47.88.115] (10.47.88.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 17:17:42 +0100
Message-ID: <d9056bc2-f640-f676-2599-c283479376a4@huawei.com>
Date:   Wed, 1 Jun 2022 17:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/3] Rewrite jevents program in python
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        "Felix Fietkau" <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
CC:     Stephane Eranian <eranian@google.com>
References: <20220527185426.240235-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220527185426.240235-1-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.115]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 19:54, Ian Rogers wrote:
> New architectures bring new complexity, such as Intel's hybrid
> models. jevents provides an alternative to specifying events in the
> kernel and exposing them through sysfs, however, it is difficult to
> work with. For example, an error in the json input would yield an
> error message but no json file or location. It is also a challenge to
> update jsmn.c given its forked nature.
> 
> The changes here switch from jevents.c to a rewrite in python called
> jevents.py. This means there is a build time dependency on python, but
> such a dependency already exists for asciidoc (used to generate perf's
> man pages). If the build detects that python isn't present or is older
> than version 3.6 (released Dec. 2016) then an empty file is
> substituted for the generated one.
> 
> A challenge with this code is in avoiding regressions. For this reason
> the jevents.py produces identical output to jevents.c, validated with a
> test script and build target.
> 

Hi Ian,

I still see this:

...
Makefile.config:906: Python interpreter too old (older than 3.6) 
disabling jevent generation
Makefile.config:939: Old version of libbfd/binutils things like PE 
executable profiling will not be available
Makefile.config:1127: No openjdk development package found, please 
install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                        libbfd: [ OFF ]
...                libbfd-buildid: [ OFF ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]


make[3]: Nothing to be done for 'install_headers'.
john@localhost:~/acme/tools/perf> python --version
Python 3.6.12

I need to figure out what is going wrong...

Thanks,
John

> v3. Updates the patches for merged changes (on
>      acme/tmp.perf/core). Re-runs all comparisons to make sure the
>      generated pmu-events.c isn't altered at all by this change. Adds
>      the jevents.c ExtSel fix in:
>      https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
>      Bumps the python version from 3.5 to 3.6, as f-strings weren't
>      introduced until 3.6.
> 
> v2. Fixes the build for architectures that don't have pmu-events json
>      (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
>      build for python not being present or too old (Suggested-by: Peter
>      Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> 
> Ian Rogers (3):
>    perf jevents: Add python converter script
>    perf jevents: Switch build to use jevents.py
>    perf jevents: Remove jevents.c
> 
>   tools/perf/Makefile.config               |   19 +
>   tools/perf/Makefile.perf                 |   16 +-
>   tools/perf/pmu-events/Build              |   15 +-
>   tools/perf/pmu-events/empty-pmu-events.c |   21 +
>   tools/perf/pmu-events/jevents.c          | 1342 ----------------------
>   tools/perf/pmu-events/jevents.py         |  392 +++++++
>   tools/perf/pmu-events/jsmn.h             |   68 --
>   tools/perf/pmu-events/json.c             |  162 ---
>   tools/perf/pmu-events/json.h             |   39 -
>   9 files changed, 444 insertions(+), 1630 deletions(-)
>   create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
>   delete mode 100644 tools/perf/pmu-events/jevents.c
>   create mode 100755 tools/perf/pmu-events/jevents.py
>   delete mode 100644 tools/perf/pmu-events/jsmn.h
>   delete mode 100644 tools/perf/pmu-events/json.c
>   delete mode 100644 tools/perf/pmu-events/json.h
> 

