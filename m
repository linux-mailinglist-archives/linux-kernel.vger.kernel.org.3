Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17324CA1DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiCBKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiCBKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:11:09 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470F26AEA;
        Wed,  2 Mar 2022 02:10:27 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nPLw7-000VIa-Og; Wed, 02 Mar 2022 11:10:23 +0100
Received: from p57bd9552.dip0.t-ipconnect.de ([87.189.149.82] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nPLw7-0043nS-IM; Wed, 02 Mar 2022 11:10:23 +0100
Message-ID: <36f05f50-ff5e-71fb-3afb-475c3ac5a376@physik.fu-berlin.de>
Date:   Wed, 2 Mar 2022 11:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.82
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/11/22 21:15, Sergey Shtylyov wrote:
> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
> that code to start the IRQ #s from 16 instead.
> 
> [1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> The patch is against Linus Torvalds' 'linux.git' repo.
> 
>  arch/sh/kernel/cpu/sh3/entry.S |    4 ++--
>  include/linux/sh_intc.h        |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux/arch/sh/kernel/cpu/sh3/entry.S
> ===================================================================
> --- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
> +++ linux/arch/sh/kernel/cpu/sh3/entry.S
> @@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
>  	mov	r4, r0		! save vector->jmp table offset for later
>  
>  	shlr2	r4		! vector to IRQ# conversion
> -	add	#-0x10, r4
>  
> -	cmp/pz	r4		! is it a valid IRQ?
> +	mov	#0x10, r5
> +	cmp/ge	r5, r4		! is it a valid IRQ?
>  	bt	10f
>  
>  	/*
> Index: linux/include/linux/sh_intc.h
> ===================================================================
> --- linux.orig/include/linux/sh_intc.h
> +++ linux/include/linux/sh_intc.h
> @@ -13,9 +13,9 @@
>  /*
>   * Convert back and forth between INTEVT and IRQ values.
>   */
> -#ifdef CONFIG_CPU_HAS_INTEVT
> -#define evt2irq(evt)		(((evt) >> 5) - 16)
> -#define irq2evt(irq)		(((irq) + 16) << 5)
> +#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
> +#define evt2irq(evt)		((evt) >> 5)
> +#define irq2evt(irq)		((irq) << 5)
>  #else
>  #define evt2irq(evt)		(evt)
>  #define irq2evt(irq)		(irq)

Successfully boot-tested without any issues on my SH-7785LCR on top of fb184c4af9b9.

Tested-By: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

