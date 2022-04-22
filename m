Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93C150B0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444455AbiDVGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444439AbiDVGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:37:16 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FC50B01
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:34:23 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1nhmrb-00017O-Gb
        for linux-kernel@vger.kernel.org; Fri, 22 Apr 2022 08:33:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] fsi: Fix error handling in fsi_master_register() and its
 callers
Date:   Fri, 22 Apr 2022 08:33:50 +0200
Message-ID: <26efc808-acd7-cff3-82e7-66561314f8ca@wanadoo.fr>
References: <f37bfdccfcf8a8d1bdcbf668b802df13253ed3fe.1650556911.git.christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
In-Reply-To: <f37bfdccfcf8a8d1bdcbf668b802df13253ed3fe.1650556911.git.christophe.jaillet@wanadoo.fr>
Cc:     kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/04/2022 à 18:02, Christophe JAILLET a écrit :
> fsi_master_register() calls device_register().
> When device_register() fails, put_device() still needs to be called.
> 
> Up to now, there is no put_device() in fsi_master_register().
> Some callers of fsi_master_register() have it, some have not.
>   - fsi_master_acf_probe() call put_device() if fsi_master_register() fails
>   - fsi_master_gpio_probe() call put_device() if fsi_master_register() fails
>   - fsi_master_aspeed_probe() doesn't
>   - hub_master_probe() doesn't
> 
> In order to fix it and be consistent with the different callers, add the
> missing put_device() in the error handling path of fsi_master_register()
> and remove it from 2 callers that were handling it by themselves.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative and compile tested only.
> Review with care.
> 
> Another alternative would be to add the put_device() call in
> fsi_master_aspeed_probe() and hub_master_probe() if it makes more sense.
> 
> Having one or more Fixes tag is a bit hard because of the relations and
> log history of the 5 files involved in this bug fix.
> ---
>   drivers/fsi/fsi-core.c          | 1 +
>   drivers/fsi/fsi-master-ast-cf.c | 1 -
>   drivers/fsi/fsi-master-gpio.c   | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 3a7b78e36701..640692e5400f 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1319,6 +1319,7 @@ int fsi_master_register(struct fsi_master *master)
>   
>   	rc = device_register(&master->dev);
>   	if (rc) {
> +		put_device(&master->dev);
>   		ida_simple_remove(&master_ida, master->idx);
>   		return rc;
>   	}
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 24292acdbaf8..dde63d703ea1 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -1395,7 +1395,6 @@ static int fsi_master_acf_probe(struct platform_device *pdev)
>   		return 0;
>   
>   	device_remove_file(master->dev, &dev_attr_external_mode);
> -	put_device(&master->master.dev);
>   	return rc;
>   
>    stop_copro:
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index 7d5f29b4b595..1ae3c164d7fd 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -856,7 +856,6 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
>   	rc = fsi_master_register(&master->master);
>   	if (rc) {
>   		device_remove_file(&pdev->dev, &dev_attr_external_mode);
> -		put_device(&master->master.dev);
>   		return rc;
>   	}
>   	return 0;

NACK

After additional reading of the code, it looks good to me as-is.
Usage in fsi_master_aspeed_probe() and hub_master_probe() seem to have 
no release function.

CJ

