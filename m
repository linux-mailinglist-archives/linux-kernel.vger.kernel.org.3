Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63B493B55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354888AbiASNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:44:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31172 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiASNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:44:24 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jf6Hb6hngz8wNx;
        Wed, 19 Jan 2022 21:41:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 21:44:21 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 21:44:21 +0800
Message-ID: <93db576e-9a62-ee98-5af2-a62f8386212c@huawei.com>
Date:   Wed, 19 Jan 2022 21:44:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Let user to control huge vmalloc
 default behavior
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
        <x86@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul Mackerras" <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Will Deacon" <will@kernel.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-2-wangkefeng.wang@huawei.com>
 <1642473992.qrnqczjfna.astroid@bobo.none>
 <f0dd59eb-6eb8-5b60-508d-7f4022f655ec@huawei.com>
 <YegQfIQibQi993dp@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YegQfIQibQi993dp@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/1/19 21:22, Matthew Wilcox wrote:
> On Wed, Jan 19, 2022 at 08:57:58PM +0800, Kefeng Wang wrote:
>> Only parts of our products wants this feature,  we add some interfaces which
>> only
>>
>> alloc hugevmalloc for them, eg,
>> vmap_hugepage/vmalloc_hugepage/remap_vmalloc_hugepage_range..
>>
>> for our products, but it's not the choice of most products, also add
>> nohugevmalloc
>>
>> for most products is expensive, so this is the reason for adding the patch.
>>
>> more config/cmdline are more flexible for test/products，
> But why do only some products want it?  What goes wrong if all products
> enable it?  Features should be auto-tuning, not relying on admins to
> understand them.

Because this feature will use more memory for vmalloc/vmap, that's why 
we add some explicit
interfaces as said above in our kernel to control the user.

