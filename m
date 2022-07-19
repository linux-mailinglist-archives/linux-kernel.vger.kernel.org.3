Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD757A0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiGSOP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiGSOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73C4E854
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:44:18 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LnKk46619zjX4T;
        Tue, 19 Jul 2022 21:41:32 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (7.185.36.93) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 21:44:15 +0800
Received: from kwepemi500012.china.huawei.com (7.221.188.12) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 21:44:15 +0800
Received: from kwepemi500012.china.huawei.com ([7.221.188.12]) by
 kwepemi500012.china.huawei.com ([7.221.188.12]) with mapi id 15.01.2375.024;
 Tue, 19 Jul 2022 21:44:15 +0800
From:   "xuqiang (M)" <xuqiang36@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: [PATCH v2 -next 2/2] irqdomain: Replace revmap_direct_max_irq
 field with hwirq_max field
Thread-Topic: [PATCH v2 -next 2/2] irqdomain: Replace revmap_direct_max_irq
 field with hwirq_max field
Thread-Index: AQHYmzpBZhMLU8dgIUSvhshLWJNuNw==
Date:   Tue, 19 Jul 2022 13:44:15 +0000
Message-ID: <b06c6275446948ad9be2a0bb4c1a8ce4@huawei.com>
References: <20220719063641.56541-1-xuqiang36@huawei.com>
 <20220719063641.56541-3-xuqiang36@huawei.com> <87k089z9ho.wl-maz@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.28]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/7/19 18:24, Marc Zyngier 写道:
> On Tue, 19 Jul 2022 07:36:41 +0100,
> Xu Qiang <xuqiang36@huawei.com> wrote:
>> In commit "4f86a06e2d6e irqdomain: Make normal and nomap irqdomains exclusive",
>> use revmap_size field instead of revmap_direct_max_irq. revmap_size field
>> originally indicates the maximum hwirq of linear Mapping. This results in
>> revmap_size having two different layers of meaning that can be confusing.
>>
>> This patch optimization point is to solve this confusion point. During
>> direct mapping, the values of hwirq_max and revmap_direct_max_irq are the same
>> and have the same meanings. They both indicate the maximum hwirq supported by
>> direct Mapping. The optimization method is to delete revmap_direct_max_irq
>> field and use hwirq_max instead of revmap_direct_max_irq.
>>
>> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> You keep referencing revmap_direct_max_irq, which is long gone.
>
> How about instead:
>
> <commit>
> NOMAP irq domains use the revmap_size field to indicate the maximum
> hwirq number the domain accepts. This is a bit confusing as
> revmap_size is usually used to indicate the size of the revmap array,
> which a NOMAP domain doesn't have.
>
> Instead, use the hwirq_max field which has the correct semantics, and
> keep revmap_size to 0 for a NOMAP domain.
> </commit>
>
> If you agree with this, please say so (no need to respin for this).

Yes, I agree.

Thanks,

                Xu.

>
> Thanks,
>
> 	M.
>

