Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC3530DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiEWJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiEWJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:31:40 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91027DF8A;
        Mon, 23 May 2022 02:31:36 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Or-0001Pn-00; Mon, 23 May 2022 11:30:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 58DC0C02EA; Mon, 23 May 2022 11:16:07 +0200 (CEST)
Date:   Mon, 23 May 2022 11:16:07 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Genjian Zhang <zhanggenjian123@gmail.com>
Cc:     maz@kernel.org, keescook@chromium.org, mark.rutland@arm.com,
        nathan@kernel.org, siyanteng01@gmail.com, yyuasa@linux.com,
        ralf@linux-mips.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, huhai@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] irq: mips: Export irq_err_count to modules
Message-ID: <20220523091607.GA5069@alpha.franken.de>
References: <20220523081625.2074527-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523081625.2074527-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:16:25PM +0800, Genjian Zhang wrote:
> From: huhai <huhai@kylinos.cn>
> 
> modpost complains once these drivers become modules.
>   ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!
> 
> Fix it by export them when that symbol is =m.
> 
> Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  arch/mips/kernel/irq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index 5e11582fe308..b0038b715008 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -38,6 +38,9 @@ void ack_bad_irq(unsigned int irq)
>  }
>  
>  atomic_t irq_err_count;
> +#ifdef CONFIG_GPIO_VR41XX_MODULE
> +EXPORT_SYMBOL_GPL(irq_err_count);
> +#endif

please use spurious_interrupt() in drivers/gpio/gpio-vr41xx.c.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
