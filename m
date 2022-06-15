Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A654C811
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiFOMDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jun 2022 08:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFOMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:03:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96985220DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:03:20 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNP681LNDzgZMd;
        Wed, 15 Jun 2022 20:01:20 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 20:03:18 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Wed, 15 Jun 2022 20:03:18 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] arm64/smp: check !ipi_desc[i] in arch_show_interrupts
Thread-Topic: [PATCH] arm64/smp: check !ipi_desc[i] in arch_show_interrupts
Thread-Index: AQHYcaRPXakPnzyBa0Cd74QU1zTpKQ==
Date:   Wed, 15 Jun 2022 12:03:17 +0000
Message-ID: <188b4432206b464d93776d80c23081bb@huawei.com>
References: <20220527082236.78037-1-chenjun102@huawei.com>
 <20220609152003.GC3289@willie-the-truck>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/9 23:20, Will Deacon 写道:
> On Fri, May 27, 2022 at 08:22:36AM +0000, Chen Jun wrote:
>> There is a potential dereferencing null pointer issue in
>> arch_show_interrupts.
>>
>> Problem 1:
>> int arch_show_interrupts(struct seq_file *p, int prec)
>>          for (i = 0; i < NR_IPI; i++) {
>>                  seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i],
>> 			cpu));
>>
>> Only ipi_desc[0..nr_ipi - 1] are initialized in set_smp_ipi_range.
>> and ipi_desc[nr_ipi..NR_IPI] are NULL.
>> irq_desc_kstat_cpu will dereference NULL pointer.
>> For now, the problem can not be triggered, because NR_IPI is always
>> equal to nr_ipi.
>>
>> Problem 2:
>> If request_percpu_irq failed in set_smp_ipi_range, ipi_desc[i]
>> would be NULL.
>> irq_desc_kstat_cpu will dereference NULL pointer.
>>
>> check !ipi_desc[i] (as arm does) to avoid the problem.
>>
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>   arch/arm64/kernel/smp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 62ed361a4376..3d54f464428b 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -781,6 +781,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>>   	unsigned int cpu, i;
>>   
>>   	for (i = 0; i < NR_IPI; i++) {
>> +		if (!ipi_desc[i])
>> +			continue;
> 
> Why not just use nr_ipi instead of NR_IPI?

Yee, that is what I do at first. But I noticed that:

void __init set_smp_ipi_range(int ipi_base, int n)
     for (i = 0; i < nr_ipi; i++) {
         err = request_percpu_irq(ipi_base + i, ipi_handler,
                                  "IPI", &cpu_number);
         WARN_ON(err);
         ipi_desc[i] = irq_to_desc(ipi_base + i);

If request_percpu_irq return a error, I not sure if ipi_desc[i] makes sense.

> 
> Will
> 

-- 
Regards
Chen Jun
