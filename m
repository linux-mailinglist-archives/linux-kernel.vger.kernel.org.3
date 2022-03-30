Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC54EBC34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbiC3H6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC3H6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:58:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068DB39
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648627010; x=1680163010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwwXpU5i2/ZnjurXHD4hkkWhEcts0d2cgS8JfDuixaQ=;
  b=U0YUIk6FFHTfJB2gaXhZheWV2lEeSOAWaSCBKsuv/ANGKWkEhn3Oj8CG
   jXYq7F8kZ6vMbt8MXW/Wo1WkMVOmb89qDN7sGs/4eTI6wCFME0Of9R4X0
   KT1g8HliScbovAMJrc3O711DIVgBXqX0vDahWxNnOrUk2kMJnKjr2yikX
   40R8GpBvzycCxIhMR79N1Bf7ZL22islgmhaTnI17dWaRC7C3vtvVrihrr
   hVawHdnoLz3wJoBvX/FFiIQLy+WaQErFc1XGwSlmsthqlZtX0weGPYsgn
   LICsuPzGsl+DhoW0yIIwmGiHHUvwAqWJgSWhnaZQjKqIZC7D2MZWnUJN/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322658819"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322658819"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 00:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="653692953"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.81.43])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 00:56:47 -0700
Date:   Wed, 30 Mar 2022 15:57:42 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        bjohannesmeyer@gmail.com, c.giuffrida@vu.nl, h.j.bos@vu.nl,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
Message-ID: <20220330075742.GA22544@louislifei-OptiPlex-7050>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319203819.2559993-1-jakobkoschel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
> The condition retry == 0 is theoretically possible even if 'client'
> does not point to a valid element because no break was hit.
> 
> To only execute the dev_warn if actually a break within the loop was
> hit, a separate variable is used that is only set if it is ensured to
> point to a valid client struct.
> 
Hi Koschel

Thanks for you to help us to try to improve the code. Maybe you don't get the point.
The dev_warn should only been called when has_pending = true && retry == 0

If retry > 0 and has_pending is true,  we would call schedule_timeout_interruptible
to schedule out to wait all the pending I/O requests would been completed.

Thanks.

> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/virt/acrn/ioreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
> index 5ff1c53740c0..bdf7cedce926 100644
> --- a/drivers/virt/acrn/ioreq.c
> +++ b/drivers/virt/acrn/ioreq.c
> @@ -211,7 +211,7 @@ static int ioreq_task(void *data)
>   */
>  void acrn_ioreq_request_clear(struct acrn_vm *vm)
>  {
> -	struct acrn_ioreq_client *client;
> +	struct acrn_ioreq_client *client, *iter;
>  	bool has_pending = false;
>  	unsigned long vcpu;
>  	int retry = 10;
> @@ -228,17 +228,20 @@ void acrn_ioreq_request_clear(struct acrn_vm *vm)
>  	 */
>  	do {
>  		spin_lock_bh(&vm->ioreq_clients_lock);
> -		list_for_each_entry(client, &vm->ioreq_clients, list) {
> -			has_pending = has_pending_request(client);
> -			if (has_pending)
> +		client = NULL;
> +		list_for_each_entry(iter, &vm->ioreq_clients, list) {
> +			has_pending = has_pending_request(iter);
> +			if (has_pending) {
> +				client = iter;
>  				break;
> +			}
>  		}
>  		spin_unlock_bh(&vm->ioreq_clients_lock);
> 
>  		if (has_pending)
>  			schedule_timeout_interruptible(HZ / 100);
>  	} while (has_pending && --retry > 0);
> -	if (retry == 0)
> +	if (client)
>  		dev_warn(acrn_dev.this_device,
>  			 "%s cannot flush pending request!\n", client->name);
> 
> 
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --
> 2.25.1
> 
