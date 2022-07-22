Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0A57E19D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiGVMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGVMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:49:35 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168997D79
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:49:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VK557-E_1658494167;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VK557-E_1658494167)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 20:49:28 +0800
Subject: Re: [PATCH 4/5] riscv: Add modules to virtual kernel memory layout
 dump
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
 <20220717101323.370245-5-xianting.tian@linux.alibaba.com>
 <87wnc5xxsj.fsf@igel.home>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <cef36a7e-f652-3c65-2627-5147291b83ea@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 20:49:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87wnc5xxsj.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/22 下午6:10, Andreas Schwab 写道:
> On Jul 17 2022, Xianting Tian wrote:
>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index d466ec670e1f..2c4a64e97aec 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -135,6 +135,10 @@ static void __init print_vm_layout(void)
>>   		(unsigned long)VMEMMAP_END);
>>   	print_ml("vmalloc", (unsigned long)VMALLOC_START,
>>   		(unsigned long)VMALLOC_END);
>> +#ifdef CONFIG_64BIT
>> +	print_ml("modules", (unsigned long)MODULES_VADDR,
>> +		(unsigned long)MODULES_END);
> #ifdef MODULES_VADDR ?
Maybe CONFIG_64BIT is better, it shows more infos(64bit defined, 32bit 
not). If use MODULES_VADD, people may doubt which conditions 
MODULES_VADD is not defined?
>
