Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5955140F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiD2DVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbiD2DVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:21:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BC55490
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:17:54 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqHcY2FL8zCs4Y;
        Fri, 29 Apr 2022 11:13:17 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 11:17:48 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 11:17:48 +0800
Message-ID: <3e4bdf67-bd11-e839-7852-36e91f54b4df@huawei.com>
Date:   Fri, 29 Apr 2022 11:17:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] ARM: module: Add all unwind tables when load module
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux@armlinux.org.uk>, <alexander.sverdlin@nokia.com>,
        <ardb@kernel.org>, <nico@fluxnic.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220401131534.241205-1-chenzhongjin@huawei.com>
 <CACRpkdbxDyasZxNeJXa9-AniTbgrzsuoLcu9CBJmzOLDg3hy5w@mail.gmail.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CACRpkdbxDyasZxNeJXa9-AniTbgrzsuoLcu9CBJmzOLDg3hy5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added,
9204/1 	module: Add all unwind tables when load module

Thanks!
Chen

On 2022/4/29 6:45, Linus Walleij wrote:
> On Fri, Apr 1, 2022 at 3:16 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> 
>> For EABI stack unwinding, when loading .ko module
>> the EXIDX sections will be added to a unwind_table list.
>>
>> However not all EXIDX sections are added because EXIDX
>> sections are searched by hardcoded section names.
>>
>> For functions in other sections such as .ref.text
>> or .kprobes.text, gcc generates seprated EXIDX sections
>> (such as .ARM.exidx.ref.text or .ARM.exidx.kprobes.text).
>>
>> These extra EXIDX sections are not loaded, so when unwinding
>> functions in these sections, we will failed with:
>>
>>         unwind: Index not found xxx
>>
>> To fix that, I refactor the code for searching and adding
>> EXIDX sections:
>>
>> - Check section type to search EXIDX tables (0x70000001)
>> instead of strcmp() the hardcoded names. Then find the
>> corresponding text sections by their section names.
>>
>> - Add a unwind_table list in module->arch to save their own
>> unwind_table instead of the fixed-lenth array.
>>
>> - Save .ARM.exidx.init.text section ptr, because it should
>> be cleaned after module init.
>>
>> Now all EXIDX sections of .ko can be added correctly.
>>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> 
> This looks reasonable to me:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If no one else comments I would say you should put this
> into Russell's patch tracker for consideration.
> 
> Yours,
> Linus Walleij
> .

