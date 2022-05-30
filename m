Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C553790A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiE3KOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiE3KO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:14:26 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9473790
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:14:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VEnJoDi_1653905659;
Received: from 30.47.200.245(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEnJoDi_1653905659)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 May 2022 18:14:20 +0800
Message-ID: <c9d0f1b9-dbc7-ddf2-18f9-2b1a991d4932@linux.alibaba.com>
Date:   Mon, 30 May 2022 18:14:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] hugetlb: do not update address in
 huge_pmd_unshare
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-3-mike.kravetz@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220527225849.284839-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2022 6:58 AM, Mike Kravetz wrote:
> As an optimization for loops sequentially processing hugetlb address
> ranges, huge_pmd_unshare would update a passed address if it unshared a
> pmd.  Updating a loop control variable outside the loop like this is
> generally a bad idea.  These loops are now using hugetlb_mask_last_hp
> to optimize scanning when non-present ptes are discovered.  The same
> can be done when huge_pmd_unshare returns 1 indicating a pmd was
> unshared.
> 
> Remove address update from huge_pmd_unshare.  Change the passed argument
> type and update all callers.  In loops sequentially processing addresses
> use hugetlb_mask_last_hp to update address if pmd is unshared.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM. Please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
