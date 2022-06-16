Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8295854E1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiFPNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377005AbiFPNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD73FBFC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 746D4B823E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70CEC34114;
        Thu, 16 Jun 2022 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655385288;
        bh=MvGzwSr7p9o7aJM3QU/WfO65koGl2h0HDVMJVHkOHR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmJ4lOxD/SDP/8Tlm5j+vlZy3wkdoDRy3ugghzx4sZFR3cpPtb/2R319an6iQZYBk
         Md9iKhOEfMQpE6FYRLDorx9BBWxdWpZfdEo3Q0NiFrwIKReIeTkTfqrwF7u0Ge+g4Z
         blAG4+tvBq/qttg3vpzveufdUIJWrfsCMm8yOu14PK7iERF0pcNAIPEBWvb87yIqLr
         lXohrJsVAwQX/nOg3aaGLX/Swry3+FLJDS2gNQ/b+3zrOaBc0/Tc4dNVm5N7HNM6dS
         OlJZIyH2IMn2o2uKP5rwWTYtNYlqNvhia++dy1FX5fBHj6ID/+QjFRLjfIQCLQbV9g
         t000Z3HomKPxw==
Received: by pali.im (Postfix)
        id D23CB9CA; Thu, 16 Jun 2022 15:14:45 +0200 (CEST)
Date:   Thu, 16 Jun 2022 15:14:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     lpieralisi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: (mvebu-mbus) Add missing of_node_put()
Message-ID: <20220616131445.fm4pyrsodo624vwz@pali>
References: <20220616020135.3973141-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616020135.3973141-1-windhl@126.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2022 10:01:35 Liang He wrote:
> In mvebu_mbus_dt_init(), of_find_matching_node_and_match() and
> of_find_node_by_phandle() will both return node pointers with
> refcount incremented. We should use of_node_put() in fail path
> or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  changelog:
> 
>   v2: (1) use real name (2) add of_node_put when not used anymore
> 
>   v1: add of_node_put in fail path
> 
> 
>  drivers/bus/mvebu-mbus.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index db612045616f..e168c8de2ae8 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -1327,22 +1327,28 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>  
>  	prop = of_get_property(np, "controller", NULL);
>  	if (!prop) {
> +		of_node_put(np);
>  		pr_err("required 'controller' property missing\n");
>  		return -EINVAL;
>  	}
>  
>  	controller = of_find_node_by_phandle(be32_to_cpup(prop));
>  	if (!controller) {
> +		of_node_put(np);
>  		pr_err("could not find an 'mbus-controller' node\n");
>  		return -ENODEV;
>  	}
>  
>  	if (of_address_to_resource(controller, 0, &mbuswins_res)) {
> +		of_node_put(np);
> +		of_node_put(controller);
>  		pr_err("cannot get MBUS register address\n");
>  		return -EINVAL;
>  	}
>  
>  	if (of_address_to_resource(controller, 1, &sdramwins_res)) {
> +		of_node_put(np);
> +		of_node_put(controller);
>  		pr_err("cannot get SDRAM register address\n");
>  		return -EINVAL;
>  	}
> @@ -1360,6 +1366,8 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>  			pr_warn(FW_WARN "deprecated mbus-mvebu Device Tree, suspend/resume will not work\n");
>  	}
>  
> +	of_node_put(controller);	
> +
>  	mbus_state.hw_io_coherency = is_coherent;
>  
>  	/* Get optional pcie-{mem,io}-aperture properties */
> @@ -1378,6 +1386,11 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>  		return ret;
>  
>  	/* Setup statically declared windows in the DT */
> -	return mbus_dt_setup(&mbus_state, np);
> +	ret = mbus_dt_setup(&mbus_state, np);
> +
> +	of_node_put(np);
> +	
> +	return ret;
> +
>  }
>  #endif
> -- 
> 2.25.1
> 
