Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346135535D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbiFUPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352670AbiFUPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:21:55 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 788A9252BE;
        Tue, 21 Jun 2022 08:21:54 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-00; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 14293C0170; Tue, 21 Jun 2022 17:14:11 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:14:11 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Genjian Zhang <zhanggenjian123@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, f.fainelli@gmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, huhai <huhai@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>,
        Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: Re: [PATCH v4] MIPS: Remove repetitive increase irq_err_count
Message-ID: <20220621151410.GA12206@alpha.franken.de>
References: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
 <20220610111420.1520410-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610111420.1520410-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 07:14:20PM +0800, Genjian Zhang wrote:
> From: huhai <huhai@kylinos.cn>
> 
> commit 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx") added
> a function irq_dispatch, and it'll increase irq_err_count when the get_irq
> callback returns a negative value, but increase irq_err_count in get_irq
> was not removed.
> 
> And also, modpost complains once gpio-vr41xx drivers become modules.
>   ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!
> 
> So it would be a good idea to remove repetitive increase irq_err_count in
> get_irq callback.
> 
> Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
> Fixes: 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: huhai <huhai@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/mips/vr41xx/common/icu.c | 2 --
>  drivers/gpio/gpio-vr41xx.c    | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
> index 7b7f25b4b057..9240bcdbe74e 100644
> --- a/arch/mips/vr41xx/common/icu.c
> +++ b/arch/mips/vr41xx/common/icu.c
> @@ -640,8 +640,6 @@ static int icu_get_irq(unsigned int irq)
>  
>  	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
>  
> -	atomic_inc(&irq_err_count);
> -
>  	return -1;
>  }
>  
> diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
> index 98cd715ccc33..8d09b619c166 100644
> --- a/drivers/gpio/gpio-vr41xx.c
> +++ b/drivers/gpio/gpio-vr41xx.c
> @@ -217,8 +217,6 @@ static int giu_get_irq(unsigned int irq)
>  	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
>  	       maskl, pendl, maskh, pendh);
>  
> -	atomic_inc(&irq_err_count);
> -
>  	return -EINVAL;
>  }
>  
> -- 
> 2.25.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
