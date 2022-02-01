Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A34A680B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiBAWdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiBAWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:33:46 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:33:46 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e28so17157308pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgSqn/ODuYhw3oBb7FQ1z3UvPoM3gm20EXCy4PGXA6c=;
        b=XOW3TJJFZ72W2QAKV7//T3KK8i5/1kgPMVQsiP2e9IJV6j7gy3+iHugCVvZX49621S
         pEE1rviUsjkSnaUjyEgPDQGXRu+37knzkf/NkUdUODcQTp2WDmGm7aYmkfibBXmIr7li
         ma3JUfn+VVWLBV5l7Q+YiyD/A8EHQq7cmbAhZyR8ljbbUmM6VOQbfBl7sG5MBzJNR2vl
         q2BpeGNsI884E+Ih1MqMwOfhbDlIrv6/WAP9JnaUQ4wNc35m04i166lcwW5q4vJpLog4
         3djMUsArDvYA784Yv4HwaZ21YtK6SOWetlk99OXo8SC7YMRYFARLP9UH/XFLgj6Jcye+
         gyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PgSqn/ODuYhw3oBb7FQ1z3UvPoM3gm20EXCy4PGXA6c=;
        b=6B80vMfDQyr7NIIdUfJE/W2+sj6Tsh775N7Tplzn0dpy+Hqb+WFoOjLA7FPD5SJAMe
         t5RzG6GBrULJl/4fcPfTsDhQnaRxwG4PqOo6GIB7r5SGCeWajvEPMJt+hgZkRMLJLky7
         Q+mJHQ1T7q2M26wRQRXD1woP0ApdJsj54V5WtwkJvupHq2X3zwMRlkq5l5QhpyAtx7bS
         MT1iiTJP6NSr8Zdv2Ry6Z6eTwk2Gec/R9n0q1xSh9hYEPCtL4nhjEU+MKkIBImJcWA5J
         vU7gzHW3SRmA875YsoLFLYpWbBhlrnQYeYfcclvgv+4JnSrUyXFFIDYKbGGfQcppc24Y
         IDlw==
X-Gm-Message-State: AOAM533dEVAOFG6QzlbD5UvVX3HawZAyVsj/S5hbXBlhsJsssVuKIRNF
        FL/CKXU9yYDw2GNSX97rBl/qzgjmnEI=
X-Google-Smtp-Source: ABdhPJwG2Xjh6eU/kgfTQBuD/iswCBzuAMIAfR+u5l3AW+P6Rk1hC67HbCvCXvQ/RaSBr9LTV7T/Eg==
X-Received: by 2002:a05:6a00:7ce:: with SMTP id n14mr27489212pfu.11.1643754825297;
        Tue, 01 Feb 2022 14:33:45 -0800 (PST)
Received: from google.com ([2620:15c:211:201:1b1a:cadc:e9c0:fbd5])
        by smtp.gmail.com with ESMTPSA id g19sm19581574pfv.164.2022.02.01.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 14:33:44 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 1 Feb 2022 14:33:43 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Tim Murray <timmurray@google.com>
Subject: Re: [PATCH] locking: add missing __sched attributes
Message-ID: <Yfm1R6BDmlca7LJO@google.com>
References: <20220115231657.84828-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115231657.84828-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 03:16:57PM -0800, Minchan Kim wrote:

Bumping up.

> This patch adds __sched attributes to a few missing places
> to show blocked function rather than locking function
> in get_wchan.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  kernel/locking/percpu-rwsem.c | 5 +++--
>  kernel/locking/rwsem.c        | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 70a32a576f3f..c9fdae94e098 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -7,6 +7,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched/debug.h>
>  #include <linux/errno.h>
>  
>  int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
> @@ -162,7 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
>  	__set_current_state(TASK_RUNNING);
>  }
>  
> -bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> +bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
>  {
>  	if (__percpu_down_read_trylock(sem))
>  		return true;
> @@ -211,7 +212,7 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
>  	return true;
>  }
>  
> -void percpu_down_write(struct percpu_rw_semaphore *sem)
> +void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>  {
>  	might_sleep();
>  	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 69aba4abe104..acde5d6f1254 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1048,7 +1048,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  /*
>   * Wait until we successfully acquire the write lock
>   */
> -static struct rw_semaphore *
> +static struct rw_semaphore __sched *
>  rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  {
>  	long count;
> -- 
> 2.34.1.703.g22d0c6ccf7-goog
> 
