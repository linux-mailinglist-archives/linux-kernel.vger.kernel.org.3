Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB424CD0D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiCDJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCDJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:08:38 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F2024B417;
        Fri,  4 Mar 2022 01:07:49 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0709A92009C; Fri,  4 Mar 2022 10:07:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F3FB992009B;
        Fri,  4 Mar 2022 09:07:48 +0000 (GMT)
Date:   Fri, 4 Mar 2022 09:07:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
In-Reply-To: <20220304011328.27459-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2203040857500.47558@angie.orcam.me.uk>
References: <20220304011328.27459-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, Randy Dunlap wrote:

> Include the DECstation interrupt handler in opting out of
> FPU support.
> 
> Fixes a linker error:
> 
> mips-linux-ld: arch/mips/dec/int-handler.o: in function `fpu':
> (.text+0x148): undefined reference to `handle_fpe_int'
> 
> Fixes: 183b40f992c8 ("MIPS: Allow FP support to be disabled")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: linux-mips@vger.kernel.org
> ---
> This builds OK. Is it enough for runtime interrupt handling?

 There's:

#ifdef CONFIG_32BIT
	lw	t2,cpu_fpu_mask
#endif

earlier on that needs to go too, and code in arch/mips/dec/setup.c below:

	/* Register board interrupts: FPU and cascade. */

(we don't want an unhandled interrupt unmasked).  Are you happy to do such 
an update or shall I?

 I cannot verify that change at run time, because any program that does FP 
will then crash.  Maybe init(8) and sulogin(8) won't.  I can check that.

 Thanks for doing this stuff!

  Maciej
