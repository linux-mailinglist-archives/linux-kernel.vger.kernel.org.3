Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C24531013
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiEWLyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiEWLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0E85133E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA8E612CA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D2DC385AA;
        Mon, 23 May 2022 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653306848;
        bh=yiHuvRq2ifZnUcEmcstVnk0KFOc8FpIy8LiSvJGaPUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBoIiS0IqElh+FJnYtAdIXyQJdqQ8pbXMPdfXmeNH2Sbrqx5nOeJSAV+V9pcOnl5X
         7RkL/HuANJjhMo5PPFj3/y62N5fv2ld+1YvURco2jEDmndYGy1EpRcDc2UWHCQ1jue
         5I9icP/Ho1+tq8VldMg0Ze4VSXUsb+oY94ot/fv7OlRixVkDYOOVoqWIjpVSNZlave
         XVmc7CBKq2BA+0cQrxa3TxJOX+FqlhFn9NwYbHEFYiQf4DD14xfdLijOho9S8AVdnD
         mjwDrMj5oB5kdQuE7I8/LnYUxGF+vrrsKX8Z1DaKHUFPjuYYMFtBuaFdyhHebZ5PMw
         mlMfQ0nFt7hAg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6dQ-00031b-De; Mon, 23 May 2022 13:54:04 +0200
Date:   Mon, 23 May 2022 13:54:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Avoid leak OF node on error
Message-ID: <Yot13L7XgvxTkgnE@hovoldconsulting.com>
References: <20220523111145.2976-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111145.2976-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:11:45AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in ipmmu_init(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 8fdb84b3642b..f6440b106f46 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1179,11 +1179,10 @@ static int __init ipmmu_init(void)
>  		return 0;
>  
>  	np = of_find_matching_node(NULL, ipmmu_of_ids);
> +	of_node_put(np);
>  	if (!np)
>  		return 0;
>  
> -	of_node_put(np);
> -
>  	ret = platform_driver_register(&ipmmu_driver);
>  	if (ret < 0)
>  		return ret;

NAK
