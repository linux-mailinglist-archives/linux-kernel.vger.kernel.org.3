Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BB477CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbhLPTpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:45:45 -0500
Received: from foss.arm.com ([217.140.110.172]:47890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241045AbhLPTpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:45:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B6D12FC;
        Thu, 16 Dec 2021 11:45:44 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A193F774;
        Thu, 16 Dec 2021 11:45:42 -0800 (PST)
Message-ID: <2abc7355-190e-b8a6-173f-d3190a0229aa@foss.arm.com>
Date:   Thu, 16 Dec 2021 19:45:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/12] perf test: Shell - only run .sh shell files to skip
 other files
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        inux-perf-users@vger.kernel.org, acme@kernel.org
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
 <20211216102220.4q6dtfc4q4qyy2it@maple.lan>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20211216102220.4q6dtfc4q4qyy2it@maple.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 10:22, Daniel Thompson wrote:
> On Wed, Dec 15, 2021 at 04:03:53PM +0000, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> You edit your scripts in the tests and end up with your usual shell
>> backup files with ~ or .bak or something else at the end, but then your
>> next perf test run wants to run the backups too. You might also have perf
>> .data files in the directory or something else undesireable as well. You end
>> up chasing which test is the one you edited and the backup and have to keep
>> removing all the backup files, so automatically skip any files that are
>> not plain *.sh scripts to limit the time wasted in chasing ghosts.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Why require both executable *and* endswith('.sh')?

Paranoia. :) Making sure we really only run things that are meant to be 
run and avoid other junk/tmp/whatever files.

>> ---
>>   tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>> index ece272b55587..849737ead9fd 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -297,7 +297,20 @@ static const char *shell_test__description(char *description, size_t size,
>>   	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>>   		if (!is_directory(base, ent) && \
>>   			is_executable_file(base, ent) && \
>> -			ent->d_name[0] != '.')
>> +			ent->d_name[0] != '.' && \
>> +			(shell_file_is_sh(ent->d_name) == 0))
>> +
>> +static int shell_file_is_sh(const char *file)
>> +{
>> +	const char *ext;
>> +
>> +	ext = strchr(file, '.');
> 
> Shouldn't this be strrchr()?

Oh indeed probably should be. My bad. Nothing uses a dot inside the 
filename yet. I can fix that - will wait for the rest to come in before 
doing an update
