Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178F528016
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbiEPIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiEPIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:50:22 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443712AF6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:50:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VDI4vKu_1652691014;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VDI4vKu_1652691014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 16:50:15 +0800
Subject: Re: [PATCH v2] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem
 instead of IORESOURCE_BUSY
To:     mick@ics.forth.gr, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        rppt@kernel.org, david@redhat.com, wangborong@cdjrlc.com,
        twd2.me@gmail.com, seanjc@google.com, alex@ghiti.fr,
        petr.pavlu@suse.com, atishp@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianghuaming.jhm@alibaba-inc.com, guoren@kernel.org,
        stable@kernel.org
References: <20220512060910.601832-1-xianting.tian@linux.alibaba.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <e32a2228-2e2f-0da2-87e8-e364c0450dcd@linux.alibaba.com>
Date:   Mon, 16 May 2022 16:50:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220512060910.601832-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Could I get any comments for the v2 patch, thanks

ÔÚ 2022/5/12 ÏÂÎç2:09, Xianting Tian Ð´µÀ:
> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> marked IORESOURCE_BUSY for reserved memory, which casued resource map
> failed in subsequent operations of related driver, so remove the
> IORESOURCE_BUSY flag. In order to prohibit userland mapping reserved
> memory, mark IORESOURCE_EXCLUSIVE for it.
>
> The code to reproduce the issue,
> dts:
>          mem0: memory@a0000000 {
>                  reg = <0x0 0xa0000000 0 0x1000000>;
>                  no-map;
>          };
>
>          &test {
>                  status = "okay";
>                  memory-region = <&mem0>;
>          };
>
> code:
>          np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>          ret = of_address_to_resource(np, 0, &r);
>          base = devm_ioremap_resource(&pdev->dev, &r);
>          // base = -EBUSY
>
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   arch/riscv/kernel/setup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..e0a00739bd13 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -189,7 +189,7 @@ static void __init init_resources(void)
>   		res = &mem_res[res_idx--];
>   
>   		res->name = "Reserved";
> -		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +		res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>   		res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>   		res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>   
> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>   
>   		if (unlikely(memblock_is_nomap(region))) {
>   			res->name = "Reserved";
> -			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +			res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>   		} else {
>   			res->name = "System RAM";
>   			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
