Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF850FC60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349731AbiDZMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiDZMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0256425;
        Tue, 26 Apr 2022 04:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C360061450;
        Tue, 26 Apr 2022 11:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D19C385AD;
        Tue, 26 Apr 2022 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650974237;
        bh=twfTbbwUvKw/8ZG6RW1rx/zAXpWAE+uv7bndMdyjTh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ovmbWjM4yMUna6oFKMWFskjFHX7UssxUvkdzmOFocV6oOR932Hrv61+uG+kWdyWqX
         RSvufD0OlEd1PHn7iRYbD6zs/e5IOLv432NI+fgyWvPB285wBoS09Y9kJFOKIL/Zvz
         lyvXZQM9mTrQzD2qv5O9JGJm9gEoCzXcAzRmOyQMMS/iWW650OwOsFiMcYcczJD9c+
         PWMumhLZ4XD+cMH7aLRlidJNsP8vEZ7FddLHHkLlrxin16WXiQ6VIlO8frKJb4qL37
         d3eZuWR3CM6A49SDlQpdNjTGxsY1vHjL8l53K/oMae9WW7imJCCGiN8lwp32ViUPvv
         zXjo7j4nOTjZw==
Message-ID: <1535620a-5a41-1ec4-3963-c9bc3b8e117f@kernel.org>
Date:   Tue, 26 Apr 2022 13:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] rtla: Remove procps-ng dependency
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <dwagner@suse.de>
References: <52161d343abeda6d039d2f0734904a1383a4c62e.1650617571.git.bristot@kernel.org>
 <20220425214559.55988956@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220425214559.55988956@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 03:45, Steven Rostedt wrote:
> On Fri, 22 Apr 2022 12:01:31 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> 
>> +
>> +/*
>> + * procfs_is_workload_pid - check if a procfs entry contains a workload_prefix* comm
>> + *
>> + * Check if the procfs entry is a directory of a process, and then check if the
>> + * process has a comm with the prefix set in char *workload_prefix. As the
>> + * current users of this function only check for kernel threads, there is no
>> + * need to check for the threads for the process.
>> + *
>> + * Return: True if the proc_entry contains a comm file with workload_prefix*.
>> + * Otherwise returns false.
>> + */
>> +static int procfs_is_workload_pid(const char *workload_prefix, struct dirent *proc_entry)
>> +{
>> +	char comm_path[MAX_PATH], comm[MAX_PATH];
> 
> This is probably fine (but there is one issue), but I would have done this
> a little different.
> 
> 	int len = strlen(workload_prefix);
> 	char comm[len + 1];
> 
>> +	int comm_fd, retval;
>> +	char *t_name;
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
>> +	snprintf(comm_path, MAX_PATH, "/proc/%s/comm", proc_entry->d_name);
>> +	comm_fd = open(comm_path, O_RDONLY);
>> +	if (comm_fd < 0)
>> +		return 0;
>> +
>> +	memset(comm, 0, MAX_PATH);
> 
> No need for the memset.
> 
>> +	retval = read(comm_fd, comm, MAX_PATH);
> 
> 	retval = read(comm_fd, comm, len + 1);
> 
>> +
>> +	close(comm_fd);
>> +
>> +	if (retval <= 0)
>> +		return 0;
> 
> 	if (comm[len] != '\n')
> 		return 0;
> 
>> +
>> +	retval = !strncmp(workload_prefix, comm, strlen(workload_prefix));
> 
> What happens if strlen(workload_prefix) is greater than MAX_PATH? ;-)

That is a concern I had, but we have only two use cases on rtla so far, and they
are both bounded: 'timerlat/' 'osnoise/'...

I will add a check though.

> 
> 	retval = !strncmp(workload_prefix, comm, len);
> 
> But that's me. If you want to keep this as is, let me know.

I made these changes... but I am loosing the debug_msg() with the comm/pid that
matched. I am adding these messages (and I plan to add more) so I can use on
testing scripts...

At the same time, I can share a char buffer[MAX_PATH] for both the comm and
comm_path...

I think I will go this way (using a single buffer), adding a warning... and...

> -- Steve
> 
> 
> 
>> +	if (!retval)
>> +		return 0;

also removing ! in the the revtal = !strcmp(...); if (!retval).

Thoughts?

-- Daniel

>> +
>> +	/* comm already have \n */
>> +	debug_msg("Found workload pid:%s comm:%s", proc_entry->d_name, comm);
>> +
>> +	return 1;
>> +}
>> +

