Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C279513581
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347578AbiD1NrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbiD1NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:47:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CEBB3DDC;
        Thu, 28 Apr 2022 06:44:01 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpxbT2CTMz6800p;
        Thu, 28 Apr 2022 21:41:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 15:43:58 +0200
Received: from [10.47.91.78] (10.47.91.78) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 14:43:57 +0100
Message-ID: <72c6c1b4-5e83-02e3-6051-c11b3bfff452@huawei.com>
Date:   Thu, 28 Apr 2022 14:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf test: Fix test case 81 on s390x
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>
References: <20220428122821.3652015-1-tmricht@linux.ibm.com>
 <YmqV5o0XFfewhNkC@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YmqV5o0XFfewhNkC@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.78]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 14:25, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 28, 2022 at 02:28:21PM +0200, Thomas Richter escreveu:
>> perf test -F 81 -v fails on s390x on the linux-next branch.
>> The test case is x86 specific can not be executed on s390x.
>> The test case depends on x86 register names such as
>>
>>    ... | egrep -q 'available registers: AX BX CX DX ....'
> 
> Thanks,
> 
> Ian, I guess this will break on other !x86 arches as well.

JFYI, arm64 gives on acme perf/core branch @ e0c1b8f9eb this:

john@debian:~/acme/tools/perf$ sudo ./perf test -F 82
  82: perf record tests     :Basic --per-thread mode test
Basic --per-thread mode test [Success]
Register capture test
Register capture test [Skipped missing instruction]
  Ok
john@debian:~/acme/tools/perf$

> Can you
> please take a look?
> 
> - Arnaldo
>   
>> Skip this test case on s390x.
>>
>> Output before:
>>   # perf test -F 81
>>   81: perf record tests                       : FAILED!
>>   #
>>
>> Output after:
>>   # perf test -F 81
>>   81: perf record tests                       : Skip
>>   #
>>
>> Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
>> Cc: Ian Rogers <irogers@google.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>   tools/perf/tests/shell/record.sh | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index cd1cf14259b8..d98f4d4a00e1 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -37,6 +37,8 @@ test_register_capture() {
>>     echo "Register capture test [Success]"
>>   }
>>   
>> +# Test for platform support and return TEST_SKIP
>> +[ $(uname -m) = s390x ] && exit 2
>>   test_per_thread
>>   test_register_capture
>>   exit $err
>> -- 
>> 2.35.1
> 

