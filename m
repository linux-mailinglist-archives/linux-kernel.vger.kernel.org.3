Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6666A4B2D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbiBKTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiBKTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:34:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52280CF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:34:45 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwP2J4Dz4z67YJ6;
        Sat, 12 Feb 2022 03:34:32 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 20:34:42 +0100
Received: from [10.81.199.170] (10.81.199.170) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 19:34:27 +0000
Message-ID: <2f1688de-a96b-75b7-9172-ff7efd91b6ef@huawei.com>
Date:   Fri, 11 Feb 2022 22:34:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v13 03/16] perf record: Introduce thread specific data
 array
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
CC:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhXG5yEHhrGDjvl@kernel.org> <Yfhg1zH9rQ3lBP9N@kernel.org>
 <YgaUA4O2wvFFeeQJ@kernel.org>
From:   Alexei Budankov <abudankov@huawei.com>
In-Reply-To: <YgaUA4O2wvFFeeQJ@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.199.170]
X-ClientProxiedBy: saopeml00100003.china.huawei.com (7.184.65.41) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.2022 19:51, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 31, 2022 at 07:21:11PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 31, 2022 at 06:39:39PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Some changes to reduce patch size, I have them in my local tree, will
>>> publish later.
>>
>> Its in perf/threaded at:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>>
>> Will continue tomorrow, testing it and checking the speedups on my
>> 5950x, I think the things I found so far can be fixed in follow up
>> patches, to make progress and have this merged sooner.
>>
>> I'll try and add committer notes with the test for some 'perf bench'
>> workload without/with parallel recording, something I missed in your
>> patch descriptions.
> 
> Didn't manage to do that, but my considerations are minor at this point
> and plenty of informed people acked, reviewed, tested, so I'm not going
> to be the one to prevent this from going upstream.
> 
> If we find problems (oh well), we'll fix it and progress.
> 
> Thank you, Alexei Budankov, Jiri, Namhyung and Riccardo for working on
> making perf scale at the record phase for so long,
> 
> I'm pushing this to perf/core, that should get into 5.18.

Please also accept my congratulations to
Alexey Bayduraev, Jiri, Namhyung and Riccardo Mancini
who made this happen.
Great work. Thanks!

Regards,
Alexei
