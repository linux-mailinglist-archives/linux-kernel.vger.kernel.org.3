Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1625798BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiGSLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSLpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:45:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22E15FC3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658231122; x=1689767122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ayIxYn79wG+BaJKMtTs4er3tTLYBaFMvwckWu9TW1RM=;
  b=Xi3sf9Xk9ktHtymoTGzFnwVexo8v7kQmi0AvcwRiljnUBLmMulyO9ZsG
   N015eRx2w/i6AhYZ35/SlaVlqsjTDMxa3eVyxL3hESB8PqyRe7RlQDplW
   jfSu2o6/X0/xmV17zcJ9xs3NzQ3ZHHlyFU88cZ2T2Z96G484zb7XbS3oS
   e3H09yLiJVwaZ0Tj1V2PyJ2Kt7eOjB1hlQ1C/aRCn6GiqSIps044JcrMS
   1BqQy7eFbe3ddkxtyE4RxUxDWQF89rXEb97bdbpIF7WbgmgliGFxvSlW3
   KYisimvfUi490QinW5Ylk9IlgzWWrQqQivM/O2CqIG9pZ2Ez0pPpKpwax
   g==;
X-IronPort-AV: E=Sophos;i="5.92,284,1650902400"; 
   d="scan'208";a="211275067"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 19:45:18 +0800
IronPort-SDR: qjIwvsSYIOinbAabpsbvwpbQvmNXlfyFiPYj5QwXHtNiSI3Sn9+H4Z+b5z8GHUCdIDxnVPAH9E
 /V+wn/K3Bfs5oObFS28HdzTq5x/zF/xWXLa76QwtSYbALuipmDQG2Maz2MwdY+A0/YPofos1dg
 sFcmoCeB+4EHwAGTYO2SD42JP4aZ5+bu4mTT9jq2DKYaBQQJxQhQLxvgH5g+kIGt9phPwEvQav
 mI6eTLbmJkCa3F3ByGCl85q9nwHAKA6SQI+jsOoBZ1XSPKSeBvGSbzXIM35sGgGqUVzCAs0rM7
 Uu3KPdiClsO8I/M22GBdQ95i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:06:44 -0700
IronPort-SDR: g99QKJBTj0IhJKiW1ncgUEEFElRX0gYeuidWq4olHasDydsJPuZUnkq4hfmw3eh3JKXPcJ01vE
 RhYLqzitpOEHR0KNd/3G6slAe6qXtdb+4kF1LmYnDiUR3B7ZntbD25rf8XUhOBjq4PfQ2BBEvi
 pj/oDSGernX9BRWlor/2omE3HmzxNXpROJ+W5QhahmNcnXAia1xUOPPddlHd6KLapCI4uBV9fC
 qKFhbNmxkTxh9mf2XldpvzUAm2bNJH8po2jmt0SqTiCQU1vj7Fi1q9U1koEuRcv9vFilGuBRzl
 aRA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:45:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnH7z01zmz1Rwnm
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:45:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658231118; x=1660823119; bh=ayIxYn79wG+BaJKMtTs4er3tTLYBaFMvwck
        Wu9TW1RM=; b=MT5WB/Lzoa/wrYfJcIYAOS1kNLB+NMPEj0eC9wkqcMylN7PJ6+h
        xlW0iy0dbFn+UIy/Fy6+C1fVaaTr/r+1JshXmIspfyrgr1sRxhVwr58KZ5SO14zH
        1m/k+tyNpNyetrKU6L+HpYfQ71jf2M2Ig3QWRjTdU3OtQM8FkhpOHOLEPDy2cv5a
        QpKMlKyJVF/rvGDV2334XnTTt9db5zUSALcObxyXOGYKTbSm/g77IVsaNvN67Yu2
        8+Dx2OABPJBSWgPW/5zo+aeDpR4zg+eiyDvP7tkYEiEsr6MseA0g2Co5BVfdFeUE
        OgcZAS57R8PfoMhaWEZ2h3sZpINWCfcZT6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tJI4edTJXROD for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jul 2022 04:45:18 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnH7y0bllz1RtVk;
        Tue, 19 Jul 2022 04:45:17 -0700 (PDT)
Message-ID: <1a659f24-b9d5-2772-920b-3dfec73d1106@opensource.wdc.com>
Date:   Tue, 19 Jul 2022 20:45:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ata:do not initialise statics to 0
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719114255.7568-1-gaoxin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220719114255.7568-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 20:42, Xin Gao wrote:
> do not initialise statics to 0
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 40e816419f48..bbb98433d160 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -119,7 +119,7 @@ static int atapi_enabled = 1;
>  module_param(atapi_enabled, int, 0444);
>  MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on [default])");
>  
> -static int atapi_dmadir = 0;
> +static int atapi_dmadir;
>  module_param(atapi_dmadir, int, 0444);
>  MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off [default], 1=on)");
>  

Is this solving any static analyzer or compiler warning ? If not, this is
not a very useful change.

-- 
Damien Le Moal
Western Digital Research
