Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE14581D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiG0BxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiG0BxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:53:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE927CCD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:53:08 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lsxbc1GDwz9sy2;
        Wed, 27 Jul 2022 09:51:56 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 09:53:06 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 09:53:05 +0800
Message-ID: <a89a98fd-568e-790f-229a-76566bce3637@huawei.com>
Date:   Wed, 27 Jul 2022 09:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
CC:     <mawupeng1@huawei.com>, <rppt@kernel.org>, <linux-mm@kvack.org>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memblock tests: compiling error
Content-Language: en-US
To:     <jrdr.linux@gmail.com>, <liuxp11@chinatelecom.cn>
References: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>
 <CAFqt6zabgY6DgCQBe0HCsMYScNEnKbm-0nH4ghhALZpF14rm4g@mail.gmail.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAFqt6zabgY6DgCQBe0HCsMYScNEnKbm-0nH4ghhALZpF14rm4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/27 9:01, Souptick Joarder wrote:
> On Tue, Jul 26, 2022 at 8:35 AM Liu Xinpeng <liuxp11@chinatelecom.cn> wrote:
>>
>> memblock.o: In function `memblock_find_in_range.constprop.9':
>> memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
>> memblock.o: In function `memblock_mark_mirror':
>> memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'
>>
> 
> what is the steps to hit this compile error ?

Do make -C tools/testing/memblock can hit this compile error.

> 
>> Fixs: 902c2d91582 ("memblock: Disable mirror feature if kernelcore is not
>> specified")

>> Fixs: 14d9a675fd0 ("mm: Ratelimited mirrored memory related warning")
>>
>> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
>> ---
>>  tools/testing/memblock/internal.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
>> index c2a492c..cf67e6e 100644
>> --- a/tools/testing/memblock/internal.h
>> +++ b/tools/testing/memblock/internal.h
>> @@ -9,6 +9,9 @@
>>  static int memblock_debug = 1;
>>  #endif
>>
>> +#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__);
>> +
>> +bool mirrored_kernelcore = false;
>>  struct page {};
>>
>>  void memblock_free_pages(struct page *page, unsigned long pfn,
>> --
>> 1.8.3.1
>>
>>
