Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D24FEFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiDMGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDMGb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:31:27 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF05FBF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:29:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9yQb99_1649831343;
Received: from 30.47.203.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V9yQb99_1649831343)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 14:29:04 +0800
Message-ID: <6f80c1fa-9e2d-a205-08ba-d85f126d18ff@linux.alibaba.com>
Date:   Wed, 13 Apr 2022 14:29:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        songmuchun@bytedance.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-2-liupeng256@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220413032915.251254-2-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 11:29 AM, Peng Liu wrote:
> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
> 
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
> Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
