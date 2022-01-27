Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE849DF47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiA0KYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiA0KYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:24:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA6C061747;
        Thu, 27 Jan 2022 02:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LdYLeFEbsBuCFZ7FoR1QEMeKfzl66QFMWg+XfJ6tKvs=; b=B27u58oYT8eae7tHHvNVtG8lzJ
        yEM0fm/NSePGNDisdEVrRj/c8e/PfZRELI6WspFV/A9zuSkVd3mexrinvl3j0hJp9irKjkHtrdgPQ
        Toe/5k6op2UNNB436swQeg0pF8lqffciqQr2FHJIUN+CtutHh3FL63zNICruhH2EVyBhW18phYZk6
        xl8N05FtrAqacU7gqCF618AIhU1Al5B/ZSIkTDle2m6cFleqWeS7oA9V3/FcaYFre3wJKw8LY8kOs
        PIdR9SCPks6hSXwhjFbxoRD3NI+bG1ZN+KJQF9WZr27rnT8egnijX73PK/OZ+Yd+lb6zvHPEaBgGk
        9HtrqmCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1x5-00F8qH-53; Thu, 27 Jan 2022 10:24:27 +0000
Date:   Thu, 27 Jan 2022 02:24:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 08/16] scsi: libsas: Add sas_execute_ssp_tmf()
Message-ID: <YfJy26K2zTxbVjDK@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-9-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-9-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:32:44PM +0800, John Garry wrote:
> Add a function to issue an SSP TMF.
> 
> Add a temp prototype to keep make W=1 happy.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/libsas/sas_scsi_host.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 93ca6da63104..cfdf4a031be0 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -938,6 +938,11 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
>  		task->dev = device;
>  		task->task_proto = device->tproto;
>  
> +		if (dev_is_sata(device)) {
> +		} else {
> +			memcpy(&task->ssp_task, parameter, para_len);
> +		}

This looks strange, why not:

		if (!dev_is_sata(device))
			memcpy(&task->ssp_task, parameter, para_len);
