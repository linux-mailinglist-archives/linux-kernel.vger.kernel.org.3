Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E74BC7B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiBSK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBSK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:27:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F348E47
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 02:27:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DB013420CF;
        Sat, 19 Feb 2022 10:27:22 +0000 (UTC)
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220201192924.672675-1-longman@redhat.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12
 warning
Message-ID: <b1a924e2-c23b-f09d-9122-fdff360cacff@marcan.st>
Date:   Sat, 19 Feb 2022 19:27:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220201192924.672675-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2022 04.29, Waiman Long wrote:
> The gcc 12 compiler reports a warning on the following code:
> 
>     static inline struct mem_section *__nr_to_section(unsigned long nr)
>     {
>     #ifdef CONFIG_SPARSEMEM_EXTREME
>         if (!mem_section)
>                 return NULL;
>     #endif
>        :
> 
> With CONFIG_SPARSEMEM_EXTREME on, the mem_section definition is
> 
>     extern struct mem_section **mem_section;
> 
> Obviously, mem_section cannot be NULL, but *mem_section can be if memory
> hasn't been allocated for the dynamic mem_section[] array yet. Fix this
> warning by checking for "!*mem_section" instead.
> 
> Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mmzone.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..bd1b19925f3b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1390,7 +1390,7 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>  static inline struct mem_section *__nr_to_section(unsigned long nr)
>  {
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!mem_section)
> +	if (!*mem_section)
>  		return NULL;
>  #endif
>  	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> 

This broke booting on Apple T6000 (M1 Pro; support not yet mainlined)
and it is obviously incorrect. !*mem_section is the same thing as
!mem_section[0], which is always checking element 0 for NULL instead of
the element we're interested in. These machines don't have memory at 0,
fail the spurious check, and crash on early boot.

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x612f0240]
[    0.000000] Linux version
5.17.0-rc4-asahi-next-20220217-00141-g3eb6fdba1573 (marcan@raider)
(aarch64-linux-gnu-gcc (Gentoo 11.2.0 p1) 11.2.0, GNU ld (Gentoo 2.36.1
p1) 2.36.1) #1112 SMP PREEMPT Sat Feb 19 18:01:31 JST 2022
[    0.000000] random: fast init done
[    0.000000] Machine model: Apple MacBook Pro (14-inch, M1 Pro, 2021)
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: s5l0 at MMIO32 0x000000039b200000 (options '')
[    0.000000] printk: bootconsole [s5l0] enabled
[    0.000000] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
<snip>
[    0.000000] pc : sparse_init+0x150/0x268
<snip>

Please revert fff3b2a167db5 and edecc06b4d34e.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
