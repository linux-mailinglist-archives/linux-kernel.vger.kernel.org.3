Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F97571029
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiGLC1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGLC04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:26:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8578E1EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:26:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lhl2y4VCbzlVtk;
        Tue, 12 Jul 2022 10:25:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 10:26:47 +0800
Subject: Re: [PATCH] mm/compaction: fix set skip in fast_find_migrateblock
To:     Zhou Chuyi <zhouchuyi@bytedance.com>, <linux-mm@kvack.org>
References: <20220711123213.66068-1-zhouchuyi@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8af11329-93d4-3bbd-fe4c-343663c00a1b@huawei.com>
Date:   Tue, 12 Jul 2022 10:26:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220711123213.66068-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cc Andrew and linux-kernel email list.

On 2022/7/11 20:32, Zhou Chuyi wrote:
> From: zhouchuyi <zhouchuyi@bytedance.com>
> 
> When we successfully find a pageblock in fast_find_migrateblock(), the block will be set skip-flag through set_pageblock_skip(). However, when entering isolate_migratepages_block(), the whole pageblock will be skipped due to the branch 'if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages))'. Eventually we will goto isolate_abort and isolate nothing.
> Signed-off-by: zhouchuyi <zhouchuyi@bytedance.com>

It seems we should tweak the commit log to satisfy the checkpatch.pl first.

> ---
>  mm/compaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 1f89b969c..a1a2b50c8 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1852,7 +1852,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  					pfn = cc->zone->zone_start_pfn;
>  				cc->fast_search_fail = 0;
>  				found_block = true;
> -				set_pageblock_skip(freepage);

This looks like a real problem. Should we add a Fixes tag here? What's the runtime effect of it?

Thanks for your patch!

>  				break;
>  			}
>  		}
> 

