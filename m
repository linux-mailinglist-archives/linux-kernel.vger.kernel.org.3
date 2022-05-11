Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51523522D78
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiEKHgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiEKHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:36:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10619532F5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652254603; x=1683790603;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Alb1xrnJhldpzE9osSqFp3an/3P5dB47J8vJc3iL0z8=;
  b=f3lA6/aRCUXEm9lxOrGboeop/J18eHWM1w+2Ms0jAkA1cM+y0o52Gejv
   3Eq4OsZgoLYGZixwBL1T/YYIcg8/4sRxKa+k/LSd6skAQX6k14BYyGVEj
   daX5T20oY2jq4tITEKogBaviokrebtlbxRCNPcEjQ+EcrhLVr40s8q5mn
   ejtCAvMUx+j2z2uf4Jjubq/m5/7voIA/yaPXbTUwAHurATBRvVforYpAt
   EGwlUUv7qQk+OE8xcSg+kmxQ8mC5JKsWH3sfVbV/Oy0B+aGxcTo5+F4dd
   kC9KeyG1NEP2dol3/blzZ+3Ej4y+qYGsALh51biDpulj2ViolwCEhIlQs
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647273600"; 
   d="scan'208";a="200041027"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2022 15:36:40 +0800
IronPort-SDR: KxjJQLqQGusJyqhrTXrzzKdHcykNSQpgCafWiv7qeSr4sFBqtshLPqrNkutXWqtiapzBrtG4pp
 /Q/ZYHuyzS3zU/MdYoJolAA5R3GkHpEFGNdMiTiLq5D1IOF+6C7mAKEKieM3thCZVBsycGPort
 v9osfcTm6Hl1AAUTivFGoNJ0tgX8eaHvhUWIf7KPhdDm7XvsQ1XnHsGNbUIoZfPLSvN4IUNelP
 hVZsAb6nlLOujW7dMTWuyFEVL2J5/fPTNxMMusy0PTJ2W5uw1EvxHTt//s/r6TuC7/8YG8fhxW
 8eYzk9QBZ8tKIipiOYGTXk3Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 00:05:24 -0700
IronPort-SDR: 6lsCvq1HWaPv/ykdIDYIxRuXSsN7O+QjwvT8zndQdEbJVOh1s7PQh1wWvhDaC7WYHRAc9yPadJ
 ndVGFubImyJyb3FLmQT2XuJr5KWblZplEbkCfS786Sc0eF2d4q2T5WUUs35l3TCt2FzGyy95iH
 vvChvKzhPnxN3HSLmNVbThKnw+XK+pIE7xIzQPKT1+rTY+8lVQE+tNcWMIkfgdo6Im8gr0bFh2
 ToF6jqyqOYPGh/rnvaujgKafMceswijr2WAIg175omX19smDSSrRUN9UzvbRR5Jhuv1LTSfJDm
 Db8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 00:36:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kymtw6pVLz1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:36:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652254600; x=1654846601; bh=Alb1xrnJhldpzE9osSqFp3an/3P5dB47J8v
        Jc3iL0z8=; b=iPLP+9bmh/sFRDsMlN+61U1UJdWQoEHUHr0wBj2xpGR4NfO9Qnh
        D+BLwpemayAbg3CNkK3Vyi5moF5RlN2y6Rx99yhj/em7ldb3F5OXFy7RivHw1/ei
        xG/MoansLkmsDPcsJvDSY/mDgdJX6g9vfj21+DZKWRB6tIquVLmKsOqp8EkPTD4B
        vn6MonKHv0be5DwoqvInLNRgXBRm1vSpBxYQyc7PgwmTJAlaw34Vi57d2xfEKtM4
        YefRD/Vt/Fxdhj/9+INTW/LYzXmAH2PtghuKol1ru68h6/ooqdP5DJO08Z4HEUVZ
        zRqkvdWiubI7LfsnpmZ96wBIulR/d7pViqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kAkBEvfhSukS for <linux-kernel@vger.kernel.org>;
        Wed, 11 May 2022 00:36:40 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kymtv0jPxz1Rvlc;
        Wed, 11 May 2022 00:36:38 -0700 (PDT)
Message-ID: <6122a113-9ea2-c3b3-153d-dac1f6a38dbb@opensource.wdc.com>
Date:   Wed, 11 May 2022 09:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220511062723.56652-1-linmq006@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220511062723.56652-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/11 8:27, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
> 
> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 6b5ed3046b44..65688459acf1 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -857,12 +857,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>  				if (!res_dma) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>  									 resource_size(res_dma));
>  				if (!cf_port->dma_base) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  

The extra reference should also be dropped at the end of the "if (dma_node)"
too, no ? Otherwise, early returns due to errors after that "if (dma_node)" will
also leak the extra ref.

Note that looking around at places where of_find_device_by_node() is being used,
very few users call put_device()... Looks like there are lots of device ref
leaks with that.

-- 
Damien Le Moal
Western Digital Research
