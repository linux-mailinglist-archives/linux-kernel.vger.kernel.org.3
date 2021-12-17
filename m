Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0454792AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhLQRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:18:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239776AbhLQRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:18:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 606C81042;
        Fri, 17 Dec 2021 09:18:51 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1F53F774;
        Fri, 17 Dec 2021 09:18:50 -0800 (PST)
Message-ID: <6467eef9-0160-b7d1-9ef0-4867dd0d17e4@foss.arm.com>
Date:   Fri, 17 Dec 2021 17:18:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 01/12] perf test: Shell - Limit to only run executable
 scripts in tests
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        inux-perf-users@vger.kernel.org, acme@kernel.org
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <5ae9ef1d-76bb-6ff3-fa34-27e9399f0110@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <5ae9ef1d-76bb-6ff3-fa34-27e9399f0110@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 14:55, Suzuki K Poulose wrote:
> On 15/12/2021 16:03, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> Perf test's shell runner will just run everything in the tests
>> directory (as long as it's not another directory or does not begin
>> with a dot), but sometimes you find files in there that are not shell
>> scripts - perf.data output for example if you do some testing and then
>> the next time you run perf test it tries to run these. Check the files
>> are executable so they are actually intended to be test scripts and
>> not just some "random junk" files there.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   tools/perf/tests/builtin-test.c |  4 +++-
>>   tools/perf/util/path.c          | 12 ++++++++++++
>>   tools/perf/util/path.h          |  1 +
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/builtin-test.c 
>> b/tools/perf/tests/builtin-test.c
>> index 8cb5a1c3489e..ece272b55587 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -295,7 +295,9 @@ static const char *shell_test__description(char 
>> *description, size_t size,
>>   #define for_each_shell_test(entlist, nr, base, 
>> ent)                    \
>>       for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)    \
>> -        if (!is_directory(base, ent) && ent->d_name[0] != '.')
>> +        if (!is_directory(base, ent) && \
>> +            is_executable_file(base, ent) && \
>> +            ent->d_name[0] != '.')
> 
> If we reorder the checks, we could potentially avoid a few
> syscalls for hidden items. i.e., if we do ent->d_name[0] != '.'
> first.

Could do that, thought this certainly is not a performance critical path 
and the code certainly shows that and doesn't care - can fix that too.

>>   static const char *shell_tests__dir(char *path, size_t size)
>>   {
>> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
>> index caed0336429f..7dde8c230ae8 100644
>> --- a/tools/perf/util/path.c
>> +++ b/tools/perf/util/path.c
>> @@ -92,3 +92,15 @@ bool is_directory(const char *base_path, const 
>> struct dirent *dent)
>>       return S_ISDIR(st.st_mode);
>>   }
>> +
>> +bool is_executable_file(const char *base_path, const struct dirent 
>> *dent)
>> +{
>> +    char path[PATH_MAX];
>> +    struct stat st;
>> +
>> +    sprintf(path, "%s/%s", base_path, dent->d_name);
> 
> Should this be snprintf() for additional safety ?

Ylou're right - I was just following the existing pattern int he code 
right above in is_directory() that uses sprintf :) I can fix both.

>> +    if (stat(path, &st))
>> +        return false;
>> +
>> +    return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
> 
> Otherwise looks good to me.
> 
> Suzuki
