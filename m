Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A954A3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbiFNBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349498AbiFNBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:53:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28622FE59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:53:33 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LMWf36k7PzjXbj;
        Tue, 14 Jun 2022 09:52:27 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 09:53:31 +0800
Subject: Re: [Bug] Take more 150s to boot qemu on ARM64
To:     <paulmck@kernel.org>
References: <36a0c658-ee5d-3a1c-416c-c041dc344bff@hisilicon.com>
 <20220613132247.GB1790663@paulmck-ThinkPad-P17-Gen-1>
CC:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <e6841520-f9c6-be3a-4a75-4f3339c7af83@hisilicon.com>
Date:   Tue, 14 Jun 2022 09:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20220613132247.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/13 21:22, Paul E. McKenney 写道:
> On Mon, Jun 13, 2022 at 08:26:34PM +0800, chenxiang (M) wrote:
>> Hi all,
>>
>> I encounter a issue with kernel 5.19-rc1 on a ARM64 board:  it takes about
>> 150s between beginning to run qemu command and beginng to boot Linux kernel
>> ("EFI stub: Booting Linux Kernel...").
>>
>> But in kernel 5.18-rc4, it only takes about 5s. I git bisect the kernel code
>> and it finds c2445d387850 ("srcu: Add contention check to call_srcu()
>> srcu_data ->lock acquisition").
>>
>> The qemu (qemu version is 6.2.92) command i run is :
>>
>> ./qemu-system-aarch64 -m 4G,slots=4,maxmem=8g \
>> --trace "kvm*" \
>> -cpu host \
>> -machine virt,accel=kvm,gic-version=3  \
>> -machine smp.cpus=2,smp.sockets=2 \
>> -no-reboot \
>> -nographic \
>> -monitor unix:/home/cx/qmp-test,server,nowait \
>> -bios /home/cx/boot/QEMU_EFI.fd \
>> -kernel /home/cx/boot/Image  \
>> -device pcie-root-port,port=0x8,chassis=1,id=net1,bus=pcie.0,multifunction=on,addr=0x1
>> \
>> -device vfio-pci,host=7d:01.3,id=net0 \
>> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4  \
>> -drive file=/home/cx/boot/boot_ubuntu.img,if=none,id=drive0 \
>> -append "rdinit=init console=ttyAMA0 root=/dev/vda rootfstype=ext4 rw " \
>> -net none \
>> -D /home/cx/qemu_log.txt
>>
>> I am not familiar with rcu code, and don't know how it causes the issue. Do
>> you have any idea about this issue?
> Please see the discussion here:
>
> https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/
>
> Though that report requires ACPI to be forced on to get the
> delay, which results in more than 9,000 back-to-back calls to
> synchronize_srcu_expedited().  I cannot reproduce this on my setup, even
> with an artificial tight loop invoking synchronize_srcu_expedited(),
> but then again I don't have ARM hardware.
>
> My current guess is that the following patch, but with larger values for
> SRCU_MAX_NODELAY_PHASE.  Here "larger" might well be up in the hundreds,
> or perhaps even larger.
>
> If you get a chance to experiment with this, could you please reply
> to the discussion at the above URL?  (Or let me know, and I can CC
> you on the next message in that thread.)

Ok, thanks, i will reply it on above URL.


>
> 						Thanx, Paul
>
> ------------------------------------------------------------------------
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
> .
>

