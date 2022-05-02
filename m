Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE636516B78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359089AbiEBIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiEBIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:00:36 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5029CA9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:57:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VByJntr_1651478218;
Received: from 30.30.72.33(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VByJntr_1651478218)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 May 2022 15:57:00 +0800
Message-ID: <80586516-d783-8f81-f6d7-338d9af7a3e6@linux.alibaba.com>
Date:   Mon, 2 May 2022 15:56:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:100.0)
 Gecko/20100101 Thunderbird/100.0
Subject: Re: [PATCH 2/3] mm/damon/sysfs: support fixed virtual address ranges
 monitoring
Content-Language: en-US
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220426231750.48822-1-sj@kernel.org>
 <20220426231750.48822-3-sj@kernel.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20220426231750.48822-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, SeongJae

I had read and tested your patchset these days. It works.
It seems that these patches only fix the issue about init_regions in 
DAMON-sysfs, but not fix in DAMON-dbgfs? maybe I missing something.

If so, do you have any plan to fix this bug in dbgfs? Actually, what I 
want to say is that I ready a patch for solving the init_regions related 
bug in dbgfs these days. I not sure if you're interested in it.

Best Regards,
Rongwei

On 4/27/22 7:17 AM, sj@kernel.org wrote:
> From: SeongJae Park <sj@kernel.org>
> 
> This commit makes DAMON sysfs interface to support the fixed virtual
> address ranges monitoring.  After this commit, writing 'fvaddr' to the
> 'operations' DAMON sysfs file makes DAMON uses the monitoring operations
> set for fixed virtual address ranges, so that users can monitor accesses
> to only interested virtual address ranges.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/sysfs.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 719a286d378f..767ab8c33e4d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1694,7 +1694,7 @@ static struct kobj_type damon_sysfs_attrs_ktype = {
>   /* This should match with enum damon_ops_id */
>   static const char * const damon_sysfs_ops_strs[] = {
>   	"vaddr",
> -	"unsupported",	/* fvaddr is not supported by sysfs yet */
> +	"fvaddr",
>   	"paddr",
>   };
>   
> @@ -1844,9 +1844,6 @@ static ssize_t operations_store(struct kobject *kobj,
>   
>   	for (id = 0; id < NR_DAMON_OPS; id++) {
>   		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
> -			/* fvaddr is not supported by sysfs yet */
> -			if (id == DAMON_OPS_FVADDR)
> -				return -EINVAL;
>   			context->ops_id = id;
>   			return count;
>   		}
> @@ -2136,7 +2133,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
>   			damon_sysfs_destroy_targets(ctx);
>   			return -ENOMEM;
>   		}
> -		if (ctx->ops.id == DAMON_OPS_VADDR) {
> +		if (ctx->ops.id == DAMON_OPS_VADDR ||
> +				ctx->ops.id == DAMON_OPS_FVADDR) {
>   			t->pid = find_get_pid(sys_target->pid);
>   			if (!t->pid) {
>   				damon_sysfs_destroy_targets(ctx);
