Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4049529F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiEQKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiEQKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:32:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D16A23BF0;
        Tue, 17 May 2022 03:32:09 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2XR56gmMz67Prk;
        Tue, 17 May 2022 18:29:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 12:32:06 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:32:04 +0100
Message-ID: <1e9d2bce-b967-dccb-e6af-241830e5b38e@huawei.com>
Date:   Tue, 17 May 2022 11:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 6/7] perf jevents: Switch build to use jevents.py
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20220511211526.1021908-1-irogers@google.com>
 <20220511211526.1021908-7-irogers@google.com>
 <d08b3d43-b02a-5aeb-e05e-f2f91d6a8f7a@huawei.com>
 <CAP-5=fUAXLL0CXrfrzYV2TT_31kouvJV-FWrZsipR27tT3i+uQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fUAXLL0CXrfrzYV2TT_31kouvJV-FWrZsipR27tT3i+uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.19]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 16:58, Ian Rogers wrote:
> On Fri, May 13, 2022 at 8:38 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 11/05/2022 22:15, Ian Rogers wrote:
>>>     # jevents.py uses os.scandir and type hints present in Python 3.5 released in Sept. 2015.
>>> +    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 5) else "0")')
>>
>> I think that many - like me - will have python 2.7, so now will find no
>> pmu-events generated any longer after missing this message in the build :(
>>
>> Maybe many will have python >= 3.5 - but I don't know...
> 
> So Python 2 has been end-of-life for over 2 years now:
> https://www.python.org/doc/sunset-python-2/
> There have been a number of LKML patches upgrading python to version 3.
> 
> Python 3.5 has some very nice features of os.scandir and type hints,
> so if I set the bar lower than this it hurts the code quality. It is
> also at least 6 years old at this point, and so hopefully not
> unreasonable for a distribution to have picked it up :-) Looking at
> the change to C11 thread:
> https://lore.kernel.org/lkml/20220228103142.3301082-1-arnd@kernel.org/
> It seems the motivation for picking a language version is the features
> it provides and compatibility. If we choose pre-Python 3.5 we get more
> compatibility but we lose language features.
> 
> My feeling is that we shouldn't need to support things that are no
> longer maintained (like Python 2) but I'm less clear if Python 3.5 is
> sufficiently compatible for everyone's needs. I kind of hope so, hence
> making the patches this way.

Fine, I just think that you need to make this transition as seamless as 
possible, otherwise it can be judged as a regression.

For example, I have now python 3.6 (default) and 2.7 but it still 
doesn't seem to work:

john@localhost:~/acme/tools/perf> make
   BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' 
differs from latest version at 'include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
Makefile.config:593: No sys/sdt.h found, no SDT events are defined, 
please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:871: Python interpreter too old (older than 3.5) 
disabling jevent generation
Makefile.config:904: Old version of libbfd/binutils things like PE 
executable profiling will not be available
Makefile.config:1092: No openjdk development package found, please 
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
john@localhost:~/acme/tools/perf>

which I need to figure out...

> 
>>   > + ifneq ($(JEVENTS_PYTHON_GOOD), 1)
>>   > + $(warning Python interpreter too old (older than 3.5) disabling
>> jevent generation)
>>   > + NO_JEVENTS := 1
>>
>> It is possible to flip NO_JEVENTS to be JEVENTS, i.e. no
>> double-negatives, like NO_JEVENTS := 0
> 
> Agreed that double negatives are bad. The NO_... pattern is kind of
> throughout the make files and build files. I preferred the NO_... for
> consistency but if there's a consensus I'm happy to change.
> 

I have no strong preference. I just find that double negatives boggle 
the mind.

Thanks,
john
