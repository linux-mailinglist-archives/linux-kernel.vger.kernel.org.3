Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE449E6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiA0QCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:02:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4529 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiA0QCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:02:32 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jl5231lyPz6H8Xr;
        Fri, 28 Jan 2022 00:02:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:02:28 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 16:02:27 +0000
Subject: Re: [PATCH 06/16] scsi: libsas: Add sas_task.tmf
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "Ajish.Koshy@microchip.com" <Ajish.Koshy@microchip.com>
CC:     yanaijie <yanaijie@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        "Viswas.G@microchip.com" <Viswas.G@microchip.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-7-git-send-email-john.garry@huawei.com>
 <e349aedb-71ad-8bf2-d3c3-920a83a56eae@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6b31c696-9808-764b-489b-4d2de91051b9@huawei.com>
Date:   Thu, 27 Jan 2022 16:01:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e349aedb-71ad-8bf2-d3c3-920a83a56eae@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 12:55, chenxiang (M) wrote:
>> -	slot->tmf = tmf;
>> -	slot->is_internal = tmf;
> In kernel 5.17-rc1(with above two lines on), it seems there is a issue
> for ata disk reset command as tmf = null while it is internal command.

ok, thanks for the notice. Would this fix it:

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a05ec7aece5a..0e12c9329ee5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -427,8 +427,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
  	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
  	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];

-	slot->tmf = tmf;
-	slot->is_internal = tmf;
  	task->lldd_task = slot;

  	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
@@ -1380,12 +1378,13 @@ static int hisi_sas_softreset_ata_disk(struct 
domain_device *device)
  	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
  	struct device *dev = hisi_hba->dev;
  	int s = sizeof(struct host_to_dev_fis);
+	struct hisi_sas_tmf_task tmf = {};

  	ata_for_each_link(link, ap, EDGE) {
  		int pmp = sata_srst_pmp(link);

  		hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
-		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, NULL);
+		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, &tmf);
  		if (rc != TMF_RESP_FUNC_COMPLETE)
  			break;
  	}
@@ -1396,7 +1395,7 @@ static int hisi_sas_softreset_ata_disk(struct 
domain_device *device)

  			hisi_sas_fill_ata_reset_cmd(link->device, 0, pmp, fis);
  			rc = hisi_sas_exec_internal_tmf_task(device, fis,
-							     s, NULL);
+							     s, &tmf);
  			if (rc != TMF_RESP_FUNC_COMPLETE)
  				dev_err(dev, "ata disk %016llx de-reset failed\n",
  					SAS_ADDR(device->sas_addr));

> 
>>    	task->lldd_task = slot;
>>    



