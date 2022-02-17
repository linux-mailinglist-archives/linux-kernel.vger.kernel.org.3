Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2941E4BA220
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiBQN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiBQN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:58:18 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA3627B4BB;
        Thu, 17 Feb 2022 05:58:03 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8389B92009C; Thu, 17 Feb 2022 14:58:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7CCD092009B;
        Thu, 17 Feb 2022 13:58:01 +0000 (GMT)
Date:   Thu, 17 Feb 2022 13:58:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove asm/war.h
In-Reply-To: <20220217134630.42203-1-tsbogend@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2202171352060.56785@angie.orcam.me.uk>
References: <20220217134630.42203-1-tsbogend@alpha.franken.de>
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

On Thu, 17 Feb 2022, Thomas Bogendoerfer wrote:

> diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
> index 35729c9e6cfa..11392e40d034 100644
> --- a/arch/mips/kernel/r4k-bugs64.c
> +++ b/arch/mips/kernel/r4k-bugs64.c
> @@ -163,7 +163,8 @@ static __always_inline __init void check_mult_sh(void)
>  	}
>  
>  	pr_cont("no.\n");
> -	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
> +	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar :
> +								    nowar);

 I think it'll read better if formatted like this:

	panic(bug64hit,
	      !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar : nowar);

or without the negation even:

	panic(bug64hit,
	      IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? nowar : r4kwar);

Likewise throughout.

  Maciej
