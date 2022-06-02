Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9253B39A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiFBGcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFBGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:32:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA0DF06
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654151550; x=1685687550;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RTvVdtkUpGa346JSx46gZWuxl7DtHHBLcONhUZYtf48=;
  b=cM/ig+SJOZi8wx67VyoJZUkaDm75r9cEOZObMczr0nMjjXFJ7bTCqMXv
   65s6uxmJEXkM575/toTXRhKM/fjD5Hkvx9LE8ZUcmYvVUnX5BnbUwL6uQ
   oUImLc3A761z4YVgF0RetchknvW2Mz/YEkq4pLfiatG+T0ZuuwcWK9/iI
   aIB/zSnFYmF5VCfavcbhqhLuwcD05W0EUzcyD+XQySfef8osjYmP+LGBk
   6KlYZzDGsm0GayN8U62mlXUHTFhTTaLeh4dCOMpApWgOHhB4xE7iMw76X
   VQrTINVwrgYUW4hhT5ZwPYeeTSri6sdZAVcwGp5mNc1eUt/fmsDKxgpyQ
   w==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="314101620"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 14:32:28 +0800
IronPort-SDR: RxE70zajE2xgqmRWPJRRkCb+d8pdBrbY0BIXsZrwTwp54w/muQ/QwT6tDGpXgDmtqIzS3Jn7uv
 THFyzhvtGDorQaDU0B4bThv1hZ/46w9U5E0l1q/dJ9q18JW0HZiqZReXXCMAyz5TXosxkOkGNX
 G4cENLZj3OElXogSn4NgX6AUt+SOAfxRRvYMTgAXVe1XhqVm3LrnQ6bUlNVE76LpJtZhXZddFj
 R3bOyNfAoOr1ayWrH2iJq4i8K7LJIPvF0RHt+OEqCFMsRk+e4LRsntp4Q4KzImEOheZP+8KwUM
 lZ4SCD0S3LxB6wr5gR603fcW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 22:56:05 -0700
IronPort-SDR: aMJROiXZYDS/P0QmetGMF91W5iG6bGPDjAj+vWUvOb30XNXtEni+Ebyb9SDcRE6tWSuojx43oa
 OvQPSPNFtHjNdUH0JnfQB66rlfgk54Gueeg1uEKq8mt5Tfh0txRQWZXMn8x/htU8admRLbYwos
 FqnbHfB+fqWnex4Qm+tk17IPZzOS5sI9EyYKb81i+YyaG5gMaIShPy7ZpXHtLWCnlps0rsvqAN
 SbPqw38LKn9BEvafEzF2o0eiWt/Wb1AFq3ISORSPh5y8pBfilIGEH1opZfoqCAf3S5P2UNEQL6
 ZKI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 23:32:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDGQg63sQz1Rvlx
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:32:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654151547; x=1656743548; bh=RTvVdtkUpGa346JSx46gZWuxl7DtHHBLcON
        hUZYtf48=; b=lwQhoeQ3qsyyYDZi20JnxmUFWoqbLSPiGmXLTlz6fSXa8B6UZTe
        wi+1X33bEV7eG8AwBvi7q/tTnhDNhVNEl0Y5HaLb7nJkI26op58Mh3Tnll4Yo0SG
        DN2rgmacrsflzKnyKLG6IFjiZjm3G5n2gRrUOfaRlLS9/t31R1klL06WzXx/iFbf
        xyhCCp+EaRaa+XKic+Oxn8K6JVKb/JDlfYtV8zwO682m1RsomnKxsj4U6yPE2B+G
        jhLXg7mVj351rsqYUg9KCf7eE+ExdatPpF6XEW9n7FHuBrCleRb2hxcja/4UzBEf
        vVPD0J7EIg+pqC8ILAFQigXMtDGPcD0gz/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WCW6D4_X2kwt for <linux-kernel@vger.kernel.org>;
        Wed,  1 Jun 2022 23:32:27 -0700 (PDT)
Received: from [10.89.84.115] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.115])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDGQf28fXz1Rvlc;
        Wed,  1 Jun 2022 23:32:26 -0700 (PDT)
Message-ID: <87953d70-198d-e146-b67d-b320603d52d3@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 15:32:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ata: pata_octeon_cf: Fix refcount leak in
 octeon_cf_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601085926.45183-1-linmq006@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601085926.45183-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/01 17:59, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() to avoid refcount leak.
> 
> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Add put_device() at the end of if (dma_dev).
>   we need the null check and do handling only if dma_dev!=NULL.
> - call put_device before of_node_put() in error path. keep the
>   reverse order of resource allocation.
> 
> v1 link:
> https://lore.kernel.org/all/20220511062723.56652-1-linmq006@gmail.com/
> ---
>  drivers/ata/pata_octeon_cf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 6b5ed3046b44..35608a0cf552 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -856,12 +856,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  				int i;
>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>  				if (!res_dma) {
> +					put_device(&dma_dev->dev);
>  					of_node_put(dma_node);
>  					return -EINVAL;
>  				}
>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>  									 resource_size(res_dma));
>  				if (!cf_port->dma_base) {
> +					put_device(&dma_dev->dev);
>  					of_node_put(dma_node);
>  					return -EINVAL;
>  				}
> @@ -871,6 +873,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  					irq = i;
>  					irq_handler = octeon_cf_interrupt;
>  				}
> +				put_device(&dma_dev->dev);
>  			}
>  			of_node_put(dma_node);
>  		}

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
