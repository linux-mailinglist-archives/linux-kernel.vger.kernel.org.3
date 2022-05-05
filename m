Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD051CCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386882AbiEEXsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiEEXs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:48:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F62606EF;
        Thu,  5 May 2022 16:44:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B5B106F;
        Thu,  5 May 2022 16:44:46 -0700 (PDT)
Received: from [10.57.0.148] (unknown [10.57.0.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C393F85F;
        Thu,  5 May 2022 16:44:43 -0700 (PDT)
Message-ID: <483bb401-13e6-8c52-4b5f-f3c635b9ad46@arm.com>
Date:   Fri, 6 May 2022 00:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv14 2/9] coresight: etm4x: Use asm-generic IO memory
 barriers
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>, arnd@arndb.de,
        catalin.marinas@arm.com, rostedt@goodmis.org
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <0d76de0ecc0aa7cb01fd8b8863a8e567abd4410b.1651663123.git.quic_saipraka@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <0d76de0ecc0aa7cb01fd8b8863a8e567abd4410b.1651663123.git.quic_saipraka@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/05/2022 12:28, Sai Prakash Ranjan wrote:
> Per discussion in [1], it was decided to move to using architecture
> independent/asm-generic IO memory barriers to have just one set of
> them and deprecate use of arm64 specific IO memory barriers in driver
> code. So replace current usage of __io_rmb()/__iowmb() in drivers to
> __io_ar()/__io_bw().
> 
> [1] https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/
> 

Looking at the dis-assembly it looks like in effect they are slightly
different for arm64.

i.e., before this patch we had

"dmb osh{ld/st}"

and after the patch we have :

"dsb {ld/st}"

Is this really what we want ? I don't think this is desirable.

Suzuki


> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
>   drivers/hwtracing/coresight/coresight-etm4x.h      | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7f416a12000e..81c0faf45b28 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -98,7 +98,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>   	}
>   
>   	if (!_relaxed)
> -		__iormb(res);	/* Imitate the !relaxed I/O helpers */
> +		__io_ar(res);	/* Imitate the !relaxed I/O helpers */
>   
>   	return res;
>   }
> @@ -106,7 +106,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>   void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>   {
>   	if (!_relaxed)
> -		__iowmb();	/* Imitate the !relaxed I/O helpers */
> +		__io_bw();	/* Imitate the !relaxed I/O helpers */
>   	if (!_64bit)
>   		val &= GENMASK(31, 0);
>   
> @@ -130,7 +130,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>   	}
>   
>   	if (!_relaxed)
> -		__iormb(res);	/* Imitate the !relaxed I/O helpers */
> +		__io_ar(res);	/* Imitate the !relaxed I/O helpers */
>   
>   	return res;
>   }
> @@ -138,7 +138,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>   static void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>   {
>   	if (!_relaxed)
> -		__iowmb();	/* Imitate the !relaxed I/O helpers */
> +		__io_bw();	/* Imitate the !relaxed I/O helpers */
>   	if (!_64bit)
>   		val &= GENMASK(31, 0);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3c4d69b096ca..f54698731582 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -448,14 +448,14 @@
>   #define etm4x_read32(csa, offset)					\
>   	({								\
>   		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
> -		__iormb(__val);						\
> +		__io_ar(__val);						\
>   		__val;							\
>   	 })
>   
>   #define etm4x_read64(csa, offset)					\
>   	({								\
>   		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
> -		__iormb(__val);						\
> +		__io_ar(__val);						\
>   		__val;							\
>   	 })
>   
> @@ -479,13 +479,13 @@
>   
>   #define etm4x_write32(csa, val, offset)					\
>   	do {								\
> -		__iowmb();						\
> +		__io_bw();						\
>   		etm4x_relaxed_write32((csa), (val), (offset));		\
>   	} while (0)
>   
>   #define etm4x_write64(csa, val, offset)					\
>   	do {								\
> -		__iowmb();						\
> +		__io_bw();						\
>   		etm4x_relaxed_write64((csa), (val), (offset));		\
>   	} while (0)
>   

