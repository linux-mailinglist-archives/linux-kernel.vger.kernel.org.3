Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADA4FD7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiDLJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350623AbiDLJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:40:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F93692B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:46:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23C8k19Y115994;
        Tue, 12 Apr 2022 03:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649753161;
        bh=3K51sbmQ8lmy2+7Rao3B6SkJ5pZ/iOE/xz34xa/ZFW0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XIDM+pO6PvMLF2MyGFNcfrwFsAcmont47iAL1gn9vu9Z4q0rxyKNwKIF+06LjSb1g
         +S1d8ETZd42TsAsasheGqeNpIungiVl05EV2XhEd8IKTmmgw9cuGrALeqK1b4lFUei
         9sUriGoGvetcDLkTnvjW7+k1bv9g9oOWtOXs30uE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23C8k1Qb104814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 03:46:01 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 03:46:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 03:46:01 -0500
Received: from [10.249.96.184] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23C8jwep053060;
        Tue, 12 Apr 2022 03:45:59 -0500
Message-ID: <48939b53-ede5-103a-ceae-9d7b9dcc4a1b@ti.com>
Date:   Tue, 12 Apr 2022 11:46:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] soc: ti: knav_dma: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <nm@ti.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220412082923.2532649-1-chi.minghao@zte.com.cn>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
In-Reply-To: <20220412082923.2532649-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2022 11:29, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/soc/ti/knav_dma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index 700d8eecd8c4..061f92c8cf7d 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -747,9 +747,8 @@ static int knav_dma_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&kdev->list);
>   
>   	pm_runtime_enable(kdev->dev);
> -	ret = pm_runtime_get_sync(kdev->dev);
> +	ret = pm_runtime_resume_and_get(kdev->dev);
>   	if (ret < 0) {
> -		pm_runtime_put_noidle(kdev->dev);
>   		dev_err(kdev->dev, "unable to enable pktdma, err %d\n", ret);
>   		goto err_pm_disable;
>   	}

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
Grygorii, Ukraine
