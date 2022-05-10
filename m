Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAD520EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiEJHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiEJHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:46:00 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA009FD36D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:37:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VCq7Cgf_1652168239;
Received: from 30.47.227.128(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VCq7Cgf_1652168239)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 15:37:20 +0800
Message-ID: <5443c895-b4bb-1297-400b-6a8ffd1d63b1@linux.alibaba.com>
Date:   Tue, 10 May 2022 15:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] sched/core: Optimize sched_core_next()
Content-Language: en-US
From:   cruzzhao <cruzzhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <1650820094-27165-1-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1650820094-27165-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping... Is this patch necessary?

在 2022/4/25 上午1:08, Cruz Zhao 写道:
> As there is __node_2_sc() defined before, just use it instead of
> container_of() in function sched_core_next().
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d50d4dd..d3e3d6e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -284,7 +284,7 @@ static struct task_struct *sched_core_next(struct task_struct *p, unsigned long
>  	if (!node)
>  		return NULL;
>  
> -	p = container_of(node, struct task_struct, core_node);
> +	p = __node_2_sc(node);
>  	if (p->core_cookie != cookie)
>  		return NULL;
>  
