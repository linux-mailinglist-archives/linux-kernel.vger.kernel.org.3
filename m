Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E08521517
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiEJMY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbiEJMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A82A18B4;
        Tue, 10 May 2022 05:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF07AB81BD8;
        Tue, 10 May 2022 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8739C385C2;
        Tue, 10 May 2022 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652185224;
        bh=3m3FiDizpECko0NYhaElUGPO30GCz7OkhP3676HbFhI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tAkbjkvidn/dYYP93JfnBXp/11xM7M8yioPwAC0siYL0piOsILGWTWsjB+b3NlsVY
         Yqf1IfITwRUkZUggfoQvYLW2d57NGSfiZXakFptJWf7UPEb3q5cv519pm/ZemFWbg5
         F7phSF6z0lkW8Mj31Y6+rDbS2cuczJQm34zC3NECJXwvSCFAzmrw2zup43PuM5CJC5
         xKw+znJDgSzAlFY5xsdBm3J3xV70bpAVNQjVpmPQ2aBIwp7QEHOTAOwiDpIg0XlKoB
         DLygQJ7pDUFKJTpz0psTqsKpY83397oxR5ei6SelEKgSUNy3ng5XTIUKNEaP2M5HBv
         CCZ4X4JJW0Dcw==
Message-ID: <6bd4ced4-88b9-89ce-9674-6678784a2f47@kernel.org>
Date:   Tue, 10 May 2022 14:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V3] rtla: Remove procps-ng dependency
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Kacur <jkacur@redhat.com>, Tao Zhou <tao.zhou@linux.dev>
References: <553032a74ccdb1e6ae4dda543b7c4430ce8fae1a.1652176288.git.bristot@kernel.org>
 <20220510113033.auxhunymxbhioi4z@carbon.lan>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220510113033.auxhunymxbhioi4z@carbon.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 13:30, Daniel Wagner wrote:
> On Tue, May 10, 2022 at 11:57:04AM +0200, Daniel Bristot de Oliveira wrote:

>> -int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
>> +int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
>>  {
>> -	int flags = PROC_FILLCOM | PROC_FILLSTAT;
>> -	PROCTAB *ptp;
>> -	proc_t task;
>> +	struct dirent *proc_entry;
>> +	DIR *procfs;
>>  	int retval;
>>  
>> -	ptp = openproc(flags);
>> -	if (!ptp) {
>> -		err_msg("error openproc()\n");
>> -		return -ENOENT;
>> +	if (strlen(comm_prefix) >= MAX_PATH) {
>> +		err_msg("Command prefix is too long: %d < strlen(%s)\n",
>> +			MAX_PATH, comm_prefix);
>> +		exit(EINVAL);
>>  	}
>>  
>> -	memset(&task, 0, sizeof(task));
>> +	procfs = opendir("/proc");
> 
> Maybe you want to check if procfs is a valid handle before using it.

Yes I want!

>> +
>> +	while ((proc_entry = readdir(procfs))) {
>>  
>> -	while (readproc(ptp, &task)) {
>> -		retval = strncmp(comm, task.cmd, strlen(comm));
>> -		if (retval)
>> +		retval = procfs_is_workload_pid(comm_prefix, proc_entry);
>> +		if (!retval)
>>  			continue;
>> -		retval = __set_sched_attr(task.tid, attr);
>> -		if (retval)
>> +
>> +		/* procfs_is_workload_pid confirmed it is a pid */
>> +		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
>> +		if (retval) {
>> +			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
>>  			goto out_err;
>> -	}
>> +		}
>>  
>> -	closeproc(ptp);
>> +		debug_msg("Set sched attributes for pid:%s\n", proc_entry->d_name);
>> +	}
>>  	return 0;
>>  
>>  out_err:
>> -	closeproc(ptp);
>> +	closedir(procfs);
>>  	return 1;
>>  }
>>  
>> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
>> index fa08e374870a..5571afd3b549 100644
>> --- a/tools/tracing/rtla/src/utils.h
>> +++ b/tools/tracing/rtla/src/utils.h
>> @@ -6,6 +6,7 @@
>>   * '18446744073709551615\0'
>>   */
>>  #define BUFF_U64_STR_SIZE	24
>> +#define MAX_PATH		1024
> 
> linux/limits.h defined MAX_PATH as well, though as 4096. Maybe use that
> definition? If you want to make it dynamic you could use fpathconf(fd,
> _PC_PATH_MAX) but one could argue that is over engineering :)
> 
> Thanks for the fix. Anyway just nitpicking.

Fedora did not find it by default... let's just define our own here.

> Reviewed-by: Daniel Wagner <dwagner@suse.de>
Thanks!
-- Daniel

