Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC565535E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352754AbiFUPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352742AbiFUPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:22:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB2F2873E;
        Tue, 21 Jun 2022 08:22:04 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-01; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 567E8C01AA; Tue, 21 Jun 2022 17:14:38 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:14:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liang He <windhl@126.com>
Cc:     miodrag.dinic@mips.com, paulburton@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: mips: generic: Add missing of_node_put() in
 board-ranchu.c
Message-ID: <20220621151438.GB12206@alpha.franken.de>
References: <20220615141123.3968401-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615141123.3968401-1-windhl@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:11:23PM +0800, Liang He wrote:
> In ranchu_measure_hpt_freq(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_put_node()
> when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/mips/generic/board-ranchu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
> index a89aaad59cb1..930c45041882 100644
> --- a/arch/mips/generic/board-ranchu.c
> +++ b/arch/mips/generic/board-ranchu.c
> @@ -44,6 +44,7 @@ static __init unsigned int ranchu_measure_hpt_freq(void)
>  		      __func__);
>  
>  	rtc_base = of_iomap(np, 0);
> +	of_node_put(np);
>  	if (!rtc_base)
>  		panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
>  
> -- 
> 2.25.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
