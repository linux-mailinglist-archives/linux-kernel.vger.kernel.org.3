Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF91579587
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiGSIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGSIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:49:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112D3CBCD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:49:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c131so24597259ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vHg8DQ2Tg8YgLGt/VZUAEDbWYI/+dfDPC1iJtL/ZaQ=;
        b=qoaVeQy03AOCvYuaoC3xcs18H1fPNZnmn5ICr8KOHkg/cA4JWayA+FR4H5lRLbAH6z
         Sp/msF5Qj7Nd1llGVhs5AyiRQ40xdcAHpj0wRGQEIWM906TArjsdTQN6hKthyWiuMVxc
         7EL5+TW+9cDh90DrbQai0900mc+k0cVg4G20NK4xtA+B2PsYf6RYERN5FWPu0sgIl7Dn
         njSf/zwZhtctLQYxCsurCxJDpzF/VmIcmIILeiTzPVuz5CVJEh9kemu81KOs8ObC7PSO
         BN4eLCEEsaal8v88eULhoS7TGRErLiiuIdnHo6lD1DYfHnmUiLbJjvROCtsLXmQcL5qY
         dIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vHg8DQ2Tg8YgLGt/VZUAEDbWYI/+dfDPC1iJtL/ZaQ=;
        b=Jy5sUvueiKfvZ+I+2iVRhnPVLrARrG2bZ7wXYemq/v035PM5sQDTZsoYguybPjqiqz
         5WEKw1D7aWvCAHsIJfrJOMPEzJl8EyEa6S62duvgONFLIRB8k+Wbt4B8WQ4oTEPYivF4
         M7Edw81fIqepKu8zg9sRcNBpVc+g+yECB0NJ/bgVCHG5Z29kXLGGDYRS9L3O/4GfE+JW
         A+g4H+n9IRy5sFZVuNYgqepiD4KGnfpyDuNt/8Gru2HcleSJ9WWxqAknqjfBCXSUPs0x
         Iz9F9XwF4mFRU8AX3T8QO1BaF/5moPZSFq8r7t0LJh1W93bn3j1b077s8s61fYU/7v5n
         gcfA==
X-Gm-Message-State: AJIora/FSpsFaHeKGpfaEpG3PEv7Vy4H0tuPDS1ue0ACjJRxxKseYBUu
        UmELH/wXymsHpjUwpU99Jqae73xIjCgaJS3GVrJZVWClIPg=
X-Google-Smtp-Source: AGRyM1tiNePdb+JvSdi9PmHXpGIZeM+KdpbzCcvfwfsWghqHWnuBGGR1j+BBt0qSt5cHh/AkCVdP4PXYz2EkidfOOiM=
X-Received: by 2002:a25:76cd:0:b0:66e:c634:1047 with SMTP id
 r196-20020a2576cd000000b0066ec6341047mr31269332ybc.241.1658220593168; Tue, 19
 Jul 2022 01:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com> <20220713040430.25778-6-zhouchengming@bytedance.com>
In-Reply-To: <20220713040430.25778-6-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jul 2022 10:49:41 +0200
Message-ID: <CAKfTPtCe3x06+O76ORcpVxJdp3qrrYN79m34YxmogyA0eVDMCw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] sched/fair: reset sched_avg last_update_time
 before set_task_rq()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 06:05, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
> task's sched_avg when migrate, which is not needed for already detached
> task.
>
> task_change_group_fair() will detached the task sched_avg from prev cfs_rq
> first, so reset sched_avg last_update_time before set_task_rq() to avoid that.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8992ce5e73d2..171bc22bc142 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11637,12 +11637,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  static void task_change_group_fair(struct task_struct *p)
>  {
>         detach_task_cfs_rq(p);
> -       set_task_rq(p, task_cpu(p));
>
>  #ifdef CONFIG_SMP
>         /* Tell se's cfs_rq has been changed -- migrated */
>         p->se.avg.last_update_time = 0;
>  #endif
> +       set_task_rq(p, task_cpu(p));
>         attach_task_cfs_rq(p);
>  }
>
> --
> 2.36.1
>
