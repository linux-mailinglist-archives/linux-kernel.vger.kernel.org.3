Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6B58E8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiHJIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiHJIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:38:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D92411835E;
        Wed, 10 Aug 2022 01:38:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6670C1FB;
        Wed, 10 Aug 2022 01:38:56 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4FE73F70D;
        Wed, 10 Aug 2022 01:38:54 -0700 (PDT)
Message-ID: <7b3bdad2-906b-98ea-239f-e76703a0f7a4@foss.arm.com>
Date:   Wed, 10 Aug 2022 09:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 01/14] perf test: Refactor shell tests allowing subdirs
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-2-carsten.haitzler@foss.arm.com>
 <20220806083712.GA124146@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220806083712.GA124146@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/22 09:37, Leo Yan wrote:
> On Thu, Jul 28, 2022 at 03:52:43PM +0100, carsten.haitzler@foss.arm.com wrote:
> 
> [...]
> 
>> +int list_script_max_width(void)
>> +{
>> +	list_script_files(); /* Ensure we have scanned all scriptd */
> 
> s/scriptd/scripts/

oops. fixed. v6 will come with that.

>> +	return files_max_width;
>> +}
> 
> [...]
> 
>>   struct shell_test {
>>   	const char *dir;
>>   	const char *file;
>> @@ -385,33 +302,17 @@ static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
>>   static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   				struct intlist *skiplist)
>>   {
>> -	struct dirent **entlist;
>> -	struct dirent *ent;
>> -	int n_dirs, e;
>> -	char path_dir[PATH_MAX];
>> -	struct shell_test st = {
>> -		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
>> -	};
>> -
>> -	if (st.dir == NULL)
>> -		return -1;
>> +	struct shell_test st;
>> +	const struct script_file *files, *file;
>>   
>> -	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
>> -	if (n_dirs == -1) {
>> -		pr_err("failed to open shell test directory: %s\n",
>> -			st.dir);
>> -		return -1;
>> -	}
>> -
>> -	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
>> +	files = list_script_files();
>> +	if (!files)
>> +		return 0;
>> +	for (file = files; file->dir; file++) {
>>   		int curr = i++;
>> -		char desc[256];
>>   		struct test_case test_cases[] = {
>>   			{
>> -				.desc = shell_test__description(desc,
>> -								sizeof(desc),
>> -								st.dir,
>> -								ent->d_name),
>> +				.desc = file->desc,
>>   				.run_case = shell_test__run,
>>   			},
>>   			{ .name = NULL, }
>> @@ -421,12 +322,13 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   			.test_cases = test_cases,
>>   			.priv = &st,
>>   		};
>> +		st.dir = file->dir;
>>   
>>   		if (test_suite.desc == NULL ||
>>   		    !perf_test__matches(test_suite.desc, curr, argc, argv))
>>   			continue;
>>   
>> -		st.file = ent->d_name;
>> +		st.file = file->file;
> 
> I am just wandering if we can remove "st" in this function, finally I
> found you are right, the "st" (struct shell_test) will be used in the
> function shell_test__run(), so let's keep as it is.
> 
>>   		pr_info("%3d: %-*s:", i, width, test_suite.desc);
>>   
>>   		if (intlist__find(skiplist, i)) {
>> @@ -436,10 +338,6 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   
>>   		test_and_print(&test_suite, 0);
>>   	}
>> -
>> -	for (e = 0; e < n_dirs; e++)
>> -		zfree(&entlist[e]);
>> -	free(entlist);
>>   	return 0;
>>   }
>>   
>> @@ -448,7 +346,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>>   	struct test_suite *t;
>>   	unsigned int j, k;
>>   	int i = 0;
>> -	int width = shell_tests__max_desc_width();
>> +	int width = list_script_max_width();
>>   
>>   	for_each_test(j, k, t) {
>>   		int len = strlen(test_description(t, -1));
>> @@ -529,36 +427,22 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>>   
>>   static int perf_test__list_shell(int argc, const char **argv, int i)
>>   {
>> -	struct dirent **entlist;
>> -	struct dirent *ent;
>> -	int n_dirs, e;
>> -	char path_dir[PATH_MAX];
>> -	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>> -
>> -	if (path == NULL)
>> -		return -1;
>> +	const struct script_file *files, *file;
>>   
>> -	n_dirs = scandir(path, &entlist, NULL, alphasort);
>> -	if (n_dirs == -1)
>> -		return -1;
>> -
>> -	for_each_shell_test(entlist, n_dirs, path, ent) {
>> +	files = list_script_files();
>> +	if (!files)
>> +		return 0;
>> +	for (file = files; file->dir; file++) {
>>   		int curr = i++;
>> -		char bf[256];
>>   		struct test_suite t = {
>> -			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
>> +			.desc = file->desc
>>   		};
>>   
>>   		if (!perf_test__matches(t.desc, curr, argc, argv))
>>   			continue;
>>   
>>   		pr_info("%3d: %s\n", i, t.desc);
>> -
>>   	}
>> -
>> -	for (e = 0; e < n_dirs; e++)
>> -		zfree(&entlist[e]);
>> -	free(entlist);
>>   	return 0;
>>   }
> 
> Except a minor typo, the patch looks good to me, it's a good
> refactoring and enhancement for shell script testing.
> 
> I reviewed the change one by one line, at least I cannot find any logic
> error.
> 
> With typo fixing:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> I'd leave this patch for maintainers to review it.  Just a caveat, given
> it's a big patch, as Carsten replied it's good that take the patch as a
> total new code for searching shell scripts, this would be easier for
> understanding the change.
> 
> Thanks,
> Leo
