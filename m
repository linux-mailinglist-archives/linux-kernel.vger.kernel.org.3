Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E74F566A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356395AbiDFFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353968AbiDFEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 00:42:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC91B84CD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:41:31 -0700 (PDT)
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY5HK6msSz4wqT;
        Wed,  6 Apr 2022 08:39:09 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 08:41:28 +0800
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 08:41:27 +0800
Message-ID: <36ac1182-36d3-d6fa-6954-c7c6a2e1d968@huawei.com>
Date:   Wed, 6 Apr 2022 08:41:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of bound
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Nick Terrell <terrelln@fb.com>, Chengyang Fan <cy.fan@huawei.com>,
        "Yann Collet" <cyan@fb.com>,
        "fangwei1@huawei.com" <fangwei1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com" 
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        "wangli74@huawei.com" <wangli74@huawei.com>
References: <20211111085058.1940591-1-guoxuenan@huawei.com>
 <20211111105048.2006070-1-guoxuenan@huawei.com>
 <CCE83845-DC40-4E14-9105-6319C048FACB@fb.com>
 <YkfXSzePVEhlajCU@B-P7TQMD6M-0146.local>
 <20220404142123.7de8d3a291d6484e7fb4c8a0@linux-foundation.org>
 <YktxATidpH2A1QJu@B-P7TQMD6M-0146.local>
From:   Guo Xuenan <guoxuenan@huawei.com>
In-Reply-To: <YktxATidpH2A1QJu@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.238]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all，

在 2022/4/5 6:28, Gao Xiang Write:
> On Mon, Apr 04, 2022 at 02:21:23PM -0700, Andrew Morton wrote:
>> On Sat, 2 Apr 2022 12:55:39 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>> On Fri, Nov 19, 2021 at 06:23:24PM +0000, Nick Terrell wrote:
>>>>
>>>>> On Nov 11, 2021, at 2:50 AM, Guo Xuenan <guoxuenan@huawei.com> wrote:
>>>>>
>>>>> When partialDecoding, it is EOF if we've either, filled the output
>>>>> buffer or can't proceed with reading an offset for following match.
>>>>>
>>>>> In some extreme corner cases when compressed data is crusted corrupted,
>>>>> UAF will occur. As reported by KASAN [1], LZ4_decompress_safe_partial
>>>>> may lead to read out of bound problem during decoding. lz4 upstream has
>>>>> fixed it [2] and this issue has been disscussed here [3] before.
>>>>>
>>>>> current decompression routine was ported from lz4 v1.8.3, bumping lib/lz4
>>>>> to v1.9.+ is certainly a huge work to be done later, so, we'd better fix
>>>>> it first.
>>>>>
>>>>> [1] https://lore.kernel.org/all/000000000000830d1205cf7f0477@google.com/
>>>>> [2] https://github.com/lz4/lz4/commit/c5d6f8a8be3927c0bec91bcc58667a6cfad244ad#
>>>>> [3] https://lore.kernel.org/all/CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com/
>>>>>
>>>>> Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
>>>>> Cc: hsiangkao@linux.alibaba.com
>>>>> Cc: terrelln@fb.com
>>>>> Cc: cyan@fb.com
>>>>> Cc: cy.fan@huawei.com
>>>>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>>>> Sorry I’m a bit late to the party, but this looks good to me!
>>>>
>>>> Reviewed-by: Nick Terrell <terrelln@fb.com>
>>> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> Hi Andrew,
>>>
>>> This patch has already been pending for 2 release cycles.. Would you
>>> mind submitting it upstream? Or are there other concerns about this?
>> Sorry, I'd not noticed that this was from lz4 upstream.
>>
>> I'll put a cc:stable in there and shall send it upstream this week.
>>
>> In the changelog, can someone please explain what "crusted corrupted"
>> is saying?
Sorry for my missspelling, Gao Xiang is right, i mean "well-designed 
corrupted".
> Er.. It sounds like "well-designed corrupted". I think it was a typo
> though.
>
> Thanks,
> Gao Xiang
> .
Thanks,
Guo Xuenan
.
