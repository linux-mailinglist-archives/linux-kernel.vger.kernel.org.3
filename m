Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9DD54E9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377912AbiFPTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbiFPTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:08:33 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3D36321
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:08:32 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1uqzoyzz62ovC1uqzoKVy7; Thu, 16 Jun 2022 21:08:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 21:08:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d2637e89-db7e-e69a-f97b-ab87ed5af25a@wanadoo.fr>
Date:   Thu, 16 Jun 2022 21:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] bus: (mvebu-mbus) Add missing of_node_put()
Content-Language: en-US
To:     Liang He <windhl@126.com>, pali@kernel.org, lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220616020135.3973141-1-windhl@126.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220616020135.3973141-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2022 à 04:01, Liang He a écrit :
> In mvebu_mbus_dt_init(), of_find_matching_node_and_match() and
> of_find_node_by_phandle() will both return node pointers with
> refcount incremented. We should use of_node_put() in fail path
> or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   changelog:
> 
>    v2: (1) use real name (2) add of_node_put when not used anymore
> 
>    v1: add of_node_put in fail path
> 
> 
>   drivers/bus/mvebu-mbus.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index db612045616f..e168c8de2ae8 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -1327,22 +1327,28 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>   
>   	prop = of_get_property(np, "controller", NULL);
>   	if (!prop) {
> +		of_node_put(np);
>   		pr_err("required 'controller' property missing\n");
>   		return -EINVAL;
>   	}
>   
>   	controller = of_find_node_by_phandle(be32_to_cpup(prop));
>   	if (!controller) {
> +		of_node_put(np);
>   		pr_err("could not find an 'mbus-controller' node\n");
>   		return -ENODEV;
>   	}
>   
>   	if (of_address_to_resource(controller, 0, &mbuswins_res)) {
> +		of_node_put(np);
> +		of_node_put(controller);
>   		pr_err("cannot get MBUS register address\n");
>   		return -EINVAL;
>   	}
>   
>   	if (of_address_to_resource(controller, 1, &sdramwins_res)) {
> +		of_node_put(np);
> +		of_node_put(controller);
>   		pr_err("cannot get SDRAM register address\n");
>   		return -EINVAL;
>   	}
> @@ -1360,6 +1366,8 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>   			pr_warn(FW_WARN "deprecated mbus-mvebu Device Tree, suspend/resume will not work\n");
>   	}
>   
> +	of_node_put(controller);	
> +
>   	mbus_state.hw_io_coherency = is_coherent;
>   
>   	/* Get optional pcie-{mem,io}-aperture properties */
> @@ -1378,6 +1386,11 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
>   		return ret;

I guess that a "of_node_put(np);" is missing before this return.
This really looks like an error handling path and it has not been 
updated as all the other path, including the normal one below.

Moreover having an error handling path and some gotos is a more usual 
solution. It avoids code duplication. (but it is also a matter of taste...)

CJ

>   
>   	/* Setup statically declared windows in the DT */
> -	return mbus_dt_setup(&mbus_state, np);
> +	ret = mbus_dt_setup(&mbus_state, np);
> +
> +	of_node_put(np);
> +	
> +	return ret;
> +

Nitpick : This extra new line is not needed.

>   }
>   #endif

