Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187F4DD3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiCRDmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiCRDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:42:38 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D38C2878BA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:41:19 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id DB49224938;
        Fri, 18 Mar 2022 03:41:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id EB7FB20015;
        Fri, 18 Mar 2022 03:41:09 +0000 (UTC)
Message-ID: <4b017a7c75d6422b3e68df1d0aef49adc31ae991.camel@perches.com>
Subject: Re: [PATCH v6 1/6] RISC-V: Correctly print supported extensions
From:   Joe Perches <joe@perches.com>
To:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Mar 2022 20:41:08 -0700
In-Reply-To: <20220314203845.832648-2-atishp@rivosinc.com>
References: <20220314203845.832648-1-atishp@rivosinc.com>
         <20220314203845.832648-2-atishp@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EB7FB20015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Stat-Signature: 9uui7t67w9hsd4frdre6zgmamcg8n3ho
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19pvWiJwU890RydAIIWBwsRim9FvyFTerA=
X-HE-Tag: 1647574869-14430
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-14 at 13:38 -0700, Atish Patra wrote:
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
> 
> This commit replaces BITS_PER_LONG with number of alphabet letters.
[]
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
[]
> @@ -133,13 +135,13 @@ void __init riscv_fill_hwcap(void)
>  	}
>  
>  	memset(print_str, 0, sizeof(print_str));
> -	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
> +	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>  		if (riscv_isa[0] & BIT_MASK(i))
>  			print_str[j++] = (char)('a' + i);

probably better to add braces for the for loops too

>  	pr_info("riscv: ISA extensions %s\n", print_str);
>  
>  	memset(print_str, 0, sizeof(print_str));
> -	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
> +	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>  		if (elf_hwcap & BIT_MASK(i))
>  			print_str[j++] = (char)('a' + i);
>  	pr_info("riscv: ELF capabilities %s\n", print_str);

and here.

