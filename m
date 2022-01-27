Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8D49EE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbiA0XJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:09:02 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8172 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344529AbiA0XIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643324930; x=1674860930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIQFZUU2YtYKz8AVEUJwYWDyx6QIOXw3eZJaDURUMqM=;
  b=DkQCAOWAJ8kldu60SFCv2TU6kMaRFq7FXriihbBj84HR40tR3aSqf8kT
   gdBR9KrdxWohThWWQJRf034C/Rf6O8/64Kukz2g8eCNFyTIJH9xehlYRh
   nkao4SlrtK2/p0uCRB7mDzX3fwX5E/jd/yrGtziF298PrtKynRxmti9qX
   LSN2LQpD3POcBy5Sgo/IM8ai5xnnvq/B6PuXbHcWmql/VnZl0e5vJoSdR
   ZZWpGwhcVb5ISG0qMfKJyp0VQMgPAsDCY2lKpdq22yosChHBsQFW3eoDx
   QxUaxezR9VwON+XfS4Ju5Fz57RbOty9YsTYesjSNsML2zxK8Bsgvm1uI2
   A==;
X-IronPort-AV: E=Sophos;i="5.88,321,1635177600"; 
   d="scan'208";a="303450888"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 07:08:50 +0800
IronPort-SDR: 2nMVoxNnpgaHIPSlE6Gu0OAr9uQOTRPALBnkulgWiIhYj7UDOtEBRNYhNhzEEnDF6u7AmZZEWR
 r2zW7m3lu184uFVhKXd5kylV9+USpwIK0beRN4EQOuepvdy7Pu/1QyvFtAI/NKL4oPUuDuaqt5
 HS9/e8myU78wFtx21mRkh5lPJv/nOQVCZf8/CryCiTYndl/NOuZvL82BsyIM0XovamGgmWmot4
 x24l3H538xTd1rxeksn1iykB8aDysqacB0UsPL60VQEj46Cmop3sXWSbZdVyO13VmQSL42kalQ
 rVUO2+WlR7dacmXfPhAyO2Vj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 14:40:53 -0800
IronPort-SDR: evt+/2cYseM6I/iL9HLhXyZ04CtZeea0BDEkIyOhKZG3Ht4rFzUoSrvx6zHw65SjaioLyWj7vz
 6q44R2zSVwA/DXE5DmhsxqRPx0Pzx80BX3sXDNMhQq7sa59yMvE3WZrFK8hEbJNS4pPJZWkXLe
 Qs5eSw51BApTh0xuoIEQcxwwjrQNvD41XYLZkZoX/tIRLTM2mffUbw7ANAn1idUKUSBwyp8pm+
 JQ8WoJLpxNnWOx3Y3GDRfOhU4G4TaEWEcKyQQLoGMFT9V/LhKuXhpON3CiwvdRfu5kJQzocE9v
 loI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:08:50 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlGVT2yrWz1SHwl
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643324928; x=1645916929; bh=sIQFZUU2YtYKz8AVEUJwYWDyx6QIOXw3eZJ
        aDURUMqM=; b=r/zy/W7ckZnVRMM3jvoBp/4D6npgXj3O/z+pF5uUJ7sAfz0vQcs
        V4HcSmvhSb6Oq7pGCysGglhogFn7qup6m9CJDfec6hC7zN3hHZ+HtMU29LbI9A5+
        q0gBAOFqXJg+KjdYXlUQZ8SFJsT/I1yR4yfkMnFPHvnYAjpl4WDG+icYBSShJxc8
        0i34GgHY/ieyCdDL1kJlCs0a1unP3tfXDy5g9QTmkU+B6jNJhSbdsO/+2pnTXjNw
        MPDBFgF2+Tj4XTMtrq5GugxKj1Y2a+th1mwRCckd3MxJDLWx/7+rPG56J3+oTW4k
        SsJ3pG+uWjlbvOgCbq3Evw1oY2v9w/Oj86Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PPojdCcnpTcK for <linux-kernel@vger.kernel.org>;
        Thu, 27 Jan 2022 15:08:48 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlGVR3tzfz1RvlN;
        Thu, 27 Jan 2022 15:08:47 -0800 (PST)
Message-ID: <ab547eb4-d97d-45e0-207a-8b660c6e96bd@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 08:08:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] scsi: pm8001: Fix use-after-free for aborted SSP/STP
 sas_task
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Ajish.Koshy@microchip.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viswas.G@microchip.com, chenxiang66@hisilicon.com
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
 <1643289172-165636-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1643289172-165636-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 22:12, John Garry wrote:
> Currently a use-after-free may occur if a sas_task is aborted by the upper
> layer before we handle the IO completion in mpi_ssp_completion() or
> mpi_sata_completion().
> 
> In this case, the following are the two steps in handling those IO
> completions:
> - call complete() to inform the upper layer handler of completion of
>   the IO
> - release driver resources associated with the sas_task in
>   pm8001_ccb_task_free() call
> 
> When complete() is called, the upper layer may free the sas_task. As such,
> we should not touch the associated sas_task afterwards, but we do so in
> the pm8001_ccb_task_free() call.
> 
> Fix by swapping the complete() and pm8001_ccb_task_free() calls ordering.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index ce38a2298e75..1134e86ac928 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -2185,9 +2185,9 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  		pm8001_dbg(pm8001_ha, FAIL,
>  			   "task 0x%p done with io_status 0x%x resp 0x%x stat 0x%x but aborted by upper layer!\n",
>  			   t, status, ts->resp, ts->stat);
> +		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
>  		if (t->slow_task)
>  			complete(&t->slow_task->completion);
> -		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
>  	} else {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
>  		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
> @@ -2794,9 +2794,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
>  		pm8001_dbg(pm8001_ha, FAIL,
>  			   "task 0x%p done with io_status 0x%x resp 0x%x stat 0x%x but aborted by upper layer!\n",
>  			   t, status, ts->resp, ts->stat);
> +		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
>  		if (t->slow_task)
>  			complete(&t->slow_task->completion);
> -		pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
>  	} else {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
>  		spin_unlock_irqrestore(&circularQ->oq_lock,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
