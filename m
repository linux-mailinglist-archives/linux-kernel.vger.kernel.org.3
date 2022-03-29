Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7C4EA96D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiC2Igx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiC2Igv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:36:51 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4823DE8F;
        Tue, 29 Mar 2022 01:35:05 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru BED922208DDD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1] MIPS: ip22-gio: Add check for the return value of
 kzalloc()
To:     QintaoShen <unSimple1993@163.com>, <tsbogend@alpha.franken.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <ralf@linux-mips.org>
References: <1648454654-27200-1-git-send-email-unSimple1993@163.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6dd8bcf0-20a1-0bab-b48e-ec1bac5c15f0@omp.ru>
Date:   Tue, 29 Mar 2022 11:35:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1648454654-27200-1-git-send-email-unSimple1993@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/28/22 11:04 AM, QintaoShen wrote:

> Since the memory allocation function kzalloc() may return a NULL pointer,
> the use of 'gio_dev' may lead to NULL pointer dereference.
> 
> So it is better to check the return value of kzalloc().
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
>  arch/mips/sgi-ip22/ip22-gio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
> index dfc52f6..df7ca21 100644
> --- a/arch/mips/sgi-ip22/ip22-gio.c
> +++ b/arch/mips/sgi-ip22/ip22-gio.c
> @@ -363,7 +363,11 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
>  		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
>  		       slotno, name, id);
>  		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
> -		gio_dev->name = name;
> +		
> +        if (!gio_dev)

   Indented too little. And indent with tabs please, not spaces.

> +            return ;

   No need for space before ';'.

[...]

MBR, Sergey
