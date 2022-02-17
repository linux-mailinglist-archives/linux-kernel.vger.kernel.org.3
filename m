Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05B4BA922
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiBQTBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:01:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiBQTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:01:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E6255BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=O1RmJQ4+/rNFA1R+TyKH53CJVcOd/47slAnlWECEgOc=; b=LWidQFgc11v+5dzkaXqGMicPMo
        QMP+d79iNwJe1OoEeTPZneWLCtEQtXAqcxqsPFHHYnA3ZcFp6WDCGdtS6D686kWBuoOXc9P04XI1P
        fqkSRQ2LzXpyk0uKtPe+ggP5clDP4ZHxN/L77Ty8olGe0hCUYpfPX1wO2pljUy1AFssgdW8V6E4M6
        2tdXrYondaSR8bU8upPaQL1seLHVojaj7slsEg8S97YoDCPBhYyRqobLHLxWSVAaF7nad/2HREYnl
        KjSeFbDxwzmm/+Ai5hHo9a40SSueNbnhU4KQMKB9xa3BALgEO2aXV/CHfP7nDWQB8wm08IeYOgZIk
        SYgV5t+A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKm23-00Fs5Z-R9; Thu, 17 Feb 2022 19:01:36 +0000
Message-ID: <e8dd8298-1a2c-c541-2e69-1e7278a0070e@infradead.org>
Date:   Thu, 17 Feb 2022 11:01:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nds32: add a Kconfig symbol for LOCKDEP_SUPPORT
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
References: <20210517031354.9646-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20210517031354.9646-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alan and KC.

On 5/16/21 20:13, Randy Dunlap wrote:
> Each architecture (arch/) should define its own LOCKDEP_SUPPORT
> Kconfig symbol (if it is needed). arch/nds32/ is the only one
> that does "select LOCKDEP_SUPPORT", which is basically a no-op
> since the symbol is not defined. (It might be nice for kconfig
> to warn about that.)
> 
> Add a "config LOCKDEP_SUPPORT" to arch/nds32/Kconfig to correct
> this issue.
> 
> Since the current Kconfig file selects LOCKDEP_SUPPORT unconditionally,
> use "def_bool y" to set/enable it always.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/nds32/Kconfig |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-next-20210514.orig/arch/nds32/Kconfig
> +++ linux-next-20210514/arch/nds32/Kconfig
> @@ -36,7 +36,6 @@ config NDS32
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_PERF_EVENTS
>  	select IRQ_DOMAIN
> -	select LOCKDEP_SUPPORT
>  	select MODULES_USE_ELF_RELA
>  	select OF
>  	select OF_EARLY_FLATTREE
> @@ -64,6 +63,9 @@ config GENERIC_LOCKBREAK
>  	def_bool y
>  	depends on PREEMPTION
>  
> +config LOCKDEP_SUPPORT
> +	def_bool y
> +
>  config TRACE_IRQFLAGS_SUPPORT
>  	def_bool y
>  

Anybody out there for Andes?

-- 
~Randy
