Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5853511C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiEZO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiEZO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:59:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8D62CD4;
        Thu, 26 May 2022 07:59:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24QEx1YF030015;
        Thu, 26 May 2022 09:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653577141;
        bh=KpKDN5NLgjKiMX92Lb8K/IdcT84hh4TJuNE1Vr3fMwU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EF62ABeMDAhmHVbgl+bvyTBs950zqK9s1KpGOAztCSCc0ieoZ38sZu3Te5FBZhNG+
         1kka35GwdQodJrOkjYdl0RSQ9SVOqWWaSEnU6zJPd9jML3bhhJrECKdzsq1IBWh5Qb
         Xnn4rW9jbi95rhof+JLQvpxmYRRB1Vw20FxCbXJQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24QEx1kO027597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 May 2022 09:59:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 26
 May 2022 09:59:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 26 May 2022 09:59:01 -0500
Received: from [10.250.161.230] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24QEwt8Q110019;
        Thu, 26 May 2022 09:58:56 -0500
Message-ID: <069ce949-bc78-7bfa-686c-ba3f72c7e431@ti.com>
Date:   Thu, 26 May 2022 20:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix ref_table memory leak
 during probe
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220525213617.30002-1-bb@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20220525213617.30002-1-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2022 3:06 AM, Bryan Brattlof wrote:
> If an error occurs in the k3_j72xx_bandgap_probe() function the memory
> allocated to the 'ref_table' will not be released.
> 
> Add a err_free_ref_table step to the error path to free 'ref_table'

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   drivers/thermal/k3_j72xx_bandgap.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index 64e3231589527..3a35aa38ff512 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -433,7 +433,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   				     GFP_KERNEL);
>   	if (!derived_table) {
>   		ret = -ENOMEM;
> -		goto err_alloc;
> +		goto err_free_ref_table;
>   	}
>   
>   	/* Workaround not needed if bit30/bit31 is set even for J721e */
> @@ -483,7 +483,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   		if (IS_ERR(ti_thermal)) {
>   			dev_err(bgp->dev, "thermal zone device is NULL\n");
>   			ret = PTR_ERR(ti_thermal);
> -			goto err_alloc;
> +			goto err_free_ref_table;
>   		}
>   	}
>   
> @@ -514,6 +514,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_free_ref_table:
> +	kfree(ref_table);
> +
>   err_alloc:
>   	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
