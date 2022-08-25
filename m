Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB25A1CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbiHYWrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHYWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:47:51 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB946C6B79
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467670; x=1693003670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmZ4y9zIob46bh2rM8o4F3fEfJ+GVDi8MB3UI98H7jY=;
  b=KcderWU977noXeR/qLqf13BCZuJQgElV62Vr4cF502rLPWVHwdy1WHN7
   TJTJ5riDkfFVPIO65Jd5AIC8c7Ui12k4vqB/G0YWG0joAUfRG1fGDf/kW
   7LMhJMVRYD3gc8dnmPJBwyQMduolYkiDITy7GfsziZ8/yfzdhuEY1OYC3
   e2fca8NYAqAIMKB1uHJ7wz238JFhF1nrDPX1L3S1jB24RXra9NsZWKU2y
   ABnZV9MUEZOBMozQNpOQKa05Y+vthNgN72VybK3HyTNtMO5Qgzu7LBRps
   Bq2Q3KgxkT/ehFs8PYLNwfNEsyeCH8ZyZivwWKBCQjrWalzAXQ5KBlOvh
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="214834938"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:47:49 +0800
IronPort-SDR: fngSQLEPtiHgATeJLDvb894eGydoWE8j7Njh9ldpVGNjmHOHmOWoTnBvfDD8MHqeE9CsqqTQ3R
 71VNQ8c5ur4Mig72EhJCdZCbTWeeBa/PviuPg3HQ/tipcZOTKUTBLffmT8rOjx37pBZ334bNF8
 RHexjNjM4EaMqqo/PX3SrDIuaT1hRByh0HPs1k/zccDMAWRMEhcPiM6eMhkGNN+CdnnS5N4Ou9
 nxYViNA1uwoDadx3UKCcAJMjkA9KcUqUKG0IWx71KwcQMDRocTfNlNXAiOZ7X4+8yPuWMaXWj/
 nF3y0kjPBe4rE0gmyJYHIabp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:08:25 -0700
IronPort-SDR: KCu22zCGVrEG1Z3o1D7MV8G+MA075Yzz691TizPxZe3dK59qjDYHuFok0ukOakfBFlAqIC4Qv7
 xux9mNY2Vcy5MSrDgov9vb4YcX9PkMiVQ7M3EovVGl8+QeqvNU1Jroh/Z+i8xpHrSLYZh9nN84
 h0zp3yDLwois8OUZ47+tpksXvPIS/lRPN34W7jG1zBN3oUcyQzO3b4bEuAhCFWpNVJieNbXNOa
 CvkkioiI8i59PRAM5qft8/Vxx0SWvBV5Wb7OK3Sjw8qkhbguR2gUnnDh0IJD9zSmBFxZmdIfj4
 1eM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:47:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDJ5J4hhPz1Rwnx
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:47:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661467668; x=1664059669; bh=jmZ4y9zIob46bh2rM8o4F3fEfJ+GVDi8MB3
        UI98H7jY=; b=d9Kzbemw76idps6mCmYdleMG0/8OTWdOd8eBiFkDVrx5DmCI6Nx
        8wLUj+voNOCu2CgkNmcRsf1K+6ZhQM8idEqerXqvsUD9nuMB6ki2e/Oy4+NDh/uU
        skkG7XTiIaBbl5fuqEMts2UjCkLsGd2kKZsl62dW/Be65ST9D5zAzVJ6UJDWWQfG
        WLQjEb3vGxD9oH0kRKEe6Xv7LYBkQzg+zUDq3d8IzVFIYEGENwg9B5nkFOJ02qZ7
        YpIvtoAiO1CI0uua9Aj/fWR6qZJiIRquMG3AHapQpC/m898F2/vXdYrqF82mpefJ
        OqnKFCLExzeGLTXllHjZVaEXkhmRHiY/YQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U3NJC5_yRehf for <linux-kernel@vger.kernel.org>;
        Thu, 25 Aug 2022 15:47:48 -0700 (PDT)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDJ5H3Cjvz1RtVk;
        Thu, 25 Aug 2022 15:47:47 -0700 (PDT)
Message-ID: <b31200c7-4737-a4fe-45dd-83ad70892177@opensource.wdc.com>
Date:   Fri, 26 Aug 2022 07:47:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] ata: libata-core: remove redundant err_mask
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220823122914.211355-1-cui.jinpeng2@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220823122914.211355-1-cui.jinpeng2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 21:29, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value from ata_exec_internal() directly instead of
> taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Applied to for-6.1. Thanks !

> ---
>  drivers/ata/libata-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 864b26009eae..0ba0e692210f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4340,7 +4340,6 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
>  {
>  	struct ata_taskfile tf;
> -	unsigned int err_mask;
>  	unsigned int timeout = 0;
>  
>  	/* set up set-features taskfile */
> @@ -4356,9 +4355,8 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
>  	if (subcmd == SETFEATURES_SPINUP)
>  		timeout = ata_probe_timeout ?
>  			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
> -	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  
> -	return err_mask;
> +	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  }
>  EXPORT_SYMBOL_GPL(ata_dev_set_feature);
>  


-- 
Damien Le Moal
Western Digital Research
