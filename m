Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A6D49B6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580126AbiAYOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:42:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4512 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiAYOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:39:35 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjqBh2kN6z689Mf;
        Tue, 25 Jan 2022 22:35:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 15:39:24 +0100
Received: from [10.47.95.36] (10.47.95.36) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 14:39:23 +0000
Subject: Re: [PATCH 05/16] scsi: libsas: Add struct sas_tmf_task
To:     Matthew Wilcox <willy@infradead.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>,
        <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-6-git-send-email-john.garry@huawei.com>
 <Ye/9Fs+JrtlMC+Mb@casper.infradead.org>
 <6b31b15c-98d9-ee07-0092-cbcc5f5c71fe@huawei.com>
 <YfAF5nlRBtaA6IVK@casper.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <87dc535f-609f-040a-5c47-5b6bb5b17b59@huawei.com>
Date:   Tue, 25 Jan 2022 14:38:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YfAF5nlRBtaA6IVK@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.36]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 14:15, Matthew Wilcox wrote:
>> Sure, but the pm8001 HW does has a 32b field, which is strange as the SAS
>> spec defines a 16b field in the task management Function information unit
>> "tag of task to be managed" field.
> My point is that it's only safe because the pm8001 driver already limits
> it to smaller than u16.
>  Seeing language like "should be enough" made
> me think you'd just assumed that it would be.

I can update that wording to be confident that u16 is enough.

>  Seeing a line like:
>          u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
> made me think it might not be; perhaps 0xdeadbeef was being used as
> a flag value somewhere in the driver.
> 
> For example ...
> 
> drivers/scsi/pm8001/pm8001_hwi.c:       int rc, tag = 0xdeadbeef;
> drivers/scsi/pm8001/pm8001_sas.c:       u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
> drivers/scsi/pm8001/pm8001_sas.c:       u32 tag = 0xdeadbeef;
> drivers/scsi/pm8001/pm80xx_hwi.c:                       if (ibutton0 == 0xdeadbeef && ibutton1 == 0xdeadbeef) {
> drivers/scsi/pm8001/pm80xx_hwi.c:       int rc, tag = 0xdeadbeef;
> 
> That doesn't seem to be the case though; as far as I can tell the
> tag value is never checked against 0xdeadbeef.
> .

Right, 0xdeadbeef is initially assigned just as a safety measure.

Thanks,
John
