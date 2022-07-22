Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04C57DFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGVKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiGVKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:19:09 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 03:19:06 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3987B1C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:19:06 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Lq4vg2j6Kz1r0nJ;
        Fri, 22 Jul 2022 12:10:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Lq4vf4FwVz1qqkp;
        Fri, 22 Jul 2022 12:10:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rbkTNUbe7Ccr; Fri, 22 Jul 2022 12:10:53 +0200 (CEST)
X-Auth-Info: 5V4d3Fnr8BDMPb3jkQu0EDJRSLyYFrjOv2Xdf5FYdjjFzWdHQsnOnSqJzPDYV4V9
Received: from igel.home (ppp-46-244-169-212.dynamic.mnet-online.de [46.244.169.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 22 Jul 2022 12:10:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 6F9AD2C3A72; Fri, 22 Jul 2022 12:10:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org
Subject: Re: [PATCH 4/5] riscv: Add modules to virtual kernel memory layout
 dump
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
        <20220717101323.370245-5-xianting.tian@linux.alibaba.com>
X-Yow:  You must be a CUB SCOUT!!  Have you made your MONEY-DROP today??
Date:   Fri, 22 Jul 2022 12:10:52 +0200
In-Reply-To: <20220717101323.370245-5-xianting.tian@linux.alibaba.com>
        (Xianting Tian's message of "Sun, 17 Jul 2022 18:13:22 +0800")
Message-ID: <87wnc5xxsj.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 17 2022, Xianting Tian wrote:

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index d466ec670e1f..2c4a64e97aec 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -135,6 +135,10 @@ static void __init print_vm_layout(void)
>  		(unsigned long)VMEMMAP_END);
>  	print_ml("vmalloc", (unsigned long)VMALLOC_START,
>  		(unsigned long)VMALLOC_END);
> +#ifdef CONFIG_64BIT
> +	print_ml("modules", (unsigned long)MODULES_VADDR,
> +		(unsigned long)MODULES_END);

#ifdef MODULES_VADDR ?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
