Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0E562F70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiGAJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiGAJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:03:32 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FD2C109
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:03:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VI0CmfV_1656666208;
Received: from 30.225.24.48(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VI0CmfV_1656666208)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 17:03:29 +0800
Message-ID: <d5cc413d-d32a-5612-fe7a-95b61892c363@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 17:03:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [Linux-cachefs] [PATCH] fscache: Fix if condition in
 fscache_wait_on_volume_collision()
Content-Language: en-US
To:     Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com
Cc:     zhangwen@coolpad.com, linux-kernel@vger.kernel.org,
        zbestahu@gmail.com
References: <20220525023212.32642-1-huyue2@coolpad.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220525023212.32642-1-huyue2@coolpad.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 10:32 AM, Yue Hu wrote:
> After waiting for the volume to complete the acquisition with timeout,
> the if condition under which potential volume collision occurs should be
> acquire the volume is still pending rather than not pending so that we
> will continue to wait until the pending flag is cleared. Also, use the
> existing test pending wrapper directly instead of test_bit().
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
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

Yeah, I also noticed that before.



> @@ -182,7 +182,7 @@ static bool fscache_hash_volume(struct fscache_volume *candidate)
>  	hlist_bl_add_head(&candidate->hash_link, h);
>  	hlist_bl_unlock(h);
>  
> -	if (test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags))
> +	if (fscache_is_acquire_pending(candidate))
>  		fscache_wait_on_volume_collision(candidate, collidee_debug_id);
>  	return true;
>  

LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
