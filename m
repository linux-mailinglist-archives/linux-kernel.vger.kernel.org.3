Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2459E7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbiHWQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiHWQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:43:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF512421C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:12:18 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBqJz46S7zXdjc;
        Tue, 23 Aug 2022 21:07:47 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:12:04 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:12:03 +0800
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <20220822141309.3b7382db0367b63b6cd72c14@linux-foundation.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <4687e93d-9245-300e-6193-d5428a76c9b8@huawei.com>
Date:   Tue, 23 Aug 2022 21:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220822141309.3b7382db0367b63b6cd72c14@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/23 5:13, Andrew Morton wrote:
> On Mon, 22 Aug 2022 14:12:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> Prevention of races against zone/node hotplug?
> I meant "cpu/node", of course.
> .
Thanks for your advice, but I didn't quite understand what you meant.
Do you mean that I should use cpus_read_lock() to protect cpu hotplug just like this?
+       cpus_read_lock();
        for_each_online_cpu(cpu)
                sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+       cpus_read_unlock();

I see there is some areas were not protected by the cpus_{read/write}_lock, so I was confused
as to whether I should add it.

I want to replace for_each_zone with for_each_populated_zone, what else should I do to protect
node hotplug.

Thanks.

