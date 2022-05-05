Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAB51C4FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381266AbiEEQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiEEQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:20:41 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E96F5C651
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651767418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0wn4S0Qd/jGJIzBFDJr95jyTK1oLewaOA/pfqygxhs=;
        b=VKHcWxYZKOAxP+9sO32ezUodHNWkBttJivF+VjfILNifkNXWy3soWvfOhW0n+NYhb/7nL0
        nOgeQPgzB4MTS9xht8nyrdq0Q6Wj/YinmdhEyya/3qONk1uu/79orwJRXB1IMsuSO2Mj+C
        Zu0sgnNbqYYvkTXFIIiGNhyrIRcrI2I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-gi5ZwfWpPDudv7tGoS3S2g-1; Thu, 05 May 2022 12:16:57 -0400
X-MC-Unique: gi5ZwfWpPDudv7tGoS3S2g-1
Received: by mail-qt1-f200.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso3730884qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=f0wn4S0Qd/jGJIzBFDJr95jyTK1oLewaOA/pfqygxhs=;
        b=1t18tz1Od5sO9jZfOTy9G1sOnRU+qv+CR7tr+U/5c/wzq/ZpARFKzYpLpMi1IUdYj9
         +2eE1Pm/HSujgd5e/yn+KRm+xmTli6zk6n8lSlZ75IIYrnS6gTR3UitGD4PNcJfGptOp
         06D/QkvksaIUMfXyzVNDX4/wpkyFnRO/cjCxhhFM7SKlFvEefoiuEIowY9BC2+jj/Ulw
         Umjz305XldCDqo+jjcFWCTIcC5kB4JX7m2GbJLdmmo1BGm5fz1zmSrgvjxJi+Df199de
         Yf9BqO+XU0EUB5Sqsjw37YsYbe7wNo0EfvHxRJWIX69sl81Yun1T/D/0xwi8BTk60cal
         29qg==
X-Gm-Message-State: AOAM530C5pzlJln6EzQRuWZXrqxaizy6JHBajIAgSQBO8U5jVwilvuf1
        nWwpgXJGdA1I4s4kO1UjdD+i7jt3m6PWpv9iZLkD6DrNoZyKmTD0tg78NbXDjaccDhuz8DKI2UB
        EpbpsRbTgIGEJ23DDNLWqUDnC
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr20240951qkp.559.1651767416591;
        Thu, 05 May 2022 09:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+S85zcq8WmL2ky3vro7SW9gMcurDgRBLcadYqEQ99Q4Kp8h2sgOWTgT0Lu2FWcfGhD8CgZQ==
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr20240923qkp.559.1651767416298;
        Thu, 05 May 2022 09:16:56 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a075000b0069fc13ce1e7sm978292qki.24.2022.05.05.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 09:16:55 -0700 (PDT)
Date:   Thu, 5 May 2022 12:16:54 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] rtla: Remove procps-ng dependency
In-Reply-To: <a0f9f8c1030c66305c9b921057c3d483064d5529.1651220820.git.bristot@kernel.org>
Message-ID: <cd9251-c95-b342-3694-777945cc374@redhat.com>
References: <a0f9f8c1030c66305c9b921057c3d483064d5529.1651220820.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2022, Daniel Bristot de Oliveira wrote:

> Daniel Wagner reported to me that readproc.h got deprecated. Also,
> while the procps-ng library was available on Fedora, it was not available
> on RHEL, which is a piece of evidence that it was not that used.

I am for removing this dependency, but I feel I have to correct your 
description. procps-ng is available on RHEL. The development library 
however is just available at boot-time, but only because no other packages depend 
on it. If we were to add a package that depended on it, it would then be 
available at runtime. I would remove any references to RHEL in your 
description, and just say you are reducing the dependency on this to 
simply building rtla. 

> 
> rtla uses procps-ng only to find the PID of the tracers' workload.
> 
> I used the procps-ng library to avoid reinventing the wheel. But in this
> case, reinventing the wheel took me less time than the time we already
> took trying to work around problems.
> 
> Implement a function that reads /proc/ entries, checking if:
> 	- the entry is a directory
> 	- the directory name is composed only of digits (PID)
> 	- the directory contains the comm file
> 	- the comm file contains a comm that matches the tracers'
> 	  workload prefix.
> 	- then return true; otherwise, return false.
> 
> And use it instead of procps-ng.
> 
> Changes from V1:
>   - Use a single buffer for comm and comm_path
>   - Cause an error in case of a too long command prefix
>   - Do a close_dir()
>   - Improve log messages
> 
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b1696371d865 ("rtla: Helper functions for rtla")
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  tools/tracing/rtla/Makefile    |   2 +-
>  tools/tracing/rtla/README.txt  |   1 -
>  tools/tracing/rtla/src/utils.c | 102 ++++++++++++++++++++++++++-------
>  tools/tracing/rtla/src/utils.h |   3 +-
>  4 files changed, 84 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 5a3226e436ef..523f0a8c38c2 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -32,7 +32,7 @@ TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
>  
>  CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS)
>  LDFLAGS	:=	-ggdb
> -LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs) -lprocps
> +LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
>  
>  SRC	:=	$(wildcard src/*.c)
>  HDR	:=	$(wildcard src/*.h)
> diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
> index 0fbad2640b8c..4af3fd40f171 100644
> --- a/tools/tracing/rtla/README.txt
> +++ b/tools/tracing/rtla/README.txt
> @@ -11,7 +11,6 @@ RTLA depends on the following libraries and tools:
>  
>   - libtracefs
>   - libtraceevent
> - - procps
>  
>  It also depends on python3-docutils to compile man pages.
>  
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> index 3bd6f64780cf..f3d562f7f14c 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
>   */
>  
> -#include <proc/readproc.h>
> +#include <dirent.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -262,43 +262,103 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
>  
>  	return 0;
>  }
> +
>  /*
> - * set_comm_sched_attr - set sched params to threads starting with char *comm
> + * procfs_is_workload_pid - check if a procfs entry contains a comm_prefix* comm
> + *
> + * Check if the procfs entry is a directory of a process, and then check if the
> + * process has a comm with the prefix set in char *comm_prefix. As the
> + * current users of this function only check for kernel threads, there is no
> + * need to check for the threads for the process.
>   *
> - * This function uses procps to list the currently running threads and then
> - * set the sched_attr *attr to the threads that start with char *comm. It is
> + * Return: True if the proc_entry contains a comm file with comm_prefix*.
> + * Otherwise returns false.
> + */
> +static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_entry)
> +{
> +	char buffer[MAX_PATH];
> +	int comm_fd, retval;
> +	char*t_name;
> +
> +	if (proc_entry->d_type != DT_DIR)
> +		return 0;
> +
> +	if (*proc_entry->d_name == '.')
> +		return 0;
> +
> +	/* check if the string is a pid */
> +	for (t_name = proc_entry->d_name; t_name; t_name++) {
> +		if (!isdigit(*t_name))
> +			break;
> +	}
> +
> +	if (*t_name != '\0')
> +		return 0;
> +
> +	snprintf(buffer, MAX_PATH, "/proc/%s/comm", proc_entry->d_name);
> +	comm_fd = open(buffer, O_RDONLY);
> +	if (comm_fd < 0)
> +		return 0;
> +
> +	memset(buffer, 0, MAX_PATH);
> +	retval = read(comm_fd, buffer, MAX_PATH);
> +
> +	close(comm_fd);
> +
> +	if (retval <= 0)
> +		return 0;
> +
> +	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
> +	if (retval)
> +		return 0;
> +
> +	/* comm already have \n */
> +	debug_msg("Found workload pid:%s comm:%s", proc_entry->d_name, buffer);
> +
> +	return 1;
> +}
> +
> +/*
> + * set_comm_sched_attr - set sched params to threads starting with char *comm_prefix
> + *
> + * This function uses procps to list the currently running threads and then set the
> + * sched_attr *attr to the threads that start with char *comm_prefix. It is
>   * mainly used to set the priority to the kernel threads created by the
>   * tracers.
>   */
> -int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
> +int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
>  {
> -	int flags = PROC_FILLCOM | PROC_FILLSTAT;
> -	PROCTAB *ptp;
> -	proc_t task;
> +	struct dirent *proc_entry;
> +	DIR *procfs;
>  	int retval;
>  
> -	ptp = openproc(flags);
> -	if (!ptp) {
> -		err_msg("error openproc()\n");
> -		return -ENOENT;
> +	if (strlen(comm_prefix) >= MAX_PATH) {
> +		err_msg("Command prefix is too long: %d < strlen(%s)\n",
> +			MAX_PATH, comm_prefix);
> +		exit(EINVAL);
>  	}
>  
> -	memset(&task, 0, sizeof(task));
> +	procfs = opendir("/proc");
> +
> +	while ((proc_entry = readdir(procfs))) {
>  
> -	while (readproc(ptp, &task)) {
> -		retval = strncmp(comm, task.cmd, strlen(comm));
> -		if (retval)
> +		retval = procfs_is_workload_pid(comm_prefix, proc_entry);
> +		if (!retval)
>  			continue;
> -		retval = __set_sched_attr(task.tid, attr);
> -		if (retval)
> +
> +		/* procfs_is_workload_pid confirmed it is a pid */
> +		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
> +		if (retval) {
> +			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
>  			goto out_err;
> -	}
> +		}
>  
> -	closeproc(ptp);
> +		debug_msg("Set sched attributes for pid:%s\n", proc_entry->d_name);
> +	}
>  	return 0;
>  
>  out_err:
> -	closeproc(ptp);
> +	closedir(procfs);
>  	return 1;
>  }
>  
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
> index fa08e374870a..5571afd3b549 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -6,6 +6,7 @@
>   * '18446744073709551615\0'
>   */
>  #define BUFF_U64_STR_SIZE	24
> +#define MAX_PATH		1024
>  
>  #define container_of(ptr, type, member)({			\
>  	const typeof(((type *)0)->member) *__mptr = (ptr);	\
> @@ -53,5 +54,5 @@ struct sched_attr {
>  };
>  
>  int parse_prio(char *arg, struct sched_attr *sched_param);
> -int set_comm_sched_attr(const char *comm, struct sched_attr *attr);
> +int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
>  int set_cpu_dma_latency(int32_t latency);
> -- 
> 2.32.0
> 
> 

