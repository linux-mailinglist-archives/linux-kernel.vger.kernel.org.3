Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16A55D112
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiF0LLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiF0LLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:11:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1764F2;
        Mon, 27 Jun 2022 04:11:36 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWlQR6B2gz9srK;
        Mon, 27 Jun 2022 19:10:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 19:11:34 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 19:11:33 +0800
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
To:     Baoquan He <bhe@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        liushixin <liushixin2@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com> <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv> <YrRzvO5F0dumsbAU@arm.com>
 <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
 <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
 <YrmDo7Sx1jNQ4WFd@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5996a53a-70eb-bb30-c8a6-b0c2c8ebb0f9@huawei.com>
Date:   Mon, 27 Jun 2022 19:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YrmDo7Sx1jNQ4WFd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 18:17, Baoquan He wrote:
> On 06/27/22 at 05:17pm, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/6/27 10:52, Baoquan He wrote:
>>> On 06/23/22 at 03:07pm, Catalin Marinas wrote:
>>>> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
>>>>> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
>>>>>> The problem with splitting is that you can end up with two entries in
>>>>>> the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
>>>>>> for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
>>>>>> abort (but can be worse like loss of coherency).
>>>>>
>>>>> Thanks for this explanation. Is this a drawback of arm64 design? X86
>>>>> code do the same thing w/o issue, is there way to overcome this on
>>>>> arm64 from hardware or software side?
>>>>
>>>> It is a drawback of the arm64 implementations. Having multiple TLB
>>>> entries for the same VA would need additional logic in hardware to
>>>> detect, so the microarchitects have pushed back. In ARMv8.4, some
>>>> balanced was reached with FEAT_BBM so that the only visible side-effect
>>>> is a potential TLB conflict abort that could be resolved by software.
>>>
>>> I see, thx.
>>>
>>>>
>>>>> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
>>>>> have different bootup time. And the more often TLB miss and flush will
>>>>> cause performance cost. It is really a pity if we have very powerful
>>>>> arm64 cpu and system capacity, but bottlenecked by this drawback.
>>>>
>>>> Is it only the boot time affected or the runtime performance as well?
>>>
>>> Sorry for late reply. What I observerd is the boot time serious latecy
>>> with huge memory. Since the timestamp is not available at that time,
>>> we can't tell the number. I didn't notice the runtime performance.
>>
>> There's some data here, and I see you're not on the cc list.
>>
>> https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/
> 
> Thanks, Zhen Lei. I also saw the patch. That seems to be a good way,

Yes.

> since there's only one process running at that time. Not sure if there's
> still risk of multiple TLB entries for the same VA existing.
> 
> .
> 

-- 
Regards,
  Zhen Lei
