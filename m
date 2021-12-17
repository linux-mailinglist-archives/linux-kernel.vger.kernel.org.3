Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB414792BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhLQRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:22:59 -0500
Received: from foss.arm.com ([217.140.110.172]:60572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239525AbhLQRW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:22:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D991042;
        Fri, 17 Dec 2021 09:22:57 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EDEB3F774;
        Fri, 17 Dec 2021 09:22:56 -0800 (PST)
Message-ID: <f24b6003-9cc6-36dd-5853-20129acd056e@foss.arm.com>
Date:   Fri, 17 Dec 2021 17:22:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/12] perf test: Shell - only run .sh shell files to skip
 other files
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        inux-perf-users@vger.kernel.org, acme@kernel.org
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
 <5c509114-f383-2876-36ae-8648d886a09e@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <5c509114-f383-2876-36ae-8648d886a09e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 15:00, Suzuki K Poulose wrote:
> On 15/12/2021 16:03, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> You edit your scripts in the tests and end up with your usual shell
>> backup files with ~ or .bak or something else at the end, but then your
>> next perf test run wants to run the backups too. You might also have perf
>> .data files in the directory or something else undesireable as well. 
>> You end
>> up chasing which test is the one you edited and the backup and have to 
>> keep
>> removing all the backup files, so automatically skip any files that are
>> not plain *.sh scripts to limit the time wasted in chasing ghosts.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/builtin-test.c 
>> b/tools/perf/tests/builtin-test.c
>> index ece272b55587..849737ead9fd 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -297,7 +297,20 @@ static const char *shell_test__description(char 
>> *description, size_t size,
>>       for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)    \
>>           if (!is_directory(base, ent) && \
>>               is_executable_file(base, ent) && \
>> -            ent->d_name[0] != '.')
>> +            ent->d_name[0] != '.' && \
>> +            (shell_file_is_sh(ent->d_name) == 0))
>> +
>> +static int shell_file_is_sh(const char *file)
> 
> nit: In line with the other "helpers", could this be:
> 
> is_shell_file_sh() or even is_shell_script() ?
> 
> Also, for consistency, could this be bool, like the other helpers ?
> 
> i.e., returns true when the condition matches ?
> 
> Suzuki

Sure - I was going for the other pattern where 0 == 
true/matches/succeeds pattern but can use the bool one and give it a 
slight rename.

>> +{
>> +    const char *ext;
>> +
>> +    ext = strchr(file, '.');
>> +    if (!ext)
>> +        return -1;
>> +    if (!strcmp(ext, ".sh"))
>> +        return 0;
>> +    return -1;
>> +}
> 
> 
>>   static const char *shell_tests__dir(char *path, size_t size)
>>   {
> 
