Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DDD549A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbiFMRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbiFMRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:39:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C5437BC7;
        Mon, 13 Jun 2022 06:08:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB44DD6E;
        Mon, 13 Jun 2022 06:08:46 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C294E3F792;
        Mon, 13 Jun 2022 06:08:45 -0700 (PDT)
Message-ID: <ae8bdc2c-a444-74c1-70d5-c97d27b22ec5@foss.arm.com>
Date:   Mon, 13 Jun 2022 14:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip
 other files
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
 <20220410022846.GB14326@leoy-ThinkPad-X240s>
 <9ab780aa-7e78-b0f9-21ed-cf30f41f8fab@foss.arm.com>
 <20220526101423.GB795802@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220526101423.GB795802@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 11:14, Leo Yan wrote:
> On Thu, Apr 21, 2022 at 05:21:27PM +0100, Carsten Haitzler wrote:
>> On 4/10/22 03:28, Leo Yan wrote:
>>> On Wed, Mar 09, 2022 at 12:28:58PM +0000, carsten.haitzler@foss.arm.com wrote:
>>>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>>>
>>>> You edit your scripts in the tests and end up with your usual shell
>>>> backup files with ~ or .bak or something else at the end, but then your
>>>> next perf test run wants to run the backups too. You might also have perf
>>>> .data files in the directory or something else undesireable as well. You end
>>>> up chasing which test is the one you edited and the backup and have to keep
>>>> removing all the backup files, so automatically skip any files that are
>>>> not plain *.sh scripts to limit the time wasted in chasing ghosts.
>>>>
>>>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>>>>
>>>> ---
>>>>    tools/perf/tests/builtin-test.c | 17 +++++++++++++++--
>>>>    1 file changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>>>> index 3c34cb766724..3a02ba7a7a89 100644
>>>> --- a/tools/perf/tests/builtin-test.c
>>>> +++ b/tools/perf/tests/builtin-test.c
>>>> @@ -296,9 +296,22 @@ static const char *shell_test__description(char *description, size_t size,
>>>>    #define for_each_shell_test(entlist, nr, base, ent)	                \
>>>>    	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>>>> -		if (!is_directory(base, ent) && \
>>>> +		if (ent->d_name[0] != '.' && \
>>>> +			!is_directory(base, ent) && \
>>>>    			is_executable_file(base, ent) && \
>>>> -			ent->d_name[0] != '.')
>>>> +			is_shell_script(ent->d_name))
>>>
>>> Just nitpick: since multiple conditions are added, seems to me it's good
>>> to use a single function is_executable_shell_script() to make decision
>>> if a file is an executable shell script.
>>
>> I'd certainly make a function if this was being re-used, but as the "coding
>> pattern" was to do all the tests already inside the if() in only one place,
>> I kept with the style there and didn't change the code that didn't need
>> changing. I can rewrite this code and basically make a function that is just
>> an if ...:
>>
>> bool is_exe_shell_script(const char *base, struct dirent *ent) {
>>     return ent->d_name[0] != '.'         && !is_directory(base, ent) &&
>>            is_executable_file(base, ent) && is_shell_script(ent->d_name);
>> }
>>
>> And macro becomes:
>>
>> #define for_each_shell_test(entlist, nr, base, ent) \
>>    for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++) \
>>      if (is_shell(base, ent))
> 
> Sorry for long latency.

No problem.

> If the condition checking gets complex, seems to me it is reasonable to
> use a static function (or a macro?) to encapsulate the logics.

Well normally my rule i s - if it gets re-used then do it, otherwise it 
just involves more indirection to follow. :) But regardless of that, 
given some other things you ask for that kind of makes this discussion 
moot as it requires much bigger wholesale changes to the test infra 
which will make these patches a lot more work. I'll get to that later in 
mails.

>> But one catch... it really should be is_non_hidden_exe_shell_script() as
>> it's checking that it's not a hidden file AND is a shell script. Or do I
>> keep the hidden file test outside of the function in the if? If we're nit
>> picking then I need to know exactly what you want here as your suggested
>> name is actually incorrect.
> 
> I personally prefer to use the condition:
> 
>    if (is_exe_shell_script() && ent->d_name[0] != '.')
>        do_something...
> 
> The reason is the function is_exe_shell_script() is more common and we
> use it easily in wider scope.

As above - will probably have to redo a lot of the test infra involving 
the shell tests to handle some of your other requests, but if we don't 
go that way, I have got where you want to go and I can do this.

>>> And the condition checking 'ent->d_name[0] != '.'' would be redundant
>>> after we have checked the file suffix '.sh'.
>>
>> This isn't actually redundant. You can have .something.sh :) If the idea is
>> we skip anything with a . at the start first always... then the if (to me)
>> is obvious.
> 
> Yeah, I agree the checking the start char '.' is the right thing
> to do.

:)
