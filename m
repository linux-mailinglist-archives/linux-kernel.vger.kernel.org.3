Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4644B401C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiBNDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:07:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbiBNDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:07:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAE56222
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:07:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m22so7671806pfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L8f/dy++5LF1Z+wO72aS7wlC9x5EEx283gxkskdGuXo=;
        b=e+6som/Tb93dp4VvtBjU1FzkdQVoD+0eIVZwtosEgh8TYLLMBdCgj+aO55P0CKVNWT
         B4YcB2XQcP4fX9XxEd2bct830bQOSxRkR7+75wGXFB+UmhwOkogZ0O9DasgjG3ojfwc2
         TSFNfI1uq130vnGsq3jeRQjkRbLiLqMOLExHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8f/dy++5LF1Z+wO72aS7wlC9x5EEx283gxkskdGuXo=;
        b=aqbMRHRtXpknUovalt/vnlJAq9I8CcawCOnqTbowY4unJsn7XegeH35DCiuipxJIXA
         dJPrHKff2vrYx42e0GiC6DlWHUxsSJtYrX4lsLb+IS6QHaExmO5629IaUWnZ0r7E5wMB
         1fHGiv4irPGviHQ+keftMes0QanKefKhw3zS6rhRCz95yuK6Jxd+tMX3H+DeRdUA5708
         VTnTjfqjg+/VejYjqi3+PDpL097ALPgletZfNtW5ymFO57A4a5iIs8KrnGkov2trwZVI
         Wf6ZsTC5bvvciGdYvjDiNGCEeiihgMqgr6OW432IitkODbzLE2aGK8yD6YJZrnic8lBN
         nPkA==
X-Gm-Message-State: AOAM530QDEw459ITqLdcQ7SkTbzruUbcgrV8xSrIMp5Y1YBVseARBqns
        dLuzxqi4CI/h0ASdROmFV85Brg==
X-Google-Smtp-Source: ABdhPJx1H2Gc+HhUAhblBTUvmqTQaV9LtBNLCgdYi8Jt0ecEOsepVeCHLIh1ytP8jPXH0iKGwF9EYA==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr10114748pgc.72.1644808018860;
        Sun, 13 Feb 2022 19:06:58 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b736:df7d:23c5:206e])
        by smtp.gmail.com with ESMTPSA id e8sm17571509pfv.168.2022.02.13.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:06:58 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:06:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        yaohongbo@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] printk: fix softlockup/rcu stall warning without setting
 CONFIG_PREEMPTION
Message-ID: <YgnHTTn6OFZzcD8C@google.com>
References: <1644672462-20793-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644672462-20793-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/12 21:27), Guanghui Feng wrote:
>     console_unlock+0x220/0x420
>     vprintk_emit+0x17c/0x1ac
>     vprintk_default+0x3c/0x44
>     vprintk+0x38/0x70
>     printk+0x64/0x88
>     dump_task.part.0+0xc4/0xe0
>     dump_task+0x70/0x74
>     dump_tasks+0x78/0x90
>     dump_global_header+0xcc/0xe8
>     oom_kill_process+0x258/0x274
>     out_of_memory.part.0+0xb0/0x33c
>     out_of_memory+0x4c/0xa0
>     __alloc_pages_may_oom+0x11c/0x1a0
>     __alloc_pages_slowpath.constprop.0+0x4c0/0x75c
>     __alloc_pages_nodemask+0x2b4/0x310
>     alloc_pages_current+0x8c/0x140
>     get_zeroed_page+0x20/0x50
>     __pud_alloc+0x40/0x190
>     copy_pud_range+0x264/0x280
>     copy_page_range+0xe8/0x204
>     dup_mmap+0x334/0x434
>     dup_mm+0x64/0x11c
>     copy_process+0x5e0/0x11a0
>     kernel_clone+0x94/0x364
>     __do_sys_clone+0x54/0x80
>     __arm64_sys_clone+0x24/0x30
>     el0_svc_common.constprop.0+0x7c/0x210
>     do_el0_svc+0x74/0x90
>     el0_svc+0x24/0x60
>     el0_sync_handler+0xa8/0xb0
>     el0_sync+0x140/0x180

[..]

> @@ -2716,7 +2716,11 @@ void console_unlock(void)
>  		if (handover)
>  			return;
>
> +#ifndef CONFIG_PREEMPTION
> +		if (do_cond_resched || need_resched())
> +#else
>  		if (do_cond_resched)
> +#endif
>  			cond_resched();

console_unlock() can be called from atomic context, it should not schedule
when it cannot do so. That's what console_may_schedule indicates.
