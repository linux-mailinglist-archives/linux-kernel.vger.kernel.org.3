Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27694C2C00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiBXMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBXMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:44:18 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED11B3A66
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645706628; x=1677242628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n4fzh44QAy22moc9qJ4F1Z/J9ZjLZgoIz8vevQPxfjQ=;
  b=IriKk+xu1xy+xm6zPJCYzIdlu2osESefzVgeaV56mZ35CaYrpqPHZrZG
   gCVxlUYnBdk7aaJ9Efa16nHVpDWzFxHq583wDcaboS5f8J32SQhTAyaSG
   GIN3mjIkwnjRoAP9BCv1ZIk/obBFlxxKH0j/+sPjzXFh4SYDGD45ZT2S3
   1g9l+fq9f3ZcGjPEC7VKdBWxvuv6QX8sfwT5BPpFmkLYjnzm8OG2C8Iv8
   6cqUDqLJ2VvG9KrEOE1lTsTFIVz9cWdBdl/Fcz3k+YzHR2IeOb0wAGmER
   FhEZgT46GoWXB3FMUo4Yx5pjOX8z0hebVvWi0W6ZKDLs9Jl9IUfxxEfFe
   A==;
X-IronPort-AV: E=Sophos;i="5.90,133,1643644800"; 
   d="scan'208";a="198681759"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2022 20:43:47 +0800
IronPort-SDR: V2PD2ebTlodWz5gwr7F299055yHEz0UnVdTaGzzveECfYvmtG+lbnLn9sElqYCcWlAKu59Kgv/
 EtEq2lHKWcIOuOlBlEkreMDbWs2Wp7LHSURRbVDCQwqJcC+JGNLUvmzXHJk2e89baevr9wEahZ
 zrFHUL/kOa9sB0zMJ7JLP4cnt00Ni+U55CmVeWq/WOsT7LFDFAXZ71dRvh1bgp7gExBwtLNVoY
 MJCcfvlIZMokaoqzSvDsey2vPeeOabnSUFLBjMhbmZa3z1Lfu7u3lSEListKaOBa2sqeDeoZ85
 H/p5gkYvoNoP3n+MlZNQylmc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 04:15:18 -0800
IronPort-SDR: KA5fpwagpqNfMl9z/li0wvcYCCQ4P37P+JKGiw9mg7r++uD2/ETYFSCfKfbIp864dICHFlSjHa
 kHfmJdXgmNGbBJPbL1u9d8fGzJ+qvX2BVO+iH1zkoKk6G39Pj6qE0oiFmr0673WiN0Q0DKv06w
 3f71h4PiEP9I5DGHtpCL+R1G9+eKE8EheGIjbt4FNMGgtfVxNg5oIjLPyMl4QY5uVJUYwTwTKV
 EzeTWkICAWMqS2zRHGD+guAwm4h69ndpGnc6xihuFph8dLnN4R8voi6Zn3Uj674i4iBOfk8ve2
 d24=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 04:43:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K4CJM2JX0z1SHwl
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:43:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645706626; x=1648298627; bh=n4fzh44QAy22moc9qJ4F1Z/J9ZjLZgoIz8v
        evQPxfjQ=; b=aqJXpR3SA6H1bY+CRnGXXkNNgDKwJ6UcL0jOmYTUtVZ8l1IHxL4
        DK5J2FbPGo1WiOfYoEB9cYRcYzVF/fAhrM35IpHYe7Gn20paZoBkDpwPLcGbtRGt
        u7gvq/In+YWLi6trxrLBdTpCo0+1IgAN8OJYuBF15XCOH0/49Y43LUfzbe72TjHL
        VVSu8IrZia2EZMf4iU/6S+vvYhSXkeqRn02yPKmj5pAupa1y1wZb8sP39FbBlH7r
        k9gTXIkGfPl4QFMVUPto6W/ha9NMbHdBj3Ufagi9wA33NHtpIdvhhKm+lDN2lRkX
        XHr2AutzWtaHFcgo626IYOrSO/qgSMVXbYg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fNXoEAVcoceC for <linux-kernel@vger.kernel.org>;
        Thu, 24 Feb 2022 04:43:46 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K4CJK04msz1Rvlx;
        Thu, 24 Feb 2022 04:43:44 -0800 (PST)
Message-ID: <014a69ed-7a99-2a67-fa3a-947d11601114@opensource.wdc.com>
Date:   Thu, 24 Feb 2022 21:43:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] scsi: libsas: Make sas_notify_{phy,port}_event()
 return void
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
 <1645700699-82369-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1645700699-82369-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 20:04, John Garry wrote:
> Nobody checks the return codes, so make them return void. Indeed, if the
> LLDD cannot send an event, nothing much can be done in the LLDD about it.

It really sound like the LLDDs should be fixed to e.g. reset the adapter
if things go south with these functions. No sure though.

> 
> Also remove prototype for sas_notify_phy_event() in sas_internal.h, which
> should not be there.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>

In any case, these changes do not make anything worse :)

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_event.c    | 20 ++++++++------------
>  drivers/scsi/libsas/sas_internal.h |  2 --
>  include/scsi/libsas.h              |  8 ++++----
>  3 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
> index 3613b9b315bc..8ff58fd97837 100644
> --- a/drivers/scsi/libsas/sas_event.c
> +++ b/drivers/scsi/libsas/sas_event.c
> @@ -165,8 +165,8 @@ static bool sas_defer_event(struct asd_sas_phy *phy, struct asd_sas_event *ev)
>  	return deferred;
>  }
>  
> -int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
> -			  gfp_t gfp_flags)
> +void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
> +			   gfp_t gfp_flags)
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> @@ -176,7 +176,7 @@ int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  
>  	ev = sas_alloc_event(phy, gfp_flags);
>  	if (!ev)
> -		return -ENOMEM;
> +		return;
>  
>  	/* Call pm_runtime_put() with pairs in sas_port_event_worker() */
>  	pm_runtime_get_noresume(ha->dev);
> @@ -184,20 +184,18 @@ int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  	INIT_SAS_EVENT(ev, sas_port_event_worker, phy, event);
>  
>  	if (sas_defer_event(phy, ev))
> -		return 0;
> +		return;
>  
>  	ret = sas_queue_event(event, &ev->work, ha);
>  	if (ret != 1) {
>  		pm_runtime_put(ha->dev);
>  		sas_free_event(ev);
>  	}
> -
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sas_notify_port_event);
>  
> -int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
> -			 gfp_t gfp_flags)
> +void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
> +			  gfp_t gfp_flags)
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> @@ -207,7 +205,7 @@ int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  
>  	ev = sas_alloc_event(phy, gfp_flags);
>  	if (!ev)
> -		return -ENOMEM;
> +		return;
>  
>  	/* Call pm_runtime_put() with pairs in sas_phy_event_worker() */
>  	pm_runtime_get_noresume(ha->dev);
> @@ -215,14 +213,12 @@ int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  	INIT_SAS_EVENT(ev, sas_phy_event_worker, phy, event);
>  
>  	if (sas_defer_event(phy, ev))
> -		return 0;
> +		return;
>  
>  	ret = sas_queue_event(event, &ev->work, ha);
>  	if (ret != 1) {
>  		pm_runtime_put(ha->dev);
>  		sas_free_event(ev);
>  	}
> -
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sas_notify_phy_event);
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index b60f0bf612cf..24843db2cb65 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -78,8 +78,6 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
>  			enum phy_func phy_func, struct sas_phy_linkrates *);
>  int sas_smp_get_phy_events(struct sas_phy *phy);
>  
> -int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
> -			 gfp_t flags);
>  void sas_device_set_phy(struct domain_device *dev, struct sas_port *port);
>  struct domain_device *sas_find_dev_by_rphy(struct sas_rphy *rphy);
>  struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id);
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index dc529cc92d65..df2c8fc43429 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -727,9 +727,9 @@ int sas_lu_reset(struct domain_device *dev, u8 *lun);
>  int sas_query_task(struct sas_task *task, u16 tag);
>  int sas_abort_task(struct sas_task *task, u16 tag);
>  
> -int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
> -			  gfp_t gfp_flags);
> -int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
> -			 gfp_t gfp_flags);
> +void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
> +			   gfp_t gfp_flags);
> +void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
> +			   gfp_t gfp_flags);
>  
>  #endif /* _SASLIB_H_ */


-- 
Damien Le Moal
Western Digital Research
