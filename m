Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577B53F34F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiFGBWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiFGBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:22:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082D273;
        Mon,  6 Jun 2022 18:22:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2571McrH079758;
        Mon, 6 Jun 2022 20:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654564958;
        bh=CgaOdxh/6hTCnwxfxKHlEtwk/bs3B/+0KLtEZteZTeg=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=WBskwVxgmQlIJmJBEj3/Pmv6FjtSLOqr/Nfj3hMdri6rjg92TgEh93deyVd7h/a2O
         xMkmKCzES3ocVaAUuAoCvU73dc/7tz4TzMZA09NDg5DHnkPrv48+lx97Wwu02xKoVL
         vh3YbbTamu0OL1FsP53KtHG59fl5MI5Dtt8KErtE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2571Mcv9039513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jun 2022 20:22:38 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Jun 2022 20:22:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Jun 2022 20:22:38 -0500
Received: from [10.249.32.125] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2571Mb7j069761;
        Mon, 6 Jun 2022 20:22:38 -0500
Message-ID: <eb7c2a20-3d9d-597c-c462-516bce30f82e@ti.com>
Date:   Mon, 6 Jun 2022 20:22:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] remoteproc: k3-r5: Fix refcount leak in
 k3_r5_cluster_of_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220605083334.23942-1-linmq006@gmail.com>
From:   Suman Anna <s-anna@ti.com>
In-Reply-To: <20220605083334.23942-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On 6/5/22 03:33, Miaoqian Lin wrote:
> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node.
> When breaking early from a for_each_available_child_of_node() loop,
> we need to explicitly call of_node_put() on the child node.
> Add missing of_node_put() to avoid refcount leak.

Thanks for catching this.

> 
> Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 4840ad906018..0481926c6975 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -1655,6 +1655,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
>  		if (!cpdev) {
>  			ret = -ENODEV;
>  			dev_err(dev, "could not get R5 core platform device\n");
> +			of_node_put(child);
>  			goto fail;
>  		}
>  
> @@ -1663,6 +1664,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
>  			dev_err(dev, "k3_r5_core_of_init failed, ret = %d\n",
>  				ret);
>  			put_device(&cpdev->dev);
> +			of_node_put(child);
>  			goto fail;
>  		}
>  

