Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F544F6060
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiDFNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiDFNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:39:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730976984C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:40:46 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KYKmb0ZQpz1HBYK;
        Wed,  6 Apr 2022 18:01:51 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 18:02:17 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 18:02:16 +0800
Message-ID: <99acc7d2-a11b-250b-f614-18077fb76cc0@huawei.com>
Date:   Wed, 6 Apr 2022 18:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 1/7] x86: fix copy_mc_to_user compile error
To:     Borislav Petkov <bp@alien8.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-2-tongtiangen@huawei.com> <Yk1bu88TcjXw/iU4@zn.tnic>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yk1bu88TcjXw/iU4@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/6 17:22, Borislav Petkov 写道:
> On Wed, Apr 06, 2022 at 09:13:05AM +0000, Tong Tiangen wrote:
>> The follow patch
> 
> There's no concept of "follow patch" in git - you need to explain this
> differently.
> 
>> will add copy_mc_to_user to include/linux/uaccess.h, X86
>> must declare Implemented to avoid compile error.
> 
> I don't know what that means. Try again pls.
> 

This description is not good, will redescribe it in next version.

Here I describe the reasons for this:

Patch 3/7 in patchset[1] introduce copy_mc_to_user() in 
include/linux/uaccess.h and the prototype is:

     static inline unsigned long __must_check
     copy_mc_to_user(void *dst, const void *src, size_t cnt)

The prototype in x86 is:

     unsigned long __must_check
     copy_mc_to_user(void *to, const void *from, unsigned len);

This two are a little different, so I added the follow code to x86 to
avoid prototype conflict compile error.

     #define copy_mc_to_user copy_mc_to_user

In addition, I think this #define should be added here.

[1]https://patchwork.kernel.org/project/linux-mm/cover/20220406091311.3354723-1-tongtiangen@huawei.com/

Thanks.
Tong.
