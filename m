Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12FE550FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiFTF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFTF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:58:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC6DEAE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:58:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3177e60d980so67910007b3.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egIeA0SLiNKPO05jBSIhD4zajMaFQurv8Liu1WE1vnw=;
        b=Hm/mIxcdIrxo4vcfPCwqoIdnwfM9pxdUwDishkv0nLmHeZuQ1nVoX3BlcOhR6KZ2Zo
         p3BXk4GQzEn8ft2uMVQNFFteDiOY0W75kAaCEjpBL25+CBbgeBo1Lu8lCBPeJOslwZqD
         3+Sbq74e2KbX5lcuOl2G2Ic85R6vASLugqZ1dRZra5R0UBwHPVepxzjuLW6bFejI9gvy
         M8O16iQkh56FXlggXCl7cFJ0Iv55gaHA0q28Kcg4measyqHSQBm1d5PZT0V7Jnc9Y1DX
         YDWs2/9gG/1EZDtdz/6N5v9xNqLmzXSRiBpBhbBa83dq86UeP8olLdt+OEjsisDszW2E
         jtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egIeA0SLiNKPO05jBSIhD4zajMaFQurv8Liu1WE1vnw=;
        b=2NemY3c+cmLmjcQVHzChUItD7Mzw6vYnJiadZGNCjGnfGCX+6r+vwJEeG5FAMHSPZp
         i2e0ZujuWulhp0xCmuLCoWJ45t+oGjtS5Jgv6FDDvH27j7kwcToGO1dWZ2EVcWc7T7kj
         /DResOqi8NOoyJTOIbXVJmfzpoMLiaayf5QP/fC0s41S6KpuyCzih6UkpYgGRyRGWKzj
         JMkMfpV6+b7iyzx3tBQ8XwPS305tLD6ZYVmmT3plS9X6FEsUZAP2wdiGfw0qRnGsUOj6
         ZqKqklsnd03/EX+Go6LtE1+lWQClrjE8PobaRZ7rMd4+1Wdp+qecRm/8EWbtUr0XXET2
         thQw==
X-Gm-Message-State: AJIora8RNvmBMsZ0B+e6QoqMr4Kkj8k/RNOkTqrNx+khLzbRiTokLjhY
        e91DojT7cZnluzad+1kRHowc3QLSeJFor35GjZiTYQ==
X-Google-Smtp-Source: AGRyM1ulQxTr+Wr84F5MnzG72nrYY1QBkWXUVNriTzp7n6KtSwDVFxLxUFM6BYQiRSbQPLuvT/Dwidct0zlYQjTbWoc=
X-Received: by 2002:a81:de4a:0:b0:30f:d89a:f025 with SMTP id
 o10-20020a81de4a000000b0030fd89af025mr26006259ywl.228.1655704681916; Sun, 19
 Jun 2022 22:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220617181151.29980-1-zhangqiao22@huawei.com> <20220617181151.29980-3-zhangqiao22@huawei.com>
In-Reply-To: <20220617181151.29980-3-zhangqiao22@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Jun 2022 07:57:50 +0200
Message-ID: <CAKfTPtB480JTahcvo-+pnfA1ZO3H2mterMO8bPegJV_4BkW8Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Remove unused function group_first_cpu()
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 at 06:14, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
> group_first_cpu() is an unused function, remove it.
>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/sched.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 01259611beb9..8f57e9391e82 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1810,15 +1810,6 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
>         return to_cpumask(sg->sgc->cpumask);
>  }
>
> -/**
> - * group_first_cpu - Returns the first CPU in the cpumask of a sched_group.
> - * @group: The group whose first CPU is to be returned.
> - */
> -static inline unsigned int group_first_cpu(struct sched_group *group)
> -{
> -       return cpumask_first(sched_group_span(group));
> -}
> -
>  extern int group_balance_cpu(struct sched_group *sg);
>
>  #ifdef CONFIG_SCHED_DEBUG
> --
> 2.18.0
>
