Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A0552932
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiFUCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245663AbiFUCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:00:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31E1F2C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:00:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f8so11226998plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vXSRs4VvP3x0Znga9Of9H/HEzlYBRuGGU2+TOqlk4gg=;
        b=g9PmUnxw3mihAqmTXmyIN/UZ1RQhh7a95nNsKWh4vR9sf0qCjDHE/o6ZIeAnOjdEVL
         agay+Mj93QrNaxiqBOGbhBSAbwu2Gz8zLcZnMzvxcU8PwDYYf4Lyt8gtqqBU+ABaXSq1
         qTXGbLOKoz+jPOkhjT2IXAEfGs4eO62jiF79WwH+T5BHX2NOSPS2EXGxImu1Igeti9iu
         scKpEJW5VSa0f9vxqXFCOxf3uMIH8wYy54aCV0KV7L5aHL+ZtZPpl3yIkjgsEprSEg2M
         4dUaIkyJ9d4SSQIARy2au1uZj+7e7/FZZGEBqSwIszZUp5Kv5sK9JUgKRCgNobso345H
         8ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vXSRs4VvP3x0Znga9Of9H/HEzlYBRuGGU2+TOqlk4gg=;
        b=FDM8bdCP/lmFrqLb6Fkgm6xkSvDpHD0nRpGnXZEGRh+PRBLtAasBX3gTDPWY9bLw1Z
         RrnppIb0O7I+ywR1w4tsBC9KkRdaAG8e0FhrTJxQkc901+DSXMFZ1QqCBT7jPuxcXCQB
         +TO2WXA2Lc3XbELmbLDrotEy+0jrPjpOHJbcL+/CMsaRFpulePWWd/VONaLv2a0JGslU
         6etdFf0QoioOjd3B7xPn6VjwlM2zW0HWtAW835ddfb6Zp2AJwfngv8CuwLp/RQ2nkIna
         2fJ4OPGlDpfrrJ2e3qx5XkJUMNpBJ1ZMDlbxB4I+DECt+p6TQF2lbw8TJ8VHNh4ZjYkF
         UJYQ==
X-Gm-Message-State: AJIora+tlSUeYBIDJuBMKhnMgFqJzz3PTW8/t3xKCbgaLtURAc2+WfP1
        TSaqsMOue/PuRher4X5ogV+Lpw==
X-Google-Smtp-Source: AGRyM1vEZPAaJ7NbnEz+jr+kqJkEpfJgdGyqHaJ+LUomJ1EoKV0o7a87fK8jVcHC0RMfwZzV/7GZug==
X-Received: by 2002:a17:90b:1e47:b0:1e6:7d04:2f4 with SMTP id pi7-20020a17090b1e4700b001e67d0402f4mr30015391pjb.93.1655776812748;
        Mon, 20 Jun 2022 19:00:12 -0700 (PDT)
Received: from [10.10.0.18] ([199.101.192.101])
        by smtp.gmail.com with ESMTPSA id mp15-20020a17090b190f00b001ec92c52285sm4246172pjb.21.2022.06.20.19.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 19:00:12 -0700 (PDT)
Subject: Re: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zhangfei Gao <zhangfei.gao@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6b89e108-69e1-5fe2-67ba-3dac9ec60f83@linaro.org>
Date:   Tue, 21 Jun 2022 10:00:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220620222032.3839547-12-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/21 上午6:20, Paul E. McKenney wrote:
> Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> from consuming CPU") fixed a problem where a long-running expedited SRCU
> grace period could block kernel live patching.  It did so by giving up
> on expediting once a given SRCU expedited grace period grew too old.
>
> Unfortunately, this added excessive delays to boots of embedded systems
> running on qemu that use the ARM IORT RMR feature.  This commit therefore
> makes the transition away from expediting less aggressive, increasing
> the per-grace-period phase number of non-sleeping polls of readers from
> one to three and increasing the required grace-period age from one jiffy
> (actually from zero to one jiffies) to two jiffies (actually from one
> to two jiffies).
>
> Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
> Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/

Test on 5.19-rc1 with this patch with qemu boot with -bios 
QEMU_EFI-2022.fd, seems not work, same as rc1.

real    2m42.948s
user    0m2.843s
sys     0m1.170s

qemu: stable-6.1

build/aarch64-softmmu/qemu-system-aarch64 -machine 
virt,gic-version=3,iommu=smmuv3 \
-enable-kvm -cpu host -m 1024 \
-kernel /home/linaro/Image -initrd /home/linaro/tmp/ramdisk-new.img 
-nographic -append \
"rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
-bios QEMU_EFI-2022.fd

Thanks
> ---
>   kernel/rcu/srcutree.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 50ba70f019dea..0db7873f4e95b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>   
>   #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
>   #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
> +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
>   #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
>   
>   /*
> @@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>    */
>   static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>   {
> +	unsigned long gpstart;
> +	unsigned long j;
>   	unsigned long jbase = SRCU_INTERVAL;
>   
>   	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>   		jbase = 0;
> -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> -	if (!jbase) {
> -		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> -		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> -			jbase = 1;
> +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> +		j = jiffies - 1;
> +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> +		if (time_after(j, gpstart))
> +			jbase += j - gpstart;
> +		if (!jbase) {
> +			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> +				jbase = 1;
> +		}
>   	}
>   	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
>   }

