Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470B4DBD86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiCQDYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiCQDYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:24:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCD2AE11;
        Wed, 16 Mar 2022 20:23:18 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJsrD1Ng7zfYqm;
        Thu, 17 Mar 2022 11:21:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 11:23:15 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 11:23:14 +0800
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <YjKfLo4YgSBG8v61@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d5f61c51-9f5a-b39c-6e15-1a5e56701516@huawei.com>
Date:   Thu, 17 Mar 2022 11:23:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YjKfLo4YgSBG8v61@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/17 10:38, Baoquan He wrote:
> On 02/27/22 at 11:07am, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>               ~~ change it to "get boot failure" or "fail to boot"

OK. I'm going to use "fail to boot".

>> for allocation.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> .
> 

-- 
Regards,
  Zhen Lei
