Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68844566847
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiGEKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 641DB1572F;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-05; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E19BCC0230; Tue,  5 Jul 2022 12:35:49 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:35:49 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
        git@birger-koblitz.de, sander@svanheule.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Message-ID: <20220705103549.GI9951@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702190705.5319-1-olek2@wp.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 09:07:05PM +0200, Aleksander Jan Bajkowski wrote:
> This patch is needed to handle interrupts by the second VPE on
> the Lantiq xRX200, xRX300 and xRX330 SoCs. In these chips, 32 ICU
> interrupts are connected to each hardware line. The SoC supports
> a total of 160 interrupts. Currently changing smp_affinity to the
> second VPE hangs interrupts.
> 
> This problem affects multithreaded SoCs with a custom interrupt
> controller. Chips with 1004Kc core and newer use the MIPS GIC.
> 
> Also CC'ed Birger Koblitz and Sander Vanheule. Both are working
> on support for Realtek RTL930x chips with 34Kc core and Birger
> has added a patch in OpenWRT that also enables all interrupt
> lines. So it looks like this patch is useful for more SoCs.
> 
> Tested on lantiq xRX200 and xRX330.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/mips/kernel/smp-mt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index 5f04a0141068..f21cd0eb1fa7 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -113,8 +113,7 @@ static void vsmp_init_secondary(void)
>  					 STATUSF_IP4 | STATUSF_IP5 |
>  					 STATUSF_IP6 | STATUSF_IP7);
>  	else
> -		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
> -					 STATUSF_IP6 | STATUSF_IP7);
> +		set_c0_status(ST0_IM);
>  }

just blindly enabling all interrupts doesn't sound like a brilliant
idea even when if works on some Lantiq platforms (probably because
their interrupt controller prevents issuing unwanted interrupts).
But not all smp-mt platforms are Lantiq. If some CPU interrupts
need to be enabled a clean interrupt controller setup with hierarchy
irq domains is IMHO the correct approach,

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
