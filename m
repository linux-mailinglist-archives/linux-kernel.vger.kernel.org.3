Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3C5AB64D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIBQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiIBQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:11:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14329C95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DB17B82C83
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BD1C433D7;
        Fri,  2 Sep 2022 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662134820;
        bh=NrdRZZGQpIkJd2dPFQ5BPqaAgpxFgSkcxmdBBCfc9fQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N0Uiy4R2LFCrLawuMjtPukyIXv+tBTvCJvdfG+wYzM0hZxvrHdUmBfI4yOrfMDgi9
         5ssO9knq2+oAImjDMH7M4iMr4S1sqtHoZNeCA29JbDOrtLjNVw3A+719ZNIlSW60bp
         E8PSCrR/rUXdeufPP6hjY0nmEE6wAK7g6nn816LA=
Date:   Fri, 2 Sep 2022 09:06:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Message-Id: <20220902090659.28829853543cac3f3f725df5@linux-foundation.org>
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Sep 2022 23:22:43 +0800 Jiebin Sun <jiebin.sun@intel.com> wrote:

> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counters
> greatly improve the performance. Since there is one unique
> ipc namespace, additional memory cost is minimal. Reading
> of the count done in msgctl call, which is infrequent. So
> the need to sum up the counts in each CPU is infrequent.
> 
> Apply the patch and test the pts/stress-ng-1.4.0
> -- system v message passing (160 threads).
> 
> Score gain: 3.38x

So this test became 3x faster?

> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/stress-ng-1.4.0
> -- system v message passing (160 threads)
> 
> ...
>
> @@ -138,6 +139,14 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
>  	preempt_enable();
>  }
>  
> +static inline void
> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	preempt_disable();
> +	fbc->count += amount;
> +	preempt_enable();
> +}

What's this and why is it added?

It would be best to propose this as a separate preparatory patch. 
Fully changelogged and perhaps even with a code comment explaining why
and when it should be used.

Thanks.
