Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C64D9772
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiCOJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiCOJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:19:00 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953A4E382
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:17:44 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KHnqp35RQz9sSj;
        Tue, 15 Mar 2022 10:17:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P8dfPOyh5Gos; Tue, 15 Mar 2022 10:17:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KHnqn2LFkz9sSp;
        Tue, 15 Mar 2022 10:17:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CDBB8B770;
        Tue, 15 Mar 2022 10:17:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id O-TSzOUhyEx1; Tue, 15 Mar 2022 10:17:41 +0100 (CET)
Received: from [192.168.202.50] (unknown [192.168.202.50])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC9488B763;
        Tue, 15 Mar 2022 10:17:40 +0100 (CET)
Message-ID: <bfdaba1e-333e-669b-e5c0-8a3e891ade35@csgroup.eu>
Date:   Tue, 15 Mar 2022 10:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] powerpc/xive: Fix unsigned comparison with less than zero
Content-Language: fr-FR
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        mpe@ellerman.id.au,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1620382851-67480-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <1620382851-67480-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/05/2021 à 12:20, Jiapeng Chong a écrit :
> The return from the call to irq_domain_alloc_irqs() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irq', this may lead to invalid if statement detection,
> so that kfree execution is invalid. So making 'irq' an int.
> 
> Clean up the following coccicheck warning:
> 
> ./arch/powerpc/sysdev/xive/common.c:1157:6-14: WARNING: Unsigned
> expression compared with zero: xid -> irq < 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This was fixed by 
https://github.com/linuxppc/linux/commit/3f601608b71c3ca1e199898cd16f09d707fedb56

> ---
>   arch/powerpc/sysdev/xive/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index a830432..a5fd45a 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -65,7 +65,7 @@
>   #ifdef CONFIG_SMP
>   /* The IPIs use the same logical irq number when on the same chip */
>   static struct xive_ipi_desc {
> -	unsigned int irq;
> +	int irq;
>   	char name[16];
>   } *xive_ipis;
>   
