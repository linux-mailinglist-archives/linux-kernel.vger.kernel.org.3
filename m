Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35374CEFA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiCGCbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiCGCbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:31:31 -0500
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163465E169
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:30:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V6O9B5W_1646620230;
Received: from 30.97.48.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6O9B5W_1646620230)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 10:30:31 +0800
Message-ID: <f905cd0c-d5e6-5e9e-e2fe-0531bcbbf14a@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 10:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 08/16] mm/migration: avoid unneeded nodemask_t
 initialization
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ying.huang@intel.com, ziy@nvidia.com, minchan@kernel.org,
        apopple@nvidia.com, dave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-9-linmiaohe@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220304093409.25829-9-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2022 5:34 PM, Miaohe Lin wrote:
> Avoid unneeded next_pass and this_pass initialization as they're always
> set before using to save possible cpu cycles when there are plenty of
> nodes in the system.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c84eec19072a..abb0c6715e1f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2378,8 +2378,8 @@ static int establish_migrate_target(int node, nodemask_t *used,
>    */
>   static void __set_migration_target_nodes(void)
>   {
> -	nodemask_t next_pass	= NODE_MASK_NONE;
> -	nodemask_t this_pass	= NODE_MASK_NONE;
> +	nodemask_t next_pass;
> +	nodemask_t this_pass;
>   	nodemask_t used_targets = NODE_MASK_NONE;
>   	int node, best_distance;

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
