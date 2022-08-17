Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DE596B61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiHQIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHQIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:31:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79917D7B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:31:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M71R84n7czGpdx;
        Wed, 17 Aug 2022 16:29:56 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:31:28 +0800
To:     Andrew Morton <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [bug report] mm/hugetlb: various bugs with avoid_reserve case in
 alloc_huge_page()
Message-ID: <d449c6d1-314f-5b90-6d68-3773e2722d7f@huawei.com>
Date:   Wed, 17 Aug 2022 16:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
    When I investigate the mm/hugetlb.c code again, I found there are a few possible issues
with avoid_reserve case. (It's really hard to follow the relevant code for me.) Please take
a look at the below analysis:

1.avoid_reserve issue with h->resv_huge_pages in alloc_huge_page.
    Assume:
	h->free_huge_pages 60
	h->resv_huge_pages 30
	spool->rsv_hpages  30

    When avoid_reserve is true, after alloc_huge_page(), we will have:
	spool->rsv_hpages  29 /* hugepage_subpool_get_pages decreases it. */
	h->free_huge_pages 59
	h->resv_huge_pages 30 /* rsv_hpages is used, but *h->resv_huge_pages is not modified accordingly*. */

    If the hugetlb page is freed later, we will have:
	spool->rsv_hpages  30 /* hugepage_subpool_put_pages increases it. */
	h->free_huge_pages 60
	h->resv_huge_pages 31 /* *increased wrongly* due to hugepage_subpool_put_pages(spool, 1) == 0. */
			   ^^

2.avoid_reserve issue with hugetlb rsvd cgroup charge for private mappings in alloc_huge_page.

    In general, if hugetlb pages are reserved, corresponding rsvd counters are charged in resv_maps
for private mappings. Otherwise they're charged in individual hugetlb pages. When alloc_huge_page()
is called with avoid_reserve == true, hugetlb_cgroup_charge_cgroup_rsvd() will be called to charge
the newly allocated hugetlb page even if there has a reservation for this page in resv_maps. Then
vma_commit_reservation() is called to indicate that the reservation is consumed. So the reservation
*can not be used, thus leaking* from now on because vma_needs_reservation always return 1 for it.

3.avoid_reserve issue with restore_reserve_on_error

    There's a assumption in restore_reserve_on_error(): If HPageRestoreReserve is not set, this indicates
there is an entry in the reserve map added by alloc_huge_page or HPageRestoreReserve would be set on the
page. But this assumption *does not hold for avoid_reserve*. HPageRestoreReserve won't be set even if there
is already an entry in the reserve map for avoid_reserve case. So avoid_reserve should be considered in this
function, i.e. we need *a reliable way* to determine whether the entry is added by the alloc_huge_page().

Are above issues possible? Or am I miss something? These possible issues seem not easy to fix for me.
Any thoughts? Any response would be appreciated!

Thanks!
Miaohe Lin
