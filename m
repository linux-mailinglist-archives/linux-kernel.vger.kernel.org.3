Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405494BF400
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiBVIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBVIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:48:13 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 288D4A2F3C;
        Tue, 22 Feb 2022 00:47:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMQpn-0001CP-00; Tue, 22 Feb 2022 09:47:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 54F15C25FC; Tue, 22 Feb 2022 09:43:31 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:43:31 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: setup: fix setnocoherentio() boolean setting
Message-ID: <20220222084331.GA7049@alpha.franken.de>
References: <20220221175029.6046-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221175029.6046-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:50:29AM -0800, Randy Dunlap wrote:
> Correct a typo/pasto: setnocoherentio() should set
> dma_default_coherent to false, not true.
> 
> Fixes: 14ac09a65e19 ("MIPS: refactor the runtime coherent vs noncoherent DMA indicators")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20220217.orig/arch/mips/kernel/setup.c
> +++ linux-next-20220217/arch/mips/kernel/setup.c
> @@ -803,7 +803,7 @@ early_param("coherentio", setcoherentio)
>  
>  static int __init setnocoherentio(char *str)
>  {
> -	dma_default_coherent = true;
> +	dma_default_coherent = false;
>  	pr_info("Software DMA cache coherency (command line)\n");
>  	return 0;
>  }

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
