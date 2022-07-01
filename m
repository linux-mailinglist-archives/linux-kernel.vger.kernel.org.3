Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA0563145
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiGAKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 921391A808
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656670909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Vf5S/F+32nKTh5v7sEJEmLVMwRomWADa1AoErk2U0M=;
        b=TrvNdkIWKdNyNgBGzHOtRo7D1i9G/NK3jvRCXeR+sC0K6+syta1BXMT/8vTO4slkn9Sfvt
        MjQEbX+wlmmO5oHkkRah2fstsByg6HjecmbYxaA5hVo1hYXIMgFKL7mW9ci7X1jgm4pg7S
        AeUfH+tO4OwSRpoZAYlNTIcd6sdy7LQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-IYWog9hcMTu9DU2_2-nIFA-1; Fri, 01 Jul 2022 06:21:48 -0400
X-MC-Unique: IYWog9hcMTu9DU2_2-nIFA-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so1189152wmp.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2Vf5S/F+32nKTh5v7sEJEmLVMwRomWADa1AoErk2U0M=;
        b=b1orjpjdmE7Y95gOD/+PS8qFPEcO4+Z1Pv7aoxEtp0R/7mFHApb9JlE0rzJ5Y9nfSS
         1XzRtsqSVG2vi1AOjjQmQCtprsgVNNSwZhQ00wcktegJnfB7dfeCiaPvtS+UmMQFYa6t
         Xs1piOKJKTgXBSjMEEBsi4eUR2pxPKnaw1hRM14tHHkv5aB1SEYXzB5Udap8jLZFZr79
         bFMoTzSwrihFsWIfbpjp38oev2nBbnLAVmvuLyxpJJcDN/99yY5GOjWQCQVS0GRzjVsd
         iyMhkgelF9Zss+TRzZSAUnXqAumzJaA6IvxM5wlLrzZtWP5L6YFAzB4AWJJ8ZvLsruAF
         vXMw==
X-Gm-Message-State: AJIora/jkEuHZxUJZgSOa1yBhZ6AiVH8qlC3nbOHx071UYgVJgg3eSVG
        cENVhkbvtvtzmvQ9ew+1gOIW4fbMbBgEBOyeuxPPovz6NMUrqCPwvfS8vowJPOf7eW+kt3KOhkA
        Ikv24+3tRRD+yfIP/bnQYVzpJ
X-Received: by 2002:adf:ec02:0:b0:21b:931c:cf78 with SMTP id x2-20020adfec02000000b0021b931ccf78mr12192561wrn.188.1656670907353;
        Fri, 01 Jul 2022 03:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tKyPytZ3gt00eeQUwjPjhaWXGeInFX5SpECkd/xh/sIuxqx/y+iN7lbgSzoV9wySyIbYLhVA==
X-Received: by 2002:adf:ec02:0:b0:21b:931c:cf78 with SMTP id x2-20020adfec02000000b0021b931ccf78mr12192544wrn.188.1656670907132;
        Fri, 01 Jul 2022 03:21:47 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a0fb88a197sm9825501wms.16.2022.07.01.03.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:21:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH v2] sched/rt: fix bad task migration for rt tasks
In-Reply-To: <20220627154051.92599-1-schspa@gmail.com>
References: <20220627154051.92599-1-schspa@gmail.com>
Date:   Fri, 01 Jul 2022 11:21:45 +0100
Message-ID: <xhsmhh7415e12.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/22 23:40, Schspa Shi wrote:
> @@ -2115,6 +2115,15 @@ static int push_rt_task(struct rq *rq, bool pull)
>       if (WARN_ON(next_task == rq->curr))
>               return 0;
>
> +	/*
> +	 * It is possible the task has running for a while, we need to check
> +	 * task migration disable flag again. If task migration is disabled,
> +	 * the retry code will retry to push the current running task on this
> +	 * CPU away.
> +	 */
> +	if (unlikely(is_migration_disabled(next_task)))
> +		goto retry;
> +

Can we ever hit this? The previous is_migration_disabled() check is in the
same rq->lock segment.

AFAIA this doesn't fix the problem v1 was fixing, which is next_task can
become migrate_disable() after push_rt_task() goes through
find_lock_lowest_rq().

For the task to still be in the pushable_tasks list after having made
itself migration disabled, it must no longer be current, which means we
enqueued a higher priority RT task, in which case we went through
set_next_task_rt() so we did rt_queue_push_tasks().

So I think what you had in v1 was actually what we needed.

>       /* We might release rq lock */
>       get_task_struct(next_task);
>
> --
> 2.24.3 (Apple Git-128)

