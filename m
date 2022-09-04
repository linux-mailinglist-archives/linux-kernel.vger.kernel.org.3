Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB45AC3FB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiIDKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:46:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11C3CBE3;
        Sun,  4 Sep 2022 03:46:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e17so442576edc.5;
        Sun, 04 Sep 2022 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=7tT5TfmiW1h2AxLyFfb2n8qLoBALtmFRWEJpbfu2Ax0=;
        b=i/6z0mwwGd9KJLjskZ7hOzdaXQCflg5F33jtZgOUJKlNOQq2g7kcAU0BIwE0nsq7aL
         TirpXgdB4AGKuHB2pwUNL6qd610r9oZXWaCErlTaA+mbLe6A9L/n2TfdPr0NMfgh5QB8
         IW8ggSVOo8vVrQViFTInSshbdk+Bq1LEJ7tvmqZKDfzaDXbEObLKqBNfBC81ZKhQ7mvD
         UYYDqmBs/We0H9xrqiLnffg4gAXEJPcntJUB/QaWRw02p8XdIravNf2D7w1/UHfOQKif
         nPGHmwvSGeN8IlcqnNR7P0lXFUIm7Z8nAx8NzNXchCN2BgVGpKf948cv9wiysmlHX9ga
         nYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7tT5TfmiW1h2AxLyFfb2n8qLoBALtmFRWEJpbfu2Ax0=;
        b=bjXL37PNixZYXAv8JFI4m22Mtdpiy3LN8ZyioOt5spVycEQyDCQPimxmBUp3SsPytp
         i0lDOo3ck/UWWGN4WV/DNk1VP6xG0e/EeN/3HBHFJlSU4p7X6ximsbQVrR2KPiYTB7ph
         d0V2V1Lx3V1jnKbsX9Nz1BmfgboBz5sYDs6O9uaR6eSJwY2bHwPqDGt15A+T7sIB6E8s
         X+8DPof7AlZbbhTKB+LBae4oR091CAUTOiDw43lEd9FHwMI6Jlihl8ApRTebWsKfVkBA
         XuMPuXkmZcW1d24N/JCujJAYpLmvj2bw5deUwDUr3dOqafyyITtfBpF/5rQLLVa7nBPm
         qRew==
X-Gm-Message-State: ACgBeo1MozUdcIq+72GVDRCWXcH7dyzFKb2ukhJThiXfdbMQTHeihMkK
        bBvKrWjZMSjX1W0FcZjMMOs=
X-Google-Smtp-Source: AA6agR4FXPwQNq2qnd7x6J2UkBpoCrvlMq9ixqIz2NnpBzHKNScpt166yzKXUsn1mV4XGyrtNNBskw==
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id q36-20020a05640224a400b004408c0c8d2bmr38468103eda.311.1662288373677;
        Sun, 04 Sep 2022 03:46:13 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073dd1ac2fc8sm3524482ejb.195.2022.09.04.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 03:46:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 4 Sep 2022 12:46:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
Message-ID: <YxSB85+BamWFj5xw@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.922711674@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822114648.922711674@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Allows waiting with a custom @state.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/completion.h |    1 +
>  kernel/sched/completion.c  |    9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -103,6 +103,7 @@ extern void wait_for_completion(struct c
>  extern void wait_for_completion_io(struct completion *);
>  extern int wait_for_completion_interruptible(struct completion *x);
>  extern int wait_for_completion_killable(struct completion *x);
> +extern int wait_for_completion_state(struct completion *x, unsigned int state);
>  extern unsigned long wait_for_completion_timeout(struct completion *x,
>  						   unsigned long timeout);
>  extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
>  }
>  EXPORT_SYMBOL(wait_for_completion_killable);
>  
> +int __sched wait_for_completion_state(struct completion *x, unsigned int state)
> +{
> +	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
> +	if (t == -ERESTARTSYS)
> +		return t;
> +	return 0;

Nit: newline missing after local variable definition.

Other than that:

Reviewed-by: Ingo Molnar <mingo@kernel.org>


Thanks,

	Ingo
