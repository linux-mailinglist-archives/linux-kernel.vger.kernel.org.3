Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEF50EE50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiDZBzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiDZBzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:55:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531B694B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:52:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so28937538plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=WfiwMB/mN1ImVa37q+tQ7YYKlhZFmP7mGo69JFo3puM=;
        b=17pqy4/MMxB3rgQQMiGD52xuDo1ey0fGl/EsmfSgCyjW23RSWSu0qRccqow/3KuQ4t
         G3cU1UKxyyigtHehIrsfx3/m7YRhZ+Gx0j6sQr8VxB8S7R7K2E2yU7F55JcM43ZzVyWT
         L8t+VdzIGjgkJLj2JXu9mgpHe9rvlmTxqdJm8xMXaJj+w4yPpnRnhwfsNE2e0UvfQqI/
         7G3AqyFEqud++8VwRpwsC7EMZZv41GZIYc/slO6aQSe+6jjY54vjBFRt+dMhGLggdfqR
         qOCXU0/DQHCJzIBolPTluEiBL2cGVoV3RdW6VZQRVGI5SYM9Xv36+boqiD4HKsySaH0e
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=WfiwMB/mN1ImVa37q+tQ7YYKlhZFmP7mGo69JFo3puM=;
        b=PcnsgNvl9pavt1xLZ4nk2J10GnJPD4LZcp+epMXZZ4eTxfL6V7W/wrzRVn9aQ/OswJ
         gz0+whs+D7AUycPV9rtcr00+8I+22S/EOjKGF+IIobYi5YcqqBa6ER2FYUCeYOqOZFrx
         sn93Cse/LyDJBuQI/TN1QxGDU3X2lsIPwKHtXK9D9/e9tns7dToqpCb8xzAFRBwRItlE
         uZZsMJZyNRqy+bbF4XvPirfWe6kZ1P+ce/IywVWU52Q64CT+par2GcytdWOyeBtY/des
         Xpwzrpp63WC8IXMPZS+cGqGjzHXjyP4Ru7vkwno8M5ViO1l/Qcbw2MqGOn1lmf76pr4b
         pF0w==
X-Gm-Message-State: AOAM532yZ75TY81vX9DpKhnJ6bdgqCX8nBXRv2ID+KJORMXx7GGQCSyT
        nfwmYLcYhTX31yoP6D6R8eAr4jzLTcBGboM+
X-Google-Smtp-Source: ABdhPJyaH60urOpqhxxi2wp6NdpyEY96WvIiAVLDSNMZf1Ueg9WHCVe+rGz5/KV+b6p6GleHWJXlzg==
X-Received: by 2002:a17:902:a583:b0:15d:197b:9259 with SMTP id az3-20020a170902a58300b0015d197b9259mr7189267plb.51.1650937953279;
        Mon, 25 Apr 2022 18:52:33 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d3-20020a62f803000000b0050d3480da4asm6405155pfh.129.2022.04.25.18.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:52:32 -0700 (PDT)
Message-ID: <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
Date:   Mon, 25 Apr 2022 19:52:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     LKML <linux-kernel@vger.kernel.org>
References: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
In-Reply-To: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 8:34 AM, Jens Axboe wrote:
> Some use cases don't always need an IPI when sending a TWA_SIGNAL
> notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
> except it doesn't send an IPI to the target task. It merely sets
> TIF_NOTIFY_SIGNAL and wakes up the task.

Adding Peter and Thomas.

> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> This is a prep patch for an io_uring change where we don't need the IPI,
> and skipping it can reduce rescheduling/IPI rate by tens to hundreds of
> thousands per second.
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3c8b34876744..66b689f6cfcb 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -355,14 +355,23 @@ static inline void clear_notify_signal(void)
>  	smp_mb__after_atomic();
>  }
>  
> +/*
> + * Returns 'true' if kick_process() is needed to force a transition from
> + * user -> kernel to guarantee expedient run of TWA_SIGNAL based task_work.
> + */
> +static inline bool __set_notify_signal(struct task_struct *task)
> +{
> +	return !test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
> +	       !wake_up_state(task, TASK_INTERRUPTIBLE);
> +}
> +
>  /*
>   * Called to break out of interruptible wait loops, and enter the
>   * exit_to_user_mode_loop().
>   */
>  static inline void set_notify_signal(struct task_struct *task)
>  {
> -	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
> -	    !wake_up_state(task, TASK_INTERRUPTIBLE))
> +	if (__set_notify_signal(task))
>  		kick_process(task);
>  }
>  
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 897494b597ba..795ef5a68429 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -17,6 +17,7 @@ enum task_work_notify_mode {
>  	TWA_NONE,
>  	TWA_RESUME,
>  	TWA_SIGNAL,
> +	TWA_SIGNAL_NO_IPI,
>  };
>  
>  static inline bool task_work_pending(struct task_struct *task)
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index c59e1a49bc40..fa8fdd04aa17 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -13,11 +13,13 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
>   *
>   * Queue @work for task_work_run() below and notify the @task if @notify
>   * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL works like signals, in that the
> - * it will interrupt the targeted task and run the task_work. @TWA_RESUME
> - * work is run only when the task exits the kernel and returns to user mode,
> - * or before entering guest mode. Fails if the @task is exiting/exited and thus
> - * it can't process this @work. Otherwise @work->func() will be called when the
> - * @task goes through one of the aforementioned transitions, or exits.
> + * it will interrupt the targeted task and run the task_work. @TWA_SIGNAL_NO_IPI
> + * works like @TWA_SIGNAL, except it doesn't send a reschedule IPI to force the
> + * targeted task to reschedule and run task_work. @TWA_RESUME work is run only
> + * when the task exits the kernel and returns to user mode, or before entering
> + * guest mode. Fails if the @task is exiting/exited and thus it can't process
> + * this @work. Otherwise @work->func() will be called when the @task goes
> + * through one of the aforementioned transitions, or exits.
>   *
>   * If the targeted task is exiting, then an error is returned and the work item
>   * is not queued. It's up to the caller to arrange for an alternative mechanism
> @@ -53,6 +55,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  	case TWA_SIGNAL:
>  		set_notify_signal(task);
>  		break;
> +	case TWA_SIGNAL_NO_IPI:
> +		__set_notify_signal(task);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		break;
> 


-- 
Jens Axboe

