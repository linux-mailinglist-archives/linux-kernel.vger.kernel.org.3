Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AB484C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiAECEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:04:25 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38785 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234434AbiAECEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:04:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1-Gl5B_1641348261;
Received: from 30.225.24.81(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V1-Gl5B_1641348261)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 10:04:22 +0800
Message-ID: <a96a59c2-101c-4576-b76b-d9923fca25af@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 10:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] fs/ocfs2: remove redundant ret variable
Content-Language: en-US
To:     cgel.zte@gmail.com, mark@fasheh.com
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220104112332.601834-1-chi.minghao@zte.com.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220104112332.601834-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/22 7:23 PM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from dlm_lock() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  fs/ocfs2/stack_user.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
> index 85a47621e0c0..3027a6a05668 100644
> --- a/fs/ocfs2/stack_user.c
> +++ b/fs/ocfs2/stack_user.c
> @@ -683,28 +683,23 @@ static int user_dlm_lock(struct ocfs2_cluster_connection *conn,
>  			 void *name,
>  			 unsigned int namelen)
>  {
> -	int ret;
> -
>  	if (!lksb->lksb_fsdlm.sb_lvbptr)
>  		lksb->lksb_fsdlm.sb_lvbptr = (char *)lksb +
>  					     sizeof(struct dlm_lksb);
>  
> -	ret = dlm_lock(conn->cc_lockspace, mode, &lksb->lksb_fsdlm,
> +	return dlm_lock(conn->cc_lockspace, mode, &lksb->lksb_fsdlm,
>  		       flags|DLM_LKF_NODLCKWT, name, namelen, 0,
>  		       fsdlm_lock_ast_wrapper, lksb,
>  		       fsdlm_blocking_ast_wrapper);

Better to align the parameters as well.

Thanks,
Joseph

> -	return ret;
>  }
>  
>  static int user_dlm_unlock(struct ocfs2_cluster_connection *conn,
>  			   struct ocfs2_dlm_lksb *lksb,
>  			   u32 flags)
>  {
> -	int ret;
>  
> -	ret = dlm_unlock(conn->cc_lockspace, lksb->lksb_fsdlm.sb_lkid,
> +	return dlm_unlock(conn->cc_lockspace, lksb->lksb_fsdlm.sb_lkid,
>  			 flags, &lksb->lksb_fsdlm, lksb);
> -	return ret;
>  }
>  
>  static int user_dlm_lock_status(struct ocfs2_dlm_lksb *lksb)
