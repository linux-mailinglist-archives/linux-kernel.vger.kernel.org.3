Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241C54B588
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356843AbiFNQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiFNQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:10:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5C2B1B8;
        Tue, 14 Jun 2022 09:10:29 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LMtfD5PNxz688jJ;
        Wed, 15 Jun 2022 00:08:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 14 Jun 2022 18:10:26 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:10:24 +0100
Message-ID: <350b905c-1ac1-3577-6b56-c13f2aeab712@huawei.com>
Date:   Tue, 14 Jun 2022 17:13:32 +0100
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
 <f94710b3-4ca8-47c5-939c-1ad01d712d5f@huawei.com>
 <CAP-5=fWO8wd2xqi2acJ0FGyLgE3dQDw2m9=AUCC_veseyuybJw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fWO8wd2xqi2acJ0FGyLgE3dQDw2m9=AUCC_veseyuybJw@mail.gmail.com>
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

On 14/06/2022 17:03, Ian Rogers wrote:
>> diff -u tools/perf/trace/beauty/include/linux/socket.h
>> include/linux/socket.h
>> Makefile.config:259: *** which python-config not found. Stop.
>> Makefile.perf:239: recipe for target 'sub-make' failed
>> make[1]: *** [sub-make] Error 2
>> Makefile:69: recipe for target 'all' failed
>> make: *** [all] Error 2
>> john@debian:~/linux/tools/perf$
>>
>> JFYI, this is my alternatives:
>>
>> sudo update-alternatives --config python
>> There are 3 choices for the alternative python (providing
>> /usr/bin/python).
>>
>>     Selection    Path                     Priority  Status
>> ------------------------------------------------------------
>>     0            /usr/local/bin/python3.6   50        auto mode
>>     1            /usr/bin/python2.7         1         manual mode
>>     2            /usr/bin/python3.5         2         manual mode
>> * 3            /usr/local/bin/python3.6   50        manual mode
>>
>> Press <enter> to keep the current choice[*], or type selection number:
> Thanks Gary,
> 
> Perhaps it relates to dev packages. Perhaps, apt-get install
> python-dev-is-python3 which should resolve the symlinks. I wonder that
> you have python dev for python2 but python3 installed without the dev.
> We should be able to make a Makefile test for this.

So I was trying another system here as a sanity test (as my main dev box 
is not working either). And this other system is debian and only 
supports python up to 3.5, so that is why I have 
/usr/local/bin/python3.6 as an alt, i.e. I downloaded and built myself.

Anyway, I do have python3-dev:

john@debian:~/linux/tools/perf$ sudo apt-get install python3-dev
Reading package lists... Done
Building dependency tree
Reading state information... Done
python3-dev is already the newest version (3.5.3-1).

