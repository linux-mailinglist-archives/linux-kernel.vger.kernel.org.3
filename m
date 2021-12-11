Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF06470F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbhLKA3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:29:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7352 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbhLKA3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639182374; x=1670718374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=94QWSZFzxy1R2Fj13jTboWw8zFWwlV1v+/xq4GrJQzk=;
  b=bgDPSnNjeqFhfTgjgzCQLN2LdHsa+Z5MUwOIwgJBUrEI+/c+3n+/3Ra4
   vtjLUxtwSNdYqedEdnHSaf0jw5PP7RBA+3/Ohc64hEA93AAVDxQtuShAM
   PN7B1nj0hG8sO9K6hijXCSzizCl9MnPOuDuoJ+UJvULoz1H3zfbJ//DPi
   tjFckFQTwcVp9iz9H+fKqMWZO4uwK2O06ff4EA0C9Kd8NKKb8/BAhnSnz
   Qa+kAEVZrtcxl67n/qGEEVnAfO24ITd4AjPLqOttPRhRU913Kem/iEaUO
   LD4Endw1SPA8cc5EyFEuY2amP6Mtd+wf+vgTbOI+/1DurwHLMFj8Pw5S5
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,197,1635177600"; 
   d="scan'208";a="187981371"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2021 08:26:14 +0800
IronPort-SDR: +PZ/nTMiqMD3lcL7e6/oaBlHlOQ4pPIjKW0x9biWXZ39apNIl/VARTA82oEjRJqiYl92sf12Sv
 AQyMKz0mB57YgcPbgYCNlZgY8u573XTKF/Z4EYcw4Nui6/x52bTHiht530z5LBfEjj4ENMOV8O
 zrZqkEjZwtmdiPMFXrF1HWTfHZR6OiPEzyN9YXDhxlstgazzdutTDS+WFheGQE4TnRhA6vP27C
 +q+KkJW9cAYWFE0A9No5nwA4mq4SGKX3ab+J/zeR6r9QoVugP7PpiLk/VrfJ7lx7XgKjJSsSU2
 68h50vjmY7WGnr6Re+uBjTqb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 16:00:46 -0800
IronPort-SDR: fRHsX9OljtYybtIYd6Ri9cTqVkpCyODHsVCMgmkIN4Zw/prp36C0oQTkdsRKqThj8gBcF1fJnc
 fCOBnoUo+imYZLkceZrrh9Wz/6nxiVBZ50zY0FOE8pFMynrJWlU+BzJlQiseyYeT65nYi7g6SL
 4Fta+0wjUMnh/Me+R6lvD5gQZK5yIKeA3S/4xu0KvE5ATgZfAfPDrQbzY9JWR7icktZTzniK3+
 lYm4l3Oy7BlEBvA4MKvp7kIEDgU99eTOtEbSCXmA8j//Xmg4QAdCC4LrOX9JXJLJ9B2TE0G42F
 JZU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 16:26:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9pTz0J1wz1Rwns
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:26:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639182374; x=1641774375; bh=94QWSZFzxy1R2Fj13jTboWw8zFWwlV1v+/x
        q4GrJQzk=; b=FsAzhQq/IocQRTrNM0JBss43bH7keAxiX4qYYhLXeGeNjT/RmWs
        pfnJoXEBcPvjfU2gNc1sfNA9ExIs3B0C0uBVy39Vy+XAUQ/Eqjp2jL/907CQ8Dc/
        4vUYMYEWA9DMlSnjPMtQR8ipPT34dbUnLBwczdZM0QBERl/MOVWIBAV5Ljv9CJmJ
        B4KR0hmYwl4eaN7khMGez9FarxRus4v7aA7lL5vhkqdxg8NGUyiHWq3JY02GnynX
        urPgNGn90virx3vESaAqZlMuDKlapKbfvqJ2Bu52ynCcb5whnzZIQzq2fC5fvRdg
        6Da0PgU8jH41yFpjXgKmqjHe9E2KDCU+ITQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b7tAADaOCQdW for <linux-kernel@vger.kernel.org>;
        Fri, 10 Dec 2021 16:26:14 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9pTw6NKqz1RtVG;
        Fri, 10 Dec 2021 16:26:12 -0800 (PST)
Message-ID: <5d1b0c7c-90c6-8aba-3153-29df6eac865d@opensource.wdc.com>
Date:   Sat, 11 Dec 2021 09:26:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Viswas.G@microchip.com, Ajish.Koshy@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1639158706-18446-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1639158706-18446-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/11 2:51, John Garry wrote:
> The driver supports a "direct" mode of operation, where the SMP req frame
> is directly copied into the command payload (and vice-versa for the SMP
> resp).
> 
> To get at the SMP req frame data in the scatterlist the driver uses
> phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken,
> and subsequently crashes as follows when an IOMMU is enabled:
> 
>  Unable to handle kernel paging request at virtual address
> ffff0000fcebfb00
> 	...
>  pc : pm80xx_chip_smp_req+0x2d0/0x3d0
>  lr : pm80xx_chip_smp_req+0xac/0x3d0
>  pm80xx_chip_smp_req+0x2d0/0x3d0
>  pm8001_task_exec.constprop.0+0x368/0x520
>  pm8001_queue_command+0x1c/0x30
>  smp_execute_task_sg+0xdc/0x204
>  sas_discover_expander.part.0+0xac/0x6cc
>  sas_discover_root_expander+0x8c/0x150
>  sas_discover_domain+0x3ac/0x6a0
>  process_one_work+0x1d0/0x354
>  worker_thread+0x13c/0x470
>  kthread+0x17c/0x190
>  ret_from_fork+0x10/0x20
>  Code: 371806e1 910006d6 6b16033f 54000249 (38766b05)
>  ---[ end trace b91d59aaee98ea2d ]---
> note: kworker/u192:0[7] exited with preempt_count 1
> 
> Instead use kmap_atomic().
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Difference to v1:
> - use kmap_atomic() in both locations
> 
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index b9f6d83ff380..bed4ab071de5 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3053,7 +3053,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	struct smp_completion_resp *psmpPayload;
>  	struct task_status_struct *ts;
>  	struct pm8001_device *pm8001_dev;
> -	char *pdma_respaddr = NULL;
>  
>  	psmpPayload = (struct smp_completion_resp *)(piomb + 4);
>  	status = le32_to_cpu(psmpPayload->status);
> @@ -3080,19 +3079,23 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  		if (pm8001_dev)
>  			atomic_dec(&pm8001_dev->running_req);
>  		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
> +			struct scatterlist *sg_resp = &t->smp_task.smp_resp;
> +			u8 *payload;
> +			void *to;
> +
>  			pm8001_dbg(pm8001_ha, IO,
>  				   "DIRECT RESPONSE Length:%d\n",
>  				   param);
> -			pdma_respaddr = (char *)(phys_to_virt(cpu_to_le64
> -						((u64)sg_dma_address
> -						(&t->smp_task.smp_resp))));
> +			to = kmap_atomic(sg_page(sg_resp));
> +			payload = to + sg_resp->offset;
>  			for (i = 0; i < param; i++) {
> -				*(pdma_respaddr+i) = psmpPayload->_r_a[i];
> +				*(payload + i) = psmpPayload->_r_a[i];
>  				pm8001_dbg(pm8001_ha, IO,
>  					   "SMP Byte%d DMA data 0x%x psmp 0x%x\n",
> -					   i, *(pdma_respaddr + i),
> +					   i, *(payload + i),
>  					   psmpPayload->_r_a[i]);
>  			}
> +			kunmap_atomic(to);
>  		}
>  		break;
>  	case IO_ABORTED:
> @@ -4236,14 +4239,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>  	struct sas_task *task = ccb->task;
>  	struct domain_device *dev = task->dev;
>  	struct pm8001_device *pm8001_dev = dev->lldd_dev;
> -	struct scatterlist *sg_req, *sg_resp;
> +	struct scatterlist *sg_req, *sg_resp, *smp_req;
>  	u32 req_len, resp_len;
>  	struct smp_req smp_cmd;
>  	u32 opc;
>  	struct inbound_queue_table *circularQ;
> -	char *preq_dma_addr = NULL;
> -	__le64 tmp_addr;
>  	u32 i, length;
> +	u8 *payload;
> +	u8 *to;
>  
>  	memset(&smp_cmd, 0, sizeof(smp_cmd));
>  	/*
> @@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>  		pm8001_ha->smp_exp_mode = SMP_INDIRECT;
>  
>  
> -	tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
> -	preq_dma_addr = (char *)phys_to_virt(tmp_addr);
> +	smp_req = &task->smp_task.smp_req;
> +	to = kmap_atomic(sg_page(smp_req));
> +	payload = to + smp_req->offset;
>  
>  	/* INDIRECT MODE command settings. Use DMA */
>  	if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
> @@ -4289,7 +4293,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>  		/* for SPCv indirect mode. Place the top 4 bytes of
>  		 * SMP Request header here. */
>  		for (i = 0; i < 4; i++)
> -			smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
> +			smp_cmd.smp_req16[i] = *(payload + i);
>  		/* exclude top 4 bytes for SMP req header */
>  		smp_cmd.long_smp_req.long_req_addr =
>  			cpu_to_le64((u64)sg_dma_address
> @@ -4320,20 +4324,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>  		pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
>  		for (i = 0; i < length; i++)
>  			if (i < 16) {
> -				smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
> +				smp_cmd.smp_req16[i] = *(payload+i);

Maybe add spacs around the "+" as you did above ?

>  				pm8001_dbg(pm8001_ha, IO,
>  					   "Byte[%d]:%x (DMA data:%x)\n",
>  					   i, smp_cmd.smp_req16[i],
> -					   *(preq_dma_addr));
> +					   *(payload));
>  			} else {
> -				smp_cmd.smp_req[i] = *(preq_dma_addr+i);
> +				smp_cmd.smp_req[i] = *(payload+i);

same comment

>  				pm8001_dbg(pm8001_ha, IO,
>  					   "Byte[%d]:%x (DMA data:%x)\n",
>  					   i, smp_cmd.smp_req[i],
> -					   *(preq_dma_addr));
> +					   *(payload));
>  			}
>  	}
> -
> +	kunmap_atomic(to);
>  	build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
>  				&smp_cmd, pm8001_ha->smp_exp_mode, length);
>  	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,

Otherwise, looks OK to me.

-- 
Damien Le Moal
Western Digital Research
