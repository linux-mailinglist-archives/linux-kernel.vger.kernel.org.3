Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8234E6CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358183AbiCYDRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCYDRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:17:02 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC2A1458
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:15:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V87tFIC_1648178124;
Received: from 30.225.24.51(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V87tFIC_1648178124)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 11:15:25 +0800
Message-ID: <9de48770-7dfa-1dd8-5eab-5fc0ac0499d5@linux.alibaba.com>
Date:   Fri, 25 Mar 2022 11:15:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ocfs2: replace usage of found with dedicated list
 iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220324071650.61168-1-jakobkoschel@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220324071650.61168-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/22 3:16 PM, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlm/dlmunlock.c | 21 ++++++++++-----------
>  fs/ocfs2/quota_local.c   | 10 +++++-----
>  2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
> index 61103b2d69fb..7318e4794ef9 100644
> --- a/fs/ocfs2/dlm/dlmunlock.c
> +++ b/fs/ocfs2/dlm/dlmunlock.c
> @@ -392,9 +392,9 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
>  	struct dlm_ctxt *dlm = data;
>  	struct dlm_unlock_lock *unlock = (struct dlm_unlock_lock *)msg->buf;
>  	struct dlm_lock_resource *res = NULL;
> -	struct dlm_lock *lock = NULL;
> +	struct dlm_lock *lock = NULL, *iter;
>  	enum dlm_status status = DLM_NORMAL;
> -	int found = 0, i;
> +	int i;
>  	struct dlm_lockstatus *lksb = NULL;
>  	int ignore;
>  	u32 flags;
> @@ -437,7 +437,6 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
>  	}
>  
>  	queue=&res->granted;
> -	found = 0;
>  	spin_lock(&res->spinlock);
>  	if (res->state & DLM_LOCK_RES_RECOVERING) {
>  		spin_unlock(&res->spinlock);
> @@ -461,21 +460,21 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
>  	}
>  
>  	for (i=0; i<3; i++) {
> -		list_for_each_entry(lock, queue, list) {
> -			if (lock->ml.cookie == unlock->cookie &&
> -		    	    lock->ml.node == unlock->node_idx) {
> -				dlm_lock_get(lock);
> -				found = 1;
> +		list_for_each_entry(iter, queue, list) {
> +			if (iter->ml.cookie == unlock->cookie &&
> +			    iter->ml.node == unlock->node_idx) {
> +				dlm_lock_get(iter);
> +				lock = iter;
>  				break;
>  			}
>  		}
> -		if (found)
> +		if (lock)
>  			break;
>  		/* scan granted -> converting -> blocked queues */
>  		queue++;
>  	}
>  	spin_unlock(&res->spinlock);
> -	if (!found) {
> +	if (!lock) {
>  		status = DLM_IVLOCKID;
>  		goto not_found;
>  	}
> @@ -505,7 +504,7 @@ int dlm_unlock_lock_handler(struct o2net_msg *msg, u32 len, void *data,
>  	dlm_kick_thread(dlm, res);
>  
>  not_found:
> -	if (!found)
> +	if (!lock)
>  		mlog(ML_ERROR, "failed to find lock to unlock! "
>  			       "cookie=%u:%llu\n",
>  		     dlm_get_lock_cookie_node(be64_to_cpu(unlock->cookie)),
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index 0e4b16d4c037..38cc75bd3127 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -923,19 +923,19 @@ static struct ocfs2_quota_chunk *ocfs2_find_free_entry(struct super_block *sb,
>  {
>  	struct mem_dqinfo *info = sb_dqinfo(sb, type);
>  	struct ocfs2_mem_dqinfo *oinfo = info->dqi_priv;
> -	struct ocfs2_quota_chunk *chunk;
> +	struct ocfs2_quota_chunk *chunk = NULL, *iter;
>  	struct ocfs2_local_disk_chunk *dchunk;
>  	int found = 0, len;
>  
> -	list_for_each_entry(chunk, &oinfo->dqi_chunk, qc_chunk) {
> +	list_for_each_entry(iter, &oinfo->dqi_chunk, qc_chunk) {
>  		dchunk = (struct ocfs2_local_disk_chunk *)
> -						chunk->qc_headerbh->b_data;
> +						iter->qc_headerbh->b_data;
>  		if (le32_to_cpu(dchunk->dqc_free) > 0) {
> -			found = 1;
> +			chunk = iter;
>  			break;
>  		}
>  	}
> -	if (!found)
> +	if (!chunk)
>  		return NULL;
>  
>  	if (chunk->qc_num < oinfo->dqi_chunks - 1) {
> 
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
