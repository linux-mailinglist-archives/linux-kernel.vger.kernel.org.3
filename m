Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD954531096
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiEWLyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiEWLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:54:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088A5158B;
        Mon, 23 May 2022 04:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA55B81057;
        Mon, 23 May 2022 11:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E6C385A9;
        Mon, 23 May 2022 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653306856;
        bh=n/Zgb6Y6yPNWuMGiGLYRFZIFDKFk8UcR8pCX1uKYnYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B79tyanNzVjMXqSJ3ahoFckyR7XQ85emG3HdQaHMQqAwmpVyM9Ozxqqp1KbsQTln0
         CCiZyI5ZhQ9Z3UzfpjpXWgemK+8XVZFw795vtccXEic9ZSsUa8hv8U2Uc95d7VI5IB
         uyFRppfOEcqV7hU9Or4ahUvRqlHTKa3BvluSzZp1NAVlQVeDsJmbZBUJ9C6cz7hw4Z
         VEBs7K+6ZnE56OMIRJZr4kGnYQHx3Iw127DFqPo9HYRfqis622QezVontQx7oTUwhu
         3x6yVV4dz+COKY9lkSvfDc84LCO7evJXqhWNoP7Ba09KFneFZZ0SOt2IXYGoPYF3gc
         YOyBXoHu19Nrw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6da-000320-1m; Mon, 23 May 2022 13:54:14 +0200
Date:   Mon, 23 May 2022 13:54:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] soc/tegra: Avoid leak OF node on error
Message-ID: <Yot15lTDH8n7+xh5@hovoldconsulting.com>
References: <20220523111221.3045-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111221.3045-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:12:21AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in tegra_init_soc(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index b0a8405dbdb1..ab3e4dc6dc6e 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -612,11 +612,10 @@ static int __init tegra_init_soc(void)
>  
>  	/* make sure we're running on Tegra */
>  	np = of_find_matching_node(NULL, tegra_fuse_match);
> +	of_node_put(np);
>  	if (!np)
>  		return 0;
>  
> -	of_node_put(np);
> -
>  	soc = tegra_soc_device_register();
>  	if (IS_ERR(soc)) {
>  		pr_err("failed to register SoC device: %ld\n", PTR_ERR(soc));

NAK
