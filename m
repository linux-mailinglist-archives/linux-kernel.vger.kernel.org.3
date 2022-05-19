Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3274552DA34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiESQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiESQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0C81D4123
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652977761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3qtS6Me54RCoWpkkU6sywHq6PAvANYkgo0QfV0PU8o=;
        b=We83zXJJ4VNplff+gCciKadhfVoNmxwa/wlD4/ML5fMuR+6Uv+H5TdX7ZoGmKFRtDHXsnI
        qMa4vLtD7p1LpPdszrQE+PKRuaDZq7NRVuY8oLyp91JHzqRBs9n2pr+/Lj51c6kLuwvmP/
        1v3d9/rsw92CAjhchcTcKXG4reZZYtw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-nnwvS6hBPcCWVUTMvFM7lQ-1; Thu, 19 May 2022 12:29:20 -0400
X-MC-Unique: nnwvS6hBPcCWVUTMvFM7lQ-1
Received: by mail-wm1-f70.google.com with SMTP id z23-20020a05600c221700b003942fd37764so4717276wml.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=O3qtS6Me54RCoWpkkU6sywHq6PAvANYkgo0QfV0PU8o=;
        b=7gmGHO+hfculOUsNVzwiJN4HUR5W2kLOOwOUlm5R0M1w5XmkaQlvJhE4e6IqIcccAz
         FMIYLP7EgScO+/3ipWQz1yOCgEbJOpBH/ElNq3RF3wqUCBG//tBqKrwYm+fFg8iqnGn0
         du6WDBGLI6ZIe/LOUQQgA6qTadeEMJOJtmBZAPwL7ltMt7CiWEvsR1lQItcXx33kZBFI
         ISdKVrUV/gElyXqqsmFKM4qUTLAWq+wb8+d3ynfIXqJOJ+Hw4e/rTm34+s7KhMUgQTJe
         y26oSjc+MTSK1oSaqKu2NKjbIbJxrGZfCBgPHp2TJZKCfVpnO8vnpbOnBtTdqM3K3hIV
         ZQzg==
X-Gm-Message-State: AOAM532cspWawnABcdgrBRuBKCp683vRBphX7MqaVzsMwEcvZDg63nzh
        SuHR/aNPShIpR5WaEorqCN8qAAXCl21I/5es7pObVV1fWmFl8feJPv9yXykXR2Pgqff/q3uYrIC
        vz0L4V2X3rZRGw+sQOJqIymuc
X-Received: by 2002:a5d:5887:0:b0:20c:83c9:b72 with SMTP id n7-20020a5d5887000000b0020c83c90b72mr4748470wrf.588.1652977759016;
        Thu, 19 May 2022 09:29:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN+sLsQKVtOB96ymwoOcuIsbeUC3KRygI6P1J4jfRQcjJnbuhL5Frtlk/R83r5v/avlNn5xQ==
X-Received: by 2002:a5d:5887:0:b0:20c:83c9:b72 with SMTP id n7-20020a5d5887000000b0020c83c90b72mr4748456wrf.588.1652977758840;
        Thu, 19 May 2022 09:29:18 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u17-20020adfc651000000b0020cf071a168sm63924wrg.29.2022.05.19.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:29:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH] sched: Dump stacktrace when some task failed to stop
In-Reply-To: <20220519161125.41144-1-schspa@gmail.com>
References: <20220519161125.41144-1-schspa@gmail.com>
Date:   Thu, 19 May 2022 17:29:17 +0100
Message-ID: <xhsmha6bd1o6a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/22 00:11, Schspa Shi wrote:
> Some processes may not be stopped, such as workqueue workers.
>
> Add this dump_stack to easily figure out which process caused the problems.
>
> Before this change:
>
> <4>[  517.545889] ------------[ cut here ]------------
> <4>[  517.545901] Dying CPU not properly vacated!
> <4>[  517.546366] ---[ end trace 0000000000000002 ]---
> <4>[  518.546831] CPU6 enqueued tasks (2 total):
> <4>[  518.546855] 	pid: 49, name: migration/6
> <4>[  518.547010] 	pid: 6231, name: kworker/6:0
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  kernel/sched/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 53596842f0d8..de6b5320e4d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9416,7 +9416,14 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  			continue;
>  
>  		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
> +		if (p != current)
> +			sched_show_task(p);
>  	}
> +	/*
> +	 * We need the stack of each cpu to analyze who is blocking the
> +	 * current cpu scheduling
> +	 */
> +	trigger_all_cpu_backtrace();
>  }
>

Given you get a WARN() when this happens, can't you get the same thing with

  panic_on_warn=1
  panic_print=PANIC_PRINT_ALL_CPU_BT

?

>  int sched_cpu_dying(unsigned int cpu)
> -- 
> 2.24.3 (Apple Git-128)

