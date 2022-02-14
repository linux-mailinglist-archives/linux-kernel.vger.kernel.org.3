Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5C4B4BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiBNKVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:21:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbiBNKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:17:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F16187C79A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:54:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52E131396;
        Mon, 14 Feb 2022 01:54:05 -0800 (PST)
Received: from [10.163.47.15] (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1074B3F718;
        Mon, 14 Feb 2022 01:54:03 -0800 (PST)
Subject: Re: [PATCH v6] mm: Uninline copy_overflow()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
Date:   Mon, 14 Feb 2022 15:24:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/22 11:56 AM, Christophe Leroy wrote:
> While building a small config with CONFIG_CC_OPTIMISE_FOR_SIZE,
> I ended up with more than 50 times the following function in vmlinux
> because GCC doesn't honor the 'inline' keyword:
> 
> 	c00243bc <copy_overflow>:
> 	c00243bc:	94 21 ff f0 	stwu    r1,-16(r1)
> 	c00243c0:	7c 85 23 78 	mr      r5,r4
> 	c00243c4:	7c 64 1b 78 	mr      r4,r3
> 	c00243c8:	3c 60 c0 62 	lis     r3,-16286
> 	c00243cc:	7c 08 02 a6 	mflr    r0
> 	c00243d0:	38 63 5e e5 	addi    r3,r3,24293
> 	c00243d4:	90 01 00 14 	stw     r0,20(r1)
> 	c00243d8:	4b ff 82 45 	bl      c001c61c <__warn_printk>
> 	c00243dc:	0f e0 00 00 	twui    r0,0
> 	c00243e0:	80 01 00 14 	lwz     r0,20(r1)
> 	c00243e4:	38 21 00 10 	addi    r1,r1,16
> 	c00243e8:	7c 08 03 a6 	mtlr    r0
> 	c00243ec:	4e 80 00 20 	blr
> 
> With -Winline, GCC tells:
> 
> 	/include/linux/thread_info.h:212:20: warning: inlining failed in call to 'copy_overflow': call is unlikely and code size would grow [-Winline]
> 
> copy_overflow() is a non conditional warning called by
> check_copy_size() on an error path.
> 
> check_copy_size() have to remain inlined in order to benefit
> from constant folding, but copy_overflow() is not worth inlining.
> 
> Uninline the warning when CONFIG_BUG is selected.
> 
> When CONFIG_BUG is not selected, WARN() does nothing so skip it.
> 
> This reduces the size of vmlinux by almost 4kbytes.

Just wondering, is this the only such scenario which results in
an avoidable bloated vmlinux image ?

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v6: I should have gone sleeping yesterday night instead of sending v5 out. Sorry for the noise. Fix EXPORT_SYMBOL()
> 
> v5: Change to EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL()
> 
> v4: Make copy_overflow() a no-op when CONFIG_BUG is not selected
> 
> v3: Added missing ; after EXPORT_SYMBOL()
> 
> v2: Added missing EXPORT_SYMBOL() and enhanced commit message
> ---
>  include/linux/thread_info.h | 5 ++++-
>  mm/maccess.c                | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 73a6f34b3847..9f392ec76f2b 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -209,9 +209,12 @@ __bad_copy_from(void);
>  extern void __compiletime_error("copy destination size is too small")
>  __bad_copy_to(void);
>  
> +void __copy_overflow(int size, unsigned long count);
> +
>  static inline void copy_overflow(int size, unsigned long count)
>  {
> -	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
> +	if (IS_ENABLED(CONFIG_BUG))
> +		__copy_overflow(size, count);
>  }
>  
>  static __always_inline __must_check bool
> diff --git a/mm/maccess.c b/mm/maccess.c
> index d3f1a1f0b1c1..3fed2b876539 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -335,3 +335,9 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)
>  
>  	return ret;
>  }
> +
> +void __copy_overflow(int size, unsigned long count)
> +{
> +	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
> +}
> +EXPORT_SYMBOL(__copy_overflow);
> 
