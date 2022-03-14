Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E14D898A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiCNQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiCNQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:41:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CEA46B3C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:39:56 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KHMfR4d2zz67KQK;
        Tue, 15 Mar 2022 00:38:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 14 Mar 2022 17:39:54 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 16:39:53 +0000
Date:   Mon, 14 Mar 2022 16:39:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] docs: ABI: Add sysfs documentation interface of
 hardware prefetch control driver
Message-ID: <20220314163951.00002500@Huawei.com>
In-Reply-To: <20220311101940.3403607-9-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
        <20220311101940.3403607-9-tarumizu.kohei@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 19:19:40 +0900
Kohei Tarumizu <tarumizu.kohei@fujitsu.com> wrote:

> This describes the sysfs interface implemented on the hardware prefetch
> control driver.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
H
i,

I'm going to review this with only a fairly basic knowledge of prefetchers
and with no particular design in mind (though I'll point at ARM docs
because they are generally good and easy to find ;) Key thing on an ABI like this
is to maintain flexibility for other implementations.

It makes me a bit nervous to see an interface for something like this
being defined with only a couple of implementations.  There are others
with public documentation such as the ARM N2.

https://developer.arm.com/documentation/102099/0000/The-Neoverse-N2--core

As is clear from below, not a lot of this is shared between CPUs so far
so it might make more sense to document them separately?

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 61f5676a7429..c1f6aa1322da 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -681,3 +681,92 @@ Description:
>  		(RO) the list of CPUs that are isolated and don't
>  		participate in load balancing. These CPUs are set by
>  		boot parameter "isolcpus=".
> +
> +What:		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/hardware_prefetcher_enable
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/ip_prefetcher_enable
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/adjacent_cache_line_prefetcher_enable
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_enable
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_strong
> +		/sys/devices/system/cpu/cpu*/cache/index[0,2]/prefetch_control/stream_detect_prefetcher_dist

I'd be tempted to have this as multiple blocks.  A lot of the documentation is not generic
to all of them and that approach tends to give documentation files that are easier to add
to later.

> +Date:		March 2022
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Parameters for CPU's hardware prefetch control
> +
> +		This sysfs interface provides Hardware Prefetch control
> +		attribute file by using implementation defined registers.

No need to say how this is implemented.  If someone wants to do it with a mailbox
for a particular CPU that would be fine at the ABI level.

> +		These files exists in every CPU's cache/index[0,2] directory,

Can see where they are from above.  No need to repeat that bit.

> +		and these affect the cache level of the parent index directory.
> +		Each attribute file exists depending on kind of processor and
> +		cache level.

Perhaps
"Attributes are only present if the particular cache implements the relevant
 prefetcher controls".  Or maybe just "All controls are optional".

> +
> +		*_prefetcher_enable:
> +		    (RW) control this prefetcher's enablement state.
> +		    Read returns current status:
> +			0: this prefetcher is disabled
> +			1: this prefetcher is enabled
> +
> +		stream_detect_prefetcher_strong:
> +		    (RW) control prefetcher operation's strongness state.
> +		    Strong prefetch operation is surely executed, if there is
> +		    no corresponding data in cache.
> +		    Weak prefetch operation allows the hardware not to execute
> +		    operation depending on hardware state.
> +
> +		    Read returns current status:
> +			0: prefetch operation is weak
> +			1: prefetch operation is strong

How likely is it that other prefetcher implementations will allow more
than two levels for this?  Can we define this ABI more broadly to allow
that?  Assuming such a scale might exist, this needs renaming to
stream_detect_pretcher_strength (as no longer on or off)

Easiest way to do that would probably be to use a separate
stream_detect_prefetcher_strength_available that lists
possible values (or min, step, max if that makes more sense).
Here,

0 1

With my very limited knowledge of the details, a multilevel approach
would map better to controls like RPF_MODE in the N2
IMP_CPUECTLR_EL1 register which has 4 levels for example (though
I have no input on whether those levels could map to 'strength'.

> +
> +		stream_detect_prefetcher_dist:
> +		    (RW) control the prefetcher distance value.
> +		    Read return current prefetcher distance value in bytes
> +		    or the string "auto".
> +
> +		    Write either a value in byte or the string "auto" to this
> +		    parameter. If you write a value less than multiples of a
> +		    specific value, it is rounded up.
> +
> +		    The value 0 and the string "auto" are the same and have
> +		    a special meaning. This means that instead of setting
> +		    dist to a user-specified value, it operates using
> +		    hardware-specific values.

Having two possible ways of representing 'auto' seems likely to cause
testing complexity for no particular benefit. I'd just not allow
one of them.

> +
> +		- Supported processors
> +
> +		    This sysfs interface is available on several processors, x86
> +		    and ARM64. Currently, the following processors are supported:

I would not list supported processors in here.  It will get out of sync if this
becomes popular and it should be easy to see if it is supported by whether the
sysfs attribute exists or not.

> +
> +			- x86 processor
> +			    - INTEL_FAM6_BROADWELL_X
> +
> +			- ARM64 processor
> +			    - FUJITSU_CPU_PART_A64FX
> +
> +		- Attribute mapping
> +
> +		    Some Intel processors have MSR 0x1a4. This register has several
> +		    specifications depending on the model. This interface provides
> +		    a one-to-one attribute file to control all the tunable
> +		    parameters the CPU provides of the following.
> +
> +			- "* Hardware Prefetcher Disable (R/W)"
> +			    corresponds to the "hardware_prefetcher_enable"
> +
> +			- "* Adjacent Cache Line Prefetcher Disable (R/W)"
> +			    corresponds to the "adjacent_cache_line_prefetcher_enable"
> +
> +			- "* IP Prefetcher Disable (R/W)"
> +			    corresponds to the "ip_prefetcher_enable"

I'm not sure on whether this should be here or not.  It seems like a path
to some very long documentation once 10+ processor families are supported.
However, there may be no better place to put this information.

Jonathan


> +
> +		    The processor A64FX has register IMP_PF_STREAM_DETECT_CTRL_EL0
> +		    for Hardware Prefetch Control. This attribute maps each
> +		    specification to the following.
> +
> +			- "L*PF_DIS": enablement of hardware prefetcher
> +			    corresponds to the "stream_detect_prefetcher_enable"
> +
> +			- "L*W": strongness of hardware prefetcher
> +			    corresponds to the "stream_detect_prefetcher_strong"
> +
> +			- "L*_DIST": distance of hardware prefetcher
> +			    corresponds to the "stream_detect_prefetcher_dist"

