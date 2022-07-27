Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D91582A24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiG0QBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiG0QAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:00:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610534A836;
        Wed, 27 Jul 2022 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMrUUBtTVdKIO/818CmIJX7vjH07uHfMlbshxW7VLdA=; b=nIvbupTuXBJpWvBzPBt2Fx6zXm
        gRJVJy0fXowGNX0j4MGolZVVSD17TQPRl1+ijvtUOyRpRwn+rWnv3MHbtKzOB3QmSFMuxDSY1PMqs
        k9LNHU2R/ZJqM0mAW8e7VmKCLpnTTUdpZ4TNS1lYTqc05v0ftxapcGOErWHObIH+JdmdYuO0hL4px
        HElouXjWXQkrbsONRI1jjXnEyg+ZL92+AWHLyR/74GhLk+joY+o/46+Y+0bHZuO9YB8oUXiVVskTO
        BYVYO7ih//oF6ry8oJkuQBNjemcUJoq7X6eRl+27MLYtsSHR6F9ZWTUk4/IyOPPRZY6b49nmO6xgk
        XRMCEjRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjSc-0031u0-Gx; Wed, 27 Jul 2022 16:00:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FC01980403; Wed, 27 Jul 2022 18:00:34 +0200 (CEST)
Date:   Wed, 27 Jul 2022 18:00:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] x86/aperfmperf: use time_is_before_jiffies(a + b) to
 replace "jiffies - a > b"
Message-ID: <YuFhIgsUgNJ+o9xG@worktop.programming.kicks-ass.net>
References: <20220727031405.26892-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727031405.26892-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 11:14:05AM +0800, Yu Zhe wrote:
> time_is_before_jiffies deals with timer wrapping correctly.

Please explain how the current code does not.

> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index 1f60a2b27936..22e0bac3fffe 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -423,7 +423,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>  	 * Bail on invalid count and when the last update was too long ago,
>  	 * which covers idle and NOHZ full CPUs.
>  	 */
> -	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> +	if (!mcnt || time_is_before_jiffies(last + MAX_SAMPLE_AGE))
>  		goto fallback;
>  
>  	return div64_u64((cpu_khz * acnt), mcnt);
> -- 
> 2.11.0
> 
