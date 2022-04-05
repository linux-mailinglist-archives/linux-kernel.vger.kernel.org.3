Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA44F427A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiDEURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384276AbiDEPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:14:54 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18320F58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:29:17 -0700 (PDT)
Received: from [192.168.137.80] (unknown [182.2.74.86])
        by gnuweeb.org (Postfix) with ESMTPSA id 817617E342;
        Tue,  5 Apr 2022 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649165356;
        bh=uhjmyqCr5OwOhwtddzDczmaKyd1OpK7B0pVdY6yUzsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xv/VvDq1G5l3g+F4JGca9f8EyByl27s/3e+PX1uX1km0gUENZt8pBz9XjfERXQJ4h
         Pp0ipO6MfXvr9NL94dhv6mGiAlV0ocA6NLUH6uPKfBwiRy5Tf00a475qYPhglDEiJW
         8xGBDRVOQLRCiv4UAZMLnZCwzpS/204A0zEz9Q0QGGxx+iqM3v+yTyxOrh6OAN9145
         y9g/HsPoH3+9qAhlQn7dSJ+5zFJzcVqcGkrDkjmCraDoBnaJYqTQacmQpUE/2maBJ/
         s8fXummwbYsvgENLZEkY7FQR/wEz7NOYhM/FfexN56gSHS9m6DxbPyIddEzuzifoab
         xR52iQQyA0bEw==
Message-ID: <df464935-9743-0f4c-1edb-e0204bab938e@gnuweeb.org>
Date:   Tue, 5 Apr 2022 20:29:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
 <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 7:21 PM, Dietmar Eggemann wrote:
> Maybe you could split the SCHED_WARN_ON so we know which signal causes this?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..0d45e09e5bfc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3350,9 +3350,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq
> *cfs_rq)
>           * Make sure that rounding and/or propagation of PELT values never
>           * break this.
>           */
> -       SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> -                     cfs_rq->avg.util_avg ||
> -                     cfs_rq->avg.runnable_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.load_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.util_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.runnable_avg);
> 
>          return true;
>   }

error: corrupt patch at line 6

Trivial enough, fixed it. Compiling now...

ammarfaizi2@integral2:~/work/linux.work$ git log -n1
commit 3123109284176b1532874591f7c81f3837bbdc17 (HEAD -> master, tag: v5.18-rc1, @torvalds/linux/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Apr 3 14:08:21 2022 -0700

     Linux 5.18-rc1
ammarfaizi2@integral2:~/work/linux.work$ git diff
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..0d45e09e5bfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3350,9 +3350,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
  	 * Make sure that rounding and/or propagation of PELT values never
  	 * break this.
  	 */
-	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
-		      cfs_rq->avg.util_avg ||
-		      cfs_rq->avg.runnable_avg);
+	SCHED_WARN_ON(cfs_rq->avg.load_avg);
+	SCHED_WARN_ON(cfs_rq->avg.util_avg);
+	SCHED_WARN_ON(cfs_rq->avg.runnable_avg);
  
  	return true;
  }
ammarfaizi2@integral2:~/work/linux.work$

-- 
Ammar Faizi
