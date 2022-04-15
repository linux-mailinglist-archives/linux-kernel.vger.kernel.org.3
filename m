Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758EB501FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbiDOArP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbiDOArI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:47:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C01277F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:44:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t190-20020a25c3c7000000b006410799ab3dso5577369ybf.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZwQPxBd8EtPA2caIKpSSvGEb5tp2AlMs5mP2bGiGorY=;
        b=Xh0tbPmp/XKj/ZjaKdtHHKO9340eZClseHomoI4Rj3NjZNAp8e3naM0Dva0HKuMY8N
         iPrz+wAscbKcTJliCnwg8XPd0ShgYtMoSkSzJWdJB9LagwPopFcjH8BUp0GDrkDmudA/
         PNoh6MX9hLlgdIWTHP8ppSyBv0w/fKPxd01F7Jw44Ss/fAcWlCjIugQ/3kjPFWcS2LQC
         tygatotND2v+OGc2+ZdvzjhzOhEhHQvLcQxsom2H5geXUjbW2NnD3SLoa8CsDZrItXwr
         fg+e6cTsajQGQX76fJW1GZ+BC2uWURrEgv6wsn+zmayU1+gt97zF+l/xcZpdqTHxd2W7
         uVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZwQPxBd8EtPA2caIKpSSvGEb5tp2AlMs5mP2bGiGorY=;
        b=Bk+SJh/CKDIT0gNzzddmKQtGu9H2kr32VncHr+ABlvFp50I9/5s7I1IcR67fXaaDav
         VOJeNH1miP+mF5Xiv+7Yxvyk0pZYXfm3Lej1bayuX1gpK4dQAamWD1WRcycjTtt+qakd
         0MOekF8LsnZyc1bpTvCrvW0f/iWgJzNUKF4HQBLeJLSOuDD4j6AX0QBiSJE/Hrwy8II9
         995rPwFxwXUKCxGddE9s/ikWYyOdXf1lqsKXEbjKCOwL6WS9DLrCK9EZn9MIYj4B5VH5
         lIUGI4R3SIms2LRLFQhj5o5Z/jSGnyiCpMXfwRks6FkbRtJLO5JViWhQcWkEpjhSiy5r
         8Glg==
X-Gm-Message-State: AOAM532i1eYuQ0libJx1c2Fae7k2zP0xUeL0sk2bGxptjkVhEGhXj1Ka
        0JjcFEk9ea6iYZYjXuHuFTb/lXriyxhs06o=
X-Google-Smtp-Source: ABdhPJwAoaNAXHbsHFTs0B57rlO4LQu5dHbO3LV5mhgRiZ+Jyle+N1fkTzOQJzK493osORtW4RZmkpeUiU+qcwY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:b28d:6e12:8dbb:a7a8])
 (user=saravanak job=sendgmr) by 2002:a05:690c:89:b0:2d7:fb7d:db7 with SMTP id
 be9-20020a05690c008900b002d7fb7d0db7mr4518123ywb.219.1649983461658; Thu, 14
 Apr 2022 17:44:21 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:44:17 -0700
In-Reply-To: <e2bbed61-b818-c391-bf65-824ea2a2ee5a@quicinc.com>
Message-Id: <20220415004417.1790161-1-saravanak@google.com>
Mime-Version: 1.0
References: <e2bbed61-b818-c391-bf65-824ea2a2ee5a@quicinc.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v3 ] remoteproc: Use unbounded workqueue for recovery work
From:   Saravana Kannan <saravanak@google.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> There could be a scenario where there is too much load on a core
> (n number of tasks which is affined) or in a case when multiple
> rproc subsystem is going for a recovery and they queued recovery
> work to one core so even though subsystem are independent there
> recovery will be delayed if one of the subsystem recovery work
> is taking more time in completing.
> 
> If we make this queue unbounded, the recovery work could be picked
> on any cpu. This patch try to address this.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v3:
>   - Add fallback option to go back to earlier path incase recovery wq
>     creation fails.
> 
> Changes in v2:
>   - Removed WQ_HIGHPRI.
>   - Updated commit text.
> 
>  drivers/remoteproc/remoteproc_core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c510125..6446c84 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
>  
>  /* Unique indices for remoteproc devices */
>  static DEFINE_IDA(rproc_dev_index);
> +static struct workqueue_struct *rproc_recovery_wq;
>  
>  static const char * const rproc_crash_names[] = {
>  	[RPROC_MMUFAULT]	= "mmufault",
> @@ -2755,8 +2756,11 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -	/* Have a worker handle the error; ensure system is not suspended */
> -	queue_work(system_freezable_wq, &rproc->crash_handler);
> +	if (rproc_recovery_wq)
> +		queue_work(rproc_recovery_wq, &rproc->crash_handler);
> +	else
> +		queue_work(system_freezable_wq, &rproc->crash_handler);

This is unnecessarily complicated. If you can't create a workqueue you
have bigger problems with the system. Just stick with the new rproc
workqueue.

> +
>  }
>  EXPORT_SYMBOL(rproc_report_crash);
>  
> @@ -2805,6 +2809,11 @@ static void __exit rproc_exit_panic(void)
>  
>  static int __init remoteproc_init(void)
>  {
> +	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq",
> +						WQ_UNBOUND | WQ_FREEZABLE, 0);
> +	if (!rproc_recovery_wq)
> +		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");

Fail the init if you can't create a workqueue.

> +
>  	rproc_init_sysfs();
>  	rproc_init_debugfs();
>  	rproc_init_cdev();
> @@ -2821,6 +2830,8 @@ static void __exit remoteproc_exit(void)
>  	rproc_exit_panic();
>  	rproc_exit_debugfs();
>  	rproc_exit_sysfs();
> +	if (rproc_recovery_wq)
> +		destroy_workqueue(rproc_recovery_wq);

Will need a fix here too.

-Saravana

>  }
>  module_exit(remoteproc_exit);
>  
> -- 
> 2.7.4
