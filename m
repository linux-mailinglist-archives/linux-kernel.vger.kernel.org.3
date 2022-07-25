Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EC57FBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGYJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiGYJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:07:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A50410555
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:07:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrvH66qcgzGpVV;
        Mon, 25 Jul 2022 17:04:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 17:07:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [bug report] mm/hugetlb: possible data leak with huge pmd sharing
To:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>
Message-ID: <025b3ea6-4b26-f091-5464-0eef5aac7719@huawei.com>
Date:   Mon, 25 Jul 2022 17:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
    When I investigate the mm/hugetlb code, I found there's a possible data leak issue
with huge pmd sharing. Thank about the below scene:

    1. Process A and process B shares huge pmd page.(vm_flags: VM_MAYSHARE but !VM_SHARED)
    2. Process A write fault a hugetlb page. As vm_flags is !VM_SHARED, a private copy of
hugetlb page will be installed in the pagetable via hugetlb_wp.
    3. Process A writes private data into hugetlb page.
    4. Process B can read process A's private data since hugetlb page is shared through huge
pmd sharing...

I think the above scene is possible. If so, huge pmd sharing for !VM_SHARED should be disabled
to fix this issue? Or am I miss something about hugetlb huge pmd sharing?

Any response would be appreciated.

Thanks! :)
