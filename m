Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9804C8866
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiCAJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiCAJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:05 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F79360D83;
        Tue,  1 Mar 2022 01:44:18 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nOz3I-0003z9-01; Tue, 01 Mar 2022 10:44:16 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E43C2C28F0; Tue,  1 Mar 2022 10:10:56 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:10:56 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: mt7621: use bitwise NOT instead of logical
Message-ID: <20220301091056.GB6517@alpha.franken.de>
References: <20220301011507.15494-1-ilya.lipnitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301011507.15494-1-ilya.lipnitskiy@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 05:15:07PM -0800, Ilya Lipnitskiy wrote:
> It was the intention to reverse the bits, not make them all zero by
> using logical NOT operator.
> 
> Fixes: cc19db8b312a ("MIPS: ralink: mt7621: do memory detection on KSEG1")
> Suggested-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index 12c8808e0dea..fb0565bc34fd 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -69,7 +69,7 @@ static bool __init mt7621_addr_wraparound_test(phys_addr_t size)
>  	__raw_writel(MT7621_MEM_TEST_PATTERN, dm);
>  	if (__raw_readl(dm) != __raw_readl(dm + size))
>  		return false;
> -	__raw_writel(!MT7621_MEM_TEST_PATTERN, dm);
> +	__raw_writel(~MT7621_MEM_TEST_PATTERN, dm);
>  	return __raw_readl(dm) == __raw_readl(dm + size);
>  }
>  
> -- 
> 2.35.1

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
