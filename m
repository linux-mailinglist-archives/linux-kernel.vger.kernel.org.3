Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF050649A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348888AbiDSGi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348884AbiDSGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:38:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10422714B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:35:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjDZY35rWzhY01;
        Tue, 19 Apr 2022 14:35:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 14:35:39 +0800
Subject: Re: [PATCH] mm/madvise: fix potential pte_unmap_unlock pte error
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <minchan@kernel.org>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220416081416.23304-1-linmiaohe@huawei.com>
 <20220418210951.b87743ae8b7c01f883e571ea@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <14389d75-bcc9-285a-f141-4de16fd34fac@huawei.com>
Date:   Tue, 19 Apr 2022 14:35:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220418210951.b87743ae8b7c01f883e571ea@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 12:09, Andrew Morton wrote:
> On Sat, 16 Apr 2022 16:14:16 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> We can't assume pte_offset_map_lock will return same orig_pte value. So
>> it's necessary to reacquire the orig_pte or pte_unmap_unlock will unmap
>> the stale pte.
> 
> hm, where did you learn this info about pte_offset_map_lock()?
> 
> I assume this is from code inspection only?  No observed runtime failures?

Yes, this is from code inspection. There is no observed runtime failures now due
to the race window being really small. And this becomes noop in !CONFIG_HIGHMEM
system (CONFIG_HIGHMEM system should be rare now). But this could be triggered theoretically.

Thanks!

> .
> 
