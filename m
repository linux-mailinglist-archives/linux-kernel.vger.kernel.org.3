Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BB4CEF95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiCGCYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCGCYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:24:49 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1D5A09D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:23:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6O3uDQ_1646619831;
Received: from 30.97.48.243(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6O3uDQ_1646619831)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 10:23:52 +0800
Message-ID: <fab45904-585b-0c59-a426-9ebecbd9d26f@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 10:23:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] kfence: Alloc kfence_pool after system startup
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220305144858.17040-1-dtcccc@linux.alibaba.com>
 <20220305144858.17040-3-dtcccc@linux.alibaba.com>
 <CANpmjNM+47dfjLyyuQwUWZyJgsr1Uxd72VPe9Vva3Qr2oiXRHA@mail.gmail.com>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <CANpmjNM+47dfjLyyuQwUWZyJgsr1Uxd72VPe9Vva3Qr2oiXRHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 07:52, Marco Elver wrote:
> On Sat, 5 Mar 2022 at 15:49, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
> [...]
>> +static int kfence_init_late(void)
>> +{
>> +       const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
>> +       struct page *pages;
>> +
>> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
> 
>> mm/kfence/core.c:836:17: error: implicit declaration of function ‘alloc_contig_pages’ [-Werror=implicit-function-declaration]
> 
> This doesn't build without CMA. See ifdef CONFIG_CONTIG_ALLOC in
> gfp.h, which declares alloc_contig_pages.
> 
> Will alloc_pages() work as you expect? If so, perhaps only use
> alloc_contig_pages() #ifdef CONFIG_CONTIG_ALLOC.
> 

alloc_pages() will be fine. We could free "tail" pages after inited.
Will send v3 soon.

> Thanks,
> -- Marco

