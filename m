Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E9522C43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbiEKGZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbiEKGZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:25:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EC65D06
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:25:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KylCN14N4zCsYT;
        Wed, 11 May 2022 14:20:48 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 14:25:34 +0800
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>,
        <akpm@linux-foundation.org>
CC:     <mgorman@techsingularity.net>, <vvghjk1234@gmail.com>,
        <aquini@redhat.com>, <ddutile@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2c2900eb-886a-5bbe-f7c7-9d74a6399893@huawei.com>
Date:   Wed, 11 May 2022 14:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/11 12:43, Rei Yamamoto wrote:
> Prevent returning a pfn outside the target zone in case that not
> aligned with pageblock boundary.
> Otherwise isolate_migratepages_block() would handle pages not in
> the target zone.
> 

IIUC, the sole caller isolate_migratepages will ensure the pfn won't outside
the target zone. So the below code change might not be necessary. Or am I miss
something ?

Thanks!

> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
> ---
>  mm/compaction.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fe915db6149b..de42b8e48758 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1858,6 +1858,8 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  
>  				update_fast_start_pfn(cc, free_pfn);
>  				pfn = pageblock_start_pfn(free_pfn);
> +				if (pfn < cc->zone->zone_start_pfn)
> +					pfn = cc->zone->zone_start_pfn;
>  				cc->fast_search_fail = 0;
>  				found_block = true;
>  				set_pageblock_skip(freepage);
> 

