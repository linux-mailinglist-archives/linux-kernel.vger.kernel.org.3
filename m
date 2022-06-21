Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735CE552C44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347617AbiFUHny convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jun 2022 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347249AbiFUHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:43:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F3237D1;
        Tue, 21 Jun 2022 00:43:11 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRz3G1mFdz67kTG;
        Tue, 21 Jun 2022 15:41:14 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 21 Jun 2022 09:43:08 +0200
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 08:43:08 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 21 Jun 2022 08:43:08 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Thread-Topic: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Thread-Index: AQHYhPP8VjWNJPtPxUuR+oHDE6Rcoq1ZeCVw
Date:   Tue, 21 Jun 2022 07:43:08 +0000
Message-ID: <fef4fbd55b88481490d52cbd65e1b1f8@huawei.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
In-Reply-To: <20220620222032.3839547-12-paulmck@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org]
> Sent: 20 June 2022 23:21
> To: rcu@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; kernel-team@fb.com;
> rostedt@goodmis.org; Paul E. McKenney <paulmck@kernel.org>; Zhangfei
> Gao <zhangfei.gao@linaro.org>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH rcu 12/12] srcu: Block less aggressively for expedited grace
> periods
> 
> Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> from consuming CPU") fixed a problem where a long-running expedited
> SRCU
> grace period could block kernel live patching.  It did so by giving up
> on expediting once a given SRCU expedited grace period grew too old.
> 
> Unfortunately, this added excessive delays to boots of embedded systems
> running on qemu that use the ARM IORT RMR feature. 

As pointed out here[0]/[1], this delay has nothing to do with ARM IORT RMR
feature. The delay is due to the "-bios QEMU_EFI.fd" line which emulates flash
devices and requires excessive memslot ops during boot.

Thanks,
Shameer

[0] https://lore.kernel.org/all/110bbec5cee74efba0aad64360069a12@huawei.com/
[1] https://lore.kernel.org/all/8735g649ew.wl-maz@kernel.org/


 This commit
> therefore
> makes the transition away from expediting less aggressive, increasing
> the per-grace-period phase number of non-sleeping polls of readers from
> one to three and increasing the required grace-period age from one jiffy
> (actually from zero to one jiffies) to two jiffies (actually from one
> to two jiffies).
> 
> Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> from consuming CPU")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
> Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link:
> https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro
> .org/
> ---
>  kernel/rcu/srcutree.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 50ba70f019dea..0db7873f4e95b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct
> *ssp)
> 
>  #define SRCU_INTERVAL		1	// Base delay if no expedited GPs
> pending.
>  #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from
> slow readers.
> -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase
> consecutive no-delay instances.
> +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase
> consecutive no-delay instances.
>  #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay
> instances.
> 
>  /*
> @@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct
> *ssp)
>   */
>  static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>  {
> +	unsigned long gpstart;
> +	unsigned long j;
>  	unsigned long jbase = SRCU_INTERVAL;
> 
>  	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>  		jbase = 0;
> -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> -	if (!jbase) {
> -		WRITE_ONCE(ssp->srcu_n_exp_nodelay,
> READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> -		if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
> SRCU_MAX_NODELAY_PHASE)
> -			jbase = 1;
> +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> +		j = jiffies - 1;
> +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> +		if (time_after(j, gpstart))
> +			jbase += j - gpstart;
> +		if (!jbase) {
> +			WRITE_ONCE(ssp->srcu_n_exp_nodelay,
> READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
> SRCU_MAX_NODELAY_PHASE)
> +				jbase = 1;
> +		}
>  	}
>  	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
>  }
> --
> 2.31.1.189.g2e36527f23

