Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943874CC2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiCCQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiCCQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:32:40 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29819D618
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646325113; x=1677861113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CQ8T9/Kbhd6Yy81cQxXm9sARrwJUyfmP5Zwrr+TZSKE=;
  b=EPQfmeW8Kwd8Abu1Ox+GMJT/x8C/G/ZxYtaY2KoToFOVGe2FQk8oNfZ2
   zSm3ZZ4IgkToO0SO5QyYbgYHV8cleMlBxOQcVbUOhPygInws9uKMzpxem
   cHTsPFLZ9aNMxiv9qr4XzAanvoHHOavpq1AMb7ZDlPfSKFFaBeTQXPbUS
   0O23JmzIpKuQlVju86dE2TFGCvQjrljancx+76JY1Fqazz8zpGs0IgGYt
   1J/bbugfH5NzqnSu0/SVNlHuM/wqZ8f6Z9HqrhdSS4YUYZZVc/l2n2mA6
   XS4/ZbLZ+7JMXyPXDZjXvWY16IMP0qU5mz9UW1WQHFcNE+rbomIPB9gvM
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="193333351"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 00:31:53 +0800
IronPort-SDR: iNcpI1fBmvn55kjGE3SVW4n8cbcQ/pJNNG7351pQeRp6ljtd3tmXAVifKXnwKgUkMGEZdncf4y
 7GkoB71TqB8LY/trwzMV2239UQVVC3TuvQa3hwn/XiNdfEO4yKP4lWbMvp+FdE1mKtPqiyYs03
 kD47iqxYs0nefHUR8d41ht3pwHOzztWuPHfnvb2P0bpStN8xB6moSQrg6WlOr2gU5ll5cjo3I2
 r34Kxgpk+teFYPmJGHcbamag6rLU0bOclTqPFFSbGG8cPSPqBIWq4DinGAdxeYoYFMW4lppjas
 8isPlv528OVbMI31AXKQ7kZw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:04:17 -0800
IronPort-SDR: ctT4etnSDIUiN+/nxPIwzBDFyVxfeRIfh0RaS+7TgrH38Hkic/GFJt4Y5cshv3zRaYWCzAiuSp
 bieMFHKEdpVIXLLv0Y4CEF3CjpZt2EYgjo8P9ZxyHehJLSvpav3zSaiKSD9JgrVwtbXMKurp1Y
 a0xJOqbvw3ucSZFCA6Fx8kAMbQ6h1/DVt39KeOjlQajtbMrnq4EBJJvyut1NZO1FgIYqVNU65d
 SzSgTvvQf8melf5ys3KOoGzebUYPSxmnxACGqLikwz55YoOUa+pCkonTM/T0hziZ94VbjPuSnK
 k3Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:31:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8c2J6C8Bz1SHwl
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:31:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646325111; x=1648917112; bh=CQ8T9/Kbhd6Yy81cQxXm9sARrwJUyfmP5Zw
        rr+TZSKE=; b=l3hHKVgz5D8FsKrZpqSitVBd+ur1Sq8+wQR9zoPwtyeoTK6cpwJ
        aDvDMuG4D9jllrkR6uyUU22W9KGju/DNnqKlTjH/KuZeir8fxOi+UpPbutZXHSOz
        O8nCcEK6++naX7iDyzE7/PwvbNEKAc0VS4DaorAkHOLeOhD39jdSrIc3B4ECV94x
        2M8tPIkW6fj4iMXA/KAckXL78j9tT5RK/B2E5RLfmHBwcNboYEW2L9gd1dGZTnJ2
        XSrsxN+5E7p60RwXaFS8bQJ8Fj/aq2zuN+JtJL7OUAz9zroQgf9FXLs2RyAB7ud1
        q1K+gMPoaH8cbRWQSO8ceqbKfYrNUHAlrSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zOCd8EdxbxLt for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 08:31:51 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8c2C728yz1Rvlx;
        Thu,  3 Mar 2022 08:31:47 -0800 (PST)
Message-ID: <1a868ac0-e5bb-7efb-c1f8-eda0b040f5db@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 18:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1646309930-138960-2-git-send-email-john.garry@huawei.com>
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

On 2022/03/03 14:18, John Garry wrote:
> The internal abort feature is common to hisi_sas and pm8001 HBAs, and the
> driver support is similar also, so add a common handler.
> 
> Two modes of operation will be supported:
> - single: Abort a single tagged command
> - device: Abort all commands associated with a specific domain device
> 
> A new protocol is added, SAS_PROTOCOL_INTERNAL_ABORT, so the common queue
> command API may be re-used.
> 
> Only add "single" support as a first step.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/libsas/sas_scsi_host.c | 75 +++++++++++++++++++++++++++++
>  include/scsi/libsas.h               | 14 ++++++
>  include/scsi/sas.h                  |  2 +
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 5b5747e33dbd..0d05826e6e8c 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -920,6 +920,81 @@ void sas_task_internal_timedout(struct timer_list *t)
>  #define TASK_TIMEOUT			(20 * HZ)
>  #define TASK_RETRY			3
>  
> +static int sas_execute_internal_abort(struct domain_device *device,
> +				      enum sas_internal_abort type, u16 tag,
> +				      unsigned int qid, void *data)
> +{
> +	struct sas_ha_struct *ha = device->port->ha;
> +	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
> +	struct sas_task *task = NULL;
> +	int res, retry;
> +
> +	for (retry = 0; retry < TASK_RETRY; retry++) {
> +		task = sas_alloc_slow_task(GFP_KERNEL);
> +		if (!task)
> +			return -ENOMEM;
> +
> +		task->dev = device;
> +		task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
> +		task->task_done = sas_task_internal_done;
> +		task->slow_task->timer.function = sas_task_internal_timedout;
> +		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
> +		add_timer(&task->slow_task->timer);
> +
> +		task->abort_task.tag = tag;
> +		task->abort_task.type = type;
> +
> +		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
> +		if (res) {
> +			del_timer_sync(&task->slow_task->timer);
> +			pr_err("Executing internal abort failed %016llx (%d)\n",
> +			       SAS_ADDR(device->sas_addr), res);
> +			break;
> +		}
> +
> +		wait_for_completion(&task->slow_task->completion);
> +		res = TMF_RESP_FUNC_FAILED;
> +
> +		/* Even if the internal abort timed out, return direct. */
> +		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
> +			pr_err("Internal abort: timeout %016llx\n",
> +			       SAS_ADDR(device->sas_addr));
> +

Nit: blank line not needed here ?

> +			res = -EIO;
> +			break;
> +		}
> +
> +		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> +			task->task_status.stat == SAS_SAM_STAT_GOOD) {
> +			res = TMF_RESP_FUNC_COMPLETE;
> +			break;
> +		}
> +
> +		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> +			task->task_status.stat == TMF_RESP_FUNC_SUCC) {
> +			res = TMF_RESP_FUNC_SUCC;
> +			break;
> +		}
> +
> +		pr_err("Internal abort: task to dev %016llx response: 0x%x status 0x%x\n",
> +		       SAS_ADDR(device->sas_addr), task->task_status.resp,
> +		       task->task_status.stat);
> +		sas_free_task(task);
> +		task = NULL;
> +	}
> +	BUG_ON(retry == TASK_RETRY && task != NULL);
> +	sas_free_task(task);
> +	return res;
> +}
> +
> +int sas_execute_internal_abort_single(struct domain_device *device, u16 tag,
> +				      unsigned int qid, void *data)
> +{
> +	return sas_execute_internal_abort(device, SAS_INTERNAL_ABORT_SINGLE,
> +					  tag, qid, data);
> +}
> +EXPORT_SYMBOL_GPL(sas_execute_internal_abort_single);
> +
>  int sas_execute_tmf(struct domain_device *device, void *parameter,
>  		    int para_len, int force_phy_id,
>  		    struct sas_tmf_task *tmf)
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index df2c8fc43429..2d30d57916e5 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -557,6 +557,16 @@ struct sas_ata_task {
>  	int    force_phy_id;
>  };
>  
> +/* LLDDs rely on these values */
> +enum sas_internal_abort {
> +	SAS_INTERNAL_ABORT_SINGLE	= 0,
> +};
> +
> +struct sas_internal_abort_task {
> +	enum sas_internal_abort type;
> +	u16 tag;
> +};
> +
>  struct sas_smp_task {
>  	struct scatterlist smp_req;
>  	struct scatterlist smp_resp;
> @@ -596,6 +606,7 @@ struct sas_task {
>  		struct sas_ata_task ata_task;
>  		struct sas_smp_task smp_task;
>  		struct sas_ssp_task ssp_task;
> +		struct sas_internal_abort_task abort_task;
>  	};
>  
>  	struct scatterlist *scatter;
> @@ -683,6 +694,9 @@ extern int sas_slave_configure(struct scsi_device *);
>  extern int sas_change_queue_depth(struct scsi_device *, int new_depth);
>  extern int sas_bios_param(struct scsi_device *, struct block_device *,
>  			  sector_t capacity, int *hsc);
> +int sas_execute_internal_abort_single(struct domain_device *device,
> +				      u16 tag, unsigned int qid,
> +				      void *data);
>  extern struct scsi_transport_template *
>  sas_domain_attach_transport(struct sas_domain_function_template *);
>  extern struct device_attribute dev_attr_phy_event_threshold;
> diff --git a/include/scsi/sas.h b/include/scsi/sas.h
> index 332a463d08ef..acfc69fd72d0 100644
> --- a/include/scsi/sas.h
> +++ b/include/scsi/sas.h
> @@ -95,6 +95,8 @@ enum sas_protocol {
>  	SAS_PROTOCOL_SSP		= 0x08,
>  	SAS_PROTOCOL_ALL		= 0x0E,
>  	SAS_PROTOCOL_STP_ALL		= SAS_PROTOCOL_STP|SAS_PROTOCOL_SATA,
> +	/* these are internal to libsas */
> +	SAS_PROTOCOL_INTERNAL_ABORT	= 0x10,
>  };
>  
>  /* From the spec; local phys only */


-- 
Damien Le Moal
Western Digital Research
