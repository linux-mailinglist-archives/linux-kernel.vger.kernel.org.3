Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE27449E14F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiA0LlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:41:02 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17819 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiA0LlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:41:01 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JkzCG3Kn0z9sBn;
        Thu, 27 Jan 2022 19:39:38 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 19:40:58 +0800
Subject: Re: [PATCH 02/16] scsi: libsas: Delete lldd_clear_aca callback
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@cloud.ionos.com>, <Ajish.Koshy@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-3-git-send-email-john.garry@huawei.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <d91de88b-0675-dca6-d96a-d6cebd9b3ccb@hisilicon.com>
Date:   Thu, 27 Jan 2022 19:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1643110372-85470-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/1/25 19:32, John Garry Ð´µÀ:
> This callback is never called, so remove support.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>

> ---
>   Documentation/scsi/libsas.rst         |  2 --
>   drivers/scsi/aic94xx/aic94xx.h        |  1 -
>   drivers/scsi/aic94xx/aic94xx_init.c   |  1 -
>   drivers/scsi/aic94xx/aic94xx_tmf.c    |  9 ---------
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ------------
>   drivers/scsi/isci/init.c              |  1 -
>   drivers/scsi/isci/task.c              | 18 ------------------
>   drivers/scsi/isci/task.h              |  4 ----
>   drivers/scsi/mvsas/mv_init.c          |  1 -
>   drivers/scsi/mvsas/mv_sas.c           | 11 -----------
>   drivers/scsi/mvsas/mv_sas.h           |  1 -
>   drivers/scsi/pm8001/pm8001_init.c     |  1 -
>   drivers/scsi/pm8001/pm8001_sas.c      |  8 --------
>   drivers/scsi/pm8001/pm8001_sas.h      |  1 -
>   include/scsi/libsas.h                 |  1 -
>   15 files changed, 72 deletions(-)
>
> diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
> index 6589dfefbc02..305a253d5c3b 100644
> --- a/Documentation/scsi/libsas.rst
> +++ b/Documentation/scsi/libsas.rst
> @@ -207,7 +207,6 @@ Management Functions (TMFs) described in SAM::
>   	/* Task Management Functions. Must be called from process context. */
>   	int (*lldd_abort_task)(struct sas_task *);
>   	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
> -	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
>   	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
>   	int (*lldd_I_T_nexus_reset)(struct domain_device *);
>   	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
> @@ -262,7 +261,6 @@ can look like this (called last thing from probe())
>   
>   	    my_ha->sas_ha.lldd_abort_task     = my_abort_task;
>   	    my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
> -	    my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
>   	    my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
>   	    my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
>   	    my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
> diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
> index 8f24180646c2..f595bc2ee45e 100644
> --- a/drivers/scsi/aic94xx/aic94xx.h
> +++ b/drivers/scsi/aic94xx/aic94xx.h
> @@ -60,7 +60,6 @@ void asd_set_dmamode(struct domain_device *dev);
>   /* ---------- TMFs ---------- */
>   int  asd_abort_task(struct sas_task *);
>   int  asd_abort_task_set(struct domain_device *, u8 *lun);
> -int  asd_clear_aca(struct domain_device *, u8 *lun);
>   int  asd_clear_task_set(struct domain_device *, u8 *lun);
>   int  asd_lu_reset(struct domain_device *, u8 *lun);
>   int  asd_I_T_nexus_reset(struct domain_device *dev);
> diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
> index 7a78606598c4..954d0c5ae2e2 100644
> --- a/drivers/scsi/aic94xx/aic94xx_init.c
> +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> @@ -960,7 +960,6 @@ static struct sas_domain_function_template aic94xx_transport_functions = {
>   
>   	.lldd_abort_task	= asd_abort_task,
>   	.lldd_abort_task_set	= asd_abort_task_set,
> -	.lldd_clear_aca		= asd_clear_aca,
>   	.lldd_clear_task_set	= asd_clear_task_set,
>   	.lldd_I_T_nexus_reset	= asd_I_T_nexus_reset,
>   	.lldd_lu_reset		= asd_lu_reset,
> diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
> index 0eb6e206a2b4..0ff0d6506ccf 100644
> --- a/drivers/scsi/aic94xx/aic94xx_tmf.c
> +++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
> @@ -644,15 +644,6 @@ int asd_abort_task_set(struct domain_device *dev, u8 *lun)
>   	return res;
>   }
>   
> -int asd_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_ACA, 0);
> -
> -	if (res == TMF_RESP_FUNC_COMPLETE)
> -		asd_clear_nexus_I_T_L(dev, lun);
> -	return res;
> -}
> -
>   int asd_clear_task_set(struct domain_device *dev, u8 *lun)
>   {
>   	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_TASK_SET, 0);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index a05ec7aece5a..f014e458edbb 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -1801,17 +1801,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
>   	return rc;
>   }
>   
> -static int hisi_sas_clear_aca(struct domain_device *device, u8 *lun)
> -{
> -	struct hisi_sas_tmf_task tmf_task;
> -	int rc;
> -
> -	tmf_task.tmf = TMF_CLEAR_ACA;
> -	rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
> -
> -	return rc;
> -}
> -
>   #define I_T_NEXUS_RESET_PHYUP_TIMEOUT  (2 * HZ)
>   
>   static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
> @@ -2341,7 +2330,6 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>   	.lldd_control_phy	= hisi_sas_control_phy,
>   	.lldd_abort_task	= hisi_sas_abort_task,
>   	.lldd_abort_task_set	= hisi_sas_abort_task_set,
> -	.lldd_clear_aca		= hisi_sas_clear_aca,
>   	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
>   	.lldd_lu_reset		= hisi_sas_lu_reset,
>   	.lldd_query_task	= hisi_sas_query_task,
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index aade707c5553..e294d5d961eb 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -193,7 +193,6 @@ static struct sas_domain_function_template isci_transport_ops  = {
>   	/* Task Management Functions. Must be called from process context. */
>   	.lldd_abort_task	= isci_task_abort_task,
>   	.lldd_abort_task_set	= isci_task_abort_task_set,
> -	.lldd_clear_aca		= isci_task_clear_aca,
>   	.lldd_clear_task_set	= isci_task_clear_task_set,
>   	.lldd_I_T_nexus_reset	= isci_task_I_T_nexus_reset,
>   	.lldd_lu_reset		= isci_task_lu_reset,
> diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
> index 3fd88d72a0c0..403bfee34d84 100644
> --- a/drivers/scsi/isci/task.c
> +++ b/drivers/scsi/isci/task.c
> @@ -625,24 +625,6 @@ int isci_task_abort_task_set(
>   }
>   
>   
> -/**
> - * isci_task_clear_aca() - This function is one of the SAS Domain Template
> - *    functions. This is one of the Task Management functoins called by libsas.
> - * @d_device: This parameter specifies the domain device associated with this
> - *    request.
> - * @lun: This parameter specifies the lun	 associated with this request.
> - *
> - * status, zero indicates success.
> - */
> -int isci_task_clear_aca(
> -	struct domain_device *d_device,
> -	u8 *lun)
> -{
> -	return TMF_RESP_FUNC_FAILED;
> -}
> -
> -
> -
>   /**
>    * isci_task_clear_task_set() - This function is one of the SAS Domain Template
>    *    functions. This is one of the Task Management functoins called by libsas.
> diff --git a/drivers/scsi/isci/task.h b/drivers/scsi/isci/task.h
> index cae168b8916f..f96633fa6939 100644
> --- a/drivers/scsi/isci/task.h
> +++ b/drivers/scsi/isci/task.h
> @@ -140,10 +140,6 @@ int isci_task_abort_task_set(
>   	struct domain_device *d_device,
>   	u8 *lun);
>   
> -int isci_task_clear_aca(
> -	struct domain_device *d_device,
> -	u8 *lun);
> -
>   int isci_task_clear_task_set(
>   	struct domain_device *d_device,
>   	u8 *lun);
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index dcae2d4464f9..21429e3a3632 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -64,7 +64,6 @@ static struct sas_domain_function_template mvs_transport_ops = {
>   
>   	.lldd_abort_task	= mvs_abort_task,
>   	.lldd_abort_task_set    = mvs_abort_task_set,
> -	.lldd_clear_aca         = mvs_clear_aca,
>   	.lldd_clear_task_set    = mvs_clear_task_set,
>   	.lldd_I_T_nexus_reset	= mvs_I_T_nexus_reset,
>   	.lldd_lu_reset 		= mvs_lu_reset,
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 1e52bc7febfa..fd273c3e069e 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -1553,17 +1553,6 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
>   	return rc;
>   }
>   
> -int mvs_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -	int rc = TMF_RESP_FUNC_FAILED;
> -	struct mvs_tmf_task tmf_task;
> -
> -	tmf_task.tmf = TMF_CLEAR_ACA;
> -	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
> -
> -	return rc;
> -}
> -
>   int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
>   {
>   	int rc = TMF_RESP_FUNC_FAILED;
> diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
> index 8ff976c9967e..fa654c73beee 100644
> --- a/drivers/scsi/mvsas/mv_sas.h
> +++ b/drivers/scsi/mvsas/mv_sas.h
> @@ -441,7 +441,6 @@ int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
>   int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
>   int mvs_abort_task(struct sas_task *task);
>   int mvs_abort_task_set(struct domain_device *dev, u8 *lun);
> -int mvs_clear_aca(struct domain_device *dev, u8 *lun);
>   int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
>   void mvs_port_formed(struct asd_sas_phy *sas_phy);
>   void mvs_port_deformed(struct asd_sas_phy *sas_phy);
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index d8a2121cb8d9..b8cf1bae4040 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -123,7 +123,6 @@ static struct sas_domain_function_template pm8001_transport_ops = {
>   
>   	.lldd_abort_task	= pm8001_abort_task,
>   	.lldd_abort_task_set	= pm8001_abort_task_set,
> -	.lldd_clear_aca		= pm8001_clear_aca,
>   	.lldd_clear_task_set	= pm8001_clear_task_set,
>   	.lldd_I_T_nexus_reset   = pm8001_I_T_nexus_reset,
>   	.lldd_lu_reset		= pm8001_lu_reset,
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 160ee8b228c9..4368122ab475 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -1357,14 +1357,6 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
>   	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
>   }
>   
> -int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -	struct pm8001_tmf_task tmf_task;
> -
> -	tmf_task.tmf = TMF_CLEAR_ACA;
> -	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
> -}
> -
>   int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
>   {
>   	struct pm8001_tmf_task tmf_task;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index a17da1cebce1..3ea53a0d0cc1 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -649,7 +649,6 @@ int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time);
>   int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags);
>   int pm8001_abort_task(struct sas_task *task);
>   int pm8001_abort_task_set(struct domain_device *dev, u8 *lun);
> -int pm8001_clear_aca(struct domain_device *dev, u8 *lun);
>   int pm8001_clear_task_set(struct domain_device *dev, u8 *lun);
>   int pm8001_dev_found(struct domain_device *dev);
>   void pm8001_dev_gone(struct domain_device *dev);
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 698f2032807b..d59618898619 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -637,7 +637,6 @@ struct sas_domain_function_template {
>   	/* Task Management Functions. Must be called from process context. */
>   	int (*lldd_abort_task)(struct sas_task *);
>   	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
> -	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
>   	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
>   	int (*lldd_I_T_nexus_reset)(struct domain_device *);
>   	int (*lldd_ata_check_ready)(struct domain_device *);

