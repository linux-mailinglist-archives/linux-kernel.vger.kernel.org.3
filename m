Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A8530F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiEWLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiEWLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250250B08
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08095612CA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9BBC385AA;
        Mon, 23 May 2022 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653306835;
        bh=zRFVyDMxaTcsTQxdZCirp8RdZgXfIBOcClwrybOlKXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVk+PSIlVPaob1w+LkxcgQAo2Z0weTeIupgGRKHcOUbDiTmEWy5TdBms65ZIyuh3b
         HAF+3fwzEgdHPXkIgK1ZhWm68wwPLqdB+y9j+mN945qLRbWUwWJ16r7qBe5iETG/Wy
         FSlvYP7BmK0snt+um2VfZMa6AI6uCSWO90/GLFFODFSSP4Ytz/Hm+16hpKhfOEq194
         oQbv7i9fd2GDCEApEUWS6hGsfcKoJNtPu6O2TDvvScjVBKePJe856Ra7GXMij6TAPa
         G/Vzlb7Gc1pdrKDqysXqqaasDmO6sw2qIb7SZQ1uPvNmNCtOyAckoxQPHpTHPNC0zU
         +7a4o+xNz9nyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6dE-00031F-Pm; Mon, 23 May 2022 13:53:52 +0200
Date:   Mon, 23 May 2022 13:53:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] firmware: arm_scmi: Avoid leak OF node on error
Message-ID: <Yot10BacRDUUJk+t@hovoldconsulting.com>
References: <20220523111116.2898-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111116.2898-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:11:16AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in smc_chan_available(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/firmware/arm_scmi/smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 745acfdd0b3d..43018be70edc 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -55,10 +55,10 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
>  static bool smc_chan_available(struct device *dev, int idx)
>  {
>  	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
> +	of_node_put(np);
>  	if (!np)
>  		return false;
>  
> -	of_node_put(np);
>  	return true;
>  }

NAK
