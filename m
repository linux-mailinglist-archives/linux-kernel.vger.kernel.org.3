Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FD54B519
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbiFNPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbiFNPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:49:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC86369C3;
        Tue, 14 Jun 2022 08:49:55 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LMtDF2Cvtz68Bfb;
        Tue, 14 Jun 2022 23:49:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:49:52 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 16:49:51 +0100
Message-ID: <f94710b3-4ca8-47c5-939c-1ad01d712d5f@huawei.com>
Date:   Tue, 14 Jun 2022 16:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/3] Rewrite jevents program in python
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
References: <20220527185426.240235-1-irogers@google.com>
 <d9056bc2-f640-f676-2599-c283479376a4@huawei.com>
 <CAP-5=fU8Wn8wV0whYOraU+5tGf+kKUk73gSwOg+LHp19vzua3A@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fU8Wn8wV0whYOraU+5tGf+kKUk73gSwOg+LHp19vzua3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 23:43, Ian Rogers wrote:
> On Wed, Jun 1, 2022 at 9:17 AM John Garry<john.garry@huawei.com>  wrote:
>> On 27/05/2022 19:54, Ian Rogers wrote:
>>> New architectures bring new complexity, such as Intel's hybrid
>>> models. jevents provides an alternative to specifying events in the
>>> kernel and exposing them through sysfs, however, it is difficult to
>>> work with. For example, an error in the json input would yield an
>>> error message but no json file or location. It is also a challenge to
>>> update jsmn.c given its forked nature.
>>>
>>> The changes here switch from jevents.c to a rewrite in python called
>>> jevents.py. This means there is a build time dependency on python, but
>>> such a dependency already exists for asciidoc (used to generate perf's
>>> man pages). If the build detects that python isn't present or is older
>>> than version 3.6 (released Dec. 2016) then an empty file is
>>> substituted for the generated one.
>>>
>>> A challenge with this code is in avoiding regressions. For this reason
>>> the jevents.py produces identical output to jevents.c, validated with a
>>> test script and build target.
>>>
>> Hi Ian,
>>
>> I still see this:
>>
>> ...
>> Makefile.config:906: Python interpreter too old (older than 3.6)
>> disabling jevent generation
>> Makefile.config:939: Old version of libbfd/binutils things like PE
>> executable profiling will not be available
>> Makefile.config:1127: No openjdk development package found, please
>> install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>>
>> Auto-detecting system features:
>> ...                         dwarf: [ on  ]
>> ...            dwarf_getlocations: [ on  ]
>> ...                         glibc: [ on  ]
>> ...                        libbfd: [ OFF ]
>> ...                libbfd-buildid: [ OFF ]
>> ...                        libcap: [ on  ]
>> ...                        libelf: [ on  ]
>> ...                       libnuma: [ on  ]
>> ...        numa_num_possible_cpus: [ on  ]
>> ...                       libperl: [ on  ]
>> ...                     libpython: [ on  ]
>> ...                     libcrypto: [ on  ]
>> ...                     libunwind: [ on  ]
>> ...            libdw-dwarf-unwind: [ on  ]
>> ...                          zlib: [ on  ]
>> ...                          lzma: [ on  ]
>> ...                     get_cpuid: [ on  ]
>> ...                           bpf: [ on  ]
>> ...                        libaio: [ on  ]
>> ...                       libzstd: [ on  ]
>> ...        disassembler-four-args: [ on  ]
>>
>>
>> make[3]: Nothing to be done for 'install_headers'.
>> john@localhost:~/acme/tools/perf> python --version
>> Python 3.6.12
>>
>> I need to figure out what is going wrong...
> Thanks for testing John! Could you try adding something like this:
> ```
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 9538d737d655..c23f39e21a70 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -901,6 +901,8 @@ ifneq ($(NO_JEVENTS),1)
>      NO_JEVENTS := 1
>    else
>      # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
> +    PYTHON_VERSION=$(shell $(PYTHON) -c 'import sys;print(sys.version_info)')
> +    $(error $(PYTHON_VERSION))
>      JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1"
> if(sys.version_info.major >=
> 3 and sys.version_info.minor >= 6) else "0")')
>      ifneq ($(JEVENTS_PYTHON_GOOD), 1)
>        $(warning Python interpreter too old (older than 3.6) disabling
> jevent generation)
> ```

That gives:

Makefile.config:459: No libdw DWARF unwind found, Please install 
elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
Makefile.config:464: No libdw.h found or old libdw.h found or elfutils 
is older than 0.138, disables dwarf support. Please install new 
elfutils-devel/libdw-dev
Makefile.config:617: DWARF support is off, BPF prologue is disabled
Makefile.config:667: No debug_frame support found in libunwind-aarch64
Makefile.config:738: No debug_frame support found in libunwind
Makefile.config:906: *** sys.version_info(major=2, minor=7, micro=13, 
releaselevel='final', serial=0).Stop.
Makefile.perf:239: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
john@debian:~/linux/tools/perf$ python --version
Python 3.6.9
john@debian:~/linux/tools/perf$

> You can also specify which python you want on the make command line,
> for example adding PYTHON=`which python` at the end of your make
> command.

diff -u tools/perf/trace/beauty/include/linux/socket.h 
include/linux/socket.h
Makefile.config:259: *** which python-config not found. Stop.
Makefile.perf:239: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
john@debian:~/linux/tools/perf$

JFYI, this is my alternatives:

sudo update-alternatives --config python
There are 3 choices for the alternative python (providing 
/usr/bin/python).

   Selection    Path			 Priority  Status
------------------------------------------------------------
   0            /usr/local/bin/python3.6   50        auto mode
   1            /usr/bin/python2.7         1         manual mode
   2            /usr/bin/python3.5         2         manual mode
* 3            /usr/local/bin/python3.6   50        manual mode

Press <enter> to keep the current choice[*], or type selection number: 



Can someone else try this? Arnaldo?

Sorry for being useless with this....
