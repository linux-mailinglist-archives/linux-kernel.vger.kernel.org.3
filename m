Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E20567FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiGFHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiGFHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:31:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FA22B04
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657092669; x=1688628669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XocMgPNbWcrNHTvCB3rNU5kPsEIuhX3fQwKnztq2c+8=;
  b=XwFPB1Cz9j00s1CwDtOhxamyhsJ57KozrQDGkkbKhVCeMTn5zspNbhEc
   BwpPVBipyZbXbR4y5v9g4L6upRoX9YeMkTJ7m1eyffZwJIMjCyCXWR0pD
   xO3bIuYHHVUfGx7lEO9s56B+kpvuCoUP5xHkJ2LukUVVSXHuEgJaBeBgw
   36ngJajCGAixJ7bJqlE5wlI6ZcS/mqlN+l95k2xxSbJshhirAO+Bull/y
   jRUinGCOWpl6irTPT9bsZsA2mDj0swUn+Rpi5Zr++cV03P5uLomsw3N/u
   0Vi3ZPVkyY/+/qHKD6oZWTjLQyPSPfFCiAUjumD+lBE92br6tbQuLDmTk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369988635"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="369988635"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 00:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="650545647"
Received: from louislifei-optiplex-7090.sh.intel.com (HELO louislifei-OptiPlex-7090) ([10.239.146.218])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 00:31:07 -0700
Date:   Wed, 6 Jul 2022 15:32:28 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] virt: acrn: using for_each_set_bit to simplify the
 code
Message-ID: <20220706073228.GA671288@louislifei-OptiPlex-7090>
References: <20220704125044.2192381-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704125044.2192381-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 08:50:44PM +0800, Yang Yingliang wrote:
> It's more cleanly to use for_each_set_bit() instead of opencoding it.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Signed-off-by: Fei Li <fei1.li@intel.com>

Thanks.

> ---
>  drivers/virt/acrn/ioreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
> index 5ff1c53740c0..d75ab3f66da4 100644
> --- a/drivers/virt/acrn/ioreq.c
> +++ b/drivers/virt/acrn/ioreq.c
> @@ -246,12 +246,8 @@ void acrn_ioreq_request_clear(struct acrn_vm *vm)
>  	spin_lock_bh(&vm->ioreq_clients_lock);
>  	client = vm->default_client;
>  	if (client) {
> -		vcpu = find_first_bit(client->ioreqs_map, ACRN_IO_REQUEST_MAX);
> -		while (vcpu < ACRN_IO_REQUEST_MAX) {
> +		for_each_set_bit(vcpu, client->ioreqs_map, ACRN_IO_REQUEST_MAX)
>  			acrn_ioreq_complete_request(client, vcpu, NULL);
> -			vcpu = find_next_bit(client->ioreqs_map,
> -					     ACRN_IO_REQUEST_MAX, vcpu + 1);
> -		}
>  	}
>  	spin_unlock_bh(&vm->ioreq_clients_lock);
>  
> -- 
> 2.25.1
> 
