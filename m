Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39370581D72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiG0CKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiG0CKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:10:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B073A633F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:10:13 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsxyZ2NvrzmVDK;
        Wed, 27 Jul 2022 10:08:22 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 10:09:51 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 10:09:51 +0800
Message-ID: <1774d0f6-9607-0111-c940-f0bd2b4f7c75@huawei.com>
Date:   Wed, 27 Jul 2022 10:09:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: memory-failure: convert to pr_fmt()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220726081046.10742-1-wangkefeng.wang@huawei.com>
 <20220727011203.GA3346517@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220727011203.GA3346517@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/27 9:12, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jul 26, 2022 at 04:10:46PM +0800, Kefeng Wang wrote:
>> Use pr_fmt to prefix pr_<level> output.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> There're other classes of prefixes like "Unpoison:" and "soft offline:" in
> mm/memory-failure.c.  So simply adding subsystem-wide pr_fmt() changes to
> print out two prefixes like below:
>
>    [ 1479.892348] Memory failure: soft offline: 0x1b8200: page migration failed 1, type 0x57ffffc00a000c(uptodate|dirty|mappedtodisk|swapbacked|node=1|zone=2|lastcpupid=0x1fffff)
>
>    [ 1486.871130] Memory failure: Unpoison: Software-unpoisoned page 0x14f00
>
> Do you intend this change?


Firstly I think they are all in memory failure, with this prefix is no 
bad impact,

soft_offline_page() and unpoison_memory()  are used by error injection,

but soft_offline_page() could be used in memory hotremove, so let's add

'#undef pr_fmt' before unpoison_pr_info definition, options? thanks.

>
> Thanks,
> Naoya Horiguchi
