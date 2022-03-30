Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A664ECCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350340AbiC3TCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbiC3TCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:02:12 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9649013E1D;
        Wed, 30 Mar 2022 12:00:26 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nZdYO-0003Qd-00; Wed, 30 Mar 2022 21:00:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9EA7DC2EE6; Wed, 30 Mar 2022 20:34:01 +0200 (CEST)
Date:   Wed, 30 Mar 2022 20:34:01 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     xkernel.wang@foxmail.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: sgi-ip22: add a check for the return of kzalloc()
Message-ID: <20220330183401.GA18042@alpha.franken.de>
References: <tencent_33384AA3FF65207ECC63B9531C1F1417E108@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_33384AA3FF65207ECC63B9531C1F1417E108@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 06:57:18PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  arch/mips/sgi-ip22/ip22-gio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
> index dfc52f6..38d12f4 100644
> --- a/arch/mips/sgi-ip22/ip22-gio.c
> +++ b/arch/mips/sgi-ip22/ip22-gio.c
> @@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
>  		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
>  		       slotno, name, id);
>  		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
> +		if (!gio_dev)
> +			return;
>  		gio_dev->name = name;
>  		gio_dev->slotno = slotno;
>  		gio_dev->id.id = id;
> -- 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
