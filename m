Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB95964DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiHPVqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiHPVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:46:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98934659E8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:46:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l64so10418600pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=NxDs1MVIhjAwn88VkGljf3tU9fwfD+SaZbrJaFVMORs=;
        b=CnT53Ps3ymbhc1WsH1XI2dvs25VfjXcAo7U3RdbrAeRgMJXMT1St4zHDYmbv99Ddka
         8RCbRlw05yJmyJRNiG7lHvQGBjhiA19HKWGEt9lx1ALNIfRWBDXyLOsaAdNoqXVq5l8i
         B9vqzrictBg0RyqQ/PjvmRZ2QANl3ji6mzcuO3dxDLJkz+45A7EH+qWtNmpRrU4sO3Ie
         X8I2V5mSM8kZeC0rxjN/U3NNwz6JU4uu183IRwF4SHCgRJOe5B3St9PLLdXeQF1mFI1e
         tWzCdYpkHjLMqeEPrB9zqlUCvA2ufVwIx2MOeJG8PJxIX9gZuwOpmRbB67K25tZ4MASR
         XSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=NxDs1MVIhjAwn88VkGljf3tU9fwfD+SaZbrJaFVMORs=;
        b=0smz3oleTYbJ6ZIAXLt6xdYI0RSliJmR2q8/IsP44wBffHILPp/RdMWBW9voX+7Uf9
         WOP1A5xaxzJO9I2+QMLN7z0JVXU38kM6XRzKEFD3f4rYHEjRVj+HyJoMH34Uk89CsFrz
         6NPCWAEyk9KiVm8iyYXMqKHAyr6KZUEh5I8w24doEQV4v8TJb6XXCxhBMOylOTSzZF1a
         rGF5g3/g58aSmVMdjYDs1ADdN8Zlg5TToZCmEf260Xqyuoum6pXShPY9VJl29jSJ+QUt
         I0vq8tRgTVBM7htN0E05vRY7C8iZYP+vWKhal6QUIE0zdfLQCBTs+/5ui3YMyleopULT
         8cRg==
X-Gm-Message-State: ACgBeo1uc78olXjBXObmtcFHutvsz8ZbYGsX2KDYeJzDFSrm93LMR3oh
        7sGjizinyPCV6SOBYTMFyEY=
X-Google-Smtp-Source: AA6agR6/GHqmYD0jX5aWaQmhiWRF+5ZS/Gqm6E9+0JDTYiamcrpUXo3ngb5AqvskYX1j9xp6GosGPQ==
X-Received: by 2002:a63:e109:0:b0:419:c3bc:b89 with SMTP id z9-20020a63e109000000b00419c3bc0b89mr19325293pgh.176.1660686373814;
        Tue, 16 Aug 2022 14:46:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090a558800b001f2fc3828e4sm24272pji.24.2022.08.16.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:46:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 11:46:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/8] workqueue: Make create_worker() safe against
 prematurely wakeups
Message-ID: <YvwQI/83USNc8610@slm.duckdns.org>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804084135.92425-3-jiangshanlai@gmail.com>
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

On Thu, Aug 04, 2022 at 04:41:29PM +0800, Lai Jiangshan wrote:
...
> Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
> until it is explicitly woken. But a spurious wakeup might
> break this expectation.

I'd rephrase the above. It's more that we can't assume that a sleeping task
will stay sleeping and should expect spurious wakeups.

> @@ -176,6 +176,7 @@ struct worker_pool {
>  						/* L: hash of busy workers */
>  
>  	struct worker		*manager;	/* L: purely informational */
> +	struct completion	created;	/* create_worker(): worker created */

Can we define sth like worker_create_args struct which contains a
completion, pointers to the worker and pool and use an on-stack instance to
carry the create parameters to the new worker thread? It's kinda odd to have
a persistent copy of completion in the pool

> @@ -1949,6 +1951,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>  	else
>  		snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
>  
> +	reinit_completion(&pool->created);

which keeps getting reinitialized.

> @@ -2383,10 +2380,17 @@ static int worker_thread(void *__worker)
>  	struct worker *worker = __worker;
>  	struct worker_pool *pool = worker->pool;
>  
> +	/* attach the worker to the pool */
> +	worker_attach_to_pool(worker, pool);

It's also odd for the new worker to have pool already set and then we attach
to that pool.

> @@ -37,8 +37,15 @@ struct worker {
>  	/* 64 bytes boundary on 64bit, 32 on 32bit */
>  
>  	struct task_struct	*task;		/* I: worker task */
> -	struct worker_pool	*pool;		/* A: the associated pool */
> -						/* L: for rescuers */
> +
> +	/*
> +	 * The associated pool, locking rules:
> +	 *   PF_WQ_WORKER: from the current worker
> +	 *   PF_WQ_WORKER && wq_pool_attach_mutex: from remote tasks
> +	 *   None: from the current worker when the worker is coming up
> +	 */
> +	struct worker_pool	*pool;

I have a difficult time understanding the above comment. Can you please
follow the same style as others?

I was hoping that this problem would be fixed through kthread changes but
that doesn't seem to have happened yet and given that we need to keep
modifying cpumasks dynamically anyway (e.g. for unbound pool config change),
solving it from wq side is fine too especially if we can leverage the same
code paths that the dynamic changes are using.

That said, some of complexities are from CPU hotplug messing with worker
cpumasks and wq trying to restore them and it seems likely that all these
will be simpler with the persistent cpumask that Waiman is working on. Lai,
can you please take a look at that patchset?

Thanks.

-- 
tejun
