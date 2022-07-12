Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7513D570F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiGLBCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGLBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:02:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57272B1B2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:02:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b9so6162200pfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=eEKfD4DXCvbmgzv0ixJGIm91G//ZHAqHIVbhoZXLE/A=;
        b=C4kQP/YwRewUiYXL5tBUB5UeB9uim08I/7ESl4/tJJU5hgnlx/w9IfrdWneXopesM+
         bzUPS3se5BtlrnqdufOJfdGu96vhF0WqZ/M+AUOd86o9KxUKZEcC/E0hL9t3cGKDCyAp
         A7sK3P5yXUkZU404fx51qTircVgRL+Hj9LTFiC+atboQSmLY/9ck7Ajzn8lsdTew7jfV
         G/BFkoeCPuKfYwU8MHVcur+P5Fpbi/p7/9cEpWVAiPJxg4eyahYaHcF1TrwJ2toNYW1C
         RIu7jpMChc2/vmePV5SwBSceFd0Y2OW8j/JtL3J7MN5Vo7KSX11FPbci3KJx0uszEQR6
         LVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=eEKfD4DXCvbmgzv0ixJGIm91G//ZHAqHIVbhoZXLE/A=;
        b=htfTUmxHclWtlDzxVJSQOXcse87oT8uN4UtZ1pzJFbAREobreb+E2mAmP6EybBxTNc
         M/kFbPmwTR8nAyALx0WM3tvJEunkPjb/qkm1xofUA9M8UPCMFjUfoRp0+aJAW1O9dwOb
         WaOWdXgN+eDf26ERPDkKHwNdCKC6yx1+cXS9lBr7DVRuIEv6oaN9lle0NBRr1ddlIqXQ
         zhJQ7FzxcOkrcTaNl6ZIbjCxXi+/rJs5VkqqUZVERPPhNA9qbFFZcpCKekATFOpNYIbm
         1dm9ChLzSUZQvvpZHgf//C0wJ92Fqp4h6gcSYLPwdEQocpFdf+Jx5AmPYtVhxIw78NsP
         H4hg==
X-Gm-Message-State: AJIora+Gu7W2zk5+xTa+1lwEy4VHLC+MQTGwl20RELQuK9t2cUBKC2im
        FWrulAsy8XPACc3Kj5FaDejas+Dz4UH4Pg==
X-Google-Smtp-Source: AGRyM1sqYLYHxvjgCJ1RAQGuLmmZH2futx2h4mUe9YNvbYZGYfqKmda6tUcXOc/T6EWK7Lf8S045kA==
X-Received: by 2002:a63:d54:0:b0:416:73d:d5cf with SMTP id 20-20020a630d54000000b00416073dd5cfmr6396781pgn.579.1657587722821;
        Mon, 11 Jul 2022 18:02:02 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b0015e8d4eb231sm5375175plk.123.2022.07.11.18.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:02:02 -0700 (PDT)
References: <20220708211755.73637-1-schspa@gmail.com>
 <20220708172614.14191089@gandalf.local.home> <m2v8s7mg78.fsf@gmail.com>
 <20220711161037.06b8c1ea@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Tue, 12 Jul 2022 08:53:56 +0800
In-reply-to: <20220711161037.06b8c1ea@gandalf.local.home>
Message-ID: <m2edyrnny9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 09 Jul 2022 05:32:25 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> >> +++ b/kernel/sched/rt.c
>> >> @@ -1998,11 +1998,14 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>> >>  			 * the mean time, task could have
>> >>  			 * migrated already or had its affinity changed.
>> >>  			 * Also make sure that it wasn't scheduled on its rq.
>> >> +			 * It is possible the task has running for a while,  
>> >
>> > I don't understand the "running for a while" part. That doesn't make sense.
>> >  
>> 
>> When I say "run for a while" I mean as long as the task has
>> run capability, we should check the migrate disabled flag again.
>> 
>> > The only way this can happen is that it was scheduled, set
>> > "migrate_disabled" and then got preempted where it's no longer on the run
>> > queue.  
>> 
>> Yes, it is the only case.
>
> Can we then change the comment, as the "running for a while" is not clear
> to what the issue is, and honestly, sounds misleading.
>
> -- Steve

How about to change this to 

			/*
			 * We had to unlock the run queue. In
			 * the mean time, task could have
			 * migrated already or had its affinity changed.
			 * Also make sure that it wasn't scheduled on its rq.
			 * It is possible the task was scheduled, set
             * "migrate_disabled" and then got preempted, And we
             * check task migration disable flag here too.
			 */

-- 
BRs
Schspa Shi
