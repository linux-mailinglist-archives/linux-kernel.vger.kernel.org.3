Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34AD57005B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiGKL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiGKLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4F65593
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:58:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oAr7k-0007FM-FO; Mon, 11 Jul 2022 12:58:44 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oAr7g-0000h5-UL; Mon, 11 Jul 2022 12:58:40 +0200
Date:   Mon, 11 Jul 2022 12:58:40 +0200
From:   Sascha Hauer <sha@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ftrace: Be more specific about arch impact when function
 tracer is enabled
Message-ID: <20220711105840.GH29790@pengutronix.de>
References: <20220706161231.085a83da@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706161231.085a83da@gandalf.local.home>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:12:31PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> It was brought up that on ARMv7, that because the FUNCTION_TRACER does not
> use nops to keep function tracing disabled because of the use of a link
> register, it does have some performance impact.
> 
> The start of functions when -pg is used to compile the kernel is:
> 
> 	push    {lr}
> 	bl      8010e7c0 <__gnu_mcount_nc>
> 
> When function tracing is tuned off, it becomes:
> 
> 	push    {lr}
> 	add   sp, sp, #4
> 
> Which just puts the stack back to its normal location. But these two
> instructions at the start of every function does incur some overhead.
> 
> Be more honest in the Kconfig FUNCTION_TRACER description and specify that
> the overhead being in the noise was x86 specific, but other architectures
> may vary.
> 
> Link: https://lore.kernel.org/all/20220705105416.GE5208@pengutronix.de/
> 
> Reported-by: Sascha Hauer <sha@pengutronix.de>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Thanks Steven

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index debbbb083286..ccd6a5ade3e9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -194,7 +194,8 @@ config FUNCTION_TRACER
>  	  sequence is then dynamically patched into a tracer call when
>  	  tracing is enabled by the administrator. If it's runtime disabled
>  	  (the bootup default), then the overhead of the instructions is very
> -	  small and not measurable even in micro-benchmarks.
> +	  small and not measurable even in micro-benchmarks (at least on
> +	  x86, but may have impact on other architectures).
>  
>  config FUNCTION_GRAPH_TRACER
>  	bool "Kernel Function Graph Tracer"
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
