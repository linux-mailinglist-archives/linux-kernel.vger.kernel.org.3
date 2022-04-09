Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B64FA68E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiDIJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDIJkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:40:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831A280690
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:38:10 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kb90z0K2yzBs5K;
        Sat,  9 Apr 2022 17:33:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 17:38:08 +0800
Subject: Re: [PATCH v2 0/9] A few cleanup and fixup patches for vmscan
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220409093408.5338-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <713e469c-770c-0867-0dc2-cc7e8ba05c05@huawei.com>
Date:   Sat, 9 Apr 2022 17:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220409093408.5338-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 17:33, Miaohe Lin wrote:
> Hi everyone,
> This series contains a few patches to remove obsolete comment, introduce
> helper to remove duplicated code and so no. Also we take all base pages
> of THP into account in rare race condition. More details can be found in
> the respective changelogs. Thanks!

Very Sorry about it! There is some invalid address in my cc list. So I failed
to send them together twice. Sorry for making noise. :(

> 
> ---
> v2:
>   patch 1/9: drop code change and add a comment about MADV_FREE
>   patch 2/9: simplify the code further and change to goto keep_locked
>   patch 3/9: use folio, remove unneeded inline and break craze long lines
>   patch 5/9: activate swap-backed executable folios after first usage too
>   patch 9/9: new cleanup patch splitted from 5/9
>   Many thanks Huang Ying, Matthew Wilcox, Christoph Hellwig, Muchun Song
>   for review!
> ---
> Miaohe Lin (9):
>   mm/vmscan: add a comment about MADV_FREE pages check in
>     folio_check_dirty_writeback
>   mm/vmscan: remove unneeded can_split_huge_page check
>   mm/vmscan: introduce helper function reclaim_page_list()
>   mm/vmscan: save a bit of stack space in shrink_lruvec
>   mm/vmscan: activate swap-backed executable folios after first usage
>   mm/vmscan: take all base pages of THP into account when race with
>     speculative reference
>   mm/vmscan: take min_slab_pages into account when try to call
>     shrink_node
>   mm/vmscan: remove obsolete comment in kswapd_run
>   mm/vmscan: use helper folio_is_file_lru()
> 
>  mm/vmscan.c | 92 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 45 insertions(+), 47 deletions(-)
> 

