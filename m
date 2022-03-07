Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AA04CF02F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiCGD26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiCGD25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:28:57 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C8B0D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:28:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6P0CTe_1646623680;
Received: from 30.97.48.243(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6P0CTe_1646623680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 11:28:00 +0800
Message-ID: <44ba7c68-d2a5-5bc1-b8e1-1a9dc6619369@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 11:27:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] kfence: Alloc kfence_pool after system startup
Content-Language: en-US
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220305144858.17040-1-dtcccc@linux.alibaba.com>
 <20220305144858.17040-3-dtcccc@linux.alibaba.com>
 <CANpmjNM+47dfjLyyuQwUWZyJgsr1Uxd72VPe9Vva3Qr2oiXRHA@mail.gmail.com>
 <fab45904-585b-0c59-a426-9ebecbd9d26f@linux.alibaba.com>
In-Reply-To: <fab45904-585b-0c59-a426-9ebecbd9d26f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 10:23, Tianchen Ding wrote:
> On 2022/3/7 07:52, Marco Elver wrote:
>> On Sat, 5 Mar 2022 at 15:49, Tianchen Ding <dtcccc@linux.alibaba.com> 
>> wrote:
>> [...]
>>> +static int kfence_init_late(void)
>>> +{
>>> +       const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
>>> +       struct page *pages;
>>> +
>>> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, 
>>> first_online_node, NULL);
>>
>>> mm/kfence/core.c:836:17: error: implicit declaration of function 
>>> ‘alloc_contig_pages’ [-Werror=implicit-function-declaration]
>>
>> This doesn't build without CMA. See ifdef CONFIG_CONTIG_ALLOC in
>> gfp.h, which declares alloc_contig_pages.
>>
>> Will alloc_pages() work as you expect? If so, perhaps only use
>> alloc_contig_pages() #ifdef CONFIG_CONTIG_ALLOC.
>>
> 
> alloc_pages() will be fine. We could free "tail" pages after inited.
> Will send v3 soon.
> 

Oh, I remember why we use alloc_contig_pages()...
alloc_pages() (or alloc_pages_exact()) only support pages less than 
MAX_ORDER (default 11). The alloc would fail when KFENCE_NUM_OBJECTS >= 512.

So the design would be:
ifndef CONFIG_CONTIG_ALLOC and KFENCE_NUM_OBJECTS exceeds MAX_ORDER, we 
do not support alloc KFENCE pool after system startup.

>> Thanks,
>> -- Marco
> 

