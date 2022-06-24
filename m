Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A9559842
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiFXK4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFXK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D48677FCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656068203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IvdUauqtsThSzQf7R6IOvYioKcqImV/YhI4IgCG9bxg=;
        b=UhJkKhHxum/wJosr9KKxiubLFomUqZAGzMlipKhk2ofDpeCiJw/Y6Wc/e8X4cUsoAU8D7B
        aNb5AwfZy4ES7aCosLz3JKv+7nGroCTWABeXCL7mKqtYeFShI491RHn+h9rY2H9WJbio7M
        gBV6auxD1fY8QnbGM1f7lCzoGOJnvQI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-mHgtofw8MmmtcB9otddnMA-1; Fri, 24 Jun 2022 06:56:42 -0400
X-MC-Unique: mHgtofw8MmmtcB9otddnMA-1
Received: by mail-wm1-f69.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so885803wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IvdUauqtsThSzQf7R6IOvYioKcqImV/YhI4IgCG9bxg=;
        b=p6kMm71DwJ9nBUVEZ0u/zqJT4qeZOcTWHZhGLtPgQBGJLLqbBLBRssks4kZYgmMpnw
         numLIeczS3ZooFVC9QTZiOgOo5sFWrhtLBehtrR9/W69h3QPnFCIJQgkITiSCNWzYqD4
         SRFogCtGyIbiX4Ybfkx/Kn3zt95dqWUWFWdAVOzVpTkmEu/QXGWPeumbkriXoAdfNrXt
         Yu9aRwg775F1g7VKLd9C24X9K1IlVBYaGH9X5T/xsH6P0gPzvuR7oQwsFfovoPngMleP
         sxPWwz3wdzZGPutvWOZw1R28AzoJzslTstJ2cWwbmCC3lz+P4s1cfOh9CbHcO6bt5CQ3
         9UCg==
X-Gm-Message-State: AJIora8PbkbZiEMb+8QGy4idZTBYdwYDsBHDHN7mDP0yZ+CilZj2DUiS
        WTIkR4BwVS5qLFLrIkNo1Dn2a7HonV5hIWPWJyOtCtvkNeEu8euaeey1fDGAv95DetTEolCbDgG
        X9Tp6J5fTi047AkbDLNJOCFqT
X-Received: by 2002:a7b:c4d9:0:b0:3a0:260f:1f4 with SMTP id g25-20020a7bc4d9000000b003a0260f01f4mr3030030wmk.178.1656068200961;
        Fri, 24 Jun 2022 03:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ul73CGYuf3nWcoswqmbLq2Rn05RHTs/WAiXu6dCDOZbh5SeLlZMogvS80/5i3SlejJlCzeUQ==
X-Received: by 2002:a7b:c4d9:0:b0:3a0:260f:1f4 with SMTP id g25-20020a7bc4d9000000b003a0260f01f4mr3030008wmk.178.1656068200758;
        Fri, 24 Jun 2022 03:56:40 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm1971603wru.21.2022.06.24.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 03:56:39 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH] sched: fix bad task migration for rt tasks
In-Reply-To: <20220623182932.58589-1-schspa@gmail.com>
References: <20220623182932.58589-1-schspa@gmail.com>
Date:   Fri, 24 Jun 2022 11:56:38 +0100
Message-ID: <xhsmhv8sq5nyx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/22 02:29, Schspa Shi wrote:
> @@ -1998,12 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
>  			 * Also make sure that it wasn't scheduled on its rq.
> +			 * It is possible the task has running for a while,
> +			 * And we check task migration disable flag again.
>  			 */
>  			if (unlikely(task_rq(task) != rq ||
>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||

cf. 95158a89dd50 ("sched,rt: Use the full cpumask for balancing"), this
made sense to me back then but not so much anymore... Shouldn't this have
remained a ->cpus_ptr check?

I'm going to revisit that commit, I evicted too much of it.

>  				     task_running(rq, task) ||
>  				     !rt_task(task) ||
> -				     !task_on_rq_queued(task))) {
> +				     !task_on_rq_queued(task) ||
> +				     is_migration_disabled(task))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
>  				lowest_rq = NULL;
> -- 
> 2.24.3 (Apple Git-128)

