Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD04B534C97
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiEZJhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiEZJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:37:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69869E0D7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:37:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VERpMXU_1653557864;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VERpMXU_1653557864)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 17:37:46 +0800
Date:   Thu, 26 May 2022 17:37:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <huyue2@coolpad.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        zhangwen@coolpad.com, linux-kernel@vger.kernel.org,
        zbestahu@gmail.com
Subject: Re: [Linux-cachefs] [PATCH] fscache: Fix if condition in
 fscache_wait_on_volume_collision()
Message-ID: <Yo9KaEn4JyLpMeOS@B-P7TQMD6M-0146.local>
References: <20220525023212.32642-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525023212.32642-1-huyue2@coolpad.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 10:32:22AM +0800, Yue Hu wrote:
> After waiting for the volume to complete the acquisition with timeout,
> the if condition under which potential volume collision occurs should be
> acquire the volume is still pending rather than not pending so that we
> will continue to wait until the pending flag is cleared. Also, use the
> existing test pending wrapper directly instead of test_bit().
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---

Looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  fs/fscache/volume.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index 71d3a6d6d72c..f2009cc22002 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -143,7 +143,7 @@ static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
>  {
>  	wait_var_event_timeout(&candidate->flags,
>  			       !fscache_is_acquire_pending(candidate), 20 * HZ);
> -	if (!fscache_is_acquire_pending(candidate)) {
> +	if (fscache_is_acquire_pending(candidate)) {
>  		pr_notice("Potential volume collision new=%08x old=%08x",
>  			  candidate->debug_id, collidee_debug_id);
>  		fscache_stat(&fscache_n_volumes_collision);
> @@ -182,7 +182,7 @@ static bool fscache_hash_volume(struct fscache_volume *candidate)
>  	hlist_bl_add_head(&candidate->hash_link, h);
>  	hlist_bl_unlock(h);
>  
> -	if (test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags))
> +	if (fscache_is_acquire_pending(candidate))
>  		fscache_wait_on_volume_collision(candidate, collidee_debug_id);
>  	return true;
>  
> -- 
> 2.17.1
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
