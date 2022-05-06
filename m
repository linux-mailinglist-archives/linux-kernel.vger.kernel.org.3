Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3693A51DC49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443016AbiEFPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbiEFPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:43:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEFA5C36A;
        Fri,  6 May 2022 08:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FA14B836B2;
        Fri,  6 May 2022 15:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495CC385A8;
        Fri,  6 May 2022 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651851607;
        bh=rfwz+CxR9lcH5PvNEzBPf/a6aAXijiYCr8VOr5vMEQs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V8FY9qGNOk69+gCbRILze5+POPMLVFUnPFBRMXqxhLB6hZCCUyGVdAns2nVHPMWDx
         Ky/TFqZ4hfeHYCsqtohNGoD8CKjQJhKI7LUAPGuTayLN8FqDoTdy52tQYXrb7qLe+7
         QoFGrvCQh3x0sfV8oUpief++84UgnnppklVfblzPeKIG7f8FA0ZVY4JaJn2UvXOoQa
         O18pjigxv1ckweBeivgU5tPxW95aimtXYIi+N3XBjYyDDgPapf1MQrpyiqfA6A7Zre
         lHxUn/UGdQpupmgnNfsHMbuxYX40Q+Ai9Y1lHOmDGxfsvyvH641rQqhh8z/gilovJI
         jVCLMTg1/lGFg==
Message-ID: <1ebd6c1d-4409-df70-165c-6f181764a617@kernel.org>
Date:   Fri, 6 May 2022 17:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] rtla: Remove procps-ng dependency
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <dwagner@suse.de>
References: <a0f9f8c1030c66305c9b921057c3d483064d5529.1651220820.git.bristot@kernel.org>
 <YnU5gtSFW8Wl54iv@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YnU5gtSFW8Wl54iv@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 17:06, Tao Zhou wrote:
> On Fri, Apr 29, 2022 at 03:01:48PM +0200,
> Daniel Bristot de Oliveira wrote:
> 
>> Daniel Wagner reported to me that readproc.h got deprecated. Also,
>> while the procps-ng library was available on Fedora, it was not available
>> on RHEL, which is a piece of evidence that it was not that used.
>>
>> rtla uses procps-ng only to find the PID of the tracers' workload.
>>
>> I used the procps-ng library to avoid reinventing the wheel. But in this
>> case, reinventing the wheel took me less time than the time we already
>> took trying to work around problems.
>>
>> Implement a function that reads /proc/ entries, checking if:
>> 	- the entry is a directory
>> 	- the directory name is composed only of digits (PID)
>> 	- the directory contains the comm file
>> 	- the comm file contains a comm that matches the tracers'
>> 	  workload prefix.
>> 	- then return true; otherwise, return false.
>>
>> And use it instead of procps-ng.
>>
>> Changes from V1:
>>   - Use a single buffer for comm and comm_path
>>   - Cause an error in case of a too long command prefix
>>   - Do a close_dir()
>>   - Improve log messages
>>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Fixes: b1696371d865 ("rtla: Helper functions for rtla")
>> Reported-by: Daniel Wagner <dwagner@suse.de>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>


[...]

>> +
>>  /*
>> - * set_comm_sched_attr - set sched params to threads starting with char *comm
>> + * procfs_is_workload_pid - check if a procfs entry contains a comm_prefix* comm
>> + *
>> + * Check if the procfs entry is a directory of a process, and then check if the
>> + * process has a comm with the prefix set in char *comm_prefix. As the
>> + * current users of this function only check for kernel threads, there is no
>> + * need to check for the threads for the process.
>>   *
>> - * This function uses procps to list the currently running threads and then
>> - * set the sched_attr *attr to the threads that start with char *comm. It is
>> + * Return: True if the proc_entry contains a comm file with comm_prefix*.
>> + * Otherwise returns false.
>> + */
>> +static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_entry)
>> +{
>> +	char buffer[MAX_PATH];
>> +	int comm_fd, retval;
>> +	char*t_name;
> 
> Need a blank..
> char *t_name;


right

>> +
>> +	if (proc_entry->d_type != DT_DIR)
>> +		return 0;
>> +
>> +	if (*proc_entry->d_name == '.')
>> +		return 0;
>> +
>> +	/* check if the string is a pid */
>> +	for (t_name = proc_entry->d_name; t_name; t_name++) {
>> +		if (!isdigit(*t_name))
>> +			break;
>> +	}
>> +
>> +	if (*t_name != '\0')
>> +		return 0;
>> +
>> +	snprintf(buffer, MAX_PATH, "/proc/%s/comm", proc_entry->d_name);
>> +	comm_fd = open(buffer, O_RDONLY);
>> +	if (comm_fd < 0)
>> +		return 0;
>> +
>> +	memset(buffer, 0, MAX_PATH);
>> +	retval = read(comm_fd, buffer, MAX_PATH);
>> +
>> +	close(comm_fd);
>> +
>> +	if (retval <= 0)
>> +		return 0;
>> +
>> +	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
>> +	if (retval)
>> +		return 0;
> 
> 
> Confused.
> 
> For example:
> comm_prefix is "osnoise/", buffer is "osnoise\n"(as said by comment below),
> strlen_prefix is 8. The return value of strncmp() is 1 and not set sched attr.

it should not set "osnoise" thread priority... so it is correct.

> Or use "osnoise" as the comm_prefix. Or am I miss something here.

I am looking for "osnoise/$CPU" threads, not "osnoise" threads. Run rtla osnoise
with log messages (-D) you will see it finding the expected threads.

>> +	/* comm already have \n */
>> +	debug_msg("Found workload pid:%s comm:%s", proc_entry->d_name, buffer);
>> +
>> +	return 1;
>> +}
>> +
>> +/*
>> + * set_comm_sched_attr - set sched params to threads starting with char *comm_prefix
>> + *
>> + * This function uses procps to list the currently running threads and then set the
> 
> s/procps/procfs/

right

Thanks
-- Daniel
> 
> Thanks,
> Tao
