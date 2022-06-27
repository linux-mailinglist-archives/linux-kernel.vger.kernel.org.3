Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FF55DC48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiF0VRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiF0VRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:17:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EE186C9;
        Mon, 27 Jun 2022 14:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C07C4B81B8B;
        Mon, 27 Jun 2022 21:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A4DC34115;
        Mon, 27 Jun 2022 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656364619;
        bh=KJZHE6p9iAGgWYymY+W6sviEHo9dVLIq1LS+KPen0+8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iw/0VEsnNwpDBo4zTgY5GYJ9e/L6Sa/sR6Rk35mHfpmloVey0Bd8WTuvJ28ORzflh
         Ew/Q4pA53xFAv5/p3Zi1YqcZTFdPhQ3TIzgb93IuxVoiJLt5+L3oAatm6TFjndYaI1
         WdB7dwLD/s9LmRcM+uR7LUot4RM4aEQztW6kCsY2F4uIHmHP3H8M5JJOq1vtqLt5EU
         e33KI/w3BvlInQ5ZFzCgpAmrSl6EMib51vNwA13iMbkUuqZoDFxZZTljfUtV5Ob2qA
         ISvM3cIMHyOWClTARLKTxcpn3wmtGIH31cIpgONRwNvKCbPC2nLoeA+7rMKK35Lp8D
         T8kLTucUUDA2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1DC075C04B1; Mon, 27 Jun 2022 14:16:58 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:16:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Message-ID: <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
 <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:43:26PM +0000, Zhang, Qiang1 wrote:
> 
> Add Cc 
> 
> Currently, the sync_sched_exp_online_cleanup() is invoked in
> cpuhp per-cpu kthreads when CPU is going online, so the CPU id
> obtained by get_cpu() should always be equal to the CPU id of
> the passed parameter, that is to say, the smp_call_function_single()
> never be invoked, if be invoked, there may be problem with cpu-hotplug,
> this commit add WARN_ON_ONCE() to remind everyone.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_exp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..ae8dcfd4486c 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
>  		put_cpu();
>  		return;
>  	}
> +
> +	WARN_ON_ONCE(my_cpu != cpu);

If we are going to add this sort of warning, why not instead add it
to rcutree_online_cpu()?

The reason the warning has not been present is the prospect of concurrent
onlining at boot time, which might have rcutree_online_cpu() invoked
from CPU 0 for multiple CPUs at boot.  However, the for_each_online_cpu()
loop has recently been removed from rcu_init().

But I would like to hear what others think.  Would such a warning
significantly help debugging?

							Thanx, Paul

>  	/* Quiescent state needed on some other CPU, send IPI. */
>  	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
>  	put_cpu();
> -- 
> 2.25.1
> 
