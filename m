Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4F5310A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiEWLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiEWLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82976517D2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A56CB81058
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24BAC385A9;
        Mon, 23 May 2022 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653306909;
        bh=GR0HZHnVOJOmOKc8I1ZzQ6Br/Q7cbNoX6z/AtRdKZns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGsndvAN0ayRrBLzIizH26VZHpfNJ/X2V+T9bvEdxvbMWp3dv6+zy6RXH9u6BtukZ
         1WeJH008JQxCPXAy4X3Cj0+YMAliub+/iZFQuCirKq86XB7YBefCMdbWfkVAlVJ35+
         YlekJwUOgkuZ0SFGEpUd71aNpXR9OYMQ2Nz9kSOETZ6ZI6icdw5zwKavGsYp8c9WNy
         omwmr1LfkV1FyY+k9fvTSg8b6ILgy36kMTZ5J2TXW+bznP/D6YX7hspKHF3NKKxM1p
         NiP0omuZazYo8KbWFTFlNIwvLn4UHAh5MWM3/NoXR0vzTANSElLUKVdvQhteGdGqjM
         tadxnWRcKokrg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6eR-00032Z-7C; Mon, 23 May 2022 13:55:07 +0200
Date:   Mon, 23 May 2022 13:55:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] firmware: Avoid leak OF node on error
Message-ID: <Yot2G7k8ICec77Rf@hovoldconsulting.com>
References: <20220523111323.3183-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111323.3183-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:13:23AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in stratix10_svc_init(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/firmware/stratix10-svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 14663f671323..3facd5dfb617 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1109,10 +1109,10 @@ static int __init stratix10_svc_init(void)
>  		return -ENODEV;
>  
>  	np = of_find_matching_node(fw_np, stratix10_svc_drv_match);
> +	of_node_put(np);
>  	if (!np)
>  		return -ENODEV;
>  
> -	of_node_put(np);
>  	ret = of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL);
>  	if (ret)
>  		return ret;

NAK, please just stop
