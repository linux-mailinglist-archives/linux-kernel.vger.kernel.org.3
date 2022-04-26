Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25344510A71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbiDZUby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354755AbiDZUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:31:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FAD2644F4;
        Tue, 26 Apr 2022 13:28:41 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 810B892009C; Tue, 26 Apr 2022 22:28:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7B0E992009B;
        Tue, 26 Apr 2022 21:28:39 +0100 (BST)
Date:   Tue, 26 Apr 2022 21:28:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
In-Reply-To: <20220423212623.1957011-10-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk>
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-10-Jason@zx2c4.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022, Jason A. Donenfeld wrote:

> diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> index b05bb70a2e46..8cfa485d19e6 100644
> --- a/arch/mips/include/asm/timex.h
> +++ b/arch/mips/include/asm/timex.h
[...]
> +	if (cpu_has_3kex)
> +		c0_random = (read_c0_random() >> 8) & 0x3f;

 Hmm, I wonder whether we do need to mask the contents of the register out 
here given that known implementations return zeros in reserved bits.  Even 
though R3000 documentation I have access to makes no guarantee as to the 
values of the reserved bits here I think we can safely proceed according 
to what systems we do actually support do (even though it only saves one 
instruction).

>  	else
> -		return 0;	/* no usable register */
> +		c0_random = read_c0_random() & 0x3f;

 Here the architecture guarantees unused bits to be zero, but the number 
of them varies between implementations.  However we'll only ever use this 
leg for the R4000/R4400 processors, which have 48 TLB entries, and for the 
Ingenic XBurst cores, which I have now verified in documentation (which 
user-reported dumps from /proc/cpuinfo are consistent with) that have 32 
TLB entries.  So I think this mask operation can go as well.

 I guess these updates can be made with a follow-up change though.

  Maciej
