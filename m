Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82324ED2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCaE2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiCaE22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:28:28 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EF49244
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:22:40 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ea1b9b3813so136088047b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaJDBiNXeo85NKqwKikovuSai9dyzMn7ZUFcWUbG9K4=;
        b=Dghm7x8aL8I+S3eoJS+SEWvqQg2/HrdJdZmypslncGAgF8Q6jajAa+AlgMezpxef6o
         bHbib+fzzD7F8uKhsA5WliGd8RFnkC/eHvtWPuAXq3GoKDDc9Bt8ioIDvMG0Gx0HQP3+
         1cpj4FM6rqIWHd82fAdPpoimSfSgoo+iFYYdrmHtKPdk2vqRFdeNocZmObdk4MHxYnCh
         TrBpqNR4TlEhZ6DMX+4sqQRhjDpFYOGIfdPt/q3W9L+FmTaoIiR9w8P2SUBTI7UEFb7Y
         uEDcy9Ej2yD75Y+Eps/jjEOAfnoDCbV1ZVY265zyzrFmfrXKaqzwD+mPq/5a3pf4g2k0
         84hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaJDBiNXeo85NKqwKikovuSai9dyzMn7ZUFcWUbG9K4=;
        b=p8Z2aY/9Ar3etzmdbJIr7DKsegglhu96whTT2Xy9X8rjg1WlHarr2nq29rrWPIOGhY
         gDa6/m87/oQrA+SkGAuRmzluzxtMFNJtJdNpFSv1e9KUxj3vLnv9PsVCni4IwYZ3cPHr
         +lg3TzTcJGKhC/zmu1HKapLONg+Oz08vcwHr95xTmAIBHgmsR047/qzP3oVYqSRuQ/uZ
         AE2bQveX0RW7cntSs7dYT1T58owTvep0HnR6iSoRGxt9appWy1MhRoqVTqQjpLWPedFJ
         XaWIthFd7PLN0JzgNTD1MhXd3nES5ysbJes5rTbDF+y/VUVdAX6ET+nbXcdCyqDlnsV2
         xRjQ==
X-Gm-Message-State: AOAM532kle8BmdRBxscj0XptL4HlGqwN9CKxijan67pj/+zUWCQ13Y7o
        l+HSNuPXxst7tU9GdW2GTlRSssSbNiPWd29Jg4bC4E4gw/Y=
X-Google-Smtp-Source: ABdhPJyKOD4KBuTUCEA72bdqErUJU17M4nUV462tk9fayCM7ED5z/M9E71vd47H2cNEKwbr2EjxaIEk6j2DAaaZndoc=
X-Received: by 2002:a81:5d09:0:b0:2ea:f17a:15c1 with SMTP id
 r9-20020a815d09000000b002eaf17a15c1mr3181475ywb.481.1648700559248; Wed, 30
 Mar 2022 21:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220329051714.2184811-1-qiang1.zhang@intel.com>
In-Reply-To: <20220329051714.2184811-1-qiang1.zhang@intel.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 31 Mar 2022 12:22:28 +0800
Message-ID: <CAJhGHyCCg_ttPwW6HX8qUJiOVaSYMbKKYsxT3myJczvZWO7H-w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Restrict kworker in the offline CPU pool
 running on housekeeping CPUs
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Lai Jiangshan <jiangshanlai@gmail.com>

I don't think the patch can be applied to the wq tree due to
the change
https://lore.kernel.org/lkml/164512420798.16921.1042432342597886877.tip-bot2@tip-bot2/
which did the rename of HK_TYPE_WQ has not been merged into Linus's tree.

On Tue, Mar 29, 2022 at 1:16 PM Zqiang <qiang1.zhang@intel.com> wrote:
>
> When CPU going offline, all workers in this CPU pool will lose
> affinity to this CPU, and may run to isolated CPU. like kworker
> in unbound pool, set CPU affinity of these kworker is housekeeping
> cpumask.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index abcc9a2ac319..c509ce73a783 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5023,7 +5023,8 @@ static void unbind_workers(int cpu)
>
>                 for_each_pool_worker(worker, pool) {
>                         kthread_set_per_cpu(worker->task, -1);
> -                       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +                       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> +                                               housekeeping_cpumask(HK_TYPE_WQ)) < 0);
>                 }
>
>                 mutex_unlock(&wq_pool_attach_mutex);
> --
> 2.25.1
>
