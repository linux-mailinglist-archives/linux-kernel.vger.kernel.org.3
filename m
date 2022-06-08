Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33486543784
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiFHPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbiFHPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:34:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D44248F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pZa5eMLQs3n7nT3BcYwObs+QQB3Roca3f6HT+aiuC0Q=; b=AA0sKPgCtZ/G7VU8w73P/z8k1h
        kxngExRdgEsvYpnGPMKDAqQ/J9tb+Mk2G81HHQQwIdgUeVlcoFjVRFjq+UuNQBjWwHIeWtlPwv7As
        uasoJwzwZ2awaa7nUkPZzTeDmqYr/zj9fr8hnt98YEz4/e2FfAGbxJ4ECy7Nc3XC4VoxDFVTSPOPQ
        UqEmzfwuoxwzLxenPDrvpIb36ipwWXopursc/Z5YVVVcozfiWUDiazU3IzxCiO1tcbWvhes/5HrNN
        Xbo5Sw2MAuwYhGUUjDxdEsRkVhHaQxV3CtoTJyVC5tQZHuBVlYPpYoK/0dYHkfqAVxBSHbRY+LY10
        npg9QY4w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxgp-0068Fr-2n; Wed, 08 Jun 2022 15:33:47 +0000
Message-ID: <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
Date:   Wed, 8 Jun 2022 08:33:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
Content-Language: en-US
To:     Steven Lung <1030steven@gmail.com>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220608150008.57629-1-1030steven@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220608150008.57629-1-1030steven@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 08:00, Steven Lung wrote:
> The second bracket describing the range is inverted, this patch
> will fix it.
> 
> Signed-off-by: Steven Lung <1030steven@gmail.com>
> ---
>  kernel/sched/pelt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 0f3107682..ed82cfba9 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>   * When syncing *_avg with *_sum, we must take into account the current
>   * position in the PELT segment otherwise the remaining part of the segment
>   * will be considered as idle time whereas it's not yet elapsed and this will
> - * generate unwanted oscillation in the range [1002..1024[.

Is the above the same as                   range [1002..1024).
?  I.e. 1002-1023 inclusive (or 1024 excluded)?

> + * generate unwanted oscillation in the range [1002..1024].
>   *
>   * The max value of *_sum varies with the position in the time segment and is
>   * equals to :

-- 
~Randy
