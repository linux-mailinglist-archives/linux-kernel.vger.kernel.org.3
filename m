Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930F594CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiHPBUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiHPBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:20:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB654CB4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:11:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 73so7520197pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=aYnevW0RKKz7AJ1R70lHY5ms4ueTX8/h0O+eGKTQjTE=;
        b=eZEVHqhUJZBl8nnM5ouCSL9Q0e+bf2oEZJkP1a1mxAW7hqVjwHZHr8VZUjqxiwZ+2E
         BMsqDv0TTpQdSdGtNtf9YCCSib1V/CngKZDbAOAiyNqqYt4akE7WI/OJYRvMmtTGJhdb
         xnAdGOnl7YH7JqrMpeakQQ/vytav1iKi2jS3bEAtqh+KAzyu0VCMX7WEZLYO3kuHBDOZ
         nYzTjeKVuIWOsP+r95Lbu/7404aYFBKgTmSmRBAiK6OmmiyFyeKAeabfG8K3Oz/niOW5
         MH9L+NuHo43T00XN6O45rU7/CvvuRnBt8xsFcSr6h6dnmqvd+Qu9ktjzQb6KgwupPFOa
         8jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=aYnevW0RKKz7AJ1R70lHY5ms4ueTX8/h0O+eGKTQjTE=;
        b=gyr8Sj694x80S/LU+BxIWX+z6gzH2fHbxBH2GJ3XD1VbA0Vtq5E5Yp1rSypi9dj41S
         Nz+t6WW3era7TbxXvWkYAOGs4MweQhgnd77YOFNQo2Mn+RVzaWdlghqm20oV3TkMe3/b
         XYrPj3YErWXx/J5RhiSgkCG81iroju7W34QRyxMgHNoAZXaGmIkWIbuIayKomCHMP7FQ
         EKGAdMKBAld52o9gX0AWo0k790heYfqOcNddgqUcqajvvFzvwBz7dmi86YIZ+UTHg04V
         WfZ16MTAFhjkMcZW94aBL8m6ss3vHST6Z/U0ivDFJbzH8g8uBFN2D8rIEi38YpoJsPMz
         yl6g==
X-Gm-Message-State: ACgBeo2Zp/XRtWL9r2s0/Edvg68FlhphA5Flf99TqaMrL48xevThmNjf
        l2Lt5tWAmfZzP/97PUJr4S8=
X-Google-Smtp-Source: AA6agR5IPlIw8spaOlrBboFpQYQvxkOKtVJJKYzds9edC2L6VjwqSrKFVlGfGNnYur7nRWeUOldhNw==
X-Received: by 2002:a05:6a00:4147:b0:52d:fe84:2614 with SMTP id bv7-20020a056a00414700b0052dfe842614mr18404576pfb.10.1660597864064;
        Mon, 15 Aug 2022 14:11:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090a2a8900b001f239783e3dsm4916818pjd.34.2022.08.15.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:11:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 11:11:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] sched/fair: allow changing cgroup of new forked
 task
Message-ID: <Yvq2ZiQL/iHNAaLh@slm.duckdns.org>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
 <20220808125745.22566-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125745.22566-8-zhouchengming@bytedance.com>
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

On Mon, Aug 08, 2022 at 08:57:43PM +0800, Chengming Zhou wrote:
> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
> introduce a TASK_NEW state and an unnessary limitation that would fail
> when changing cgroup of new forked task.
> 
> Because at that time, we can't handle task_change_group_fair() for new
> forked fair task which hasn't been woken up by wake_up_new_task(),
> which will cause detach on an unattached task sched_avg problem.
> 
> This patch delete this unnessary limitation by adding check before do
> detach or attach in task_change_group_fair().
> 
> So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
> only define it in #ifdef CONFIG_RT_GROUP_SCHED.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

I don't know cfs enough to review this but it'd be really great to remove
this restriction.

Thanks.

-- 
tejun
