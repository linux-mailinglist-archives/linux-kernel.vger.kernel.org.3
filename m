Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545AA578015
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiGRKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:48:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15D12AB1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658141282; x=1689677282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7rBMGEx1YSGdVB6fbYn5Y5KkPOqfQscgrLN9anE2Owo=;
  b=Hz6Sevb0ADgfx+vKhzI8AqOjKo+2XhTsB2gmygyWPmhVlObJ5rPMB6yZ
   scuuiAdDbqR/eUdva+A8UG4xDAoUUt2nQOW9IZkLWd3Ybg5wRAtmbioy8
   YfI2bRj040z/oKyXBS86pNnVOaLy+5rX7wIkLyVYqa0c5h71yTqssVinr
   aUQ6jjL5HSGRXQCQrpIuZwYN6eNIlJNwJCraUHcx0Qor9OT0eKqTsqOf1
   eHlkLZDwpbMmJpZP+w1Siq4Cy9bOWbJz6pMBh7VAH5MP35I0Zvipe85cq
   HYF0rTyYuPhgynZ8VR3RdD4qJeLEsMgIzAdgptQlfz4TtReuvXhP01pw8
   g==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="206714051"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 18:48:01 +0800
IronPort-SDR: hpNYio37gaONyuSvvVM0/7xC9x7IKjD3egHnZXArWeJVt5esBQe5YIJU/bvT7zQNkapBL+pYxc
 cLuOtT+sn4pxboydczhzBiOhJ7eGlYzZoUwwh9kIuyydxZ4v7ATRchyEM18YupZLNpZxfX9ZWf
 KjXEbOT7VSqdL5imFbQxL+2hzP7017xyU6tJ1vOc30BqY5ft6WC9zf69NNbJ0wF5yTxJMo45no
 prPeHB7MXiJwzDdRARlSMUj/d3Zhop5m18icYDNZ7iEXL/y/lP4P8dv9zZ/QaQiX9jaiUpEw2i
 7BuwsW+v5cs4X13CrV2Po1ys
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:04:45 -0700
IronPort-SDR: 3C+nTYKoFHyuDxHZLy61YSnyERoDNnUSLMUWaL021KuKaE0uICb8f6K2rIOzGJht4gOy/WBbFB
 uWDH14tA8PS8U4kv1klrcEPqfxpQInG/DQMB72Ji0WDcA/4mtE5h/deabsKo5L4FxY/h9jYP9t
 o2xYcnMz45G6Suu8kzj38G4cveM9SYJltVqu710gl1QsTmcq4naId3CleZja8ufALc+rQLIg4n
 IYXWyO1X4S0x2jwfSbotoFY4VgUBn8UxsSX/V5lVSMUn6hZQDon0GseTmiJj4VDHclLoZuMmDd
 zeI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:48:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LmdwK1Zhtz1Rwnx
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658141280; x=1660733281; bh=7rBMGEx1YSGdVB6fbYn5Y5KkPOqfQscgrLN
        9anE2Owo=; b=bjN5B1j0Rkc2vSnTaBg0I6yZlDKb3jC/Ey1Ow71t0OK/WvsEBS6
        zcLef5xxzvKAk6dN3xoqmSaUtbHCa7GpME+/Gyjh24WSx+3oRTp/RTNJw0MQirr9
        /HS1V4UnLFvDu+T4pFMk4KY+3/YbTd/C+0K+2mxZS9H9jBJuF+QtICaIVfDFwcoq
        Xf2U2c1D81NnxfOvu3UB2HOllG4nhOn6akT3u2/VfBdiWtKfjfBzx9y4PQm2k+Ek
        0JsdZ2kx7xVyP3FIIgro3g3SbxmL5fcX2NKc1Qc5XkWcUaSyDtLMWWgD9RAD5Dqz
        CmPSh/wyz5ZJehHEEZge/Uqk7PRq0biCTqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k_4wfKDSfHLh for <linux-kernel@vger.kernel.org>;
        Mon, 18 Jul 2022 03:48:00 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LmdwG3P48z1RtVk;
        Mon, 18 Jul 2022 03:47:58 -0700 (PDT)
Message-ID: <dad18548-8487-e059-9538-f34ed46d39c0@opensource.wdc.com>
Date:   Mon, 18 Jul 2022 19:47:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/6] scsi: scsi_transport_sas: Cap shost opt_sectors
 according to DMA optimal limit
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux.dev,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
 <1657797329-98541-6-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1657797329-98541-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 20:15, John Garry wrote:
> Streaming DMA mappings may be considerably slower when mappings go through
> an IOMMU and the total mapping length is somewhat long. This is because the
> IOMMU IOVA code allocates and free an IOVA for each mapping, which may
> affect performance.
> 
> For performance reasons set the request queue max_sectors from
> dma_opt_mapping_size(), which knows this mapping limit.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/scsi_transport_sas.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 12bff64dade6..2f88c61216ee 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -225,6 +225,7 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  {
>  	struct Scsi_Host *shost = dev_to_shost(dev);
>  	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
> +	struct device *dma_dev = shost->dma_dev;
>  
>  	INIT_LIST_HEAD(&sas_host->rphy_list);
>  	mutex_init(&sas_host->lock);
> @@ -236,6 +237,11 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  		dev_printk(KERN_ERR, dev, "fail to a bsg device %d\n",
>  			   shost->host_no);
>  
> +	if (dma_dev->dma_mask) {
> +		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}
> +
>  	return 0;
>  }
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
