Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8274E1BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiCTNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiCTNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:41:35 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C327E438F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 06:40:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7esMTL_1647783607;
Received: from 30.47.241.208(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V7esMTL_1647783607)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Mar 2022 21:40:08 +0800
Message-ID: <ae21bbb1-9794-77e5-bd02-fad77096fa1d@linux.alibaba.com>
Date:   Sun, 20 Mar 2022 21:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ocfs2: refactor the noqueue_attempted
Content-Language: en-US
To:     Yi Li <yili@winhong.com>, linux-kernel@vger.kernel.org
Cc:     yilikernel@gmail.com, jlbec@evilplan.org, mark@fasheh.com,
        ocfs2-devel@oss.oracle.com
References: <20220319061028.3152-1-yili@winhong.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220319061028.3152-1-yili@winhong.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't see any optimization after this change.

On 3/19/22 2:10 PM, Yi Li wrote:
> The variable noqueue_attempted just set when DLM_LKF_NOQUEUE.
> refactor the code.
> 
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  fs/ocfs2/dlmglue.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 801e60bab955..6315757c164d 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -1547,12 +1547,11 @@ static int __ocfs2_cluster_lock(struct ocfs2_super *osb,
>  	}
>  
>  	if (level > lockres->l_level) {
> -		if (noqueue_attempted > 0) {
> +		if (noqueue_attempted) {
>  			ret = -EAGAIN;
>  			goto unlock;
>  		}
> -		if (lkm_flags & DLM_LKF_NOQUEUE)
> -			noqueue_attempted = 1;
> +		noqueue_attempted = lkm_flags & DLM_LKF_NOQUEUE;
>  
>  		if (lockres->l_action != OCFS2_AST_INVALID)
>  			mlog(ML_ERROR, "lockres %s has action %u pending\n",
