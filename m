Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E248C303
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbiALLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:19:25 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55358 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352823AbiALLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:19:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1f1q5U_1641986356;
Received: from 30.225.24.55(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V1f1q5U_1641986356)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 19:19:17 +0800
Message-ID: <5c820350-3dd0-5bb5-66a4-6bedb119525f@linux.alibaba.com>
Date:   Wed, 12 Jan 2022 19:19:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] fs/ocfs2: remove redundant ret variable
Content-Language: en-US
To:     cgel.zte@gmail.com, mark@fasheh.com
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220112081408.667411-1-chi.minghao@zte.com.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220112081408.667411-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is obviously not right as you remove the extent tree initialization.

Thanks,
Joseph

On 1/12/22 4:14 PM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ocfs2_add_clusters_in_btree() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  fs/ocfs2/file.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index fc5f780fa235..9a46dcef448c 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -540,15 +540,11 @@ int ocfs2_add_inode_data(struct ocfs2_super *osb,
>  			 struct ocfs2_alloc_context *meta_ac,
>  			 enum ocfs2_alloc_restarted *reason_ret)
>  {
> -	int ret;
>  	struct ocfs2_extent_tree et;
>  
> -	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), fe_bh);
> -	ret = ocfs2_add_clusters_in_btree(handle, &et, logical_offset,
> +	return ocfs2_add_clusters_in_btree(handle, &et, logical_offset,
>  					  clusters_to_add, mark_unwritten,
>  					  data_ac, meta_ac, reason_ret);
> -
> -	return ret;
>  }
>  
>  static int ocfs2_extend_allocation(struct inode *inode, u32 logical_start,
