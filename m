Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964BA536A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350964AbiE1CIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiE1CIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC5F62A25
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653703690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BilZlRuBX0e87BiCfhHrxcgaP2G8p748ZT9BTfjho68=;
        b=CtIOkuEmYNryhq8EVtS8Z1/iP9Q8XPzY7IUb5UXkInq6H21Fwh0TOikPOYxh6JSv2bvZ59
        4zBGLwAR3wmbKoefvhqlmqmKxQAy7d+d+tcvczWz8pr9NCKnnPs/6wD/omnAu+GyiJxg6J
        GPNOdbhdMOz2y0rl0uaG2JK2o8bSG/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-FnV1EXgqOk-HVxQwkp-5nw-1; Fri, 27 May 2022 22:08:00 -0400
X-MC-Unique: FnV1EXgqOk-HVxQwkp-5nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2408027EE;
        Sat, 28 May 2022 02:08:00 +0000 (UTC)
Received: from [10.22.33.184] (unknown [10.22.33.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E14CC1121314;
        Sat, 28 May 2022 02:07:59 +0000 (UTC)
Message-ID: <fa2d516e-70b5-3012-9134-5ca325282bc4@redhat.com>
Date:   Fri, 27 May 2022 22:07:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clocksource: Make clocksource watchdog check with
 WATCHDOG_INTERVAL period
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Larabel <Michael@phoronix.com>,
        Joe Mario <jmario@redhat.com>,
        Michey Mehta <mimehta@redhat.com>
References: <20220528015714.109442-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220528015714.109442-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 21:57, Waiman Long wrote:
> Since commit c86ff8c55b8a ("clocksource: Avoid accidental unstable
> marking of clocksource"), a new WD_READ_SKIP value was introduced
> as a possible return value of cs_watchdog_read() to skip the current
> check. However, this has an undesriable side effect of extending the
> time gap between csnow and cs_last to more than one WATCHDOG_INTERVAL
> (0.5s) in case of intermittent WD_READ_SKIP's.
>
> There was an instance of reported clocksource watchdog failure with
> the time skew of 485us where the uncertainly threshold is 400us. In
> that particular case, the (now - last) gap was about 2s. Looking at
> the dmesg log, it was clear there was a successful cs_watchdog_read()
> followed by 3 skips and then another successful cs_watchdog_read().
>
> If there is an existing skew between the hpet (watchdog) and tsc
> clocksource, enlarging the period by 4x will certainly increase the
> measured skew causing it to exceed the threshold in this case. Fix
> this variable period problem by resetting the CLOCK_SOURCE_WATCHDOG bit
> after each WD_READ_SKIP to force the reloading of wd_last and cs_last
> in the next round. This ensures that we have two consecutive successful
> cs_watchdog_read()'s before checking the clock skew.
>
> Fixes: c86ff8c55b8a ("clocksource: Avoid accidental unstable marking of clocksource")
> Reported-by: Michael Larabel <Michael@phoronix.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/time/clocksource.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index cee5da1e54c4..173e052c12b6 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -411,9 +411,18 @@ static void clocksource_watchdog(struct timer_list *unused)
>   		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
>   
>   		if (read_ret != WD_READ_SUCCESS) {
> -			if (read_ret == WD_READ_UNSTABLE)
> +			if (read_ret == WD_READ_UNSTABLE) {
>   				/* Clock readout unreliable, so give it up. */
>   				__clocksource_unstable(cs);
> +			} else { /* WD_READ_SKIP */
> +				/*
> +				 * Watchdog clock unstable at the moment,
> +				 * discard the stored wd_last and cs_last to
> +				 * make sure the gap between now and last
> +				 * is always one WATCHDOG_INTERVAL.
> +				 */
> +				cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> +			}
>   			continue;
>   		}
>   

Sorry, I accidentally use the old email address for John.

Cheers,
Longman

