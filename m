Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187395B28DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIHV6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIHV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:57:33 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92F9113B552;
        Thu,  8 Sep 2022 14:56:18 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oWPVQ-0007qL-00; Thu, 08 Sep 2022 23:56:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A3CE5C0EC6; Thu,  8 Sep 2022 23:32:29 +0200 (CEST)
Date:   Thu, 8 Sep 2022 23:32:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Select SPARSEMEM_EXTREME for CAVIUM_OCTEON_SOC
Message-ID: <20220908213229.GA6322@alpha.franken.de>
References: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
 <20220906095943.60296-2-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906095943.60296-2-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:59:42AM +0200, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Commit c46173183657 ("MIPS: Add NUMA support for Loongson-3") has increased
> .bss size of the Octeon kernel from 16k to 16M. Providing the conditions
> for SPARSEMEM_EXTREME avoids the waste of memory.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ec21f89..79cfa1c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2669,7 +2669,7 @@ config ARCH_FLATMEM_ENABLE
>  
>  config ARCH_SPARSEMEM_ENABLE
>  	bool
> -	select SPARSEMEM_STATIC if !SGI_IP27
> +	select SPARSEMEM_STATIC if MACH_LOONGSON64

removing the statement completely gives

      text       data        bss      total filename
  11874896    6019382   17304160   35198438 vmlinux-sparsemem_static
  11935172    6019702     526944   18481818 vmlinux

for a loogsoon64 kernel. And the kernel boots and works just fine.
Can you respin your patch and remove the select SPARSEMEM_STATIC ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
